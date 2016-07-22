//+build !noasm

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
	"fmt"
)

//go:noescape
func block(h []uint32, message []uint8, xfer []uint32)

func Sha2562(dat []byte) string {

	h := []uint32{0x6a09e667,
		0xbb67ae85,
		0x3c6ef372,
		0xa54ff53a,
		0x510e527f,
		0x9b05688c,
		0x1f83d9ab,
		0x5be0cd19}

	// HACK: Just reserve some space on the stack
	xfer := []uint32{0x0, 0x1, 0x2, 0x3}

	blocks := len(dat) / 64

	if blocks > 0 {
		block(h[:], dat[:64*blocks], xfer[:])
	}

	return fmt.Sprintf("%08x-%08x-%08x-%08x-%08x-%08x-%08x-%08x", h[0], h[1], h[2], h[3], h[4], h[5], h[6], h[7])
}

