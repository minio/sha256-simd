//+build !noasm

package sha256

//go:noescape
func block(h []uint32, message []uint8)

func Sha256(dat []byte) {

	h := []uint32{0x6a09e667,
		0xbb67ae85,
		0x3c6ef372,
		0xa54ff53a,
		0x510e527f,
		0x9b05688c,
		0x1f83d9ab,
		0x5be0cd19}

	blocks := len(dat) / 64

	if blocks > 0 {
		block(h[:], dat[:64*blocks])
	}
}
