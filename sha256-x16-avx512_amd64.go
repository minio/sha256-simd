package sha256

//go:noescape
func sha256_x16_avx512(state []byte, blocks uint64)
