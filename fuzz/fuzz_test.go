package main

import (
	stdsha256 "crypto/sha256"
	sha256simd "github.com/minio/sha256-simd"
	"testing"
)

func Equal(a, b []byte) bool {
	if len(a) != len(b) {
		return false
	}
	for i, v := range a {
		if v != b[i] {
			return false
		}
	}
	return true
}

func FuzzSha256(f *testing.F) {
	f.Fuzz(func(t *testing.T, data []byte) {
		simdShaWriter := sha256simd.New()
		simdShaWriter.Write(data)

		stdShaWriter := stdsha256.New()
		stdShaWriter.Write(data)

		if !Equal(stdShaWriter.Sum(nil), simdShaWriter.Sum(nil)) {
			t.Fatalf("Expected equality between stdlib sha256 and simd sha256, but got different shas")
		}

	})
}
