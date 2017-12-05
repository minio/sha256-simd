//+build !noasm

/*
 * Minio Cloud Storage, (C) 2017 Minio, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package sha256

import (
	"encoding/binary"
	"hash"
	"sort"
	"sync/atomic"
	"time"
)

//go:noescape
func sha256_x16_avx512(digests *[512]byte, scratch *[512]byte, mask []uint64, inputs [16][]byte)

const Avx512ServerUid = 16

var uidCounter uint64

func NewAvx512(a512srv *Avx512Server) hash.Hash {
	uid := atomic.AddUint64(&uidCounter, 1)
	return &Avx512Digest{uid: uid, a512srv: a512srv}
}

// Type for computing SHA256 using AVX51
type Avx512Digest struct {
	uid     uint64
	a512srv *Avx512Server
}

// Return size of checksum
func (digest *Avx512Digest) Size() int { return Size }

// Return blocksize of checksum
func (digest Avx512Digest) BlockSize() int { return BlockSize }

func (digest *Avx512Digest) Reset() {
	// TODO: Implement Reset()
}

// Write to digest
func (digest *Avx512Digest) Write(p []byte) (n int, err error) {
	digest.a512srv.blocksCh <- blockInput{uid: digest.uid, msg: p}
	n = len(p)
	return
}

// Return sha256 sum in bytes
func (digest *Avx512Digest) Sum(in []byte) (result []byte) {
	sumCh := make(chan [32]byte)
	digest.a512srv.blocksCh <- blockInput{uid: digest.uid, msg: in, final: true, sumCh: sumCh}
	output := <-sumCh
	return output[:]
}

// Interface function to assembly ode
func blockAvx512(digests *[512]byte, input [16][]byte, mask []uint64) [][32]byte {

	scratch := [512]byte{}
	sha256_x16_avx512(digests, &scratch, mask, input)

	// TODO: See if we can use statically size array
	output := make([][32]byte, 16)
	for i := 0; i < 16; i++ {
		output[i] = getDigest(i, digests[:])
	}

	return output
}

func getDigest(index int, state []byte) (sum [32]byte) {
	for j := 0; j < 16; j += 2 {
		for i := index*4 + j*32; i < index*4+(j+1)*32; i += 32 {
			// TODO: See if we can prevent byte swapping
			binary.BigEndian.PutUint32(sum[j*2:], binary.LittleEndian.Uint32(state[i:i+4]))
		}
	}
	return
}

// Type to implement 16x parallel handling of SHA256 invocations
type Avx512Server struct {
	inputs   [16][]byte
	totalIn  int
	inputUid [16]uint64
	digests  map[uint64][32]byte
	blocksCh chan blockInput
	outputCh [16]chan [32]byte
}

// Message to send across channel
type blockInput struct {
	uid   uint64
	msg   []byte
	final bool
	sumCh chan [32]byte
}

func NewAvx512Server() *Avx512Server {
	a512srv := &Avx512Server{}
	a512srv.digests = make(map[uint64][32]byte)
	a512srv.blocksCh = make(chan blockInput)

	// Start a single thread for reading from the input channel
	go a512srv.Process()
	return a512srv
}

// Sole handler for reading from the input channel
func (a512srv *Avx512Server) Process() {
	for {
		select {
		case block := <-a512srv.blocksCh:
			index := block.uid & 0xf
			// fmt.Println("Adding message:", block.uid, index)

			if a512srv.inputs[index] != nil { // If slot is already filled, process all inputs
				//fmt.Println("Invoking Blocks()")
				a512srv.blocks()
			}
			a512srv.totalIn++
			a512srv.inputUid[index] = block.uid
			a512srv.inputs[index] = block.msg
			if block.final {
				a512srv.outputCh[index] = block.sumCh
			}
			if a512srv.totalIn == len(a512srv.inputs) {
				// fmt.Println("Invoking Blocks() while FULL: ")
				a512srv.blocks()
			}
		case <-time.After(1 * time.Microsecond):
			for _, input := range a512srv.inputs {
				if input != nil { // check if there is any input to process
					// fmt.Println("Invoking Blocks() on TIMEOUT: ")
					a512srv.blocks()
					break // we are done
				}
			}
		}
	}
}

// Invoke assembly and send results back
func (a512srv *Avx512Server) blocks() (err error) {

	mask := expandMask(genMask(a512srv.inputs))
	outputs := blockAvx512(a512srv.getDigests(), a512srv.inputs, mask)
	//fmt.Println(hex.EncodeToString(outputs[0][:]))
	a512srv.totalIn = 0
	for i := 0; i < 16; i++ {
		a512srv.digests[a512srv.inputUid[i]] = outputs[i]
		a512srv.inputs[i] = nil

		if a512srv.outputCh[i] != nil {
			// Send back result
			a512srv.outputCh[i] <- outputs[i]
			a512srv.outputCh[i] = nil
			// TODO: Remove entry from hashmap
		}
	}
	return
}

func (a512srv *Avx512Server) Write(uid uint64, p []byte) (nn int, err error) {
	a512srv.blocksCh <- blockInput{uid: uid, msg: p}
	return len(p), nil
}

func (a512srv *Avx512Server) Sum(uid uint64, p []byte) [32]byte {
	sumCh := make(chan [32]byte)
	a512srv.blocksCh <- blockInput{uid: uid, msg: p, final: true, sumCh: sumCh}
	return <-sumCh
}

func (a512srv *Avx512Server) getDigests() *[512]byte {
	digests := [512]byte{}
	for i := 0; i < 16; i++ {
		a, ok := a512srv.digests[a512srv.inputUid[i]]
		if ok {
			// TODO: See if we can prevent byte swap
			binary.BigEndian.PutUint32(digests[(i+0*16)*4:], binary.LittleEndian.Uint32(a[0:4]))
			binary.BigEndian.PutUint32(digests[(i+1*16)*4:], binary.LittleEndian.Uint32(a[4:8]))
			binary.BigEndian.PutUint32(digests[(i+2*16)*4:], binary.LittleEndian.Uint32(a[8:12]))
			binary.BigEndian.PutUint32(digests[(i+3*16)*4:], binary.LittleEndian.Uint32(a[12:16]))
			binary.BigEndian.PutUint32(digests[(i+4*16)*4:], binary.LittleEndian.Uint32(a[16:20]))
			binary.BigEndian.PutUint32(digests[(i+5*16)*4:], binary.LittleEndian.Uint32(a[20:24]))
			binary.BigEndian.PutUint32(digests[(i+6*16)*4:], binary.LittleEndian.Uint32(a[24:28]))
			binary.BigEndian.PutUint32(digests[(i+7*16)*4:], binary.LittleEndian.Uint32(a[28:32]))
		} else {
			binary.LittleEndian.PutUint32(digests[(i+0*16)*4:], init0)
			binary.LittleEndian.PutUint32(digests[(i+1*16)*4:], init1)
			binary.LittleEndian.PutUint32(digests[(i+2*16)*4:], init2)
			binary.LittleEndian.PutUint32(digests[(i+3*16)*4:], init3)
			binary.LittleEndian.PutUint32(digests[(i+4*16)*4:], init4)
			binary.LittleEndian.PutUint32(digests[(i+5*16)*4:], init5)
			binary.LittleEndian.PutUint32(digests[(i+6*16)*4:], init6)
			binary.LittleEndian.PutUint32(digests[(i+7*16)*4:], init7)
		}
	}
	return &digests
}

// Helper struct for sorting blocks based on length
type lane struct {
	len uint
	pos uint
}

type lanes []lane

func (lns lanes) Len() int           { return len(lns) }
func (lns lanes) Swap(i, j int)      { lns[i], lns[j] = lns[j], lns[i] }
func (lns lanes) Less(i, j int) bool { return lns[i].len < lns[j].len }

// Helper struct for
type maskRounds struct {
	mask   uint64
	rounds uint64
}

func genMask(input [16][]byte) [16]maskRounds {

	// Sort on blocks length small to large
	var sorted [16]lane
	for c, inpt := range input {
		sorted[c] = lane{uint(len(inpt)), uint(c)}
	}
	sort.Sort(lanes(sorted[:]))

	// Create mask array including 'rounds' between masks
	m, round, index := uint64(0xffff), uint64(0), 0
	var mr [16]maskRounds
	for _, s := range sorted {
		if s.len > 0 {
			if uint64(s.len)>>6 > round {
				mr[index] = maskRounds{m, (uint64(s.len) >> 6) - round}
				index++
			}
			round = uint64(s.len) >> 6
		}
		m = m & ^(1 << uint(s.pos))
	}

	return mr
}

// TODO: remove function
func expandMask(mr [16]maskRounds) []uint64 {
	size := uint64(0)
	for _, r := range mr {
		size += r.rounds
	}
	result, index := make([]uint64, size), 0
	for _, r := range mr {
		for j := uint64(0); j < r.rounds; j++ {
			result[index] = r.mask
			index++
		}
	}
	return result
}
