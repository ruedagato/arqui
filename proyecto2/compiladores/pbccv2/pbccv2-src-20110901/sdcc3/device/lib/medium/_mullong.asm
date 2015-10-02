;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:25 2015
;--------------------------------------------------------
	.module _mullong
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mullong_PARM_2
	.globl __mullong
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
__mullong_sloc0_1_0::
	.ds 1
__mullong_sloc1_1_0::
	.ds 1
__mullong_sloc2_1_0::
	.ds 2
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
__mullong_PARM_2:
	.ds 4
__mullong_a_1_1:
	.ds 4
__mullong_t_1_1:
	.ds 4
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function '_mullong'
;------------------------------------------------------------
;sloc0                     Allocated with name '__mullong_sloc0_1_0'
;sloc1                     Allocated with name '__mullong_sloc1_1_0'
;sloc2                     Allocated with name '__mullong_sloc2_1_0'
;------------------------------------------------------------
;	_mullong.c:703: _mullong (long a, long b)
;	-----------------------------------------
;	 function _mullong
;	-----------------------------------------
__mullong:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	r0,#__mullong_a_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	_mullong.c:707: t.i.hi = bcast(a)->b.b0 * bcast(b)->b.b2;           // A
	mov	r0,#__mullong_a_1_1
	movx	a,@r0
	mov	r2,a
	mov	r0,#(__mullong_PARM_2 + 0x0002)
	movx	a,@r0
	mov	r3,a
	mov	b,r2
	mul	ab
	mov	r4,a
	mov	r5,b
	mov	r0,#(__mullong_t_1_1 + 0x0002)
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	_mullong.c:708: t.i.lo = bcast(a)->b.b0 * bcast(b)->b.b0;           // A
	mov	r0,#__mullong_PARM_2
	movx	a,@r0
	mov	r4,a
	mov	b,r2
	mul	ab
	mov	r5,a
	mov	r6,b
	mov	r0,#__mullong_t_1_1
	mov	a,r5
	movx	@r0,a
	inc	r0
	mov	a,r6
	movx	@r0,a
;	_mullong.c:709: t.b.b3 += bcast(a)->b.b3 * bcast(b)->b.b0;          // G
	mov	r0,#(__mullong_t_1_1 + 0x0003)
	movx	a,@r0
	mov	r5,a
	mov	r0,#(__mullong_a_1_1 + 0x0003)
	movx	a,@r0
	mov	r6,a
	mov	b,r6
	mov	a,r4
	mul	ab
	add	a,r5
	mov	r0,#(__mullong_t_1_1 + 0x0003)
	movx	@r0,a
;	_mullong.c:710: t.b.b3 += bcast(a)->b.b2 * bcast(b)->b.b1;          // F
	mov	r0,#(__mullong_t_1_1 + 0x0003)
	movx	a,@r0
	mov	__mullong_sloc0_1_0,a
	mov	r0,#(__mullong_a_1_1 + 0x0002)
	movx	a,@r0
	mov	r6,a
	mov	r0,#(__mullong_PARM_2 + 0x0001)
	movx	a,@r0
	mov	__mullong_sloc1_1_0,a
	mov	b,r6
	mul	ab
	add	a,__mullong_sloc0_1_0
	mov	r0,#(__mullong_t_1_1 + 0x0003)
	movx	@r0,a
;	_mullong.c:711: t.i.hi += bcast(a)->b.b2 * bcast(b)->b.b0;          // E <- b lost in .lst
	mov	r0,#(__mullong_t_1_1 + 0x0002)
	movx	a,@r0
	mov	__mullong_sloc2_1_0,a
	inc	r0
	movx	a,@r0
	mov	(__mullong_sloc2_1_0 + 1),a
	mov	b,r6
	mov	a,r4
	mul	ab
	mov	r5,b
	add	a,__mullong_sloc2_1_0
	mov	r6,a
	mov	a,r5
	addc	a,(__mullong_sloc2_1_0 + 1)
	mov	r5,a
	mov	r0,#(__mullong_t_1_1 + 0x0002)
	mov	a,r6
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	_mullong.c:713: t.i.hi += bcast(a)->b.b1 * bcast(b)->b.b1;          // D <- b lost in .lst
	mov	r0,#(__mullong_t_1_1 + 0x0002)
	movx	a,@r0
	mov	__mullong_sloc2_1_0,a
	inc	r0
	movx	a,@r0
	mov	(__mullong_sloc2_1_0 + 1),a
	mov	r0,#(__mullong_a_1_1 + 0x0001)
	movx	a,@r0
	mov	r7,a
	mov	b,r7
	mov	a,__mullong_sloc1_1_0
	mul	ab
	mov	r6,b
	add	a,__mullong_sloc2_1_0
	mov	r5,a
	mov	a,r6
	addc	a,(__mullong_sloc2_1_0 + 1)
	mov	r6,a
	mov	r0,#(__mullong_t_1_1 + 0x0002)
	mov	a,r5
	movx	@r0,a
	inc	r0
	mov	a,r6
	movx	@r0,a
;	_mullong.c:715: bcast(a)->bi.b3 = bcast(a)->b.b1 * bcast(b)->b.b2;  // C
	mov	b,r7
	mov	a,r3
	mul	ab
	mov	r0,#(__mullong_a_1_1 + 0x0003)
	movx	@r0,a
;	_mullong.c:716: bcast(a)->bi.i12 = bcast(a)->b.b1 * bcast(b)->b.b0; // C
	mov	r0,#(__mullong_a_1_1 + 0x0001)
	movx	a,@r0
	mov	r3,a
	mov	b,r3
	mov	a,r4
	mul	ab
	mov	r4,a
	mov	r5,b
	mov	r0,#(__mullong_a_1_1 + 0x0001)
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	_mullong.c:718: bcast(b)->bi.b3 = bcast(a)->b.b0 * bcast(b)->b.b3;  // B
	mov	r0,#(__mullong_PARM_2 + 0x0003)
	movx	a,@r0
	mov	b,r2
	mul	ab
	mov	r0,#(__mullong_PARM_2 + 0x0003)
	movx	@r0,a
;	_mullong.c:719: bcast(b)->bi.i12 = bcast(a)->b.b0 * bcast(b)->b.b1; // B
	mov	r0,#(__mullong_PARM_2 + 0x0001)
	movx	a,@r0
	mov	b,r2
	mul	ab
	mov	r2,a
	mov	r4,b
	mov	r0,#(__mullong_PARM_2 + 0x0001)
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
;	_mullong.c:721: bcast(b)->bi.b0 = 0;                                // B
	mov	r0,#__mullong_PARM_2
	clr	a
	movx	@r0,a
;	_mullong.c:722: bcast(a)->bi.b0 = 0;                                // C
	mov	r0,#__mullong_a_1_1
	clr	a
	movx	@r0,a
;	_mullong.c:723: t.l += a;
	mov	r0,#__mullong_t_1_1
	movx	a,@r0
	mov	r2,a
	inc	r0
	movx	a,@r0
	mov	r3,a
	inc	r0
	movx	a,@r0
	mov	r4,a
	inc	r0
	movx	a,@r0
	mov	r5,a
	mov	r0,#__mullong_a_1_1
	movx	a,@r0
	add	a,r2
	mov	r2,a
	inc	r0
	movx	a,@r0
	addc	a,r3
	mov	r3,a
	inc	r0
	movx	a,@r0
	addc	a,r4
	mov	r4,a
	inc	r0
	movx	a,@r0
	addc	a,r5
	mov	r5,a
	mov	r0,#__mullong_t_1_1
	mov	a,r2
	movx	@r0,a
	inc	r0
	mov	a,r3
	movx	@r0,a
	inc	r0
	mov	a,r4
	movx	@r0,a
	inc	r0
	mov	a,r5
	movx	@r0,a
;	_mullong.c:725: return t.l + b;
	mov	r0,#__mullong_t_1_1
	movx	a,@r0
	inc	r0
	movx	a,@r0
	inc	r0
	movx	a,@r0
	inc	r0
	movx	a,@r0
	mov	r0,#__mullong_PARM_2
	movx	a,@r0
	add	a,r2
	mov	r2,a
	inc	r0
	movx	a,@r0
	addc	a,r3
	mov	r3,a
	inc	r0
	movx	a,@r0
	addc	a,r4
	mov	r4,a
	inc	r0
	movx	a,@r0
	addc	a,r5
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
