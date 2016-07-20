// ARM64 version of SHA256

//
// Based on implementaion as found in  https://github.com/jocover/sha256-armv8
//
// Use github.com/minio/asm2plan9s on this file to assemble ARM instructions to their Plan9 equivalent
//

TEXT ·block(SB), NOSPLIT, $0
	MOVD h+0(FP), R0
	MOVD message+24(FP), R1
	MOVD lenmessage+32(FP), R2 // length of message
	SUBS $64, R2
	BMI  complete

loop:
	WORD $0x4cdf2025 // ld1	{v5.16b-v8.16b}, [x1], #64
	WORD $0x4ea01c02 // mov	v2.16b, v0.16b
	WORD $0x4ea11c23 // mov	v3.16b, v1.16b
	WORD $0x6e2008a5 // rev32	v5.16b, v5.16b
	WORD $0x6e2008c6 // rev32	v6.16b, v6.16b
	WORD $0x4eb084a9 // add	v9.4s, v5.4s, v16.4s
	WORD $0x6e2008e7 // rev32	v7.16b, v7.16b
	WORD $0x4eb184ca // add	v10.4s, v6.4s, v17.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e2828c5 // sha256su0	v5.4s, v6.4s
	WORD $0x6e200908 // rev32	v8.16b, v8.16b
	WORD $0x4eb284e9 // add	v9.4s, v7.4s, v18.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x5e2828e6 // sha256su0	v6.4s, v7.4s
	WORD $0x5e0860e5 // sha256su1	v5.4s, v7.4s, v8.4s
	WORD $0x4eb3850a // add	v10.4s, v8.4s, v19.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e282907 // sha256su0	v7.4s, v8.4s
	WORD $0x5e056106 // sha256su1	v6.4s, v8.4s, v5.4s
	WORD $0x4eb484a9 // add	v9.4s, v5.4s, v20.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x5e2828a8 // sha256su0	v8.4s, v5.4s
	WORD $0x5e0660a7 // sha256su1	v7.4s, v5.4s, v6.4s
	WORD $0x4eb584ca // add	v10.4s, v6.4s, v21.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e2828c5 // sha256su0	v5.4s, v6.4s
	WORD $0x5e0760c8 // sha256su1	v8.4s, v6.4s, v7.4s
	WORD $0x4eb684e9 // add	v9.4s, v7.4s, v22.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x5e2828e6 // sha256su0	v6.4s, v7.4s
	WORD $0x5e0860e5 // sha256su1	v5.4s, v7.4s, v8.4s
	WORD $0x4eb7850a // add	v10.4s, v8.4s, v23.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e282907 // sha256su0	v7.4s, v8.4s
	WORD $0x5e056106 // sha256su1	v6.4s, v8.4s, v5.4s
	WORD $0x4eb884a9 // add	v9.4s, v5.4s, v24.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x5e2828a8 // sha256su0	v8.4s, v5.4s
	WORD $0x5e0660a7 // sha256su1	v7.4s, v5.4s, v6.4s
	WORD $0x4eb984ca // add	v10.4s, v6.4s, v25.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e2828c5 // sha256su0	v5.4s, v6.4s
	WORD $0x5e0760c8 // sha256su1	v8.4s, v6.4s, v7.4s
	WORD $0x4eba84e9 // add	v9.4s, v7.4s, v26.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x5e2828e6 // sha256su0	v6.4s, v7.4s
	WORD $0x5e0860e5 // sha256su1	v5.4s, v7.4s, v8.4s
	WORD $0x4ebb850a // add	v10.4s, v8.4s, v27.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e282907 // sha256su0	v7.4s, v8.4s
	WORD $0x5e056106 // sha256su1	v6.4s, v8.4s, v5.4s
	WORD $0x4ebc84a9 // add	v9.4s, v5.4s, v28.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x5e2828a8 // sha256su0	v8.4s, v5.4s
	WORD $0x5e0660a7 // sha256su1	v7.4s, v5.4s, v6.4s
	WORD $0x4ebd84ca // add	v10.4s, v6.4s, v29.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x5e0760c8 // sha256su1	v8.4s, v6.4s, v7.4s
	WORD $0x4ebe84e9 // add	v9.4s, v7.4s, v30.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x4ebf850a // add	v10.4s, v8.4s, v31.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e094062 // sha256h	q2, q3, v9.4s
	WORD $0x5e095083 // sha256h2	q3, q4, v9.4s
	WORD $0x4ea21c44 // mov	v4.16b, v2.16b
	WORD $0x5e0a4062 // sha256h	q2, q3, v10.4s
	WORD $0x5e0a5083 // sha256h2	q3, q4, v10.4s
	WORD $0x4ea38421 // add	v1.4s, v1.4s, v3.4s
	WORD $0x4ea28400 // add	v0.4s, v0.4s, v2.4s

	SUBS $64, R2
	BPL  loop

	WORD $0x4c00a800 // st1	{v0.4s, v1.4s}, [x0]

complete:
	RET

