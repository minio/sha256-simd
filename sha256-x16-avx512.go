package sha256

import "encoding/binary"
import "unsafe"

func blockAvx512(input [][]byte) {

	// state[0..511]  -> digests
	// state[512:639] -> 16 pointers to input data
	// state[640:]    -> scratch space
	state := make([]byte, 512+16*8+512)

	input[0][0] = byte(2)

	binary.LittleEndian.PutUint64(state[512+8*0:], uint64(uintptr(unsafe.Pointer(&input[0][0]))))
	binary.LittleEndian.PutUint64(state[512+8*1:], uint64(uintptr(unsafe.Pointer(&input[1][0]))))
	binary.LittleEndian.PutUint64(state[512+8*2:], uint64(uintptr(unsafe.Pointer(&input[2][0]))))
	binary.LittleEndian.PutUint64(state[512+8*3:], uint64(uintptr(unsafe.Pointer(&input[3][0]))))
	binary.LittleEndian.PutUint64(state[512+8*4:], uint64(uintptr(unsafe.Pointer(&input[4][0]))))
	binary.LittleEndian.PutUint64(state[512+8*5:], uint64(uintptr(unsafe.Pointer(&input[5][0]))))
	binary.LittleEndian.PutUint64(state[512+8*6:], uint64(uintptr(unsafe.Pointer(&input[6][0]))))
	binary.LittleEndian.PutUint64(state[512+8*7:], uint64(uintptr(unsafe.Pointer(&input[7][0]))))
	binary.LittleEndian.PutUint64(state[512+8*8:], uint64(uintptr(unsafe.Pointer(&input[8][0]))))
	binary.LittleEndian.PutUint64(state[512+8*9:], uint64(uintptr(unsafe.Pointer(&input[9][0]))))
	binary.LittleEndian.PutUint64(state[512+8*10:], uint64(uintptr(unsafe.Pointer(&input[10][0]))))
	binary.LittleEndian.PutUint64(state[512+8*11:], uint64(uintptr(unsafe.Pointer(&input[11][0]))))
	binary.LittleEndian.PutUint64(state[512+8*12:], uint64(uintptr(unsafe.Pointer(&input[12][0]))))
	binary.LittleEndian.PutUint64(state[512+8*13:], uint64(uintptr(unsafe.Pointer(&input[13][0]))))
	binary.LittleEndian.PutUint64(state[512+8*14:], uint64(uintptr(unsafe.Pointer(&input[14][0]))))
	binary.LittleEndian.PutUint64(state[512+8*15:], uint64(uintptr(unsafe.Pointer(&input[15][0]))))

	blocksIn64Bytes := uint64(len(input[0]) >> 6)
	sha256_x16_avx512(state, blocksIn64Bytes)

	// fmt.Println(state[:64])
}
