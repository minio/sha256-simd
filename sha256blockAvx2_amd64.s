//+build !noasm !appengine

// SHA256 implementation for AVX2

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

#define ROUND_INTERTWINED(a, b, c, d, e, f, g, h, t1, a0, a1, a2, a3, p, offst, ins1_long, ins1_byte, ins2_long, ins3_long, ins3_byte, ins4_long, ins5_long, ins5_byte, ins6_long, ins7_long, ins7_byte, ins8_long) \
    ADDL offst(p), h \ // add    r11d,[rbp+0x10]     /* # h+=X[i]+K[i] */
    ANDL e, t1 \       // and    r12d,r8d            /* f&e */
    MOVL e, a0 \
    LONG $ins1_long; BYTE $ins1_byte \
    RORL $0x19, a0 \   // rorx   r13d,r8d,0x19       /* rorx    ($a0,$e,$Sigma1[2] */
    MOVL e, a2 \
    RORL $0xb, a2 \    // rorx   r15d,r8d,0xb        /* rorx    ($a2,$e,$Sigma1[1] */
    LONG $ins2_long \
    ADDL a1, a \       // lea    eax,[rax+r14*1]     /* h+=Sigma0(a) from the past */
    ADDL t1, h \       // lea    r11d,[r11+r12*1]
    MOVL e, t1 \
    LONG $ins3_long; BYTE $ins3_byte \
    NOTL t1 \
    ANDL g, t1 \       // andn   r12d,r8d,r10d       /* ~e&g */
    XORL a2, a0 \      // xor    r13d,r15d
    LONG $ins4_long \
    MOVL e, a1 \
    RORL $0x6, a1 \    // rorx   r14d,r8d,0x6        /* rorx    ($a1,$e,$Sigma1[0] */
    ADDL t1, h \       // lea    r11d,[r11+r12*1]    /* h+=Ch(e,f,g)=(e&f)+(~e&g) */
    LONG $ins5_long; BYTE $ins5_byte \
    XORL a1, a0 \      // xor    r13d,r14d           /* Sigma1(e) */
    MOVL a, a2 \       // mov    r15d,eax
    MOVL a, t1 \
    LONG $ins6_long \
    RORL $0x16, t1 \   // rorx   r12d,eax,0x16       /* rorx    ($a4,$a,$Sigma0[2] */
    ADDL a0, h \       // lea    r11d,[r11+r13*1]    /* h+=Sigma1(e) */
    XORL b, a2 \       // xor    r15d,ebx            /* a^b, b^c in next round */
    LONG $ins7_long; BYTE $ins7_byte \
    MOVL a, a1 \
    RORL $0xd, a1 \    // rorx   r14d,eax,0xd        /* rorx    ($a1,$a,$Sigma0[1] */
    MOVL a, a0 \
    LONG $ins8_long \
    RORL $0x2, a0 \    // rorx   r13d,eax,0x2        /* rorx    ($a0,$a,$Sigma0[0] */
    ADDL h, d \        // lea    edx,[rdx+r11*1]     /*  d+=h */
    ANDL a2, a3 \      // and    edi,r15d            /* (b^c)&(a^b) */
    XORL t1, a1 \      // xor    r14d,r12d
    XORL b, a3 \       // xor    edi,ebx             /* Maj(a,b,c)=Ch(a^b,c,b) */
    XORL a0, a1 \      // xor    r14d,r13d           /* Sigma0(a) */
    ADDL a3, h \       // lea    r11d,[r11+rdi*1]    /* h+=Maj(a,b,c) */
    MOVL e, t1         // mov    r12d,r8d            /* copy of f in future */

#define ROUND(a, b, c, d, e, f, g, h, t1, a0, a1, a2, a3, p, offst) \
    ADDL offst(p), h \ // add    r11d,[rbp+0x10]     /* # h+=X[i]+K[i] */
    ANDL e, t1 \       // and    r12d,r8d            /* f&e */
    MOVL e, a0 \
    RORL $0x19, a0 \   // rorx   r13d,r8d,0x19       /* rorx    ($a0,$e,$Sigma1[2] */
    MOVL e, a2 \
    RORL $0xb, a2 \    // rorx   r15d,r8d,0xb        /* rorx    ($a2,$e,$Sigma1[1] */
    ADDL a1, a \       // lea    eax,[rax+r14*1]     /* h+=Sigma0(a) from the past */
    ADDL t1, h \       // lea    r11d,[r11+r12*1]
    MOVL e, t1 \
    NOTL t1 \
    ANDL g, t1 \       // andn   r12d,r8d,r10d       /* ~e&g */
    XORL a2, a0 \      // xor    r13d,r15d
    MOVL e, a1 \
    RORL $0x6, a1 \    // rorx   r14d,r8d,0x6        /* rorx    ($a1,$e,$Sigma1[0] */
    ADDL t1, h \       // lea    r11d,[r11+r12*1]    /* h+=Ch(e,f,g)=(e&f)+(~e&g) */
    XORL a1, a0 \      // xor    r13d,r14d           /* Sigma1(e) */
    MOVL a, a2 \       // mov    r15d,eax
    MOVL a, t1 \
    RORL $0x16, t1 \   // rorx   r12d,eax,0x16       /* rorx    ($a4,$a,$Sigma0[2] */
    ADDL a0, h \       // lea    r11d,[r11+r13*1]    /* h+=Sigma1(e) */
    XORL b, a2 \       // xor    r15d,ebx            /* a^b, b^c in next round */
    MOVL a, a1 \
    RORL $0xd, a1 \    // rorx   r14d,eax,0xd        /* rorx    ($a1,$a,$Sigma0[1] */
    MOVL a, a0 \
    RORL $0x2, a0 \    // rorx   r13d,eax,0x2        /* rorx    ($a0,$a,$Sigma0[0] */
    ADDL h, d \        // lea    edx,[rdx+r11*1]     /*  d+=h */
    ANDL a2, a3 \      // and    edi,r15d            /* (b^c)&(a^b) */
    XORL t1, a1 \      // xor    r14d,r12d
    XORL b, a3 \       // xor    edi,ebx             /* Maj(a,b,c)=Ch(a^b,c,b) */
    XORL a0, a1 \      // xor    r14d,r13d           /* Sigma0(a) */
    ADDL a3, h \       // lea    r11d,[r11+rdi*1]    /* h+=Maj(a,b,c) */
    MOVL e, t1         // mov    r12d,r8d            /* copy of f in future */

DATA K256<>+0x000(SB)/8, $0x71374491428a2f98
DATA K256<>+0x008(SB)/8, $0xe9b5dba5b5c0fbcf
DATA K256<>+0x010(SB)/8, $0x71374491428a2f98
DATA K256<>+0x018(SB)/8, $0xe9b5dba5b5c0fbcf
DATA K256<>+0x020(SB)/8, $0x59f111f13956c25b
DATA K256<>+0x028(SB)/8, $0xab1c5ed5923f82a4
DATA K256<>+0x030(SB)/8, $0x59f111f13956c25b
DATA K256<>+0x038(SB)/8, $0xab1c5ed5923f82a4
DATA K256<>+0x040(SB)/8, $0x12835b01d807aa98
DATA K256<>+0x048(SB)/8, $0x550c7dc3243185be
DATA K256<>+0x050(SB)/8, $0x12835b01d807aa98
DATA K256<>+0x058(SB)/8, $0x550c7dc3243185be
DATA K256<>+0x060(SB)/8, $0x80deb1fe72be5d74
DATA K256<>+0x068(SB)/8, $0xc19bf1749bdc06a7
DATA K256<>+0x070(SB)/8, $0x80deb1fe72be5d74
DATA K256<>+0x078(SB)/8, $0xc19bf1749bdc06a7
DATA K256<>+0x080(SB)/8, $0xefbe4786e49b69c1
DATA K256<>+0x088(SB)/8, $0x240ca1cc0fc19dc6
DATA K256<>+0x090(SB)/8, $0xefbe4786e49b69c1
DATA K256<>+0x098(SB)/8, $0x240ca1cc0fc19dc6
DATA K256<>+0x0a0(SB)/8, $0x4a7484aa2de92c6f
DATA K256<>+0x0a8(SB)/8, $0x76f988da5cb0a9dc
DATA K256<>+0x0b0(SB)/8, $0x4a7484aa2de92c6f
DATA K256<>+0x0b8(SB)/8, $0x76f988da5cb0a9dc
DATA K256<>+0x0c0(SB)/8, $0xa831c66d983e5152
DATA K256<>+0x0c8(SB)/8, $0xbf597fc7b00327c8
DATA K256<>+0x0d0(SB)/8, $0xa831c66d983e5152
DATA K256<>+0x0d8(SB)/8, $0xbf597fc7b00327c8
DATA K256<>+0x0e0(SB)/8, $0xd5a79147c6e00bf3
DATA K256<>+0x0e8(SB)/8, $0x1429296706ca6351
DATA K256<>+0x0f0(SB)/8, $0xd5a79147c6e00bf3
DATA K256<>+0x0f8(SB)/8, $0x1429296706ca6351
DATA K256<>+0x100(SB)/8, $0x2e1b213827b70a85
DATA K256<>+0x108(SB)/8, $0x53380d134d2c6dfc
DATA K256<>+0x110(SB)/8, $0x2e1b213827b70a85
DATA K256<>+0x118(SB)/8, $0x53380d134d2c6dfc
DATA K256<>+0x120(SB)/8, $0x766a0abb650a7354
DATA K256<>+0x128(SB)/8, $0x92722c8581c2c92e
DATA K256<>+0x130(SB)/8, $0x766a0abb650a7354
DATA K256<>+0x138(SB)/8, $0x92722c8581c2c92e
DATA K256<>+0x140(SB)/8, $0xa81a664ba2bfe8a1
DATA K256<>+0x148(SB)/8, $0xc76c51a3c24b8b70
DATA K256<>+0x150(SB)/8, $0xa81a664ba2bfe8a1
DATA K256<>+0x158(SB)/8, $0xc76c51a3c24b8b70
DATA K256<>+0x160(SB)/8, $0xd6990624d192e819
DATA K256<>+0x168(SB)/8, $0x106aa070f40e3585
DATA K256<>+0x170(SB)/8, $0xd6990624d192e819
DATA K256<>+0x178(SB)/8, $0x106aa070f40e3585
DATA K256<>+0x180(SB)/8, $0x1e376c0819a4c116
DATA K256<>+0x188(SB)/8, $0x34b0bcb52748774c
DATA K256<>+0x190(SB)/8, $0x1e376c0819a4c116
DATA K256<>+0x198(SB)/8, $0x34b0bcb52748774c
DATA K256<>+0x1a0(SB)/8, $0x4ed8aa4a391c0cb3
DATA K256<>+0x1a8(SB)/8, $0x682e6ff35b9cca4f
DATA K256<>+0x1b0(SB)/8, $0x4ed8aa4a391c0cb3
DATA K256<>+0x1b8(SB)/8, $0x682e6ff35b9cca4f
DATA K256<>+0x1c0(SB)/8, $0x78a5636f748f82ee
DATA K256<>+0x1c8(SB)/8, $0x8cc7020884c87814
DATA K256<>+0x1d0(SB)/8, $0x78a5636f748f82ee
DATA K256<>+0x1d8(SB)/8, $0x8cc7020884c87814
DATA K256<>+0x1e0(SB)/8, $0xa4506ceb90befffa
DATA K256<>+0x1e8(SB)/8, $0xc67178f2bef9a3f7
DATA K256<>+0x1f0(SB)/8, $0xa4506ceb90befffa
DATA K256<>+0x1f8(SB)/8, $0xc67178f2bef9a3f7

DATA K256<>+0x200(SB)/8, $0x0405060700010203
DATA K256<>+0x208(SB)/8, $0x0c0d0e0f08090a0b
DATA K256<>+0x210(SB)/8, $0x0405060700010203
DATA K256<>+0x218(SB)/8, $0x0c0d0e0f08090a0b
DATA K256<>+0x220(SB)/8, $0x0b0a090803020100
DATA K256<>+0x228(SB)/8, $0xffffffffffffffff
DATA K256<>+0x230(SB)/8, $0x0b0a090803020100
DATA K256<>+0x238(SB)/8, $0xffffffffffffffff
DATA K256<>+0x240(SB)/8, $0xffffffffffffffff
DATA K256<>+0x248(SB)/8, $0x0b0a090803020100
DATA K256<>+0x250(SB)/8, $0xffffffffffffffff
DATA K256<>+0x258(SB)/8, $0x0b0a090803020100

GLOBL K256<>(SB), 8, $608

// func blockAvx2(h []uint32, message []uint8)
TEXT ·blockAvx2(SB), 7, $0

    MOVQ  ctx+0(FP), DI                        // DI: &h
    MOVQ  inp+24(FP), SI                       // SI: &message
    MOVQ  inplength+32(FP), DX                 // len(message)
    ADDQ  SI, DX                               // end pointer of input
    MOVQ  SP, R11                              // copy stack pointer 
    SUBQ  $0x220, SP                           // sp -= 0x220
    ANDQ  $0xfffffffffffffc00, SP              // align stack frame 
    ADDQ  $0x1c0, SP
    MOVQ DI, 0x40(SP)                          // save ctx
    MOVQ SI, 0x48(SP)                          // save input
    MOVQ DX, 0x50(SP)                          // save end pointer
    MOVQ R11, 0x58(SP)                         // save copy of stack pointer

    WORD $0xf8c5; BYTE $0x77                   // vzeroupper 
    ADDQ $0x40, SI			       // input++
    MOVL (DI), AX
    MOVQ SI, R12                               // borrow $T1
    MOVL 4(DI), BX
    CMPQ SI, DX                                // $_end
    MOVL 8(DI), CX
    LONG $0xe4440f4c                           // cmove  r12,rsp            /* next block or random data */
    MOVL 12(DI), DX
    MOVL 16(DI), R8
    MOVL 20(DI), R9
    MOVL 24(DI), R10
    MOVL 28(DI), R11

    LEAQ K256<>(SB), BP                        // lea    rbp,[rip+0x0]
    LONG $0x856f7dc5; LONG $0x00000220         // VMOVDQA YMM8, 0x220[rbp]  /* vmovdqa ymm8,YMMWORD PTR [rip+0x220] */
    LONG $0x8d6f7dc5; LONG $0x00000240         // VMOVDQA YMM9, 0x240[rbp]  /* vmovdqa ymm9,YMMWORD PTR [rip+0x240] */
    LONG $0x956f7dc5; LONG $0x00000200         // VMOVDQA YMM10, 0x200[rbp] /* vmovdqa ymm7,YMMWORD PTR [rip+0x200] */

loop0:
    LONG $0x6f7dc1c4; BYTE $0xfa               // VMOVDQA YMM7, YMM10

    // Load first 16 dwords from two blocks 
    MOVOU -64(SI), X0                          // vmovdqu xmm0,XMMWORD PTR [rsi-0x40]
    MOVOU -48(SI), X1                          // vmovdqu xmm1,XMMWORD PTR [rsi-0x30]
    MOVOU -32(SI), X2                          // vmovdqu xmm2,XMMWORD PTR [rsi-0x20]
    MOVOU -16(SI), X3                          // vmovdqu xmm3,XMMWORD PTR [rsi-0x10]

    // Byte swap data and transpose data into high/low
    LONG $0x387dc3c4; WORD $0x2404; BYTE $0x01 // vinserti128 ymm0,ymm0,[r12],0x1
    LONG $0x3875c3c4; LONG $0x0110244c         // vinserti128 ymm1,ymm1,0x10[r12],0x1
    LONG $0x007de2c4; BYTE $0xc7               // vpshufb     ymm0,ymm0,ymm7
    LONG $0x386dc3c4; LONG $0x01202454         // vinserti128 ymm2,ymm2,0x20[r12],0x1
    LONG $0x0075e2c4; BYTE $0xcf               // vpshufb     ymm1,ymm1,ymm7
    LONG $0x3865c3c4; LONG $0x0130245c         // vinserti128 ymm3,ymm3,0x30[r12],0x1

    LEAQ K256<>(SB), BP
    LONG $0x006de2c4; BYTE $0xd7               // vpshufb ymm2,ymm2,ymm7
    LONG $0x65fefdc5; BYTE $0x00               // vpaddd  ymm4,ymm0,[rbp]
    LONG $0x0065e2c4; BYTE $0xdf               // vpshufb ymm3,ymm3,ymm7
    LONG $0x6dfef5c5; BYTE $0x20               // vpaddd  ymm5,ymm1,0x20[rbp]
    LONG $0x75feedc5; BYTE $0x40               // vpaddd  ymm6,ymm2,0x40[rbp]
    LONG $0x7dfee5c5; BYTE $0x60               // vpaddd  ymm7,ymm3,0x60[rbp]

    LONG $0x247ffdc5; BYTE $0x24               // vmovdqa [rsp],ymm4
    XORQ R14, R14
    LONG $0x6c7ffdc5; WORD $0x2024             // vmovdqa [rsp+0x20],ymm5

    ADDQ $-0x40, SP
    MOVQ BX, DI
    LONG $0x347ffdc5; BYTE $0x24               // vmovdqa [rsp],ymm6
    XORQ CX, DI                                // magic
    LONG $0x7c7ffdc5; WORD $0x2024             // vmovdqa [rsp+0x20],ymm7
    MOVQ R9, R12
    ADDQ $0x80,BP

loop1:
    // Schedule 48 input dwords, by doing 3 rounds of 12 each
    ADDQ $-0x40, SP

    LONG $0x0f75e3c4; WORD $0x04e0 // vpalignr ymm4,ymm1,ymm0,0x4
    LONG $0x0f65e3c4; WORD $0x04fa // vpalignr ymm7,ymm3,ymm2,0x4

    // LONG $0xd472cdc5; BYTE $0x07   // vpsrld ymm6,ymm4,0x7
    // LONG $0xc7fefdc5               // vpaddd ymm0,ymm0,ymm7
    // LONG $0xd472c5c5; BYTE $0x03   // vpsrld ymm7,ymm4,0x3
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xf472d5c5; BYTE $0x0e   // vpslld ymm5,ymm4,0xe
    // LONG $0xe6efc5c5               // vpxor  ymm4,ymm7,ymm6
    // LONG $0xfb70fdc5; BYTE $0xfa   // vpshufd ymm7,ymm3,0xfa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(AX, BX, CX, DX, R8, R9, R10, R11, R12, R13, R14, R15, DI, SP, 0x80, 0xd472cdc5, 0x07, 0xc7fefdc5, 0xd472c5c5, 0x03, 0xf8fe7dc5, 0xf472d5c5, 0x0e, 0xe6efc5c5, 0xfb70fdc5, 0xfa, 0xf8fe7dc5)

    // LONG $0xd672cdc5; BYTE $0x0b   // vpsrld ymm6,ymm6,0xb
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xf572d5c5; BYTE $0x0b   // vpslld ymm5,ymm5,0xb
    // LONG $0xe6efddc5               // vpxor  ymm4,ymm4,ymm6
    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xc4fefdc5               // vpaddd ymm0,ymm0,ymm4
    ROUND_INTERTWINED(R11, AX, BX, CX, DX, R8, R9, R10, R12, R13, R14, DI, R15, SP, 0x84, 0xd672cdc5, 0x0b, 0xe5efddc5, 0xf572d5c5, 0x0b, 0xe6efddc5, 0xd772cdc5, 0x0a, 0xe5efddc5, 0xd773c5c5, 0x11, 0xc4fefdc5)

    // LONG $0xd07285c5; BYTE $0x01   // vpsrld ymm15,ymm0,0x1    /* (5 byte dummy) */
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf0   // vpshufb ymm6,ymm6,ymm8
    // LONG $0xc6fefdc5               // vpaddd ymm0,ymm0,ymm6
    // LONG $0xf870fdc5; BYTE $0x50   // vpshufd ymm7,ymm0,0x50
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(R10, R11, AX, BX, CX, DX, R8, R9, R12, R13, R14, R15, DI, SP, 0x88, 0xd07285c5, 0x01, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf0, 0xc6fefdc5, 0xf870fdc5, 0x50, 0xf8fe7dc5)

    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf1   // vpshufb ymm6,ymm6,ymm9
    // LONG $0xc6fefdc5               // vpaddd ymm0,ymm0,ymm6
    ROUND_INTERTWINED(R9, R10, R11, AX, BX, CX, DX, R8, R12, R13, R14, DI, R15, SP, 0x8c, 0xd772cdc5, 0x0a, 0xf8fe7dc5, 0xd773c5c5, 0x11, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf1, 0xc6fefdc5)

    LONG $0x75fefdc5; BYTE $0x00   // vpaddd ymm6,ymm0,[rbp+0x0]
    LONG $0x347ffdc5; BYTE $0x24   // vmovdqa [rsp],ymm6

    LONG $0x0f6de3c4; WORD $0x04e1 // vpalignr ymm4,ymm2,ymm1,0x4
    LONG $0x0f7de3c4; WORD $0x04fb // vpalignr ymm7,ymm0,ymm3,0x4

    // LONG $0xd472cdc5; BYTE $0x07   // vpsrld ymm6,ymm4,0x7
    // LONG $0xcffef5c5               // vpaddd ymm1,ymm1,ymm7
    // LONG $0xd472c5c5; BYTE $0x03   // vpsrld ymm7,ymm4,0x3
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xf472d5c5; BYTE $0x0e   // vpslld ymm5,ymm4,0xe
    // LONG $0xe6efc5c5               // vpxor  ymm4,ymm7,ymm6
    // LONG $0xf870fdc5; BYTE $0xfa   // vpshufd ymm7,ymm0,0xfa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(R8, R9, R10, R11, AX, BX, CX, DX, R12, R13, R14, R15, DI, SP, 0xa0, 0xd472cdc5, 0x07, 0xcffef5c5, 0xd472c5c5, 0x03, 0xf8fe7dc5, 0xf472d5c5, 0x0e, 0xe6efc5c5, 0xf870fdc5, 0xfa, 0xf8fe7dc5)

    // LONG $0xd672cdc5; BYTE $0x0b   // vpsrld ymm6,ymm6,0xb
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xf572d5c5; BYTE $0x0b   // vpslld ymm5,ymm5,0xb
    // LONG $0xe6efddc5               // vpxor  ymm4,ymm4,ymm6
    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xccfef5c5               // vpaddd ymm1,ymm1,ymm4
    ROUND_INTERTWINED(DX, R8, R9, R10, R11, AX, BX, CX, R12, R13, R14, DI, R15, SP, 0xa4, 0xd672cdc5, 0x0b, 0xe5efddc5, 0xf572d5c5, 0x0b, 0xe6efddc5, 0xd772cdc5, 0x0a, 0xe5efddc5, 0xd773c5c5, 0x11, 0xccfef5c5)

    // LONG $0xd07285c5; BYTE $0x01   // vpsrld ymm15,ymm0,0x1    /* (5 byte dummy) */
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf0   // vpshufb ymm6,ymm6,ymm8
    // LONG $0xcefef5c5               // vpaddd ymm1,ymm1,ymm6
    // LONG $0xf970fdc5; BYTE $0x50   // vpshufd ymm7,ymm1,0x50
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(CX, DX, R8, R9, R10, R11, AX, BX, R12, R13, R14, R15, DI, SP, 0xa8, 0xd07285c5, 0x01, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf0, 0xcefef5c5, 0xf970fdc5, 0x50, 0xf8fe7dc5)


    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf1   // vpshufb ymm6,ymm6,ymm9
    // LONG $0xcefef5c5               // vpaddd ymm1,ymm1,ymm6
    ROUND_INTERTWINED(BX, CX, DX, R8, R9, R10, R11, AX, R12, R13, R14, DI, R15, SP, 0xac, 0xd772cdc5, 0x0a, 0xf8fe7dc5, 0xd773c5c5, 0x11, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf1, 0xcefef5c5)

    LONG $0x75fef5c5; BYTE $0x20   // vpaddd ymm6,ymm1,[rbp+0x20]
    LONG $0x747ffdc5; WORD $0x2024 // vmovdqa [rsp+0x20],ymm6

    ADDQ $-0x40, SP
    LONG $0x0f65e3c4; WORD $0x04e2 // vpalignr ymm4,ymm3,ymm2,0x4
    LONG $0x0f75e3c4; WORD $0x04f8 // vpalignr ymm7,ymm1,ymm0,0x4

    // LONG $0xd472cdc5; BYTE $0x07   // vpsrld ymm6,ymm4,0x7
    // LONG $0xd7feedc5               // vpaddd ymm2,ymm2,ymm7
    // LONG $0xd472c5c5; BYTE $0x03   // vpsrld ymm7,ymm4,0x3
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xf472d5c5; BYTE $0x0e   // vpslld ymm5,ymm4,0xe
    // LONG $0xe6efc5c5               // vpxor  ymm4,ymm7,ymm6
    // LONG $0xf970fdc5; BYTE $0xfa   // vpshufd ymm7,ymm1,0xfa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(AX, BX, CX, DX, R8, R9, R10, R11, R12, R13, R14, R15, DI, SP, 0x80, 0xd472cdc5, 0x07, 0xd7feedc5, 0xd472c5c5, 0x03, 0xf8fe7dc5, 0xf472d5c5, 0x0e, 0xe6efc5c5, 0xf970fdc5, 0xfa, 0xf8fe7dc5)

    // LONG $0xd672cdc5; BYTE $0x0b   // vpsrld ymm6,ymm6,0xb
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xf572d5c5; BYTE $0x0b   // vpslld ymm5,ymm5,0xb
    // LONG $0xe6efddc5               // vpxor  ymm4,ymm4,ymm6
    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xd4feedc5               // vpaddd ymm2,ymm2,ymm4
    ROUND_INTERTWINED(R11, AX, BX, CX, DX, R8, R9, R10, R12, R13, R14, DI, R15, SP, 0x84, 0xd672cdc5, 0x0b, 0xe5efddc5, 0xf572d5c5, 0x0b, 0xe6efddc5, 0xd772cdc5, 0x0a, 0xe5efddc5, 0xd773c5c5, 0x11, 0xd4feedc5)

    // LONG $0xd07285c5; BYTE $0x01   // vpsrld ymm15,ymm0,0x1    /* (5 byte dummy) */
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf0   // vpshufb ymm6,ymm6,ymm8
    // LONG $0xd6feedc5               // vpaddd ymm2,ymm2,ymm6
    // LONG $0xfa70fdc5; BYTE $0x50   // vpshufd ymm7,ymm2,0x50
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(R10, R11, AX, BX, CX, DX, R8, R9, R12, R13, R14, R15, DI, SP, 0x88, 0xd07285c5, 0x01, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf0, 0xd6feedc5, 0xfa70fdc5, 0x50, 0xf8fe7dc5)

    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf1   // vpshufb ymm6,ymm6,ymm9
    // LONG $0xd6feedc5               // vpaddd ymm2,ymm2,ymm6
    ROUND_INTERTWINED(R9, R10, R11, AX, BX, CX, DX, R8, R12, R13, R14, DI, R15, SP, 0x8c, 0xd772cdc5, 0x0a, 0xf8fe7dc5, 0xd773c5c5, 0x11, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf1, 0xd6feedc5)


    LONG $0x75feedc5; BYTE $0x40   // vpaddd ymm6,ymm2,[rbp+0x40]
    LONG $0x347ffdc5; BYTE $0x24   // vmovdqa [rsp],ymm6

    LONG $0x0f7de3c4; WORD $0x04e3 // vpalignr ymm4,ymm0,ymm3,0x4
    LONG $0x0f6de3c4; WORD $0x04f9 // vpalignr ymm7,ymm2,ymm1,0x4

    // LONG $0xd472cdc5; BYTE $0x07   // vpsrld ymm6,ymm4,0x7
    // LONG $0xdffee5c5               // vpaddd ymm3,ymm3,ymm7
    // LONG $0xd472c5c5; BYTE $0x03   // vpsrld ymm7,ymm4,0x3
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xf472d5c5; BYTE $0x0e   // vpslld ymm5,ymm4,0xe
    // LONG $0xe6efc5c5               // vpxor  ymm4,ymm7,ymm6
    // LONG $0xfa70fdc5; BYTE $0xfa   // vpshufd ymm7,ymm2,0xfa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(R8, R9, R10, R11, AX, BX, CX, DX, R12, R13, R14, R15, DI, SP, 0xa0, 0xd472cdc5, 0x07, 0xdffee5c5, 0xd472c5c5, 0x03, 0xf8fe7dc5, 0xf472d5c5, 0x0e, 0xe6efc5c5, 0xfa70fdc5, 0xfa, 0xf8fe7dc5)

    // LONG $0xd672cdc5; BYTE $0x0b   // vpsrld ymm6,ymm6,0xb
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xf572d5c5; BYTE $0x0b   // vpslld ymm5,ymm5,0xb
    // LONG $0xe6efddc5               // vpxor  ymm4,ymm4,ymm6
    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xe5efddc5               // vpxor  ymm4,ymm4,ymm5
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xdcfee5c5               // vpaddd ymm3,ymm3,ymm4
    ROUND_INTERTWINED(DX, R8, R9, R10, R11, AX, BX, CX, R12, R13, R14, DI, R15, SP, 0xa4, 0xd672cdc5, 0x0b, 0xe5efddc5, 0xf572d5c5, 0x0b, 0xe6efddc5, 0xd772cdc5, 0x0a, 0xe5efddc5, 0xd773c5c5, 0x11, 0xdcfee5c5)


    // LONG $0xd07285c5; BYTE $0x01   // vpsrld ymm15,ymm0,0x1    /* (5 byte dummy) */
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf0   // vpshufb ymm6,ymm6,ymm8
    // LONG $0xdefee5c5               // vpaddd ymm3,ymm3,ymm6
    // LONG $0xfb70fdc5; BYTE $0x50   // vpshufd ymm7,ymm3,0x50
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    ROUND_INTERTWINED(CX, DX, R8, R9, R10, R11, AX, BX, R12, R13, R14, R15, DI, SP, 0xa8, 0xd07285c5, 0x01, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf0, 0xdefee5c5, 0xfb70fdc5, 0x50, 0xf8fe7dc5)


    // LONG $0xd772cdc5; BYTE $0x0a   // vpsrld ymm6,ymm7,0xa
    // LONG $0xf8fe7dc5               // vpaddd ymm15,ymm0, ymm0  /* (4 byte dummy) */
    // LONG $0xd773c5c5; BYTE $0x11   // vpsrlq ymm7,ymm7,0x11
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0xd773c5c5; BYTE $0x02   // vpsrlq ymm7,ymm7,0x2
    // LONG $0xf7efcdc5               // vpxor  ymm6,ymm6,ymm7
    // LONG $0x004dc2c4; BYTE $0xf1   // vpshufb ymm6,ymm6,ymm9
    // LONG $0xdefee5c5               // vpaddd ymm3,ymm3,ymm6
    ROUND_INTERTWINED(BX, CX, DX, R8, R9, R10, R11, AX, R12, R13, R14, DI, R15, SP, 0xac, 0xd772cdc5, 0x0a, 0xf8fe7dc5, 0xd773c5c5, 0x11, 0xf7efcdc5, 0xd773c5c5, 0x02, 0xf7efcdc5, 0x004dc2c4, 0xf1, 0xdefee5c5)

    LONG $0x75fee5c5; BYTE $0x60   // vpaddd ymm6,ymm3,[rbp+0x60]
    LONG $0x747ffdc5; WORD $0x2024 // vmovdqa [rsp+0x20],ymm6

    ADDQ $0x80, BP

    CMPB 0x3(BP),$0x0
    JNE  loop1

    ROUND(AX, BX, CX, DX, R8, R9, R10, R11, R12, R13, R14, R15, DI, SP, 0x40)
    ROUND(R11, AX, BX, CX, DX, R8, R9, R10, R12, R13, R14, DI, R15, SP, 0x44)
    ROUND(R10, R11, AX, BX, CX, DX, R8, R9, R12, R13, R14, R15, DI, SP, 0x48)
    ROUND(R9, R10, R11, AX, BX, CX, DX, R8, R12, R13, R14, DI, R15, SP, 0x4c)
    ROUND(R8, R9, R10, R11, AX, BX, CX, DX, R12, R13, R14, R15, DI, SP, 0x60)
    ROUND(DX, R8, R9, R10, R11, AX, BX, CX, R12, R13, R14, DI, R15, SP, 0x64)
    ROUND(CX, DX, R8, R9, R10, R11, AX, BX, R12, R13, R14, R15, DI, SP, 0x68)
    ROUND(BX, CX, DX, R8, R9, R10, R11, AX, R12, R13, R14, DI, R15, SP, 0x6c)
    ROUND(AX, BX, CX, DX, R8, R9, R10, R11, R12, R13, R14, R15, DI, SP, 0x00)
    ROUND(R11, AX, BX, CX, DX, R8, R9, R10, R12, R13, R14, DI, R15, SP, 0x04)
    ROUND(R10, R11, AX, BX, CX, DX, R8, R9, R12, R13, R14, R15, DI, SP, 0x08)
    ROUND(R9, R10, R11, AX, BX, CX, DX, R8, R12, R13, R14, DI, R15, SP, 0x0c)
    ROUND(R8, R9, R10, R11, AX, BX, CX, DX, R12, R13, R14, R15, DI, SP, 0x20)
    ROUND(DX, R8, R9, R10, R11, AX, BX, CX, R12, R13, R14, DI, R15, SP, 0x24)
    ROUND(CX, DX, R8, R9, R10, R11, AX, BX, R12, R13, R14, R15, DI, SP, 0x28)
    ROUND(BX, CX, DX, R8, R9, R10, R11, AX, R12, R13, R14, DI, R15, SP, 0x2c)

    MOVQ 0x200(SP), DI             // $_ctx
    ADDQ R14, AX

    LEAQ 0x1c0(SP), BP

    ADDL (DI), AX
    ADDL 4(DI), BX
    ADDL 8(DI), CX
    ADDL 12(DI), DX
    ADDL 16(DI), R8
    ADDL 20(DI), R9
    ADDL 24(DI), R10
    ADDL 28(DI), R11

    MOVL AX, (DI)
    MOVL BX, 4(DI)
    MOVL CX, 8(DI)
    MOVL DX, 12(DI)
    MOVL R8, 16(DI)
    MOVL R9, 20(DI)
    MOVL R10, 24(DI)
    MOVL R11, 28(DI)

    CMPQ SI, 0x50(BP)              // $_end
    JE   done

    XORQ R14, R14
    MOVQ BX, DI
    XORQ CX, DI                    // magic
    MOVQ R9, R12

loop2:
    ROUND(AX, BX, CX, DX, R8, R9, R10, R11, R12, R13, R14, R15, DI, BP, 0x10)
    ROUND(R11, AX, BX, CX, DX, R8, R9, R10, R12, R13, R14, DI, R15, BP, 0x14)
    ROUND(R10, R11, AX, BX, CX, DX, R8, R9, R12, R13, R14, R15, DI, BP, 0x18)
    ROUND(R9, R10, R11, AX, BX, CX, DX, R8, R12, R13, R14, DI, R15, BP, 0x1c)
    ROUND(R8, R9, R10, R11, AX, BX, CX, DX, R12, R13, R14, R15, DI, BP, 0x30)
    ROUND(DX, R8, R9, R10, R11, AX, BX, CX, R12, R13, R14, DI, R15, BP, 0x34)
    ROUND(CX, DX, R8, R9, R10, R11, AX, BX, R12, R13, R14, R15, DI, BP, 0x38)
    ROUND(BX, CX, DX, R8, R9, R10, R11, AX, R12, R13, R14, DI, R15, BP, 0x3c)

    ADDQ $-0x40, BP
    CMPQ BP, SP
    JAE  loop2

    MOVQ 0x200(SP), DI             // $_ctx
    ADDQ R14, AX

    ADDQ $0x1c0, SP

    ADDL (DI), AX
    ADDL 4(DI), BX
    ADDL 8(DI), CX
    ADDL 12(DI), DX
    ADDL 16(DI), R8
    ADDL 20(DI), R9

    ADDQ $0x80, SI                 // input += 2
    ADDL 24(DI), R10
    MOVQ SI, R12
    ADDL 28(DI), R11
    CMPQ  SI, 0x50(SP)             // input == _end

    MOVL AX, (DI)
    LONG $0xe4440f4c               // cmove  r12,rsp                /* next block or stale data */
    MOVL AX, (DI)
    MOVL BX, 4(DI)
    MOVL CX, 8(DI)
    MOVL DX, 12(DI)
    MOVL R8, 16(DI)
    MOVL R9, 20(DI)
    MOVL R10, 24(DI)
    MOVL R11, 28(DI)

    JBE loop0
    LEAQ (SP), BP

done:
    MOVQ BP, SP
    MOVQ 0x58(SP), SP
    WORD $0xf8c5; BYTE $0x77     // vzeroupper

    RET

