//+build !noasm !appengine

// SHA256 implementation for AVX

//
// Minio Cloud Storage, (C) 2016 Minio, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

//
// This code is based on an Intel White-Paper:
// "Fast SHA-256 Implementations on Intel Architecture Processors"
//
// together with the reference implementation from the following authors:
//    James Guilford <james.guilford@intel.com>
//    Kirk Yap <kirk.s.yap@intel.com>
//    Tim Chen <tim.c.chen@linux.intel.com>
//
// For Golang it has been converted to Plan 9 assembly with the help of
// github.com/minio/asm2plan9s to assemble Intel instructions to their Plan9
// equivalents
//

#include "textflag.h"

#define SHUF_00BA      X10      // shuffle xBxA -> 00BA
#define SHUF_DC00      X12      // shuffle xDxC -> DC00

#define FOUR_ROUNDS_AND_SCHED(a, b, c, d, e, f, g, h) \
    MOVL e, R13 \                                                        /* y0 = e                                 */
    ROLL $18, R13 \                                                      /* y0 = e >> (25-11)                      */
    MOVL a, R14 \                                                        /* y1 = a                                 */
                                 \ /* vpalignr xmm0,xmm7,xmm6,0x4           XTMP0 = W[-7]                          */
    ROLL $23, R14 \                                                      /* y1 = a >> (22-13)                      */
    XORL e, R13 \                                                        /* y0 = e ^ (e >> (25-11))                */
    MOVL f, R15 \                                                        /* y2 = f                                 */
    ROLL $27, R13 \                                                      /* y0 = (e >> (11-6)) ^ (e >> (25-6))     */
    XORL a, R14 \                                                        /* y1 = a ^ (a >> (22-13)                 */
    XORL g, R15 \                                                        /* y2 = f^g                               */
                                 \ /* vpaddd xmm0,xmm0,xmm4                 XTMP0 = W[-7] + W[-16]                 */
    XORL e, R13 \                                                        /* y0 = e ^ (e >> (11-6)) ^ (e >> (25-6)) */
    ANDL e, R15 \                                                        /* y2 = (f^g)&e                           */
    ROLL $21, R14 \                                                      /* y1 = (a >> (13-2)) ^ (a >> (22-2))     */
                                 \ /*                                                                              */
                                 \ /* compute s0                                                                   */
                                 \ /*                                                                              */
                                 \ /* vpalignr xmm1,xmm5,xmm4,0x4           XTMP1 = W[-15]                         */
    XORL a, R14 \                                                        /* y1 = a ^ (a >> (13-2)) ^ (a >> (22-2)) */
    ROLL $26, R13 \                                                      /* y0 = S1 = (e>>6) & (e>>11) ^ (e>>25)   */
    XORL g, R15 \                                                        /* y2 = CH = ((f^g)&e)^g                  */
    ROLL $30, R14 \                                                      /* y1 = S0 = (a>>2) ^ (a>>13) ^ (a>>22)   */
    ADDL R13, R15 \                                                      /* y2 = S1 + CH                           */
    ADDL _xfer+48(FP), R15 \                                             /* y2 = k + w + S1 + CH                   */
    MOVL a, R13 \                                                        /* y0 = a                                 */
    ADDL R15, h \                                                        /*  h = h + S1 + CH + k + w               */
                                 \ /* ROTATE_ARGS */
    MOVL a, R15 \                                                        /* y2 = a */
                                 \ /* vpsrld xmm2,xmm1,0x7 */
    ORL  c, R13 \                                                        /* y0 = a|c */
    ADDL h, d \                                                          /*  d = d + h + S1 + CH + k + w */
    ANDL c, R15 \                                                        /* y2 = a&c */
                                 \ /* vpslld xmm3,xmm1,0x19 */
    ANDL b, R13 \                                                        /* y0 = (a|c)&b */
    ADDL R14, h \                                                        /*  h = h + S1 + CH + k + w + S0 */
                                 \ /* vpor   xmm3,xmm3,xmm2                 XTMP1 = W[-15] MY_ROR 7 */
    ORL  R15, R13 \                                                      /* y0 = MAJ = (a|c)&b)|(a&c) */
    ADDL R13, h \                                                        /*  h = h + S1 + CH + k + w + S0 + MAJ */
                                 \ /* ROTATE_ARGS */
    MOVL d, R13 \                                                        /* y0 = e */
    MOVL h, R14 \                                                        /* y1 = a */
    ROLL $18, R13 \                                                      /* y0 = e >> (25-11) */
    XORL d, R13 \                                                        /* y0 = e ^ (e >> (25-11)) */
    MOVL e, R15 \                                                        /* y2 = f */
    ROLL $23, R14 \                                                      /* y1 = a >> (22-13)*/
                                 \ /* vpsrld xmm2,xmm1,0x12                  */
    XORL h, R14 \                                                        /* y1 = a ^ (a >> (22-13) */
    ROLL $27, R13 \                                                      /* y0 = (e >> (11-6)) ^ (e >> (25-6)) */
    XORL f, R15 \                                                        /* y2 = f^g */
                                 \ /* vpsrld xmm8,xmm1,0x3                  XTMP4 = W[-15] >> 3 */
    ROLL $21, R14 \                                                      /* y1 = (a >> (13-2)) ^ (a >> (22-2)) */
    XORL d, R13 \                                                        /* y0 = e ^ (e >> (11-6)) ^ (e >> (25-6)) */
    ANDL d, R15 \                                                        /* y2 = (f^g)&e */
    ROLL $26, R13 \                                                      /* y0 = S1 = (e>>6) & (e>>11) ^ (e>>25) */
                                 \ /* vpslld xmm1,xmm1,0xe                   */
    XORL h, R14 \                                                        /* y1 = a ^ (a >> (13-2)) ^ (a >> (22-2)) */
    XORL f, R15 \                                                        /* y2 = CH = ((f^g)&e)^g */
                                 \ /* vpxor  xmm3,xmm3,xmm1                  */
    ADDL R13, R15 \                                                      /* y2 = S1 + CH */
    ADDL _xfer+52(FP), R15 \                                             /* y2 = k + w + S1 + CH */
    ROLL $30, R14 \                                                      /* y1 = S0 = (a>>2) ^ (a>>13) ^ (a>>22) */
                                 \ /* vpxor  xmm3,xmm3,xmm2                  XTMP1 = W[-15] MY_ROR 7 ^ W[-15] MY_ROR */
    MOVL h, R13 \                                                        /* y0 = a */
    ADDL R15, g \                                                        /*  h = h + S1 + CH + k + w */
    MOVL h, R15 \                                                        /* y2 = a */
                                 \ /* vpxor  xmm1,xmm3,xmm8                  XTMP1 = s0 */
    ORL  b, R13 \                                                        /* y0 = a|c */
    ADDL g, c \                                                          /*  d = d + h + S1 + CH + k + w */
    ANDL b, R15 \                                                        /* y2 = a&c */
                                 \ /*                                                                              */
                                 \ /* compute low s1                                                               */
                                 \ /*                                                                              */
                                 \ /* vpshufd xmm2,xmm7,0xfa                 XTMP2 = W[-2] {BBAA} */
    ANDL a, R13 \                                                        /* y0 = (a|c)&b */
    ADDL R14, g \                                                        /*  h = h + S1 + CH + k + w + S0 */
                                 \ /* vpaddd xmm0,xmm0,xmm1                  XTMP0 = W[-16] + W[-7] + s0 */
    ORL  R15, R13 \                                                      /* y0 = MAJ = (a|c)&b)|(a&c) */
    ADDL R13, g \                                                        /*  h = h + S1 + CH + k + w + S0 + MAJ */
                                 \ /* */
    MOVL c, R13 \                                                        /* y0 = e */
    MOVL g, R14 \                                                        /* y1 = a */
    ROLL $18, R13 \                                                      /* y0 = e >> (25-11) */
    XORL c, R13 \                                                        /* y0 = e ^ (e >> (25-11)) */
    ROLL $23, R14 \                                                      /* y1 = a >> (22-13) */
    MOVL d, R15 \                                                        /* y2 = f */
    XORL g, R14 \                                                        /* y1 = a ^ (a >> (22-13) */
    ROLL $27, R13 \                                                      /* y0 = (e >> (11-6)) ^ (e >> (25-6)) */
                                 \ /* vpsrld xmm8,xmm2,0xa                   XTMP4 = W[-2] >> 10 {BBAA} */
    XORL e, R15 \                                                        /* y2 = f^g */
                                 \ /* vpsrlq xmm3,xmm2,0x13                  XTMP3 = W[-2] MY_ROR 19 {xBxA} */
    XORL c, R13 \                                                        /* y0 = e ^ (e >> (11-6)) ^ (e >> (25-6)) */
    ANDL c, R15 \                                                        /* y2 = (f^g)&e */
                                 \ /* vpsrlq xmm2,xmm2,0x11                  XTMP2 = W[-2] MY_ROR 17 {xBxA} */
    ROLL $21, R14 \                                                      /* y1 = (a >> (13-2)) ^ (a >> (22-2)) */
    XORL g, R14 \                                                        /* y1 = a ^ (a >> (13-2)) ^ (a >> (22-2)) */
    XORL e, R15 \                                                        /* y2 = CH = ((f^g)&e)^g */
    ROLL $26, R13 \                                                      /* y0 = S1 = (e>>6) & (e>>11) ^ (e>>25) */
                                 \ /* vpxor  xmm2,xmm2,xmm3                  */
    ADDL R13, R15 \                                                      /* y2 = S1 + CH */
    ROLL $30, R14 \                                                      /* y1 = S0 = (a>>2) ^ (a>>13) ^ (a>>22) */
    ADDL _xfer+56(FP), R15 \                                             /* y2 = k + w + S1 + CH */
                                 \ /* vpxor  xmm8,xmm8,xmm2                 XTMP4 = s1 {xBxA} */
    MOVL g, R13 \                                                        /* y0 = a */
    ADDL R15, f \                                                        /*  h = h + S1 + CH + k + w */
    MOVL g, R15 \                                                        /* y2 = a */
                                 \ /* vpshufb xmm8,xmm8,xmm10               XTMP4 = s1 {00BA} */
    ORL  a, R13 \                                                        /* y0 = a|c */
    ADDL f, b \                                                          /*  d = d + h + S1 + CH + k + w */
    ANDL a, R15 \                                                        /* y2 = a&c */
                                 \ /* vpaddd xmm0,xmm0,xmm8                 XTMP0 = {..., ..., W[1], W[0]} */
    ANDL h, R13 \                                                        /* y0 = (a|c)&b */
    ADDL R14, f \                                                        /*  h = h + S1 + CH + k + w + S0 */
                                 \ /*                                                                              */
                                 \ /* compute high s1                                                              */
                                 \ /*                                                                              */
                                 \ /* vpshufd xmm2,xmm0,0x50                 XTMP2 = W[-2] {DDCC} */
    ORL  R15, R13 \                                                      /* y0 = MAJ = (a|c)&b)|(a&c) */
    ADDL R13, f \                                                        /*  h = h + S1 + CH + k + w + S0 + MAJ */
                                 \ /* */
    MOVL b, R13 \                                                        /* y0 = e */
    ROLL $18, R13 \                                                      /* y0 = e >> (25-11) */
    MOVL f, R14 \                                                        /* y1 = a */
    ROLL $23, R14 \                                                      /* y1 = a >> (22-13) */
    XORL b, R13 \                                                        /* y0 = e ^ (e >> (25-11)) */
    MOVL c, R15 \                                                        /* y2 = f */
    ROLL $27, R13 \                                                      /* y0 = (e >> (11-6)) ^ (e >> (25-6)) */
                                 \ /* vpsrld xmm11,xmm2,0xa                 XTMP5 = W[-2] >> 10 {DDCC} */
    XORL f, R14 \                                                        /* y1 = a ^ (a >> (22-13) */
    XORL d, R15 \                                                        /* y2 = f^g */
                                 \ /* vpsrlq xmm3,xmm2,0x13                 XTMP3 = W[-2] MY_ROR 19 {xDxC} */
    XORL b, R13 \                                                        /* y0 = e ^ (e >> (11-6)) ^ (e >> (25-6)) */
    ANDL b, R15 \                                                        /* y2 = (f^g)&e */
    ROLL $21, R14 \                                                      /* y1 = (a >> (13-2)) ^ (a >> (22-2)) */
                                 \ /* vpsrlq xmm2,xmm2,0x11                 XTMP2 = W[-2] MY_ROR 17 {xDxC} */
    XORL f, R14 \                                                        /* y1 = a ^ (a >> (13-2)) ^ (a >> (22-2)) */
    ROLL $26, R13 \                                                      /* y0 = S1 = (e>>6) & (e>>11) ^ (e>>25) */
    XORL d, R15 \                                                        /* y2 = CH = ((f^g)&e)^g */
                                 \ /* vpxor  xmm2,xmm2,xmm3                  */
    ROLL $30, R14 \                                                      /* y1 = S0 = (a>>2) ^ (a>>13) ^ (a>>22) */
    ADDL R13, R15 \                                                      /* y2 = S1 + CH */
    ADDL _xfer+60(FP), R15 \                                             /* y2 = k + w + S1 + CH */
                                 \ /* vpxor  xmm11,xmm11,xmm2               XTMP5 = s1 {xDxC} */
    MOVL f, R13 \                                                        /* y0 = a */
    ADDL R15, e \                                                        /*  h = h + S1 + CH + k + w */
    MOVL f, R15 \                                                        /* y2 = a */
                                 \ /* vpshufb xmm11,xmm11,xmm12             XTMP5 = s1 {DC00} */
    ORL  h, R13 \                                                        /* y0 = a|c */
    ADDL e, a \                                                          /*  d = d + h + S1 + CH + k + w */
    ANDL h, R15 \                                                        /* y2 = a&c */
                                 \ /* vpaddd xmm4,xmm11,xmm0                X0 = {W[3], W[2], W[1], W[0]} */
    ANDL g, R13 \                                                        /* y0 = (a|c)&b */
    ADDL R14, e \                                                        /*  h = h + S1 + CH + k + w + S0 */
    ORL  R15, R13 \                                                      /* y0 = MAJ = (a|c)&b)|(a&c) */
    ADDL R13, e                                                          /*  h = h + S1 + CH + k + w + S0 + MAJ */

#define DO_ROUND(a, b, c, d, e, f, g, h) \
    MOVL e, R13 \                                                        /* y0 = e                                 */
    ROLL $18, R13 \                                                      /* y0 = e >> (25-11)                      */
    MOVL a, R14 \                                                        /* y1 = a                                 */
    XORL e, R13 \                                                        /* y0 = e ^ (e >> (25-11))                */
    ROLL $23, R14 \                                                      /* y1 = a >> (22-13)                      */
    MOVL f, R15 \                                                        /* y2 = f                                 */
    XORL a, R14 \                                                        /* y1 = a ^ (a >> (22-13)                 */
    ROLL $27, R13 \                                                      /* y0 = (e >> (11-6)) ^ (e >> (25-6))     */
    XORL g, R15 \                                                        /* y2 = f^g                               */
    XORL e, R13 \                                                        /* y0 = e ^ (e >> (11-6)) ^ (e >> (25-6)) */
    ROLL $21, R14 \                                                      /* y1 = (a >> (13-2)) ^ (a >> (22-2))     */
    ANDL e, R15 \                                                        /* y2 = (f^g)&e                           */
    XORL a, R14 \                                                        /* y1 = a ^ (a >> (13-2)) ^ (a >> (22-2)) */
    ROLL $26, R13 \                                                      /* y0 = S1 = (e>>6) & (e>>11) ^ (e>>25)   */
    XORL g, R15 \                                                        /* y2 = CH = ((f^g)&e)^g                  */
    ADDL R13, R15 \                                                      /* y2 = S1 + CH                           */
    ROLL $30, R14 \                                                      /* y1 = S0 = (a>>2) ^ (a>>13) ^ (a>>22)   */
                                 \ /* offset = \round * 4 + _XFER */
                                 \ /* add    r15d,DWORD PTR [rsp+0x10]      y2 = k + w + S1 + CH                   */
    MOVL a, R13 \                                                        /* y0 = a                                 */
    ADDL R15, h \                                                        /*  h = h + S1 + CH + k + w               */
    MOVL a, R15 \                                                        /* y2 = a */
    ORL  c, R13 \                                                        /* y0 = a|c */
    ADDL h, d \                                                          /*  d = d + h + S1 + CH + k + w */
    ANDL c, R15 \                                                        /* y2 = a&c */
    ANDL b, R13 \                                                        /* y0 = (a|c)&b */
    ADDL R14, h \                                                        /*  h = h + S1 + CH + k + w + S0 */
    ORL  R15, R13 \                                                      /* y0 = MAJ = (a|c)&b)|(a&c) */
    ADDL R13, h \                                                        /*  h = h + S1 + CH + k + w + S0 + MAJ */


// func block()
TEXT ·block(SB), 7, $0

	MOVQ    h+0(FP), SI // SI: &h
//  MOVD lenmessage+32(FP), R2 // length of message

    // Register definition
    //  a -->  eax
    //  b -->  ebx
    //  c -->  ecx
    //  d -->  r8d
    //  e -->  edx
    //  f -->  r9d
    //  g --> r10d
    //  h --> r11d
    //
    // y0 --> r13d
    // y1 --> r14d
    // y2 --> r15d

	MOVL    (0*4)(SI),  AX        // a = H0
	MOVL    (1*4)(SI),  BX        // b = H1
	MOVL    (2*4)(SI),  CX        // c = H2
	MOVL    (3*4)(SI),  R8        // d = H3
	MOVL    (4*4)(SI),  DX        // e = H4
	MOVL    (5*4)(SI),  R9        // f = H5
	MOVL    (6*4)(SI), R10        // g = H6
	MOVL    (7*4)(SI), R11        // h = H7

	MOVOU bflipMask<>(SB), X13
	MOVOU shuf00BA<>(SB), SHUF_00BA
	MOVOU shufDC00<>(SB), SHUF_DC00

loop0:
	LEAQ constants<>(SB), BP
    //  50:    lea    rbp,[rip+0x0]        # 57 <loop0+0x7>

	// byte swap first 16 dwords
	MOVQ  message+24(FP), SI // SI: &message
    MOVOU 0*16(SI), X4
    LONG $0x0059c2c4; BYTE $0xe5 // VPSHUFB XMM4, XMM4, XMM13
    MOVOU 1*16(SI), X5
    LONG $0x0051c2c4; BYTE $0xed // VPSHUFB XMM5, XMM5, XMM13
    MOVOU 2*16(SI), X6
    LONG $0x0049c2c4; BYTE $0xf5 // VPSHUFB XMM6, XMM6, XMM13
    MOVOU 3*16(SI), X7
    LONG $0x0041c2c4; BYTE $0xfd // VPSHUFB XMM7, XMM7, XMM13

    //  mov    QWORD PTR [rsp+0x8],rdi
    //  mov    rdi,0x3
    //  nop    WORD PTR [rax+rax*1+0x0]

	// schedule 48 input dwords, by doing 3 rounds of 16 each
loop1:
    LONG $0x4dfe59c5; BYTE $0x00 // VPADDD XMM9, XMM4, 0[RBP]   // Add constant to first part of message
    MOVOU X9, _xfer+48(FP)

    FOUR_ROUNDS_AND_SCHED(AX, BX,  CX,  R8, DX, R9, R10, R11)
//  FOUR_ROUNDS_AND_SCHED(DX, R9, R10, R11, AX, BX,  CX,  R8)
//  FOUR_ROUNDS_AND_SCHED(AX, BX,  CX,  R8, DX, R9, R10, R11)
//  FOUR_ROUNDS_AND_SCHED(DX, R9, R10, R11, AX, BX,  CX,  R8)

loop2:
//  DO_ROUND( AX,  BX,  CX,  R8,  DX,  R9, R10, R11)
//  DO_ROUND(R11,  AX,  BX,  CX,  R8,  DX,  R9, R10)
//  DO_ROUND(R10, R11,  AX,  BX,  CX,  R8,  DX,  R9)
//  DO_ROUND( R9, R10, R11,  AX,  BX,  CX,  R8,  DX)

//  ROTATE X0-X3

//  DO_ROUND( DX,  R9, R10, R11,  AX,  BX,  CX,  R8)
//  DO_ROUND( R8,  DX,  R9, R10, R11,  AX,  BX,  CX)
//  DO_ROUND( CX,  R8,  DX,  R9, R10, R11,  AX,  BX)
//  DO_ROUND( BX,  CX,  R8,  DX,  R9, R10, R11,  AX)

	MOVQ    h+0(FP), SI // SI: &h
	ADDL    (0*4)(SI), AX     // H0 = a + H0
	MOVL    AX, (0*4)(SI)
	ADDL    (1*4)(SI), BX     // H1 = b + H1
	MOVL    BX, (1*4)(SI)
	ADDL    (2*4)(SI), CX     // H2 = c + H2
	MOVL    CX, (2*4)(SI)
	ADDL    (3*4)(SI), R8     // H3 = d + H3
	MOVL    R8, (3*4)(SI)
	ADDL    (4*4)(SI), DX     // H4 = e + H4
	MOVL    DX, (4*4)(SI)
	ADDL    (5*4)(SI), R9     // H5 = f + H5
	MOVL    R9, (5*4)(SI)
	ADDL    (6*4)(SI), R10    // H6 = g + H6
	MOVL    R10, (6*4)(SI)
	ADDL    (7*4)(SI), R11    // H7 = h + H7
	MOVL    R11, (7*4)(SI)

    RET

// Constants table
DATA constants<>+0x0(SB)/8, $0x71374491428a2f98
DATA constants<>+0x8(SB)/8, $0xe9b5dba5b5c0fbcf
DATA constants<>+0x10(SB)/8, $0x59f111f13956c25b
DATA constants<>+0x18(SB)/8, $0xab1c5ed5923f82a4
DATA constants<>+0x20(SB)/8, $0x12835b01d807aa98
DATA constants<>+0x28(SB)/8, $0x550c7dc3243185be
DATA constants<>+0x30(SB)/8, $0x80deb1fe72be5d74
DATA constants<>+0x38(SB)/8, $0xc19bf1749bdc06a7
DATA constants<>+0x40(SB)/8, $0xefbe4786e49b69c1
DATA constants<>+0x48(SB)/8, $0x240ca1cc0fc19dc6
DATA constants<>+0x50(SB)/8, $0x4a7484aa2de92c6f
DATA constants<>+0x58(SB)/8, $0x76f988da5cb0a9dc
DATA constants<>+0x60(SB)/8, $0xa831c66d983e5152
DATA constants<>+0x68(SB)/8, $0xbf597fc7b00327c8
DATA constants<>+0x70(SB)/8, $0xd5a79147c6e00bf3
DATA constants<>+0x78(SB)/8, $0x1429296706ca6351
DATA constants<>+0x80(SB)/8, $0x2e1b213827b70a85
DATA constants<>+0x88(SB)/8, $0x53380d134d2c6dfc
DATA constants<>+0x90(SB)/8, $0x766a0abb650a7354
DATA constants<>+0x98(SB)/8, $0x92722c8581c2c92e
DATA constants<>+0xa0(SB)/8, $0xa81a664ba2bfe8a1
DATA constants<>+0xa8(SB)/8, $0xc76c51a3c24b8b70
DATA constants<>+0xb0(SB)/8, $0xd6990624d192e819
DATA constants<>+0xb8(SB)/8, $0x106aa070f40e3585
DATA constants<>+0xc0(SB)/8, $0x1e376c0819a4c116
DATA constants<>+0xc8(SB)/8, $0x34b0bcb52748774c
DATA constants<>+0xd0(SB)/8, $0x4ed8aa4a391c0cb3
DATA constants<>+0xd8(SB)/8, $0x682e6ff35b9cca4f
DATA constants<>+0xe0(SB)/8, $0x78a5636f748f82ee
DATA constants<>+0xe8(SB)/8, $0x8cc7020884c87814
DATA constants<>+0xf0(SB)/8, $0xa4506ceb90befffa
DATA constants<>+0xf8(SB)/8, $0xc67178f2bef9a3f7

DATA bflipMask<>+0x00(SB)/8, $0x0405060700010203
DATA bflipMask<>+0x08(SB)/8, $0x0c0d0e0f08090a0b

DATA shuf00BA<>+0x00(SB)/8, $0x0b0a090803020100
DATA shuf00BA<>+0x08(SB)/8, $0xFFFFFFFFFFFFFFFF

DATA shufDC00<>+0x00(SB)/8, $0xFFFFFFFFFFFFFFFF
DATA shufDC00<>+0x08(SB)/8, $0x0b0a090803020100

GLOBL constants<>(SB), 8, $256
GLOBL bflipMask<>(SB), (NOPTR+RODATA), $16
GLOBL shuf00BA<>(SB), (NOPTR+RODATA), $16
GLOBL shufDC00<>(SB), (NOPTR+RODATA), $16
