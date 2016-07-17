// ARM64 version of SHA256


TEXT ·block(SB), NOSPLIT, $0
	MOVD h+0(FP), R0
	MOVD message+24(FP), R1
	MOVD lenmessage+32(FP), R2 // length of message
	SUBS $64, R2
	BMI  complete

loop:

	SUBS $64, R2
	BPL  loop

complete:
	RET

