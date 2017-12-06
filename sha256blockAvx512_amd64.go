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

// Do not start at 0 but next multiple of 16 so as to be able to
// differentiate with default initialiation value of 0
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
	x       [chunk]byte
	nx      int
	len     uint64
}

// Return size of checksum
func (d *Avx512Digest) Size() int { return Size }

// Return blocksize of checksum
func (d Avx512Digest) BlockSize() int { return BlockSize }

func (d *Avx512Digest) Reset() {
	d.a512srv.blocksCh <- blockInput{uid: d.uid, reset: true}
	d.nx = 0
	d.len = 0
}

// Write to digest
func (d *Avx512Digest) Write(p []byte) (nn int, err error) {
	nn = len(p)
	d.len += uint64(nn)
	if d.nx > 0 {
		n := copy(d.x[d.nx:], p)
		d.nx += n
		if d.nx == chunk {
			d.a512srv.blocksCh <- blockInput{uid: d.uid, msg: d.x[:]}
			d.nx = 0
		}
		p = p[n:]
	}
	if len(p) >= chunk {
		n := len(p) &^ (chunk - 1)
		d.a512srv.blocksCh <- blockInput{uid: d.uid, msg: p[:n]}
		p = p[n:]
	}
	if len(p) > 0 {
		d.nx = copy(d.x[:], p)
	}
	return
}

// Return sha256 sum in bytes
func (d *Avx512Digest) Sum(in []byte) (result []byte) {
	final := make([]byte, 0, 128)

	len := d.len
	// Padding.  Add a 1 bit and 0 bits until 56 bytes mod 64.
	var tmp [64]byte
	tmp[0] = 0x80
	if len%64 < 56 {
		final = append(d.x[:d.nx], tmp[0 : 56-len%64]...)
	} else {
		final = append(d.x[:d.nx], tmp[0 : 64+56-len%64]...)
	}
	d.nx = 0

	// Length in bits.
	len <<= 3
	for i := uint(0); i < 8; i++ {
		tmp[i] = byte(len >> (56 - 8*i))
	}
	final = append(final, tmp[0:8]...)

	sumCh := make(chan [Size]byte)
	d.a512srv.blocksCh <- blockInput{uid: d.uid, msg: final, final: true, sumCh: sumCh}
	output := <-sumCh
	// TODO: Cache output result until we have reset
	return append(in, output[:]...)
}

// Interface function to assembly ode
func blockAvx512(digests *[512]byte, input [16][]byte, mask []uint64) [][Size]byte {

	scratch := [512]byte{}
	sha256_x16_avx512(digests, &scratch, mask, input)

	// TODO: See if we can use statically size array
	output := make([][Size]byte, 16)
	for i := 0; i < 16; i++ {
		output[i] = getDigest(i, digests[:])
	}

	return output
}

func getDigest(index int, state []byte) (sum [Size]byte) {
	for j := 0; j < 16; j += 2 {
		for i := index*4 + j*Size; i < index*4+(j+1)*Size; i += Size {
			// TODO: See if we can prevent byte swapping
			binary.BigEndian.PutUint32(sum[j*2:], binary.LittleEndian.Uint32(state[i:i+4]))
		}
	}
	return
}

// Message to send across input channel
type blockInput struct {
	uid   uint64
	msg   []byte
	reset bool
	final bool
	sumCh chan [Size]byte
}

// Type to implement 16x parallel handling of SHA256 invocations
type Avx512Server struct {
	blocksCh chan blockInput       // Input channel
	totalIn  int                   // Total number of inputs waiting to be processed
	lanes    [16]Avx512LaneInfo    // Array with info per lane (out of 16)
	digests  map[uint64][Size]byte // Map of uids to (interim) digest results
}

// Info for each lane
type Avx512LaneInfo struct {
	uid      uint64          // unique identification for this SHA processing
	block    []byte          // input block to be processed
	outputCh chan [Size]byte // channel for output result
}

// Create new object for parallel processing handling
func NewAvx512Server() *Avx512Server {
	a512srv := &Avx512Server{}
	a512srv.digests = make(map[uint64][Size]byte)
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
			if block.reset {
				a512srv.reset(block.uid)
				continue
			}
			index := block.uid & 0xf
			// fmt.Println("Adding message:", block.uid, index)

			if a512srv.lanes[index].block != nil { // If slot is already filled, process all inputs
				//fmt.Println("Invoking Blocks()")
				a512srv.blocks()
			}
			a512srv.totalIn++
			a512srv.lanes[index] = Avx512LaneInfo{uid: block.uid, block: block.msg}
			if block.final {
				a512srv.lanes[index].outputCh = block.sumCh
			}
			if a512srv.totalIn == len(a512srv.lanes) {
				// fmt.Println("Invoking Blocks() while FULL: ")
				a512srv.blocks()
			}

			// TODO: test with larger timeout
		case <-time.After(1 * time.Microsecond):
			for _, lane := range a512srv.lanes {
				if lane.block != nil { // check if there is any input to process
					// fmt.Println("Invoking Blocks() on TIMEOUT: ")
					a512srv.blocks()
					break // we are done
				}
			}
		}
	}
}

// Do a reset for this calculation
func (a512srv *Avx512Server) reset(uid uint64) {

	// Check if there is a message still waiting to be processed (and remove if so)
	for i, lane := range a512srv.lanes {
		if lane.uid == uid {
			if lane.block != nil {
				a512srv.lanes[i] = Avx512LaneInfo{} // clear message
				a512srv.totalIn -= 1
			}
		}
	}

	// Delete entry from hash map
	delete(a512srv.digests, uid)
}

// Invoke assembly and send results back
func (a512srv *Avx512Server) blocks() (err error) {

	inputs := [16][]byte{}
	for i := range inputs {
		inputs[i] = a512srv.lanes[i].block
	}

	mask := expandMask(genMask(inputs))
	outputs := blockAvx512(a512srv.getDigests(), inputs, mask)

	a512srv.totalIn = 0
	for i := 0; i < len(outputs); i++ {
		uid, outputCh := a512srv.lanes[i].uid, a512srv.lanes[i].outputCh
		a512srv.digests[uid] = outputs[i]
		a512srv.lanes[i] = Avx512LaneInfo{}

		if outputCh != nil {
			// Send back result
			outputCh <- outputs[i]
			delete(a512srv.digests, uid) // Delete entry from hashmap
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
	for i, lane := range a512srv.lanes {
		a, ok := a512srv.digests[lane.uid]
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
