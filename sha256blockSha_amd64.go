//go:build !noasm && !appengine && gc
// +build !noasm,!appengine,gc

package sha256

//go:noescape
func blockIntelSha(h *[8]uint32, message []uint8)
