;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _mullong
	.optsdcc -mds400 --model-flat24
	
;--------------------------------------------------------
; CPU specific extensions
;--------------------------------------------------------
.flat24 on		; 24 bit flat addressing
dpl1	=	0x84
dph1	=	0x85
dps	=	0x86
dpx	=	0x93
dpx1	=	0x95
esp	=	0x9B
ap	=	0x9C
_ap	=	0x9C
mcnt0	=	0xD1
mcnt1	=	0xD2
ma	=	0xD3
mb	=	0xD4
mc	=	0xD5
F1	=	0xD1	; user flag
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mullong_PARM_2
	.globl __mullong
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
	.area REG_BANK_3	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
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
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
__mullong_PARM_2:
	.ds 4
__mullong_a_1_1:
	.ds 4
__mullong_t_1_1:
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
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
;b                         Allocated with name '__mullong_PARM_2'
;a                         Allocated with name '__mullong_a_1_1'
;t                         Allocated with name '__mullong_t_1_1'
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
	mov     dps, #1
	mov     dptr, #__mullong_a_1_1
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	inc	dptr
	mov	a,b
	movx	@dptr,a
	mov	dps,#0
;	_mullong.c:707: t.i.hi = bcast(a)->b.b0 * bcast(b)->b.b2;           // A
	mov	dptr,#__mullong_a_1_1
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#(__mullong_PARM_2 + 0x000002)
	movx	a,@dptr
	mov	r3,a
	mov	b,r2
	mov	a,r3
	mul	ab
	mov	r4,a
	mov	r5,b
	mov	dptr,#(__mullong_t_1_1 + 0x000002)
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_mullong.c:708: t.i.lo = bcast(a)->b.b0 * bcast(b)->b.b0;           // A
	mov	dptr,#__mullong_PARM_2
	movx	a,@dptr
	mov	r4,a
	mov	b,r2
	mov	a,r4
	mul	ab
	mov	r5,a
	mov	r6,b
	mov	dptr,#__mullong_t_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_mullong.c:709: t.b.b3 += bcast(a)->b.b3 * bcast(b)->b.b0;          // G
	mov	dptr,#(__mullong_t_1_1 + 0x000003)
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#(__mullong_a_1_1 + 0x000003)
	movx	a,@dptr
	mov	r6,a
	mov	b,r6
	mov	a,r4
	mul	ab
	mov  r6,a
	add	a,r5
	mov  r5,a
	mov  dptr,#(__mullong_t_1_1 + 0x000003)
	movx @dptr,a
;	_mullong.c:710: t.b.b3 += bcast(a)->b.b2 * bcast(b)->b.b1;          // F
	mov	dptr,#(__mullong_t_1_1 + 0x000003)
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#(__mullong_a_1_1 + 0x000002)
	movx	a,@dptr
	mov	r6,a
	mov	dptr,#(__mullong_PARM_2 + 0x000001)
	movx	a,@dptr
	mov	r7,a
	mov	b,r6
	mov	a,r7
	mul	ab
	mov  r0,a
	add	a,r5
	mov  r5,a
	mov  dptr,#(__mullong_t_1_1 + 0x000003)
	movx @dptr,a
;	_mullong.c:711: t.i.hi += bcast(a)->b.b2 * bcast(b)->b.b0;          // E <- b lost in .lst
	mov	dptr,#(__mullong_t_1_1 + 0x000002)
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r0,a
	mov	b,r6
	mov	a,r4
	mul	ab
	mov	r6,a
	mov	r1,b
	add	a,r5
	mov	r5,a
	mov	a,r1
	addc	a,r0
	mov	r0,a
	mov	dptr,#(__mullong_t_1_1 + 0x000002)
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
;	_mullong.c:713: t.i.hi += bcast(a)->b.b1 * bcast(b)->b.b1;          // D <- b lost in .lst
	mov	dptr,#(__mullong_t_1_1 + 0x000002)
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	mov	dptr,#(__mullong_a_1_1 + 0x000001)
	movx	a,@dptr
	mov	r0,a
	mov	b,r0
	mov	a,r7
	mul	ab
	mov	r7,a
	mov	r1,b
	add	a,r5
	mov	r5,a
	mov	a,r1
	addc	a,r6
	mov	r6,a
	mov	dptr,#(__mullong_t_1_1 + 0x000002)
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_mullong.c:715: bcast(a)->bi.b3 = bcast(a)->b.b1 * bcast(b)->b.b2;  // C
	mov	b,r0
	mov	a,r3
	mul	ab
	mov  r3,a
	mov  dptr,#(__mullong_a_1_1 + 0x000003)
	movx @dptr,a
;	_mullong.c:716: bcast(a)->bi.i12 = bcast(a)->b.b1 * bcast(b)->b.b0; // C
	mov	dptr,#(__mullong_a_1_1 + 0x000001)
	movx	a,@dptr
	mov	r3,a
	mov	b,r3
	mov	a,r4
	mul	ab
	mov	r4,a
	mov	r5,b
	mov	dptr,#(__mullong_a_1_1 + 0x000001)
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_mullong.c:718: bcast(b)->bi.b3 = bcast(a)->b.b0 * bcast(b)->b.b3;  // B
	mov	dptr,#(__mullong_PARM_2 + 0x000003)
	movx	a,@dptr
	mov	r3,a
	mov	b,r2
	mov	a,r3
	mul	ab
	mov  r3,a
	mov  dptr,#(__mullong_PARM_2 + 0x000003)
	movx @dptr,a
;	_mullong.c:719: bcast(b)->bi.i12 = bcast(a)->b.b0 * bcast(b)->b.b1; // B
	mov	dptr,#(__mullong_PARM_2 + 0x000001)
	movx	a,@dptr
	mov	r3,a
	mov	b,r2
	mov	a,r3
	mul	ab
	mov	r2,a
	mov	r4,b
	mov	dptr,#(__mullong_PARM_2 + 0x000001)
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_mullong.c:721: bcast(b)->bi.b0 = 0;                                // B
	mov	dptr,#__mullong_PARM_2
;	_mullong.c:722: bcast(a)->bi.b0 = 0;                                // C
	clr   a
	movx  @dptr,a
	mov   dptr,#__mullong_a_1_1
	movx  @dptr,a
;	_mullong.c:723: t.l += a;
	mov	dptr,#__mullong_t_1_1
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#__mullong_a_1_1
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	a,r6
	add	a,r2
	mov	r2,a
	mov	a,r7
	addc	a,r3
	mov	r3,a
	mov	a,r0
	addc	a,r4
	mov	r4,a
	mov	a,r1
	addc	a,r5
	mov	r5,a
	mov	dptr,#__mullong_t_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	_mullong.c:725: return t.l + b;
	mov	dptr,#__mullong_t_1_1
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	mov	dptr,#__mullong_PARM_2
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	a,r6
	add	a,r2
	mov	r2,a
	mov	a,r7
	addc	a,r3
	mov	r3,a
	mov	a,r0
	addc	a,r4
	mov	r4,a
	mov	a,r1
	addc	a,r5
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00101$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
