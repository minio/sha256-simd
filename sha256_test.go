package sha256

import (
	"testing"
)

func TestSum(t *testing.T) {

	dat := make([]byte, 1024, 1024)
	for i := 0; i < len(dat); i++ {
		dat[i] = byte(i)
	}

	Sha256(dat)
}
