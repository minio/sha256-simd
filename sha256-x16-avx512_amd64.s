TEXT ·sha256_x16_avx512(SB), 7, $0
	MOVQ state+0(FP), DI
	MOVQ blocks+24(FP), SI
	LONG $0x487ef162; WORD $0x076f // vmovdqu32 zmm0, [rdi+0*64]
	LONG $0x487ef162; WORD $0x4f6f; BYTE $0x01 // vmovdqu32 zmm1, [rdi+1*64]
	LONG $0x487ef162; WORD $0x576f; BYTE $0x02 // vmovdqu32 zmm2, [rdi+2*64]
	LONG $0x487ef162; WORD $0x5f6f; BYTE $0x03 // vmovdqu32 zmm3, [rdi+3*64]
	LONG $0x487ef162; WORD $0x676f; BYTE $0x04 // vmovdqu32 zmm4, [rdi+4*64]
	LONG $0x487ef162; WORD $0x6f6f; BYTE $0x05 // vmovdqu32 zmm5, [rdi+5*64]
	LONG $0x487ef162; WORD $0x776f; BYTE $0x06 // vmovdqu32 zmm6, [rdi+6*64]
	LONG $0x487ef162; WORD $0x7f6f; BYTE $0x07 // vmovdqu32 zmm7, [rdi+7*64]
	LEAQ TABLE<>(SB), DX
	WORD $0x3148; BYTE $0xc9 // xor rcx, rcx
	LONG $0x008f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+0*8]
	LONG $0x08978b4c; WORD $0x0002; BYTE $0x00 // mov r10, [rdi+8*64+1*8]
	LONG $0x109f8b4c; WORD $0x0002; BYTE $0x00 // mov r11, [rdi+8*64+2*8]
	LONG $0x18a78b4c; WORD $0x0002; BYTE $0x00 // mov r12, [rdi+8*64+3*8]
	LONG $0x20af8b4c; WORD $0x0002; BYTE $0x00 // mov r13, [rdi+8*64+4*8]
	LONG $0x28b78b4c; WORD $0x0002; BYTE $0x00 // mov r14, [rdi+8*64+5*8]
	LONG $0x30bf8b4c; WORD $0x0002; BYTE $0x00 // mov r15, [rdi+8*64+6*8]
	LONG $0x38878b48; WORD $0x0002; BYTE $0x00 // mov rax, [rdi+8*64+7*8]
	LONG $0x487cc162; WORD $0x0410; BYTE $0x09 // vmovups zmm16, [r9+rcx]
	LONG $0x487cc162; WORD $0x0c10; BYTE $0x0a // vmovups zmm17, [r10+rcx]
	LONG $0x487cc162; WORD $0x1410; BYTE $0x0b // vmovups zmm18, [r11+rcx]
	LONG $0x487cc162; WORD $0x1c10; BYTE $0x0c // vmovups zmm19, [r12+rcx]
	LONG $0x487cc162; LONG $0x000d6410 // vmovups zmm20, [r13+rcx]
	LONG $0x487cc162; WORD $0x2c10; BYTE $0x0e // vmovups zmm21, [r14+rcx]
	LONG $0x487cc162; WORD $0x3410; BYTE $0x0f // vmovups zmm22, [r15+rcx]
	LONG $0x487ce162; WORD $0x3c10; BYTE $0x08 // vmovups zmm23, [rax+rcx]
	LONG $0x408f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+8*8]
	LONG $0x48978b4c; WORD $0x0002; BYTE $0x00 // mov r10, [rdi+8*64+9*8]
	LONG $0x509f8b4c; WORD $0x0002; BYTE $0x00 // mov r11, [rdi+8*64+10*8]
	LONG $0x58a78b4c; WORD $0x0002; BYTE $0x00 // mov r12, [rdi+8*64+11*8]
	LONG $0x60af8b4c; WORD $0x0002; BYTE $0x00 // mov r13, [rdi+8*64+12*8]
	LONG $0x68b78b4c; WORD $0x0002; BYTE $0x00 // mov r14, [rdi+8*64+13*8]
	LONG $0x70bf8b4c; WORD $0x0002; BYTE $0x00 // mov r15, [rdi+8*64+14*8]
	LONG $0x78878b48; WORD $0x0002; BYTE $0x00 // mov rax, [rdi+8*64+15*8]
	LONG $0x487c4162; WORD $0x0410; BYTE $0x09 // vmovups zmm24, [r9+rcx]
	LONG $0x487c4162; WORD $0x0c10; BYTE $0x0a // vmovups zmm25, [r10+rcx]
	LONG $0x487c4162; WORD $0x1410; BYTE $0x0b // vmovups zmm26, [r11+rcx]
	LONG $0x487c4162; WORD $0x1c10; BYTE $0x0c // vmovups zmm27, [r12+rcx]
	LONG $0x487c4162; LONG $0x000d6410 // vmovups zmm28, [r13+rcx]
	LONG $0x487c4162; WORD $0x2c10; BYTE $0x0e // vmovups zmm29, [r14+rcx]
	LONG $0x487c4162; WORD $0x3410; BYTE $0x0f // vmovups zmm30, [r15+rcx]
	LONG $0x487c6162; WORD $0x3c10; BYTE $0x08 // vmovups zmm31, [rax+rcx]
	JMP lloop
lloop:
	LEAQ PSHUFFLE_BYTE_FLIP_MASK<>(SB), DX
	LONG $0x487e7162; WORD $0x1a6f // vmovdqu32 zmm11, [rdx]
	LEAQ TABLE<>(SB), DX
	LONG $0x487e7162; WORD $0x226f // vmovdqu32 zmm12, [rdx]
	LONG $0x487ef162; LONG $0x0000877f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*0], zmm0
	LONG $0x487ef162; LONG $0x00008f7f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*1], zmm1
	LONG $0x487ef162; LONG $0x0000977f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*2], zmm2
	LONG $0x487ef162; LONG $0x00009f7f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*3], zmm3
	LONG $0x487ef162; LONG $0x0000a77f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*4], zmm4
	LONG $0x487ef162; LONG $0x0000af7f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*5], zmm5
	LONG $0x487ef162; LONG $0x0000b77f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*6], zmm6
	LONG $0x487ef162; LONG $0x0000bf7f; WORD $0x0000 // vmovdqu32 [rdi+_DIGEST_SAVE+64*7], zmm7
	LONG $0x40c18348 // add rcx, 64
	LONG $0x407c3162; WORD $0xc9c6; BYTE $0x44 // vshufps zmm9, zmm16, zmm17, 0x44
	LONG $0x407ca162; WORD $0xc1c6; BYTE $0xee // vshufps zmm16, zmm16, zmm17, 0xEE
	LONG $0x406c3162; WORD $0xd3c6; BYTE $0x44 // vshufps zmm10, zmm18, zmm19, 0x44
	LONG $0x406ca162; WORD $0xd3c6; BYTE $0xee // vshufps zmm18, zmm18, zmm19, 0xEE
	LONG $0x4834c162; WORD $0xdac6; BYTE $0xdd // vshufps zmm19, zmm9, zmm10, 0xDD
	LONG $0x407ca162; WORD $0xcac6; BYTE $0x88 // vshufps zmm17, zmm16, zmm18, 0x88
	LONG $0x407ca162; WORD $0xc2c6; BYTE $0xdd // vshufps zmm16, zmm16, zmm18, 0xDD
	LONG $0x48345162; WORD $0xcac6; BYTE $0x88 // vshufps zmm9, zmm9, zmm10, 0x88
	LONG $0x405ca162; WORD $0xd5c6; BYTE $0x44 // vshufps zmm18, zmm20, zmm21, 0x44
	LONG $0x405ca162; WORD $0xe5c6; BYTE $0xee // vshufps zmm20, zmm20, zmm21, 0xEE
	LONG $0x404c3162; WORD $0xd7c6; BYTE $0x44 // vshufps zmm10, zmm22, zmm23, 0x44
	LONG $0x404ca162; WORD $0xf7c6; BYTE $0xee // vshufps zmm22, zmm22, zmm23, 0xEE
	LONG $0x406cc162; WORD $0xfac6; BYTE $0xdd // vshufps zmm23, zmm18, zmm10, 0xDD
	LONG $0x405ca162; WORD $0xeec6; BYTE $0x88 // vshufps zmm21, zmm20, zmm22, 0x88
	LONG $0x405ca162; WORD $0xe6c6; BYTE $0xdd // vshufps zmm20, zmm20, zmm22, 0xDD
	LONG $0x406cc162; WORD $0xd2c6; BYTE $0x88 // vshufps zmm18, zmm18, zmm10, 0x88
	LONG $0x403c8162; WORD $0xf1c6; BYTE $0x44 // vshufps zmm22, zmm24, zmm25, 0x44
	LONG $0x403c0162; WORD $0xc1c6; BYTE $0xee // vshufps zmm24, zmm24, zmm25, 0xEE
	LONG $0x402c1162; WORD $0xd3c6; BYTE $0x44 // vshufps zmm10, zmm26, zmm27, 0x44
	LONG $0x402c0162; WORD $0xd3c6; BYTE $0xee // vshufps zmm26, zmm26, zmm27, 0xEE
	LONG $0x404c4162; WORD $0xdac6; BYTE $0xdd // vshufps zmm27, zmm22, zmm10, 0xDD
	LONG $0x403c0162; WORD $0xcac6; BYTE $0x88 // vshufps zmm25, zmm24, zmm26, 0x88
	LONG $0x403c0162; WORD $0xc2c6; BYTE $0xdd // vshufps zmm24, zmm24, zmm26, 0xDD
	LONG $0x404cc162; WORD $0xf2c6; BYTE $0x88 // vshufps zmm22, zmm22, zmm10, 0x88
	LONG $0x401c0162; WORD $0xd5c6; BYTE $0x44 // vshufps zmm26, zmm28, zmm29, 0x44
	LONG $0x401c0162; WORD $0xe5c6; BYTE $0xee // vshufps zmm28, zmm28, zmm29, 0xEE
	LONG $0x400c1162; WORD $0xd7c6; BYTE $0x44 // vshufps zmm10, zmm30, zmm31, 0x44
	LONG $0x400c0162; WORD $0xf7c6; BYTE $0xee // vshufps zmm30, zmm30, zmm31, 0xEE
	LONG $0x402c4162; WORD $0xfac6; BYTE $0xdd // vshufps zmm31, zmm26, zmm10, 0xDD
	LONG $0x401c0162; WORD $0xeec6; BYTE $0x88 // vshufps zmm29, zmm28, zmm30, 0x88
	LONG $0x401c0162; WORD $0xe6c6; BYTE $0xdd // vshufps zmm28, zmm28, zmm30, 0xDD
	LONG $0x402c4162; WORD $0xd2c6; BYTE $0x88 // vshufps zmm26, zmm26, zmm10, 0x88
	LEAQ PSHUFFLE_TRANSPOSE16_MASK1<>(SB), BX
	LEAQ PSHUFFLE_TRANSPOSE16_MASK2<>(SB), R8
	LONG $0x487e6162; WORD $0x336f // vmovdqu32 zmm30, [rbx]
	LONG $0x48b52262; WORD $0xf276 // vpermi2q zmm30, zmm9, zmm18
	LONG $0x487e5162; WORD $0x106f // vmovdqu32 zmm10, [r8]
	LONG $0x48b53262; WORD $0xd276 // vpermi2q zmm10, zmm9, zmm18
	LONG $0x487ee162; WORD $0x136f // vmovdqu32 zmm18, [rbx]
	LONG $0x40e5a262; WORD $0xd776 // vpermi2q zmm18, zmm19, zmm23
	LONG $0x487e5162; WORD $0x086f // vmovdqu32 zmm9, [r8]
	LONG $0x40e53262; WORD $0xcf76 // vpermi2q zmm9, zmm19, zmm23
	LONG $0x487ee162; WORD $0x1b6f // vmovdqu32 zmm19, [rbx]
	LONG $0x40f5a262; WORD $0xdd76 // vpermi2q zmm19, zmm17, zmm21
	LONG $0x487ec162; WORD $0x386f // vmovdqu32 zmm23, [r8]
	LONG $0x40f5a262; WORD $0xfd76 // vpermi2q zmm23, zmm17, zmm21
	LONG $0x487ee162; WORD $0x0b6f // vmovdqu32 zmm17, [rbx]
	LONG $0x40fda262; WORD $0xcc76 // vpermi2q zmm17, zmm16, zmm20
	LONG $0x487ec162; WORD $0x286f // vmovdqu32 zmm21, [r8]
	LONG $0x40fda262; WORD $0xec76 // vpermi2q zmm21, zmm16, zmm20
	LONG $0x487ee162; WORD $0x036f // vmovdqu32 zmm16, [rbx]
	LONG $0x40cd8262; WORD $0xc276 // vpermi2q zmm16, zmm22, zmm26
	LONG $0x487ec162; WORD $0x206f // vmovdqu32 zmm20, [r8]
	LONG $0x40cd8262; WORD $0xe276 // vpermi2q zmm20, zmm22, zmm26
	LONG $0x487ee162; WORD $0x336f // vmovdqu32 zmm22, [rbx]
	LONG $0x40a58262; WORD $0xf776 // vpermi2q zmm22, zmm27, zmm31
	LONG $0x487e4162; WORD $0x106f // vmovdqu32 zmm26, [r8]
	LONG $0x40a50262; WORD $0xd776 // vpermi2q zmm26, zmm27, zmm31
	LONG $0x487e6162; WORD $0x1b6f // vmovdqu32 zmm27, [rbx]
	LONG $0x40b50262; WORD $0xdd76 // vpermi2q zmm27, zmm25, zmm29
	LONG $0x487e4162; WORD $0x386f // vmovdqu32 zmm31, [r8]
	LONG $0x40b50262; WORD $0xfd76 // vpermi2q zmm31, zmm25, zmm29
	LONG $0x487e6162; WORD $0x0b6f // vmovdqu32 zmm25, [rbx]
	LONG $0x40bd0262; WORD $0xcc76 // vpermi2q zmm25, zmm24, zmm28
	LONG $0x487e4162; WORD $0x286f // vmovdqu32 zmm29, [r8]
	LONG $0x40bd0262; WORD $0xec76 // vpermi2q zmm29, zmm24, zmm28
	LONG $0x408d2362; WORD $0xc023; BYTE $0xee // vshuff64x2 zmm24, zmm30, zmm16, 0xEE
	LONG $0x408da362; WORD $0xc023; BYTE $0x44 // vshuff64x2 zmm16, zmm30, zmm16, 0x44
	LONG $0x48ad2362; WORD $0xe423; BYTE $0xee // vshuff64x2 zmm28, zmm10, zmm20, 0xEE
	LONG $0x48ada362; WORD $0xe423; BYTE $0x44 // vshuff64x2 zmm20, zmm10, zmm20, 0x44
	LONG $0x40c50362; WORD $0xf723; BYTE $0xee // vshuff64x2 zmm30, zmm23, zmm31, 0xEE
	LONG $0x40c51362; WORD $0xd723; BYTE $0x44 // vshuff64x2 zmm10, zmm23, zmm31, 0x44
	LONG $0x40d50362; WORD $0xfd23; BYTE $0xee // vshuff64x2 zmm31, zmm21, zmm29, 0xEE
	LONG $0x40d58362; WORD $0xfd23; BYTE $0x44 // vshuff64x2 zmm23, zmm21, zmm29, 0x44
	LONG $0x48b50362; WORD $0xea23; BYTE $0xee // vshuff64x2 zmm29, zmm9, zmm26, 0xEE
	LONG $0x48b58362; WORD $0xea23; BYTE $0x44 // vshuff64x2 zmm21, zmm9, zmm26, 0x44
	LONG $0x40e50362; WORD $0xd323; BYTE $0xee // vshuff64x2 zmm26, zmm19, zmm27, 0xEE
	LONG $0x40e51362; WORD $0xcb23; BYTE $0x44 // vshuff64x2 zmm9, zmm19, zmm27, 0x44
	LONG $0x40f50362; WORD $0xd923; BYTE $0xee // vshuff64x2 zmm27, zmm17, zmm25, 0xEE
	LONG $0x40f58362; WORD $0xd923; BYTE $0x44 // vshuff64x2 zmm19, zmm17, zmm25, 0x44
	LONG $0x40ed2362; WORD $0xce23; BYTE $0xee // vshuff64x2 zmm25, zmm18, zmm22, 0xEE
	LONG $0x40eda362; WORD $0xce23; BYTE $0x44 // vshuff64x2 zmm17, zmm18, zmm22, 0x44
	LONG $0x487ec162; WORD $0xd16f // vmovdqu32 zmm18, zmm9
	LONG $0x487ec162; WORD $0xf26f // vmovdqu32 zmm22, zmm10
	LONG $0x407dc262; WORD $0xc300 // vpshufb zmm16, zmm16, zmm11
	LONG $0x4075c262; WORD $0xcb00 // vpshufb zmm17, zmm17, zmm11
	LONG $0x406dc262; WORD $0xd300 // vpshufb zmm18, zmm18, zmm11
	LONG $0x4065c262; WORD $0xdb00 // vpshufb zmm19, zmm19, zmm11
	LONG $0x405dc262; WORD $0xe300 // vpshufb zmm20, zmm20, zmm11
	LONG $0x4055c262; WORD $0xeb00 // vpshufb zmm21, zmm21, zmm11
	LONG $0x404dc262; WORD $0xf300 // vpshufb zmm22, zmm22, zmm11
	LONG $0x4045c262; WORD $0xfb00 // vpshufb zmm23, zmm23, zmm11
	LONG $0x403d4262; WORD $0xc300 // vpshufb zmm24, zmm24, zmm11
	LONG $0x40354262; WORD $0xcb00 // vpshufb zmm25, zmm25, zmm11
	LONG $0x402d4262; WORD $0xd300 // vpshufb zmm26, zmm26, zmm11
	LONG $0x40254262; WORD $0xdb00 // vpshufb zmm27, zmm27, zmm11
	LONG $0x401d4262; WORD $0xe300 // vpshufb zmm28, zmm28, zmm11
	LONG $0x40154262; WORD $0xeb00 // vpshufb zmm29, zmm29, zmm11
	LONG $0x400d4262; WORD $0xf300 // vpshufb zmm30, zmm30, zmm11
	LONG $0x40054262; WORD $0xfb00 // vpshufb zmm31, zmm31, zmm11
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d3162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm16
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x01 // vmovdqu32 zmm12, [rdx+((0+1)*64)]
	LONG $0x48159162; WORD $0xc672; BYTE $0x11 // vprord zmm13, zmm30, 17
	LONG $0x480d9162; WORD $0xc672; BYTE $0x13 // vprord zmm14, zmm30, 19
	LONG $0x48059162; WORD $0xd672; BYTE $0x0a // vpsrld zmm15, zmm30, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x407dc162; WORD $0xc5fe // vpaddd zmm16, zmm16, zmm13
	LONG $0x407d8162; WORD $0xc1fe // vpaddd zmm16, zmm16, zmm25
	LONG $0x4815b162; WORD $0xc172; BYTE $0x07 // vprord zmm13, zmm17, 7
	LONG $0x480db162; WORD $0xc172; BYTE $0x12 // vprord zmm14, zmm17, 18
	LONG $0x4805b162; WORD $0xd172; BYTE $0x03 // vpsrld zmm15, zmm17, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x407dc162; WORD $0xc5fe // vpaddd zmm16, zmm16, zmm13
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d3162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm17
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x02 // vmovdqu32 zmm12, [rdx+((1+1)*64)]
	LONG $0x48159162; WORD $0xc772; BYTE $0x11 // vprord zmm13, zmm31, 17
	LONG $0x480d9162; WORD $0xc772; BYTE $0x13 // vprord zmm14, zmm31, 19
	LONG $0x48059162; WORD $0xd772; BYTE $0x0a // vpsrld zmm15, zmm31, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4075c162; WORD $0xcdfe // vpaddd zmm17, zmm17, zmm13
	LONG $0x40758162; WORD $0xcafe // vpaddd zmm17, zmm17, zmm26
	LONG $0x4815b162; WORD $0xc272; BYTE $0x07 // vprord zmm13, zmm18, 7
	LONG $0x480db162; WORD $0xc272; BYTE $0x12 // vprord zmm14, zmm18, 18
	LONG $0x4805b162; WORD $0xd272; BYTE $0x03 // vpsrld zmm15, zmm18, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4075c162; WORD $0xcdfe // vpaddd zmm17, zmm17, zmm13
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d3162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm18
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x03 // vmovdqu32 zmm12, [rdx+((2+1)*64)]
	LONG $0x4815b162; WORD $0xc072; BYTE $0x11 // vprord zmm13, zmm16, 17
	LONG $0x480db162; WORD $0xc072; BYTE $0x13 // vprord zmm14, zmm16, 19
	LONG $0x4805b162; WORD $0xd072; BYTE $0x0a // vpsrld zmm15, zmm16, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x406dc162; WORD $0xd5fe // vpaddd zmm18, zmm18, zmm13
	LONG $0x406d8162; WORD $0xd3fe // vpaddd zmm18, zmm18, zmm27
	LONG $0x4815b162; WORD $0xc372; BYTE $0x07 // vprord zmm13, zmm19, 7
	LONG $0x480db162; WORD $0xc372; BYTE $0x12 // vprord zmm14, zmm19, 18
	LONG $0x4805b162; WORD $0xd372; BYTE $0x03 // vpsrld zmm15, zmm19, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x406dc162; WORD $0xd5fe // vpaddd zmm18, zmm18, zmm13
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d3162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm19
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x04 // vmovdqu32 zmm12, [rdx+((3+1)*64)]
	LONG $0x4815b162; WORD $0xc172; BYTE $0x11 // vprord zmm13, zmm17, 17
	LONG $0x480db162; WORD $0xc172; BYTE $0x13 // vprord zmm14, zmm17, 19
	LONG $0x4805b162; WORD $0xd172; BYTE $0x0a // vpsrld zmm15, zmm17, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4065c162; WORD $0xddfe // vpaddd zmm19, zmm19, zmm13
	LONG $0x40658162; WORD $0xdcfe // vpaddd zmm19, zmm19, zmm28
	LONG $0x4815b162; WORD $0xc472; BYTE $0x07 // vprord zmm13, zmm20, 7
	LONG $0x480db162; WORD $0xc472; BYTE $0x12 // vprord zmm14, zmm20, 18
	LONG $0x4805b162; WORD $0xd472; BYTE $0x03 // vpsrld zmm15, zmm20, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4065c162; WORD $0xddfe // vpaddd zmm19, zmm19, zmm13
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d3162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm20
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x05 // vmovdqu32 zmm12, [rdx+((4+1)*64)]
	LONG $0x4815b162; WORD $0xc272; BYTE $0x11 // vprord zmm13, zmm18, 17
	LONG $0x480db162; WORD $0xc272; BYTE $0x13 // vprord zmm14, zmm18, 19
	LONG $0x4805b162; WORD $0xd272; BYTE $0x0a // vpsrld zmm15, zmm18, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x405dc162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm13
	LONG $0x405d8162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm29
	LONG $0x4815b162; WORD $0xc572; BYTE $0x07 // vprord zmm13, zmm21, 7
	LONG $0x480db162; WORD $0xc572; BYTE $0x12 // vprord zmm14, zmm21, 18
	LONG $0x4805b162; WORD $0xd572; BYTE $0x03 // vpsrld zmm15, zmm21, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x405dc162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm13
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d3162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm21
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x06 // vmovdqu32 zmm12, [rdx+((5+1)*64)]
	LONG $0x4815b162; WORD $0xc372; BYTE $0x11 // vprord zmm13, zmm19, 17
	LONG $0x480db162; WORD $0xc372; BYTE $0x13 // vprord zmm14, zmm19, 19
	LONG $0x4805b162; WORD $0xd372; BYTE $0x0a // vpsrld zmm15, zmm19, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4055c162; WORD $0xedfe // vpaddd zmm21, zmm21, zmm13
	LONG $0x40558162; WORD $0xeefe // vpaddd zmm21, zmm21, zmm30
	LONG $0x4815b162; WORD $0xc672; BYTE $0x07 // vprord zmm13, zmm22, 7
	LONG $0x480db162; WORD $0xc672; BYTE $0x12 // vprord zmm14, zmm22, 18
	LONG $0x4805b162; WORD $0xd672; BYTE $0x03 // vpsrld zmm15, zmm22, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4055c162; WORD $0xedfe // vpaddd zmm21, zmm21, zmm13
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d3162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm22
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x07 // vmovdqu32 zmm12, [rdx+((6+1)*64)]
	LONG $0x4815b162; WORD $0xc472; BYTE $0x11 // vprord zmm13, zmm20, 17
	LONG $0x480db162; WORD $0xc472; BYTE $0x13 // vprord zmm14, zmm20, 19
	LONG $0x4805b162; WORD $0xd472; BYTE $0x0a // vpsrld zmm15, zmm20, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x404dc162; WORD $0xf5fe // vpaddd zmm22, zmm22, zmm13
	LONG $0x404d8162; WORD $0xf7fe // vpaddd zmm22, zmm22, zmm31
	LONG $0x4815b162; WORD $0xc772; BYTE $0x07 // vprord zmm13, zmm23, 7
	LONG $0x480db162; WORD $0xc772; BYTE $0x12 // vprord zmm14, zmm23, 18
	LONG $0x4805b162; WORD $0xd772; BYTE $0x03 // vpsrld zmm15, zmm23, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x404dc162; WORD $0xf5fe // vpaddd zmm22, zmm22, zmm13
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d3162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm23
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x08 // vmovdqu32 zmm12, [rdx+((7+1)*64)]
	LONG $0x4815b162; WORD $0xc572; BYTE $0x11 // vprord zmm13, zmm21, 17
	LONG $0x480db162; WORD $0xc572; BYTE $0x13 // vprord zmm14, zmm21, 19
	LONG $0x4805b162; WORD $0xd572; BYTE $0x0a // vpsrld zmm15, zmm21, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4045c162; WORD $0xfdfe // vpaddd zmm23, zmm23, zmm13
	LONG $0x4045a162; WORD $0xf8fe // vpaddd zmm23, zmm23, zmm16
	LONG $0x48159162; WORD $0xc072; BYTE $0x07 // vprord zmm13, zmm24, 7
	LONG $0x480d9162; WORD $0xc072; BYTE $0x12 // vprord zmm14, zmm24, 18
	LONG $0x48059162; WORD $0xd072; BYTE $0x03 // vpsrld zmm15, zmm24, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4045c162; WORD $0xfdfe // vpaddd zmm23, zmm23, zmm13
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d1162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm24
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x09 // vmovdqu32 zmm12, [rdx+((8+1)*64)]
	LONG $0x4815b162; WORD $0xc672; BYTE $0x11 // vprord zmm13, zmm22, 17
	LONG $0x480db162; WORD $0xc672; BYTE $0x13 // vprord zmm14, zmm22, 19
	LONG $0x4805b162; WORD $0xd672; BYTE $0x0a // vpsrld zmm15, zmm22, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x403d4162; WORD $0xc5fe // vpaddd zmm24, zmm24, zmm13
	LONG $0x403d2162; WORD $0xc1fe // vpaddd zmm24, zmm24, zmm17
	LONG $0x48159162; WORD $0xc172; BYTE $0x07 // vprord zmm13, zmm25, 7
	LONG $0x480d9162; WORD $0xc172; BYTE $0x12 // vprord zmm14, zmm25, 18
	LONG $0x48059162; WORD $0xd172; BYTE $0x03 // vpsrld zmm15, zmm25, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x403d4162; WORD $0xc5fe // vpaddd zmm24, zmm24, zmm13
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d1162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm25
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x0a // vmovdqu32 zmm12, [rdx+((9+1)*64)]
	LONG $0x4815b162; WORD $0xc772; BYTE $0x11 // vprord zmm13, zmm23, 17
	LONG $0x480db162; WORD $0xc772; BYTE $0x13 // vprord zmm14, zmm23, 19
	LONG $0x4805b162; WORD $0xd772; BYTE $0x0a // vpsrld zmm15, zmm23, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40354162; WORD $0xcdfe // vpaddd zmm25, zmm25, zmm13
	LONG $0x40352162; WORD $0xcafe // vpaddd zmm25, zmm25, zmm18
	LONG $0x48159162; WORD $0xc272; BYTE $0x07 // vprord zmm13, zmm26, 7
	LONG $0x480d9162; WORD $0xc272; BYTE $0x12 // vprord zmm14, zmm26, 18
	LONG $0x48059162; WORD $0xd272; BYTE $0x03 // vpsrld zmm15, zmm26, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40354162; WORD $0xcdfe // vpaddd zmm25, zmm25, zmm13
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d1162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm26
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x0b // vmovdqu32 zmm12, [rdx+((10+1)*64)]
	LONG $0x48159162; WORD $0xc072; BYTE $0x11 // vprord zmm13, zmm24, 17
	LONG $0x480d9162; WORD $0xc072; BYTE $0x13 // vprord zmm14, zmm24, 19
	LONG $0x48059162; WORD $0xd072; BYTE $0x0a // vpsrld zmm15, zmm24, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x402d4162; WORD $0xd5fe // vpaddd zmm26, zmm26, zmm13
	LONG $0x402d2162; WORD $0xd3fe // vpaddd zmm26, zmm26, zmm19
	LONG $0x48159162; WORD $0xc372; BYTE $0x07 // vprord zmm13, zmm27, 7
	LONG $0x480d9162; WORD $0xc372; BYTE $0x12 // vprord zmm14, zmm27, 18
	LONG $0x48059162; WORD $0xd372; BYTE $0x03 // vpsrld zmm15, zmm27, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x402d4162; WORD $0xd5fe // vpaddd zmm26, zmm26, zmm13
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d1162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm27
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x0c // vmovdqu32 zmm12, [rdx+((11+1)*64)]
	LONG $0x48159162; WORD $0xc172; BYTE $0x11 // vprord zmm13, zmm25, 17
	LONG $0x480d9162; WORD $0xc172; BYTE $0x13 // vprord zmm14, zmm25, 19
	LONG $0x48059162; WORD $0xd172; BYTE $0x0a // vpsrld zmm15, zmm25, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40254162; WORD $0xddfe // vpaddd zmm27, zmm27, zmm13
	LONG $0x40252162; WORD $0xdcfe // vpaddd zmm27, zmm27, zmm20
	LONG $0x48159162; WORD $0xc472; BYTE $0x07 // vprord zmm13, zmm28, 7
	LONG $0x480d9162; WORD $0xc472; BYTE $0x12 // vprord zmm14, zmm28, 18
	LONG $0x48059162; WORD $0xd472; BYTE $0x03 // vpsrld zmm15, zmm28, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40254162; WORD $0xddfe // vpaddd zmm27, zmm27, zmm13
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d1162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm28
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x0d // vmovdqu32 zmm12, [rdx+((12+1)*64)]
	LONG $0x48159162; WORD $0xc272; BYTE $0x11 // vprord zmm13, zmm26, 17
	LONG $0x480d9162; WORD $0xc272; BYTE $0x13 // vprord zmm14, zmm26, 19
	LONG $0x48059162; WORD $0xd272; BYTE $0x0a // vpsrld zmm15, zmm26, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x401d4162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm13
	LONG $0x401d2162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm21
	LONG $0x48159162; WORD $0xc572; BYTE $0x07 // vprord zmm13, zmm29, 7
	LONG $0x480d9162; WORD $0xc572; BYTE $0x12 // vprord zmm14, zmm29, 18
	LONG $0x48059162; WORD $0xd572; BYTE $0x03 // vpsrld zmm15, zmm29, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x401d4162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm13
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d1162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm29
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x0e // vmovdqu32 zmm12, [rdx+((13+1)*64)]
	LONG $0x48159162; WORD $0xc372; BYTE $0x11 // vprord zmm13, zmm27, 17
	LONG $0x480d9162; WORD $0xc372; BYTE $0x13 // vprord zmm14, zmm27, 19
	LONG $0x48059162; WORD $0xd372; BYTE $0x0a // vpsrld zmm15, zmm27, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40154162; WORD $0xedfe // vpaddd zmm29, zmm29, zmm13
	LONG $0x40152162; WORD $0xeefe // vpaddd zmm29, zmm29, zmm22
	LONG $0x48159162; WORD $0xc672; BYTE $0x07 // vprord zmm13, zmm30, 7
	LONG $0x480d9162; WORD $0xc672; BYTE $0x12 // vprord zmm14, zmm30, 18
	LONG $0x48059162; WORD $0xd672; BYTE $0x03 // vpsrld zmm15, zmm30, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40154162; WORD $0xedfe // vpaddd zmm29, zmm29, zmm13
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d1162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm30
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x0f // vmovdqu32 zmm12, [rdx+((14+1)*64)]
	LONG $0x48159162; WORD $0xc472; BYTE $0x11 // vprord zmm13, zmm28, 17
	LONG $0x480d9162; WORD $0xc472; BYTE $0x13 // vprord zmm14, zmm28, 19
	LONG $0x48059162; WORD $0xd472; BYTE $0x0a // vpsrld zmm15, zmm28, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x400d4162; WORD $0xf5fe // vpaddd zmm30, zmm30, zmm13
	LONG $0x400d2162; WORD $0xf7fe // vpaddd zmm30, zmm30, zmm23
	LONG $0x48159162; WORD $0xc772; BYTE $0x07 // vprord zmm13, zmm31, 7
	LONG $0x480d9162; WORD $0xc772; BYTE $0x12 // vprord zmm14, zmm31, 18
	LONG $0x48059162; WORD $0xd772; BYTE $0x03 // vpsrld zmm15, zmm31, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x400d4162; WORD $0xf5fe // vpaddd zmm30, zmm30, zmm13
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d1162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm31
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x10 // vmovdqu32 zmm12, [rdx+((15+1)*64)]
	LONG $0x48159162; WORD $0xc572; BYTE $0x11 // vprord zmm13, zmm29, 17
	LONG $0x480d9162; WORD $0xc572; BYTE $0x13 // vprord zmm14, zmm29, 19
	LONG $0x48059162; WORD $0xd572; BYTE $0x0a // vpsrld zmm15, zmm29, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40054162; WORD $0xfdfe // vpaddd zmm31, zmm31, zmm13
	LONG $0x40050162; WORD $0xf8fe // vpaddd zmm31, zmm31, zmm24
	LONG $0x4815b162; WORD $0xc072; BYTE $0x07 // vprord zmm13, zmm16, 7
	LONG $0x480db162; WORD $0xc072; BYTE $0x12 // vprord zmm14, zmm16, 18
	LONG $0x4805b162; WORD $0xd072; BYTE $0x03 // vpsrld zmm15, zmm16, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40054162; WORD $0xfdfe // vpaddd zmm31, zmm31, zmm13
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d3162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm16
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x11 // vmovdqu32 zmm12, [rdx+((16+1)*64)]
	LONG $0x48159162; WORD $0xc672; BYTE $0x11 // vprord zmm13, zmm30, 17
	LONG $0x480d9162; WORD $0xc672; BYTE $0x13 // vprord zmm14, zmm30, 19
	LONG $0x48059162; WORD $0xd672; BYTE $0x0a // vpsrld zmm15, zmm30, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x407dc162; WORD $0xc5fe // vpaddd zmm16, zmm16, zmm13
	LONG $0x407d8162; WORD $0xc1fe // vpaddd zmm16, zmm16, zmm25
	LONG $0x4815b162; WORD $0xc172; BYTE $0x07 // vprord zmm13, zmm17, 7
	LONG $0x480db162; WORD $0xc172; BYTE $0x12 // vprord zmm14, zmm17, 18
	LONG $0x4805b162; WORD $0xd172; BYTE $0x03 // vpsrld zmm15, zmm17, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x407dc162; WORD $0xc5fe // vpaddd zmm16, zmm16, zmm13
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d3162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm17
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x12 // vmovdqu32 zmm12, [rdx+((17+1)*64)]
	LONG $0x48159162; WORD $0xc772; BYTE $0x11 // vprord zmm13, zmm31, 17
	LONG $0x480d9162; WORD $0xc772; BYTE $0x13 // vprord zmm14, zmm31, 19
	LONG $0x48059162; WORD $0xd772; BYTE $0x0a // vpsrld zmm15, zmm31, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4075c162; WORD $0xcdfe // vpaddd zmm17, zmm17, zmm13
	LONG $0x40758162; WORD $0xcafe // vpaddd zmm17, zmm17, zmm26
	LONG $0x4815b162; WORD $0xc272; BYTE $0x07 // vprord zmm13, zmm18, 7
	LONG $0x480db162; WORD $0xc272; BYTE $0x12 // vprord zmm14, zmm18, 18
	LONG $0x4805b162; WORD $0xd272; BYTE $0x03 // vpsrld zmm15, zmm18, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4075c162; WORD $0xcdfe // vpaddd zmm17, zmm17, zmm13
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d3162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm18
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x13 // vmovdqu32 zmm12, [rdx+((18+1)*64)]
	LONG $0x4815b162; WORD $0xc072; BYTE $0x11 // vprord zmm13, zmm16, 17
	LONG $0x480db162; WORD $0xc072; BYTE $0x13 // vprord zmm14, zmm16, 19
	LONG $0x4805b162; WORD $0xd072; BYTE $0x0a // vpsrld zmm15, zmm16, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x406dc162; WORD $0xd5fe // vpaddd zmm18, zmm18, zmm13
	LONG $0x406d8162; WORD $0xd3fe // vpaddd zmm18, zmm18, zmm27
	LONG $0x4815b162; WORD $0xc372; BYTE $0x07 // vprord zmm13, zmm19, 7
	LONG $0x480db162; WORD $0xc372; BYTE $0x12 // vprord zmm14, zmm19, 18
	LONG $0x4805b162; WORD $0xd372; BYTE $0x03 // vpsrld zmm15, zmm19, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x406dc162; WORD $0xd5fe // vpaddd zmm18, zmm18, zmm13
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d3162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm19
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x14 // vmovdqu32 zmm12, [rdx+((19+1)*64)]
	LONG $0x4815b162; WORD $0xc172; BYTE $0x11 // vprord zmm13, zmm17, 17
	LONG $0x480db162; WORD $0xc172; BYTE $0x13 // vprord zmm14, zmm17, 19
	LONG $0x4805b162; WORD $0xd172; BYTE $0x0a // vpsrld zmm15, zmm17, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4065c162; WORD $0xddfe // vpaddd zmm19, zmm19, zmm13
	LONG $0x40658162; WORD $0xdcfe // vpaddd zmm19, zmm19, zmm28
	LONG $0x4815b162; WORD $0xc472; BYTE $0x07 // vprord zmm13, zmm20, 7
	LONG $0x480db162; WORD $0xc472; BYTE $0x12 // vprord zmm14, zmm20, 18
	LONG $0x4805b162; WORD $0xd472; BYTE $0x03 // vpsrld zmm15, zmm20, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4065c162; WORD $0xddfe // vpaddd zmm19, zmm19, zmm13
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d3162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm20
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x15 // vmovdqu32 zmm12, [rdx+((20+1)*64)]
	LONG $0x4815b162; WORD $0xc272; BYTE $0x11 // vprord zmm13, zmm18, 17
	LONG $0x480db162; WORD $0xc272; BYTE $0x13 // vprord zmm14, zmm18, 19
	LONG $0x4805b162; WORD $0xd272; BYTE $0x0a // vpsrld zmm15, zmm18, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x405dc162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm13
	LONG $0x405d8162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm29
	LONG $0x4815b162; WORD $0xc572; BYTE $0x07 // vprord zmm13, zmm21, 7
	LONG $0x480db162; WORD $0xc572; BYTE $0x12 // vprord zmm14, zmm21, 18
	LONG $0x4805b162; WORD $0xd572; BYTE $0x03 // vpsrld zmm15, zmm21, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x405dc162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm13
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d3162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm21
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x16 // vmovdqu32 zmm12, [rdx+((21+1)*64)]
	LONG $0x4815b162; WORD $0xc372; BYTE $0x11 // vprord zmm13, zmm19, 17
	LONG $0x480db162; WORD $0xc372; BYTE $0x13 // vprord zmm14, zmm19, 19
	LONG $0x4805b162; WORD $0xd372; BYTE $0x0a // vpsrld zmm15, zmm19, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4055c162; WORD $0xedfe // vpaddd zmm21, zmm21, zmm13
	LONG $0x40558162; WORD $0xeefe // vpaddd zmm21, zmm21, zmm30
	LONG $0x4815b162; WORD $0xc672; BYTE $0x07 // vprord zmm13, zmm22, 7
	LONG $0x480db162; WORD $0xc672; BYTE $0x12 // vprord zmm14, zmm22, 18
	LONG $0x4805b162; WORD $0xd672; BYTE $0x03 // vpsrld zmm15, zmm22, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4055c162; WORD $0xedfe // vpaddd zmm21, zmm21, zmm13
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d3162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm22
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x17 // vmovdqu32 zmm12, [rdx+((22+1)*64)]
	LONG $0x4815b162; WORD $0xc472; BYTE $0x11 // vprord zmm13, zmm20, 17
	LONG $0x480db162; WORD $0xc472; BYTE $0x13 // vprord zmm14, zmm20, 19
	LONG $0x4805b162; WORD $0xd472; BYTE $0x0a // vpsrld zmm15, zmm20, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x404dc162; WORD $0xf5fe // vpaddd zmm22, zmm22, zmm13
	LONG $0x404d8162; WORD $0xf7fe // vpaddd zmm22, zmm22, zmm31
	LONG $0x4815b162; WORD $0xc772; BYTE $0x07 // vprord zmm13, zmm23, 7
	LONG $0x480db162; WORD $0xc772; BYTE $0x12 // vprord zmm14, zmm23, 18
	LONG $0x4805b162; WORD $0xd772; BYTE $0x03 // vpsrld zmm15, zmm23, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x404dc162; WORD $0xf5fe // vpaddd zmm22, zmm22, zmm13
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d3162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm23
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x18 // vmovdqu32 zmm12, [rdx+((23+1)*64)]
	LONG $0x4815b162; WORD $0xc572; BYTE $0x11 // vprord zmm13, zmm21, 17
	LONG $0x480db162; WORD $0xc572; BYTE $0x13 // vprord zmm14, zmm21, 19
	LONG $0x4805b162; WORD $0xd572; BYTE $0x0a // vpsrld zmm15, zmm21, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4045c162; WORD $0xfdfe // vpaddd zmm23, zmm23, zmm13
	LONG $0x4045a162; WORD $0xf8fe // vpaddd zmm23, zmm23, zmm16
	LONG $0x48159162; WORD $0xc072; BYTE $0x07 // vprord zmm13, zmm24, 7
	LONG $0x480d9162; WORD $0xc072; BYTE $0x12 // vprord zmm14, zmm24, 18
	LONG $0x48059162; WORD $0xd072; BYTE $0x03 // vpsrld zmm15, zmm24, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4045c162; WORD $0xfdfe // vpaddd zmm23, zmm23, zmm13
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d1162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm24
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x19 // vmovdqu32 zmm12, [rdx+((24+1)*64)]
	LONG $0x4815b162; WORD $0xc672; BYTE $0x11 // vprord zmm13, zmm22, 17
	LONG $0x480db162; WORD $0xc672; BYTE $0x13 // vprord zmm14, zmm22, 19
	LONG $0x4805b162; WORD $0xd672; BYTE $0x0a // vpsrld zmm15, zmm22, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x403d4162; WORD $0xc5fe // vpaddd zmm24, zmm24, zmm13
	LONG $0x403d2162; WORD $0xc1fe // vpaddd zmm24, zmm24, zmm17
	LONG $0x48159162; WORD $0xc172; BYTE $0x07 // vprord zmm13, zmm25, 7
	LONG $0x480d9162; WORD $0xc172; BYTE $0x12 // vprord zmm14, zmm25, 18
	LONG $0x48059162; WORD $0xd172; BYTE $0x03 // vpsrld zmm15, zmm25, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x403d4162; WORD $0xc5fe // vpaddd zmm24, zmm24, zmm13
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d1162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm25
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x1a // vmovdqu32 zmm12, [rdx+((25+1)*64)]
	LONG $0x4815b162; WORD $0xc772; BYTE $0x11 // vprord zmm13, zmm23, 17
	LONG $0x480db162; WORD $0xc772; BYTE $0x13 // vprord zmm14, zmm23, 19
	LONG $0x4805b162; WORD $0xd772; BYTE $0x0a // vpsrld zmm15, zmm23, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40354162; WORD $0xcdfe // vpaddd zmm25, zmm25, zmm13
	LONG $0x40352162; WORD $0xcafe // vpaddd zmm25, zmm25, zmm18
	LONG $0x48159162; WORD $0xc272; BYTE $0x07 // vprord zmm13, zmm26, 7
	LONG $0x480d9162; WORD $0xc272; BYTE $0x12 // vprord zmm14, zmm26, 18
	LONG $0x48059162; WORD $0xd272; BYTE $0x03 // vpsrld zmm15, zmm26, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40354162; WORD $0xcdfe // vpaddd zmm25, zmm25, zmm13
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d1162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm26
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x1b // vmovdqu32 zmm12, [rdx+((26+1)*64)]
	LONG $0x48159162; WORD $0xc072; BYTE $0x11 // vprord zmm13, zmm24, 17
	LONG $0x480d9162; WORD $0xc072; BYTE $0x13 // vprord zmm14, zmm24, 19
	LONG $0x48059162; WORD $0xd072; BYTE $0x0a // vpsrld zmm15, zmm24, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x402d4162; WORD $0xd5fe // vpaddd zmm26, zmm26, zmm13
	LONG $0x402d2162; WORD $0xd3fe // vpaddd zmm26, zmm26, zmm19
	LONG $0x48159162; WORD $0xc372; BYTE $0x07 // vprord zmm13, zmm27, 7
	LONG $0x480d9162; WORD $0xc372; BYTE $0x12 // vprord zmm14, zmm27, 18
	LONG $0x48059162; WORD $0xd372; BYTE $0x03 // vpsrld zmm15, zmm27, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x402d4162; WORD $0xd5fe // vpaddd zmm26, zmm26, zmm13
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d1162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm27
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x1c // vmovdqu32 zmm12, [rdx+((27+1)*64)]
	LONG $0x48159162; WORD $0xc172; BYTE $0x11 // vprord zmm13, zmm25, 17
	LONG $0x480d9162; WORD $0xc172; BYTE $0x13 // vprord zmm14, zmm25, 19
	LONG $0x48059162; WORD $0xd172; BYTE $0x0a // vpsrld zmm15, zmm25, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40254162; WORD $0xddfe // vpaddd zmm27, zmm27, zmm13
	LONG $0x40252162; WORD $0xdcfe // vpaddd zmm27, zmm27, zmm20
	LONG $0x48159162; WORD $0xc472; BYTE $0x07 // vprord zmm13, zmm28, 7
	LONG $0x480d9162; WORD $0xc472; BYTE $0x12 // vprord zmm14, zmm28, 18
	LONG $0x48059162; WORD $0xd472; BYTE $0x03 // vpsrld zmm15, zmm28, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40254162; WORD $0xddfe // vpaddd zmm27, zmm27, zmm13
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d1162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm28
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x1d // vmovdqu32 zmm12, [rdx+((28+1)*64)]
	LONG $0x48159162; WORD $0xc272; BYTE $0x11 // vprord zmm13, zmm26, 17
	LONG $0x480d9162; WORD $0xc272; BYTE $0x13 // vprord zmm14, zmm26, 19
	LONG $0x48059162; WORD $0xd272; BYTE $0x0a // vpsrld zmm15, zmm26, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x401d4162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm13
	LONG $0x401d2162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm21
	LONG $0x48159162; WORD $0xc572; BYTE $0x07 // vprord zmm13, zmm29, 7
	LONG $0x480d9162; WORD $0xc572; BYTE $0x12 // vprord zmm14, zmm29, 18
	LONG $0x48059162; WORD $0xd572; BYTE $0x03 // vpsrld zmm15, zmm29, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x401d4162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm13
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d1162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm29
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x1e // vmovdqu32 zmm12, [rdx+((29+1)*64)]
	LONG $0x48159162; WORD $0xc372; BYTE $0x11 // vprord zmm13, zmm27, 17
	LONG $0x480d9162; WORD $0xc372; BYTE $0x13 // vprord zmm14, zmm27, 19
	LONG $0x48059162; WORD $0xd372; BYTE $0x0a // vpsrld zmm15, zmm27, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40154162; WORD $0xedfe // vpaddd zmm29, zmm29, zmm13
	LONG $0x40152162; WORD $0xeefe // vpaddd zmm29, zmm29, zmm22
	LONG $0x48159162; WORD $0xc672; BYTE $0x07 // vprord zmm13, zmm30, 7
	LONG $0x480d9162; WORD $0xc672; BYTE $0x12 // vprord zmm14, zmm30, 18
	LONG $0x48059162; WORD $0xd672; BYTE $0x03 // vpsrld zmm15, zmm30, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40154162; WORD $0xedfe // vpaddd zmm29, zmm29, zmm13
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d1162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm30
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x1f // vmovdqu32 zmm12, [rdx+((30+1)*64)]
	LONG $0x48159162; WORD $0xc472; BYTE $0x11 // vprord zmm13, zmm28, 17
	LONG $0x480d9162; WORD $0xc472; BYTE $0x13 // vprord zmm14, zmm28, 19
	LONG $0x48059162; WORD $0xd472; BYTE $0x0a // vpsrld zmm15, zmm28, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x400d4162; WORD $0xf5fe // vpaddd zmm30, zmm30, zmm13
	LONG $0x400d2162; WORD $0xf7fe // vpaddd zmm30, zmm30, zmm23
	LONG $0x48159162; WORD $0xc772; BYTE $0x07 // vprord zmm13, zmm31, 7
	LONG $0x480d9162; WORD $0xc772; BYTE $0x12 // vprord zmm14, zmm31, 18
	LONG $0x48059162; WORD $0xd772; BYTE $0x03 // vpsrld zmm15, zmm31, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x400d4162; WORD $0xf5fe // vpaddd zmm30, zmm30, zmm13
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d1162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm31
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x20 // vmovdqu32 zmm12, [rdx+((31+1)*64)]
	LONG $0x48159162; WORD $0xc572; BYTE $0x11 // vprord zmm13, zmm29, 17
	LONG $0x480d9162; WORD $0xc572; BYTE $0x13 // vprord zmm14, zmm29, 19
	LONG $0x48059162; WORD $0xd572; BYTE $0x0a // vpsrld zmm15, zmm29, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40054162; WORD $0xfdfe // vpaddd zmm31, zmm31, zmm13
	LONG $0x40050162; WORD $0xf8fe // vpaddd zmm31, zmm31, zmm24
	LONG $0x4815b162; WORD $0xc072; BYTE $0x07 // vprord zmm13, zmm16, 7
	LONG $0x480db162; WORD $0xc072; BYTE $0x12 // vprord zmm14, zmm16, 18
	LONG $0x4805b162; WORD $0xd072; BYTE $0x03 // vpsrld zmm15, zmm16, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40054162; WORD $0xfdfe // vpaddd zmm31, zmm31, zmm13
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d3162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm16
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x21 // vmovdqu32 zmm12, [rdx+((32+1)*64)]
	LONG $0x48159162; WORD $0xc672; BYTE $0x11 // vprord zmm13, zmm30, 17
	LONG $0x480d9162; WORD $0xc672; BYTE $0x13 // vprord zmm14, zmm30, 19
	LONG $0x48059162; WORD $0xd672; BYTE $0x0a // vpsrld zmm15, zmm30, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x407dc162; WORD $0xc5fe // vpaddd zmm16, zmm16, zmm13
	LONG $0x407d8162; WORD $0xc1fe // vpaddd zmm16, zmm16, zmm25
	LONG $0x4815b162; WORD $0xc172; BYTE $0x07 // vprord zmm13, zmm17, 7
	LONG $0x480db162; WORD $0xc172; BYTE $0x12 // vprord zmm14, zmm17, 18
	LONG $0x4805b162; WORD $0xd172; BYTE $0x03 // vpsrld zmm15, zmm17, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x407dc162; WORD $0xc5fe // vpaddd zmm16, zmm16, zmm13
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d3162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm17
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x22 // vmovdqu32 zmm12, [rdx+((33+1)*64)]
	LONG $0x48159162; WORD $0xc772; BYTE $0x11 // vprord zmm13, zmm31, 17
	LONG $0x480d9162; WORD $0xc772; BYTE $0x13 // vprord zmm14, zmm31, 19
	LONG $0x48059162; WORD $0xd772; BYTE $0x0a // vpsrld zmm15, zmm31, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4075c162; WORD $0xcdfe // vpaddd zmm17, zmm17, zmm13
	LONG $0x40758162; WORD $0xcafe // vpaddd zmm17, zmm17, zmm26
	LONG $0x4815b162; WORD $0xc272; BYTE $0x07 // vprord zmm13, zmm18, 7
	LONG $0x480db162; WORD $0xc272; BYTE $0x12 // vprord zmm14, zmm18, 18
	LONG $0x4805b162; WORD $0xd272; BYTE $0x03 // vpsrld zmm15, zmm18, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4075c162; WORD $0xcdfe // vpaddd zmm17, zmm17, zmm13
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d3162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm18
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x23 // vmovdqu32 zmm12, [rdx+((34+1)*64)]
	LONG $0x4815b162; WORD $0xc072; BYTE $0x11 // vprord zmm13, zmm16, 17
	LONG $0x480db162; WORD $0xc072; BYTE $0x13 // vprord zmm14, zmm16, 19
	LONG $0x4805b162; WORD $0xd072; BYTE $0x0a // vpsrld zmm15, zmm16, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x406dc162; WORD $0xd5fe // vpaddd zmm18, zmm18, zmm13
	LONG $0x406d8162; WORD $0xd3fe // vpaddd zmm18, zmm18, zmm27
	LONG $0x4815b162; WORD $0xc372; BYTE $0x07 // vprord zmm13, zmm19, 7
	LONG $0x480db162; WORD $0xc372; BYTE $0x12 // vprord zmm14, zmm19, 18
	LONG $0x4805b162; WORD $0xd372; BYTE $0x03 // vpsrld zmm15, zmm19, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x406dc162; WORD $0xd5fe // vpaddd zmm18, zmm18, zmm13
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d3162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm19
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x24 // vmovdqu32 zmm12, [rdx+((35+1)*64)]
	LONG $0x4815b162; WORD $0xc172; BYTE $0x11 // vprord zmm13, zmm17, 17
	LONG $0x480db162; WORD $0xc172; BYTE $0x13 // vprord zmm14, zmm17, 19
	LONG $0x4805b162; WORD $0xd172; BYTE $0x0a // vpsrld zmm15, zmm17, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4065c162; WORD $0xddfe // vpaddd zmm19, zmm19, zmm13
	LONG $0x40658162; WORD $0xdcfe // vpaddd zmm19, zmm19, zmm28
	LONG $0x4815b162; WORD $0xc472; BYTE $0x07 // vprord zmm13, zmm20, 7
	LONG $0x480db162; WORD $0xc472; BYTE $0x12 // vprord zmm14, zmm20, 18
	LONG $0x4805b162; WORD $0xd472; BYTE $0x03 // vpsrld zmm15, zmm20, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4065c162; WORD $0xddfe // vpaddd zmm19, zmm19, zmm13
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d3162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm20
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x25 // vmovdqu32 zmm12, [rdx+((36+1)*64)]
	LONG $0x4815b162; WORD $0xc272; BYTE $0x11 // vprord zmm13, zmm18, 17
	LONG $0x480db162; WORD $0xc272; BYTE $0x13 // vprord zmm14, zmm18, 19
	LONG $0x4805b162; WORD $0xd272; BYTE $0x0a // vpsrld zmm15, zmm18, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x405dc162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm13
	LONG $0x405d8162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm29
	LONG $0x4815b162; WORD $0xc572; BYTE $0x07 // vprord zmm13, zmm21, 7
	LONG $0x480db162; WORD $0xc572; BYTE $0x12 // vprord zmm14, zmm21, 18
	LONG $0x4805b162; WORD $0xd572; BYTE $0x03 // vpsrld zmm15, zmm21, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x405dc162; WORD $0xe5fe // vpaddd zmm20, zmm20, zmm13
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d3162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm21
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x26 // vmovdqu32 zmm12, [rdx+((37+1)*64)]
	LONG $0x4815b162; WORD $0xc372; BYTE $0x11 // vprord zmm13, zmm19, 17
	LONG $0x480db162; WORD $0xc372; BYTE $0x13 // vprord zmm14, zmm19, 19
	LONG $0x4805b162; WORD $0xd372; BYTE $0x0a // vpsrld zmm15, zmm19, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4055c162; WORD $0xedfe // vpaddd zmm21, zmm21, zmm13
	LONG $0x40558162; WORD $0xeefe // vpaddd zmm21, zmm21, zmm30
	LONG $0x4815b162; WORD $0xc672; BYTE $0x07 // vprord zmm13, zmm22, 7
	LONG $0x480db162; WORD $0xc672; BYTE $0x12 // vprord zmm14, zmm22, 18
	LONG $0x4805b162; WORD $0xd672; BYTE $0x03 // vpsrld zmm15, zmm22, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4055c162; WORD $0xedfe // vpaddd zmm21, zmm21, zmm13
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d3162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm22
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x27 // vmovdqu32 zmm12, [rdx+((38+1)*64)]
	LONG $0x4815b162; WORD $0xc472; BYTE $0x11 // vprord zmm13, zmm20, 17
	LONG $0x480db162; WORD $0xc472; BYTE $0x13 // vprord zmm14, zmm20, 19
	LONG $0x4805b162; WORD $0xd472; BYTE $0x0a // vpsrld zmm15, zmm20, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x404dc162; WORD $0xf5fe // vpaddd zmm22, zmm22, zmm13
	LONG $0x404d8162; WORD $0xf7fe // vpaddd zmm22, zmm22, zmm31
	LONG $0x4815b162; WORD $0xc772; BYTE $0x07 // vprord zmm13, zmm23, 7
	LONG $0x480db162; WORD $0xc772; BYTE $0x12 // vprord zmm14, zmm23, 18
	LONG $0x4805b162; WORD $0xd772; BYTE $0x03 // vpsrld zmm15, zmm23, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x404dc162; WORD $0xf5fe // vpaddd zmm22, zmm22, zmm13
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d3162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm23
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x28 // vmovdqu32 zmm12, [rdx+((39+1)*64)]
	LONG $0x4815b162; WORD $0xc572; BYTE $0x11 // vprord zmm13, zmm21, 17
	LONG $0x480db162; WORD $0xc572; BYTE $0x13 // vprord zmm14, zmm21, 19
	LONG $0x4805b162; WORD $0xd572; BYTE $0x0a // vpsrld zmm15, zmm21, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4045c162; WORD $0xfdfe // vpaddd zmm23, zmm23, zmm13
	LONG $0x4045a162; WORD $0xf8fe // vpaddd zmm23, zmm23, zmm16
	LONG $0x48159162; WORD $0xc072; BYTE $0x07 // vprord zmm13, zmm24, 7
	LONG $0x480d9162; WORD $0xc072; BYTE $0x12 // vprord zmm14, zmm24, 18
	LONG $0x48059162; WORD $0xd072; BYTE $0x03 // vpsrld zmm15, zmm24, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x4045c162; WORD $0xfdfe // vpaddd zmm23, zmm23, zmm13
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d1162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm24
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x29 // vmovdqu32 zmm12, [rdx+((40+1)*64)]
	LONG $0x4815b162; WORD $0xc672; BYTE $0x11 // vprord zmm13, zmm22, 17
	LONG $0x480db162; WORD $0xc672; BYTE $0x13 // vprord zmm14, zmm22, 19
	LONG $0x4805b162; WORD $0xd672; BYTE $0x0a // vpsrld zmm15, zmm22, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x403d4162; WORD $0xc5fe // vpaddd zmm24, zmm24, zmm13
	LONG $0x403d2162; WORD $0xc1fe // vpaddd zmm24, zmm24, zmm17
	LONG $0x48159162; WORD $0xc172; BYTE $0x07 // vprord zmm13, zmm25, 7
	LONG $0x480d9162; WORD $0xc172; BYTE $0x12 // vprord zmm14, zmm25, 18
	LONG $0x48059162; WORD $0xd172; BYTE $0x03 // vpsrld zmm15, zmm25, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x403d4162; WORD $0xc5fe // vpaddd zmm24, zmm24, zmm13
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d1162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm25
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x2a // vmovdqu32 zmm12, [rdx+((41+1)*64)]
	LONG $0x4815b162; WORD $0xc772; BYTE $0x11 // vprord zmm13, zmm23, 17
	LONG $0x480db162; WORD $0xc772; BYTE $0x13 // vprord zmm14, zmm23, 19
	LONG $0x4805b162; WORD $0xd772; BYTE $0x0a // vpsrld zmm15, zmm23, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40354162; WORD $0xcdfe // vpaddd zmm25, zmm25, zmm13
	LONG $0x40352162; WORD $0xcafe // vpaddd zmm25, zmm25, zmm18
	LONG $0x48159162; WORD $0xc272; BYTE $0x07 // vprord zmm13, zmm26, 7
	LONG $0x480d9162; WORD $0xc272; BYTE $0x12 // vprord zmm14, zmm26, 18
	LONG $0x48059162; WORD $0xd272; BYTE $0x03 // vpsrld zmm15, zmm26, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40354162; WORD $0xcdfe // vpaddd zmm25, zmm25, zmm13
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d1162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm26
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x2b // vmovdqu32 zmm12, [rdx+((42+1)*64)]
	LONG $0x48159162; WORD $0xc072; BYTE $0x11 // vprord zmm13, zmm24, 17
	LONG $0x480d9162; WORD $0xc072; BYTE $0x13 // vprord zmm14, zmm24, 19
	LONG $0x48059162; WORD $0xd072; BYTE $0x0a // vpsrld zmm15, zmm24, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x402d4162; WORD $0xd5fe // vpaddd zmm26, zmm26, zmm13
	LONG $0x402d2162; WORD $0xd3fe // vpaddd zmm26, zmm26, zmm19
	LONG $0x48159162; WORD $0xc372; BYTE $0x07 // vprord zmm13, zmm27, 7
	LONG $0x480d9162; WORD $0xc372; BYTE $0x12 // vprord zmm14, zmm27, 18
	LONG $0x48059162; WORD $0xd372; BYTE $0x03 // vpsrld zmm15, zmm27, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x402d4162; WORD $0xd5fe // vpaddd zmm26, zmm26, zmm13
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d1162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm27
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x2c // vmovdqu32 zmm12, [rdx+((43+1)*64)]
	LONG $0x48159162; WORD $0xc172; BYTE $0x11 // vprord zmm13, zmm25, 17
	LONG $0x480d9162; WORD $0xc172; BYTE $0x13 // vprord zmm14, zmm25, 19
	LONG $0x48059162; WORD $0xd172; BYTE $0x0a // vpsrld zmm15, zmm25, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40254162; WORD $0xddfe // vpaddd zmm27, zmm27, zmm13
	LONG $0x40252162; WORD $0xdcfe // vpaddd zmm27, zmm27, zmm20
	LONG $0x48159162; WORD $0xc472; BYTE $0x07 // vprord zmm13, zmm28, 7
	LONG $0x480d9162; WORD $0xc472; BYTE $0x12 // vprord zmm14, zmm28, 18
	LONG $0x48059162; WORD $0xd472; BYTE $0x03 // vpsrld zmm15, zmm28, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40254162; WORD $0xddfe // vpaddd zmm27, zmm27, zmm13
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d1162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm28
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x2d // vmovdqu32 zmm12, [rdx+((44+1)*64)]
	LONG $0x48159162; WORD $0xc272; BYTE $0x11 // vprord zmm13, zmm26, 17
	LONG $0x480d9162; WORD $0xc272; BYTE $0x13 // vprord zmm14, zmm26, 19
	LONG $0x48059162; WORD $0xd272; BYTE $0x0a // vpsrld zmm15, zmm26, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x401d4162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm13
	LONG $0x401d2162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm21
	LONG $0x48159162; WORD $0xc572; BYTE $0x07 // vprord zmm13, zmm29, 7
	LONG $0x480d9162; WORD $0xc572; BYTE $0x12 // vprord zmm14, zmm29, 18
	LONG $0x48059162; WORD $0xd572; BYTE $0x03 // vpsrld zmm15, zmm29, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x401d4162; WORD $0xe5fe // vpaddd zmm28, zmm28, zmm13
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d1162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm29
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x2e // vmovdqu32 zmm12, [rdx+((45+1)*64)]
	LONG $0x48159162; WORD $0xc372; BYTE $0x11 // vprord zmm13, zmm27, 17
	LONG $0x480d9162; WORD $0xc372; BYTE $0x13 // vprord zmm14, zmm27, 19
	LONG $0x48059162; WORD $0xd372; BYTE $0x0a // vpsrld zmm15, zmm27, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40154162; WORD $0xedfe // vpaddd zmm29, zmm29, zmm13
	LONG $0x40152162; WORD $0xeefe // vpaddd zmm29, zmm29, zmm22
	LONG $0x48159162; WORD $0xc672; BYTE $0x07 // vprord zmm13, zmm30, 7
	LONG $0x480d9162; WORD $0xc672; BYTE $0x12 // vprord zmm14, zmm30, 18
	LONG $0x48059162; WORD $0xd672; BYTE $0x03 // vpsrld zmm15, zmm30, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40154162; WORD $0xedfe // vpaddd zmm29, zmm29, zmm13
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d1162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm30
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x2f // vmovdqu32 zmm12, [rdx+((46+1)*64)]
	LONG $0x48159162; WORD $0xc472; BYTE $0x11 // vprord zmm13, zmm28, 17
	LONG $0x480d9162; WORD $0xc472; BYTE $0x13 // vprord zmm14, zmm28, 19
	LONG $0x48059162; WORD $0xd472; BYTE $0x0a // vpsrld zmm15, zmm28, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x400d4162; WORD $0xf5fe // vpaddd zmm30, zmm30, zmm13
	LONG $0x400d2162; WORD $0xf7fe // vpaddd zmm30, zmm30, zmm23
	LONG $0x48159162; WORD $0xc772; BYTE $0x07 // vprord zmm13, zmm31, 7
	LONG $0x480d9162; WORD $0xc772; BYTE $0x12 // vprord zmm14, zmm31, 18
	LONG $0x48059162; WORD $0xd772; BYTE $0x03 // vpsrld zmm15, zmm31, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x400d4162; WORD $0xf5fe // vpaddd zmm30, zmm30, zmm13
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d1162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm31
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x30 // vmovdqu32 zmm12, [rdx+((47+1)*64)]
	LONG $0x48159162; WORD $0xc572; BYTE $0x11 // vprord zmm13, zmm29, 17
	LONG $0x480d9162; WORD $0xc572; BYTE $0x13 // vprord zmm14, zmm29, 19
	LONG $0x48059162; WORD $0xd572; BYTE $0x0a // vpsrld zmm15, zmm29, 10
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40054162; WORD $0xfdfe // vpaddd zmm31, zmm31, zmm13
	LONG $0x40050162; WORD $0xf8fe // vpaddd zmm31, zmm31, zmm24
	LONG $0x4815b162; WORD $0xc072; BYTE $0x07 // vprord zmm13, zmm16, 7
	LONG $0x480db162; WORD $0xc072; BYTE $0x12 // vprord zmm14, zmm16, 18
	LONG $0x4805b162; WORD $0xd072; BYTE $0x03 // vpsrld zmm15, zmm16, 3
	LONG $0x480d5362; WORD $0xef25; BYTE $0x96 // vpternlogd zmm13, zmm14, zmm15, 0x96
	LONG $0x40054162; WORD $0xfdfe // vpaddd zmm31, zmm31, zmm13
	LONG $0x01ee8348 // sub rsi, 1
	JE lastLoop
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d3162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm16
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x31 // vmovdqu32 zmm12, [rdx+((48+1)*64)]
	LONG $0x008f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(0*8)]
	LONG $0x487cc162; WORD $0x0410; BYTE $0x09 // vmovups zmm16, [r9+rcx]
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d3162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm17
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x32 // vmovdqu32 zmm12, [rdx+((49+1)*64)]
	LONG $0x088f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(1*8)]
	LONG $0x487cc162; WORD $0x0c10; BYTE $0x09 // vmovups zmm17, [r9+rcx]
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d3162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm18
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x33 // vmovdqu32 zmm12, [rdx+((50+1)*64)]
	LONG $0x108f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(2*8)]
	LONG $0x487cc162; WORD $0x1410; BYTE $0x09 // vmovups zmm18, [r9+rcx]
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d3162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm19
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x34 // vmovdqu32 zmm12, [rdx+((51+1)*64)]
	LONG $0x188f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(3*8)]
	LONG $0x487cc162; WORD $0x1c10; BYTE $0x09 // vmovups zmm19, [r9+rcx]
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d3162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm20
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x35 // vmovdqu32 zmm12, [rdx+((52+1)*64)]
	LONG $0x208f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(4*8)]
	LONG $0x487cc162; WORD $0x2410; BYTE $0x09 // vmovups zmm20, [r9+rcx]
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d3162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm21
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x36 // vmovdqu32 zmm12, [rdx+((53+1)*64)]
	LONG $0x288f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(5*8)]
	LONG $0x487cc162; WORD $0x2c10; BYTE $0x09 // vmovups zmm21, [r9+rcx]
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d3162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm22
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x37 // vmovdqu32 zmm12, [rdx+((54+1)*64)]
	LONG $0x308f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(6*8)]
	LONG $0x487cc162; WORD $0x3410; BYTE $0x09 // vmovups zmm22, [r9+rcx]
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d3162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm23
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x38 // vmovdqu32 zmm12, [rdx+((55+1)*64)]
	LONG $0x388f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(7*8)]
	LONG $0x487cc162; WORD $0x3c10; BYTE $0x09 // vmovups zmm23, [r9+rcx]
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d1162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm24
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x39 // vmovdqu32 zmm12, [rdx+((56+1)*64)]
	LONG $0x408f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(8*8)]
	LONG $0x487c4162; WORD $0x0410; BYTE $0x09 // vmovups zmm24, [r9+rcx]
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d1162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm25
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3a // vmovdqu32 zmm12, [rdx+((57+1)*64)]
	LONG $0x488f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(9*8)]
	LONG $0x487c4162; WORD $0x0c10; BYTE $0x09 // vmovups zmm25, [r9+rcx]
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d1162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm26
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3b // vmovdqu32 zmm12, [rdx+((58+1)*64)]
	LONG $0x508f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(10*8)]
	LONG $0x487c4162; WORD $0x1410; BYTE $0x09 // vmovups zmm26, [r9+rcx]
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d1162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm27
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3c // vmovdqu32 zmm12, [rdx+((59+1)*64)]
	LONG $0x588f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(11*8)]
	LONG $0x487c4162; WORD $0x1c10; BYTE $0x09 // vmovups zmm27, [r9+rcx]
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d1162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm28
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3d // vmovdqu32 zmm12, [rdx+((60+1)*64)]
	LONG $0x608f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(12*8)]
	LONG $0x487c4162; WORD $0x2410; BYTE $0x09 // vmovups zmm28, [r9+rcx]
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d1162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm29
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3e // vmovdqu32 zmm12, [rdx+((61+1)*64)]
	LONG $0x688f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(13*8)]
	LONG $0x487c4162; WORD $0x2c10; BYTE $0x09 // vmovups zmm29, [r9+rcx]
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d1162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm30
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3f // vmovdqu32 zmm12, [rdx+((62+1)*64)]
	LONG $0x708f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(14*8)]
	LONG $0x487c4162; WORD $0x3410; BYTE $0x09 // vmovups zmm30, [r9+rcx]
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d1162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm31
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x40 // vmovdqu32 zmm12, [rdx+((63+1)*64)]
	LONG $0x788f8b4c; WORD $0x0002; BYTE $0x00 // mov r9, [rdi+8*64+(15*8)]
	LONG $0x487c4162; WORD $0x3c10; BYTE $0x09 // vmovups zmm31, [r9+rcx]
	LONG $0x487df162; LONG $0x000087fe; WORD $0x0000 // vpaddd zmm0, zmm0, [rdi+_DIGEST_SAVE+64*0]
	LONG $0x4875f162; LONG $0x00008ffe; WORD $0x0000 // vpaddd zmm1, zmm1, [rdi+_DIGEST_SAVE+64*1]
	LONG $0x486df162; LONG $0x000097fe; WORD $0x0000 // vpaddd zmm2, zmm2, [rdi+_DIGEST_SAVE+64*2]
	LONG $0x4865f162; LONG $0x00009ffe; WORD $0x0000 // vpaddd zmm3, zmm3, [rdi+_DIGEST_SAVE+64*3]
	LONG $0x485df162; LONG $0x0000a7fe; WORD $0x0000 // vpaddd zmm4, zmm4, [rdi+_DIGEST_SAVE+64*4]
	LONG $0x4855f162; LONG $0x0000affe; WORD $0x0000 // vpaddd zmm5, zmm5, [rdi+_DIGEST_SAVE+64*5]
	LONG $0x484df162; LONG $0x0000b7fe; WORD $0x0000 // vpaddd zmm6, zmm6, [rdi+_DIGEST_SAVE+64*6]
	LONG $0x4845f162; LONG $0x0000bffe; WORD $0x0000 // vpaddd zmm7, zmm7, [rdi+_DIGEST_SAVE+64*7]
	JMP lloop
lastLoop:
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d3162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm16
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x31 // vmovdqu32 zmm12, [rdx+((48+1)*64)]
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d3162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm17
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x32 // vmovdqu32 zmm12, [rdx+((49+1)*64)]
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d3162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm18
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x33 // vmovdqu32 zmm12, [rdx+((50+1)*64)]
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d3162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm19
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x34 // vmovdqu32 zmm12, [rdx+((51+1)*64)]
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d3162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm20
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x35 // vmovdqu32 zmm12, [rdx+((52+1)*64)]
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d3162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm21
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x36 // vmovdqu32 zmm12, [rdx+((53+1)*64)]
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d3162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm22
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x37 // vmovdqu32 zmm12, [rdx+((54+1)*64)]
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d3162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm23
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x38 // vmovdqu32 zmm12, [rdx+((55+1)*64)]
	LONG $0x48455162; WORD $0xc4fe // vpaddd zmm8, zmm7, zmm12
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x482df162; WORD $0xc472; BYTE $0x06 // vprord zmm10, zmm4, 6
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0b // vprord zmm11, zmm4, 11
	LONG $0x481df162; WORD $0xc472; BYTE $0x19 // vprord zmm12, zmm4, 25
	LONG $0x48557362; WORD $0xce25; BYTE $0xca // vpternlogd zmm9, zmm5, zmm6, 0xCA
	LONG $0x483d1162; WORD $0xc0fe // vpaddd zmm8, zmm8, zmm24
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x4845f162; WORD $0xc072; BYTE $0x02 // vprord zmm7, zmm0, 2
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0d // vprord zmm11, zmm0, 13
	LONG $0x481df162; WORD $0xc072; BYTE $0x16 // vprord zmm12, zmm0, 22
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x48757362; WORD $0xca25; BYTE $0xe8 // vpternlogd zmm9, zmm1, zmm2, 0xE8
	LONG $0x4825d362; WORD $0xfc25; BYTE $0x96 // vpternlogd zmm7, zmm11, zmm12, 0x96
	LONG $0x4845d162; WORD $0xf9fe // vpaddd zmm7, zmm7, zmm9
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x39 // vmovdqu32 zmm12, [rdx+((56+1)*64)]
	LONG $0x484d5162; WORD $0xc4fe // vpaddd zmm8, zmm6, zmm12
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x482df162; WORD $0xc372; BYTE $0x06 // vprord zmm10, zmm3, 6
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0b // vprord zmm11, zmm3, 11
	LONG $0x481df162; WORD $0xc372; BYTE $0x19 // vprord zmm12, zmm3, 25
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xca // vpternlogd zmm9, zmm4, zmm5, 0xCA
	LONG $0x483d1162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm25
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x484df162; WORD $0xc772; BYTE $0x02 // vprord zmm6, zmm7, 2
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0d // vprord zmm11, zmm7, 13
	LONG $0x481df162; WORD $0xc772; BYTE $0x16 // vprord zmm12, zmm7, 22
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x487d7362; WORD $0xc925; BYTE $0xe8 // vpternlogd zmm9, zmm0, zmm1, 0xE8
	LONG $0x4825d362; WORD $0xf425; BYTE $0x96 // vpternlogd zmm6, zmm11, zmm12, 0x96
	LONG $0x484dd162; WORD $0xf1fe // vpaddd zmm6, zmm6, zmm9
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3a // vmovdqu32 zmm12, [rdx+((57+1)*64)]
	LONG $0x48555162; WORD $0xc4fe // vpaddd zmm8, zmm5, zmm12
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x482df162; WORD $0xc272; BYTE $0x06 // vprord zmm10, zmm2, 6
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0b // vprord zmm11, zmm2, 11
	LONG $0x481df162; WORD $0xc272; BYTE $0x19 // vprord zmm12, zmm2, 25
	LONG $0x48657362; WORD $0xcc25; BYTE $0xca // vpternlogd zmm9, zmm3, zmm4, 0xCA
	LONG $0x483d1162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm26
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x4855f162; WORD $0xc672; BYTE $0x02 // vprord zmm5, zmm6, 2
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0d // vprord zmm11, zmm6, 13
	LONG $0x481df162; WORD $0xc672; BYTE $0x16 // vprord zmm12, zmm6, 22
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x48457362; WORD $0xc825; BYTE $0xe8 // vpternlogd zmm9, zmm7, zmm0, 0xE8
	LONG $0x4825d362; WORD $0xec25; BYTE $0x96 // vpternlogd zmm5, zmm11, zmm12, 0x96
	LONG $0x4855d162; WORD $0xe9fe // vpaddd zmm5, zmm5, zmm9
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3b // vmovdqu32 zmm12, [rdx+((58+1)*64)]
	LONG $0x485d5162; WORD $0xc4fe // vpaddd zmm8, zmm4, zmm12
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x482df162; WORD $0xc172; BYTE $0x06 // vprord zmm10, zmm1, 6
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0b // vprord zmm11, zmm1, 11
	LONG $0x481df162; WORD $0xc172; BYTE $0x19 // vprord zmm12, zmm1, 25
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xca // vpternlogd zmm9, zmm2, zmm3, 0xCA
	LONG $0x483d1162; WORD $0xc3fe // vpaddd zmm8, zmm8, zmm27
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x485df162; WORD $0xc572; BYTE $0x02 // vprord zmm4, zmm5, 2
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0d // vprord zmm11, zmm5, 13
	LONG $0x481df162; WORD $0xc572; BYTE $0x16 // vprord zmm12, zmm5, 22
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xe8 // vpternlogd zmm9, zmm6, zmm7, 0xE8
	LONG $0x4825d362; WORD $0xe425; BYTE $0x96 // vpternlogd zmm4, zmm11, zmm12, 0x96
	LONG $0x485dd162; WORD $0xe1fe // vpaddd zmm4, zmm4, zmm9
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3c // vmovdqu32 zmm12, [rdx+((59+1)*64)]
	LONG $0x48655162; WORD $0xc4fe // vpaddd zmm8, zmm3, zmm12
	LONG $0x487e7162; WORD $0xc86f // vmovdqu32 zmm9, zmm0
	LONG $0x482df162; WORD $0xc072; BYTE $0x06 // vprord zmm10, zmm0, 6
	LONG $0x4825f162; WORD $0xc072; BYTE $0x0b // vprord zmm11, zmm0, 11
	LONG $0x481df162; WORD $0xc072; BYTE $0x19 // vprord zmm12, zmm0, 25
	LONG $0x48757362; WORD $0xca25; BYTE $0xca // vpternlogd zmm9, zmm1, zmm2, 0xCA
	LONG $0x483d1162; WORD $0xc4fe // vpaddd zmm8, zmm8, zmm28
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4845d162; WORD $0xf8fe // vpaddd zmm7, zmm7, zmm8
	LONG $0x4865f162; WORD $0xc472; BYTE $0x02 // vprord zmm3, zmm4, 2
	LONG $0x4825f162; WORD $0xc472; BYTE $0x0d // vprord zmm11, zmm4, 13
	LONG $0x481df162; WORD $0xc472; BYTE $0x16 // vprord zmm12, zmm4, 22
	LONG $0x487e7162; WORD $0xcc6f // vmovdqu32 zmm9, zmm4
	LONG $0x48557362; WORD $0xce25; BYTE $0xe8 // vpternlogd zmm9, zmm5, zmm6, 0xE8
	LONG $0x4825d362; WORD $0xdc25; BYTE $0x96 // vpternlogd zmm3, zmm11, zmm12, 0x96
	LONG $0x4865d162; WORD $0xd9fe // vpaddd zmm3, zmm3, zmm9
	LONG $0x4865d162; WORD $0xd8fe // vpaddd zmm3, zmm3, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3d // vmovdqu32 zmm12, [rdx+((60+1)*64)]
	LONG $0x486d5162; WORD $0xc4fe // vpaddd zmm8, zmm2, zmm12
	LONG $0x487e7162; WORD $0xcf6f // vmovdqu32 zmm9, zmm7
	LONG $0x482df162; WORD $0xc772; BYTE $0x06 // vprord zmm10, zmm7, 6
	LONG $0x4825f162; WORD $0xc772; BYTE $0x0b // vprord zmm11, zmm7, 11
	LONG $0x481df162; WORD $0xc772; BYTE $0x19 // vprord zmm12, zmm7, 25
	LONG $0x487d7362; WORD $0xc925; BYTE $0xca // vpternlogd zmm9, zmm0, zmm1, 0xCA
	LONG $0x483d1162; WORD $0xc5fe // vpaddd zmm8, zmm8, zmm29
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x484dd162; WORD $0xf0fe // vpaddd zmm6, zmm6, zmm8
	LONG $0x486df162; WORD $0xc372; BYTE $0x02 // vprord zmm2, zmm3, 2
	LONG $0x4825f162; WORD $0xc372; BYTE $0x0d // vprord zmm11, zmm3, 13
	LONG $0x481df162; WORD $0xc372; BYTE $0x16 // vprord zmm12, zmm3, 22
	LONG $0x487e7162; WORD $0xcb6f // vmovdqu32 zmm9, zmm3
	LONG $0x485d7362; WORD $0xcd25; BYTE $0xe8 // vpternlogd zmm9, zmm4, zmm5, 0xE8
	LONG $0x4825d362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm2, zmm11, zmm12, 0x96
	LONG $0x486dd162; WORD $0xd1fe // vpaddd zmm2, zmm2, zmm9
	LONG $0x486dd162; WORD $0xd0fe // vpaddd zmm2, zmm2, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3e // vmovdqu32 zmm12, [rdx+((61+1)*64)]
	LONG $0x48755162; WORD $0xc4fe // vpaddd zmm8, zmm1, zmm12
	LONG $0x487e7162; WORD $0xce6f // vmovdqu32 zmm9, zmm6
	LONG $0x482df162; WORD $0xc672; BYTE $0x06 // vprord zmm10, zmm6, 6
	LONG $0x4825f162; WORD $0xc672; BYTE $0x0b // vprord zmm11, zmm6, 11
	LONG $0x481df162; WORD $0xc672; BYTE $0x19 // vprord zmm12, zmm6, 25
	LONG $0x48457362; WORD $0xc825; BYTE $0xca // vpternlogd zmm9, zmm7, zmm0, 0xCA
	LONG $0x483d1162; WORD $0xc6fe // vpaddd zmm8, zmm8, zmm30
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x4855d162; WORD $0xe8fe // vpaddd zmm5, zmm5, zmm8
	LONG $0x4875f162; WORD $0xc272; BYTE $0x02 // vprord zmm1, zmm2, 2
	LONG $0x4825f162; WORD $0xc272; BYTE $0x0d // vprord zmm11, zmm2, 13
	LONG $0x481df162; WORD $0xc272; BYTE $0x16 // vprord zmm12, zmm2, 22
	LONG $0x487e7162; WORD $0xca6f // vmovdqu32 zmm9, zmm2
	LONG $0x48657362; WORD $0xcc25; BYTE $0xe8 // vpternlogd zmm9, zmm3, zmm4, 0xE8
	LONG $0x4825d362; WORD $0xcc25; BYTE $0x96 // vpternlogd zmm1, zmm11, zmm12, 0x96
	LONG $0x4875d162; WORD $0xc9fe // vpaddd zmm1, zmm1, zmm9
	LONG $0x4875d162; WORD $0xc8fe // vpaddd zmm1, zmm1, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x3f // vmovdqu32 zmm12, [rdx+((62+1)*64)]
	LONG $0x487d5162; WORD $0xc4fe // vpaddd zmm8, zmm0, zmm12
	LONG $0x487e7162; WORD $0xcd6f // vmovdqu32 zmm9, zmm5
	LONG $0x482df162; WORD $0xc572; BYTE $0x06 // vprord zmm10, zmm5, 6
	LONG $0x4825f162; WORD $0xc572; BYTE $0x0b // vprord zmm11, zmm5, 11
	LONG $0x481df162; WORD $0xc572; BYTE $0x19 // vprord zmm12, zmm5, 25
	LONG $0x484d7362; WORD $0xcf25; BYTE $0xca // vpternlogd zmm9, zmm6, zmm7, 0xCA
	LONG $0x483d1162; WORD $0xc7fe // vpaddd zmm8, zmm8, zmm31
	LONG $0x48255362; WORD $0xd425; BYTE $0x96 // vpternlogd zmm10, zmm11, zmm12, 0x96
	LONG $0x483d5162; WORD $0xc1fe // vpaddd zmm8, zmm8, zmm9
	LONG $0x483d5162; WORD $0xc2fe // vpaddd zmm8, zmm8, zmm10
	LONG $0x485dd162; WORD $0xe0fe // vpaddd zmm4, zmm4, zmm8
	LONG $0x487df162; WORD $0xc172; BYTE $0x02 // vprord zmm0, zmm1, 2
	LONG $0x4825f162; WORD $0xc172; BYTE $0x0d // vprord zmm11, zmm1, 13
	LONG $0x481df162; WORD $0xc172; BYTE $0x16 // vprord zmm12, zmm1, 22
	LONG $0x487e7162; WORD $0xc96f // vmovdqu32 zmm9, zmm1
	LONG $0x486d7362; WORD $0xcb25; BYTE $0xe8 // vpternlogd zmm9, zmm2, zmm3, 0xE8
	LONG $0x4825d362; WORD $0xc425; BYTE $0x96 // vpternlogd zmm0, zmm11, zmm12, 0x96
	LONG $0x487dd162; WORD $0xc1fe // vpaddd zmm0, zmm0, zmm9
	LONG $0x487dd162; WORD $0xc0fe // vpaddd zmm0, zmm0, zmm8
	LONG $0x487e7162; WORD $0x626f; BYTE $0x40 // vmovdqu32 zmm12, [rdx+((63+1)*64)]
	LONG $0x487df162; LONG $0x000087fe; WORD $0x0000 // vpaddd zmm0, zmm0, [rdi+_DIGEST_SAVE+64*0]
	LONG $0x4875f162; LONG $0x00008ffe; WORD $0x0000 // vpaddd zmm1, zmm1, [rdi+_DIGEST_SAVE+64*1]
	LONG $0x486df162; LONG $0x000097fe; WORD $0x0000 // vpaddd zmm2, zmm2, [rdi+_DIGEST_SAVE+64*2]
	LONG $0x4865f162; LONG $0x00009ffe; WORD $0x0000 // vpaddd zmm3, zmm3, [rdi+_DIGEST_SAVE+64*3]
	LONG $0x485df162; LONG $0x0000a7fe; WORD $0x0000 // vpaddd zmm4, zmm4, [rdi+_DIGEST_SAVE+64*4]
	LONG $0x4855f162; LONG $0x0000affe; WORD $0x0000 // vpaddd zmm5, zmm5, [rdi+_DIGEST_SAVE+64*5]
	LONG $0x484df162; LONG $0x0000b7fe; WORD $0x0000 // vpaddd zmm6, zmm6, [rdi+_DIGEST_SAVE+64*6]
	LONG $0x4845f162; LONG $0x0000bffe; WORD $0x0000 // vpaddd zmm7, zmm7, [rdi+_DIGEST_SAVE+64*7]
	LONG $0x487ef162; WORD $0x077f // vmovdqu32 [rdi+0*64], zmm0
	LONG $0x487ef162; WORD $0x4f7f; BYTE $0x01 // vmovdqu32 [rdi+1*64], zmm1
	LONG $0x487ef162; WORD $0x577f; BYTE $0x02 // vmovdqu32 [rdi+2*64], zmm2
	LONG $0x487ef162; WORD $0x5f7f; BYTE $0x03 // vmovdqu32 [rdi+3*64], zmm3
	LONG $0x487ef162; WORD $0x677f; BYTE $0x04 // vmovdqu32 [rdi+4*64], zmm4
	LONG $0x487ef162; WORD $0x6f7f; BYTE $0x05 // vmovdqu32 [rdi+5*64], zmm5
	LONG $0x487ef162; WORD $0x777f; BYTE $0x06 // vmovdqu32 [rdi+6*64], zmm6
	LONG $0x487ef162; WORD $0x7f7f; BYTE $0x07 // vmovdqu32 [rdi+7*64], zmm7
	LONG $0x008f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+0*8], rcx
	LONG $0x088f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+1*8], rcx
	LONG $0x108f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+2*8], rcx
	LONG $0x188f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+3*8], rcx
	LONG $0x208f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+4*8], rcx
	LONG $0x288f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+5*8], rcx
	LONG $0x308f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+6*8], rcx
	LONG $0x388f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+7*8], rcx
	LONG $0x408f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+8*8], rcx
	LONG $0x488f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+9*8], rcx
	LONG $0x508f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+10*8], rcx
	LONG $0x588f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+11*8], rcx
	LONG $0x608f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+12*8], rcx
	LONG $0x688f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+13*8], rcx
	LONG $0x708f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+14*8], rcx
	LONG $0x788f0148; WORD $0x0002; BYTE $0x00 // add [rdi+8*64+15*8], rcx
	VZEROUPPER
	RET
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x000(SB)/8, $0x0405060700010203
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x008(SB)/8, $0x0c0d0e0f08090a0b
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x010(SB)/8, $0x0405060700010203
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x018(SB)/8, $0x0c0d0e0f08090a0b
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x020(SB)/8, $0x0405060700010203
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x028(SB)/8, $0x0c0d0e0f08090a0b
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x030(SB)/8, $0x0405060700010203
DATA PSHUFFLE_BYTE_FLIP_MASK<>+0x038(SB)/8, $0x0c0d0e0f08090a0b
GLOBL PSHUFFLE_BYTE_FLIP_MASK<>(SB), 8, $64
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x000(SB)/8, $0x0000000000000000
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x008(SB)/8, $0x0000000000000001
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x010(SB)/8, $0x0000000000000008
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x018(SB)/8, $0x0000000000000009
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x020(SB)/8, $0x0000000000000004
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x028(SB)/8, $0x0000000000000005
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x030(SB)/8, $0x000000000000000C
DATA PSHUFFLE_TRANSPOSE16_MASK1<>+0x038(SB)/8, $0x000000000000000D
GLOBL PSHUFFLE_TRANSPOSE16_MASK1<>(SB), 8, $64
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x000(SB)/8, $0x0000000000000002
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x008(SB)/8, $0x0000000000000003
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x010(SB)/8, $0x000000000000000A
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x018(SB)/8, $0x000000000000000B
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x020(SB)/8, $0x0000000000000006
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x028(SB)/8, $0x0000000000000007
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x030(SB)/8, $0x000000000000000E
DATA PSHUFFLE_TRANSPOSE16_MASK2<>+0x038(SB)/8, $0x000000000000000F
GLOBL PSHUFFLE_TRANSPOSE16_MASK2<>(SB), 8, $64
DATA TABLE<>+0x000(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x008(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x010(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x018(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x020(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x028(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x030(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x038(SB)/8, $0x428a2f98428a2f98
DATA TABLE<>+0x040(SB)/8, $0x7137449171374491
DATA TABLE<>+0x048(SB)/8, $0x7137449171374491
DATA TABLE<>+0x050(SB)/8, $0x7137449171374491
DATA TABLE<>+0x058(SB)/8, $0x7137449171374491
DATA TABLE<>+0x060(SB)/8, $0x7137449171374491
DATA TABLE<>+0x068(SB)/8, $0x7137449171374491
DATA TABLE<>+0x070(SB)/8, $0x7137449171374491
DATA TABLE<>+0x078(SB)/8, $0x7137449171374491
DATA TABLE<>+0x080(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x088(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x090(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x098(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x0a0(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x0a8(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x0b0(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x0b8(SB)/8, $0xb5c0fbcfb5c0fbcf
DATA TABLE<>+0x0c0(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0c8(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0d0(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0d8(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0e0(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0e8(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0f0(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x0f8(SB)/8, $0xe9b5dba5e9b5dba5
DATA TABLE<>+0x100(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x108(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x110(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x118(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x120(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x128(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x130(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x138(SB)/8, $0x3956c25b3956c25b
DATA TABLE<>+0x140(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x148(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x150(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x158(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x160(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x168(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x170(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x178(SB)/8, $0x59f111f159f111f1
DATA TABLE<>+0x180(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x188(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x190(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x198(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x1a0(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x1a8(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x1b0(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x1b8(SB)/8, $0x923f82a4923f82a4
DATA TABLE<>+0x1c0(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1c8(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1d0(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1d8(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1e0(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1e8(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1f0(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x1f8(SB)/8, $0xab1c5ed5ab1c5ed5
DATA TABLE<>+0x200(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x208(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x210(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x218(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x220(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x228(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x230(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x238(SB)/8, $0xd807aa98d807aa98
DATA TABLE<>+0x240(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x248(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x250(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x258(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x260(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x268(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x270(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x278(SB)/8, $0x12835b0112835b01
DATA TABLE<>+0x280(SB)/8, $0x243185be243185be
DATA TABLE<>+0x288(SB)/8, $0x243185be243185be
DATA TABLE<>+0x290(SB)/8, $0x243185be243185be
DATA TABLE<>+0x298(SB)/8, $0x243185be243185be
DATA TABLE<>+0x2a0(SB)/8, $0x243185be243185be
DATA TABLE<>+0x2a8(SB)/8, $0x243185be243185be
DATA TABLE<>+0x2b0(SB)/8, $0x243185be243185be
DATA TABLE<>+0x2b8(SB)/8, $0x243185be243185be
DATA TABLE<>+0x2c0(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2c8(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2d0(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2d8(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2e0(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2e8(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2f0(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x2f8(SB)/8, $0x550c7dc3550c7dc3
DATA TABLE<>+0x300(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x308(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x310(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x318(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x320(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x328(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x330(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x338(SB)/8, $0x72be5d7472be5d74
DATA TABLE<>+0x340(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x348(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x350(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x358(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x360(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x368(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x370(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x378(SB)/8, $0x80deb1fe80deb1fe
DATA TABLE<>+0x380(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x388(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x390(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x398(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x3a0(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x3a8(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x3b0(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x3b8(SB)/8, $0x9bdc06a79bdc06a7
DATA TABLE<>+0x3c0(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3c8(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3d0(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3d8(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3e0(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3e8(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3f0(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x3f8(SB)/8, $0xc19bf174c19bf174
DATA TABLE<>+0x400(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x408(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x410(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x418(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x420(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x428(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x430(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x438(SB)/8, $0xe49b69c1e49b69c1
DATA TABLE<>+0x440(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x448(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x450(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x458(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x460(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x468(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x470(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x478(SB)/8, $0xefbe4786efbe4786
DATA TABLE<>+0x480(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x488(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x490(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x498(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x4a0(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x4a8(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x4b0(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x4b8(SB)/8, $0x0fc19dc60fc19dc6
DATA TABLE<>+0x4c0(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4c8(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4d0(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4d8(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4e0(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4e8(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4f0(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x4f8(SB)/8, $0x240ca1cc240ca1cc
DATA TABLE<>+0x500(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x508(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x510(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x518(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x520(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x528(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x530(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x538(SB)/8, $0x2de92c6f2de92c6f
DATA TABLE<>+0x540(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x548(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x550(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x558(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x560(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x568(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x570(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x578(SB)/8, $0x4a7484aa4a7484aa
DATA TABLE<>+0x580(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x588(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x590(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x598(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x5a0(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x5a8(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x5b0(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x5b8(SB)/8, $0x5cb0a9dc5cb0a9dc
DATA TABLE<>+0x5c0(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5c8(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5d0(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5d8(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5e0(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5e8(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5f0(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x5f8(SB)/8, $0x76f988da76f988da
DATA TABLE<>+0x600(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x608(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x610(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x618(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x620(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x628(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x630(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x638(SB)/8, $0x983e5152983e5152
DATA TABLE<>+0x640(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x648(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x650(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x658(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x660(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x668(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x670(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x678(SB)/8, $0xa831c66da831c66d
DATA TABLE<>+0x680(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x688(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x690(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x698(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x6a0(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x6a8(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x6b0(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x6b8(SB)/8, $0xb00327c8b00327c8
DATA TABLE<>+0x6c0(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6c8(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6d0(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6d8(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6e0(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6e8(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6f0(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x6f8(SB)/8, $0xbf597fc7bf597fc7
DATA TABLE<>+0x700(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x708(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x710(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x718(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x720(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x728(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x730(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x738(SB)/8, $0xc6e00bf3c6e00bf3
DATA TABLE<>+0x740(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x748(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x750(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x758(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x760(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x768(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x770(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x778(SB)/8, $0xd5a79147d5a79147
DATA TABLE<>+0x780(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x788(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x790(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x798(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x7a0(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x7a8(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x7b0(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x7b8(SB)/8, $0x06ca635106ca6351
DATA TABLE<>+0x7c0(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7c8(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7d0(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7d8(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7e0(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7e8(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7f0(SB)/8, $0x1429296714292967
DATA TABLE<>+0x7f8(SB)/8, $0x1429296714292967
DATA TABLE<>+0x800(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x808(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x810(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x818(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x820(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x828(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x830(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x838(SB)/8, $0x27b70a8527b70a85
DATA TABLE<>+0x840(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x848(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x850(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x858(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x860(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x868(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x870(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x878(SB)/8, $0x2e1b21382e1b2138
DATA TABLE<>+0x880(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x888(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x890(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x898(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x8a0(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x8a8(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x8b0(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x8b8(SB)/8, $0x4d2c6dfc4d2c6dfc
DATA TABLE<>+0x8c0(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8c8(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8d0(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8d8(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8e0(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8e8(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8f0(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x8f8(SB)/8, $0x53380d1353380d13
DATA TABLE<>+0x900(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x908(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x910(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x918(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x920(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x928(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x930(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x938(SB)/8, $0x650a7354650a7354
DATA TABLE<>+0x940(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x948(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x950(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x958(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x960(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x968(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x970(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x978(SB)/8, $0x766a0abb766a0abb
DATA TABLE<>+0x980(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x988(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x990(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x998(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x9a0(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x9a8(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x9b0(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x9b8(SB)/8, $0x81c2c92e81c2c92e
DATA TABLE<>+0x9c0(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9c8(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9d0(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9d8(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9e0(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9e8(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9f0(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0x9f8(SB)/8, $0x92722c8592722c85
DATA TABLE<>+0xa00(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa08(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa10(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa18(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa20(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa28(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa30(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa38(SB)/8, $0xa2bfe8a1a2bfe8a1
DATA TABLE<>+0xa40(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa48(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa50(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa58(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa60(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa68(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa70(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa78(SB)/8, $0xa81a664ba81a664b
DATA TABLE<>+0xa80(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xa88(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xa90(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xa98(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xaa0(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xaa8(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xab0(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xab8(SB)/8, $0xc24b8b70c24b8b70
DATA TABLE<>+0xac0(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xac8(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xad0(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xad8(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xae0(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xae8(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xaf0(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xaf8(SB)/8, $0xc76c51a3c76c51a3
DATA TABLE<>+0xb00(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb08(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb10(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb18(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb20(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb28(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb30(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb38(SB)/8, $0xd192e819d192e819
DATA TABLE<>+0xb40(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb48(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb50(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb58(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb60(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb68(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb70(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb78(SB)/8, $0xd6990624d6990624
DATA TABLE<>+0xb80(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xb88(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xb90(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xb98(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xba0(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xba8(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xbb0(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xbb8(SB)/8, $0xf40e3585f40e3585
DATA TABLE<>+0xbc0(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbc8(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbd0(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbd8(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbe0(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbe8(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbf0(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xbf8(SB)/8, $0x106aa070106aa070
DATA TABLE<>+0xc00(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc08(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc10(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc18(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc20(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc28(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc30(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc38(SB)/8, $0x19a4c11619a4c116
DATA TABLE<>+0xc40(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc48(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc50(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc58(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc60(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc68(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc70(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc78(SB)/8, $0x1e376c081e376c08
DATA TABLE<>+0xc80(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xc88(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xc90(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xc98(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xca0(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xca8(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xcb0(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xcb8(SB)/8, $0x2748774c2748774c
DATA TABLE<>+0xcc0(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xcc8(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xcd0(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xcd8(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xce0(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xce8(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xcf0(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xcf8(SB)/8, $0x34b0bcb534b0bcb5
DATA TABLE<>+0xd00(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd08(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd10(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd18(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd20(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd28(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd30(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd38(SB)/8, $0x391c0cb3391c0cb3
DATA TABLE<>+0xd40(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd48(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd50(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd58(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd60(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd68(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd70(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd78(SB)/8, $0x4ed8aa4a4ed8aa4a
DATA TABLE<>+0xd80(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xd88(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xd90(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xd98(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xda0(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xda8(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xdb0(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xdb8(SB)/8, $0x5b9cca4f5b9cca4f
DATA TABLE<>+0xdc0(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xdc8(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xdd0(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xdd8(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xde0(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xde8(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xdf0(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xdf8(SB)/8, $0x682e6ff3682e6ff3
DATA TABLE<>+0xe00(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe08(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe10(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe18(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe20(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe28(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe30(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe38(SB)/8, $0x748f82ee748f82ee
DATA TABLE<>+0xe40(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe48(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe50(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe58(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe60(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe68(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe70(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe78(SB)/8, $0x78a5636f78a5636f
DATA TABLE<>+0xe80(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xe88(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xe90(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xe98(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xea0(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xea8(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xeb0(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xeb8(SB)/8, $0x84c8781484c87814
DATA TABLE<>+0xec0(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xec8(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xed0(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xed8(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xee0(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xee8(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xef0(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xef8(SB)/8, $0x8cc702088cc70208
DATA TABLE<>+0xf00(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf08(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf10(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf18(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf20(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf28(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf30(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf38(SB)/8, $0x90befffa90befffa
DATA TABLE<>+0xf40(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf48(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf50(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf58(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf60(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf68(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf70(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf78(SB)/8, $0xa4506ceba4506ceb
DATA TABLE<>+0xf80(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xf88(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xf90(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xf98(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xfa0(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xfa8(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xfb0(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xfb8(SB)/8, $0xbef9a3f7bef9a3f7
DATA TABLE<>+0xfc0(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xfc8(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xfd0(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xfd8(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xfe0(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xfe8(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xff0(SB)/8, $0xc67178f2c67178f2
DATA TABLE<>+0xff8(SB)/8, $0xc67178f2c67178f2
GLOBL TABLE<>(SB), 8, $4096
