/*
 * Minio Cloud Storage, (C) 2016 Minio, Inc.
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
	"crypto/sha256"
	"hash"
	"runtime"
	"encoding/binary"
)

// Size - The size of a SHA256 checksum in bytes.
const Size = 32

// BlockSize - The blocksize of SHA256 in bytes.
const BlockSize = 64

const (
	chunk = BlockSize
	init0 = 0x6A09E667
	init1 = 0xBB67AE85
	init2 = 0x3C6EF372
	init3 = 0xA54FF53A
	init4 = 0x510E527F
	init5 = 0x9B05688C
	init6 = 0x1F83D9AB
	init7 = 0x5BE0CD19
)

// digest represents the partial evaluation of a checksum.
type digest struct {
	h   [8]uint32
	x   [chunk]byte
	nx  int
	len uint64
}

// Reset digest back to default
func (d *digest) Reset() {
	d.h[0] = init0
	d.h[1] = init1
	d.h[2] = init2
	d.h[3] = init3
	d.h[4] = init4
	d.h[5] = init5
	d.h[6] = init6
	d.h[7] = init7
	d.nx = 0
	d.len = 0
}

type blockfuncType int

const (
	blockfuncGeneric blockfuncType = iota
	blockfuncAvx2 blockfuncType = iota
	blockfuncAvx blockfuncType = iota
	blockfuncSsse blockfuncType = iota
	blockfuncSha blockfuncType = iota
	blockfuncArm blockfuncType = iota
)

var blockfunc blockfuncType

func block(dig *digest, p []byte) {
	if blockfunc == blockfuncSha {
		blockShaGo(dig, p)
	} else if blockfunc == blockfuncAvx2 {
		blockAvx2Go(dig, p)
	} else if blockfunc == blockfuncAvx {
		blockAvxGo(dig, p)
	} else if blockfunc == blockfuncSsse {
		blockSsseGo(dig, p)
	} else if blockfunc == blockfuncArm {
		blockArmGo(dig, p)
	} else if blockfunc == blockfuncGeneric {
		blockGeneric(dig, p)
	}
}

func init() {
	is386bit := runtime.GOARCH == "386"
	isARM := runtime.GOARCH == "arm"
	switch {
	case is386bit || isARM:
		blockfunc = blockfuncGeneric
	case sha && ssse3 && sse41:
		blockfunc = blockfuncSha
	case avx2:
		blockfunc = blockfuncAvx2
	case avx:
		blockfunc = blockfuncAvx
	case ssse3:
		blockfunc = blockfuncSsse
	case armSha:
		blockfunc = blockfuncArm
	default:
		blockfunc = blockfuncGeneric
	}
}

// New returns a new hash.Hash computing the SHA256 checksum.
func New() hash.Hash {
	if blockfunc != blockfuncGeneric {
		d := new(digest)
		d.Reset()
		return d
	}
	// Fallback to the standard golang implementation
	// if no features were found.
	return sha256.New()
}

// Sum256 - single caller sha256 helper
func Sum256(data []byte) (result [Size]byte) {
	var d digest
	d.Reset()
	d.Write(data)
	result = d.checkSum()
	return
}

// Return size of checksum
func (d *digest) Size() int { return Size }

// Return blocksize of checksum
func (d *digest) BlockSize() int { return BlockSize }

// Write to digest
func (d *digest) Write(p []byte) (nn int, err error) {
	nn = len(p)
	d.len += uint64(nn)
	if d.nx > 0 {
		n := copy(d.x[d.nx:], p)
		d.nx += n
		if d.nx == chunk {
			block(d, d.x[:])
			d.nx = 0
		}
		p = p[n:]
	}
	if len(p) >= chunk {
		n := len(p) &^ (chunk - 1)
		block(d, p[:n])
		p = p[n:]
	}
	if len(p) > 0 {
		d.nx = copy(d.x[:], p)
	}
	return
}

// Return sha256 sum in bytes
func (d *digest) Sum(in []byte) []byte {
	// Make a copy of d0 so that caller can keep writing and summing.
	d0 := *d
	hash := d0.checkSum()
	return append(in, hash[:]...)
}

// Intermediate checksum function
func (d *digest) checkSum() (digest [Size]byte) {
	d.pad()

	{ const i = 0; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 1; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 2; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 3; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 4; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 5; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 6; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }
	{ const i = 7; binary.BigEndian.PutUint32(digest[i*4:i*4+4], d.h[i]); }

	return
}

// Apply end of data padding
func (d *digest) pad() {
	// Padding.  Add a 1 bit and 0 bits until 56 bytes mod 64.
	dx := &d.x
	i := d.nx
	d.nx = 0

	// Append a 1 bit and 7 0 bits
	dx[i] = 0x80
	i++

	// Clear trailing bytes in last uint64 fragment (if any)
	if i & 7 != 0 {
		mask := ^uint64(0) >> (uint(-i & 7) << 3)
		j := i &^ 7
		i = j + 8
		x := binary.LittleEndian.Uint64(dx[j:i])
		binary.LittleEndian.PutUint64(dx[j:i], x & mask)
	}

	if i == chunk {
		i = 0
		block(d, dx[:])
	}

	// Clear trailing bytes in block
	// Mask will be all ones if i < k else all zeros
	// Unrolled loop with constants avoids branches and bounds checks
	j := -i
	{
		const k = 0
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}
	{
		const k = 8
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}
	{
		const k = 16
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}
	{
		const k = 24
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}
	{
		const k = 32
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}
	{
		const k = 40
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}
	{
		const k = 48
		mask := uint64(int64(k+j)>>63)
		x := binary.LittleEndian.Uint64(dx[k:k+8])
		binary.LittleEndian.PutUint64(dx[k:k+8], x & mask)
	}

	// Finally append data length in bits
	{
		const k = 56
		binary.BigEndian.PutUint64(dx[k:k+8], d.len << 3)
	}

	block(d, dx[:])

	return
}
