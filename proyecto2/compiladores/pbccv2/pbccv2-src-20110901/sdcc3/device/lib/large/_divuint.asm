;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module _divuint
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divuint_PARM_2
	.globl __divuint
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
__divuint_c_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
__divuint_PARM_2:
	.ds 2
__divuint_x_1_1:
	.ds 2
__divuint_reste_1_1:
	.ds 2
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
;Allocation info for local variables in function '_divuint'
;------------------------------------------------------------
;y                         Allocated with name '__divuint_PARM_2'
;x                         Allocated with name '__divuint_x_1_1'
;reste                     Allocated with name '__divuint_reste_1_1'
;count                     Allocated with name '__divuint_count_1_1'
;------------------------------------------------------------
;	_divuint.c:155: _divuint (unsigned int x, unsigned int y)
;	-----------------------------------------
;	 function _divuint
;	-----------------------------------------
__divuint:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dph
	mov	a,dpl
	mov	dptr,#__divuint_x_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_divuint.c:157: unsigned int reste = 0;
	mov	dptr,#__divuint_reste_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_divuint.c:161: do
	mov	dptr,#__divuint_PARM_2
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	r4,#0x10
00105$:
;	_divuint.c:164: c = MSB_SET(x);
	mov	dptr,#__divuint_x_1_1
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	rlc	a
	mov	__divuint_c_1_1,c
;	_divuint.c:165: x <<= 1;
	mov	a,r6
	xch	a,r5
	add	a,acc
	xch	a,r5
	rlc	a
	mov	r6,a
	mov	dptr,#__divuint_x_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_divuint.c:166: reste <<= 1;
	mov	dptr,#__divuint_reste_1_1
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	xch	a,r5
	add	a,acc
	xch	a,r5
	rlc	a
	mov	r6,a
	mov	dptr,#__divuint_reste_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_divuint.c:167: if (c)
	jnb	__divuint_c_1_1,00102$
;	_divuint.c:168: reste |= 1;
	mov	dptr,#__divuint_reste_1_1
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	dptr,#__divuint_reste_1_1
	mov	a,#0x01
	orl	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
00102$:
;	_divuint.c:170: if (reste >= y)
	mov	dptr,#__divuint_reste_1_1
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	clr	c
	mov	a,r5
	subb	a,r2
	mov	a,r6
	subb	a,r3
	jc	00106$
;	_divuint.c:172: reste -= y;
	mov	dptr,#__divuint_reste_1_1
	mov	a,r5
	clr	c
	subb	a,r2
	movx	@dptr,a
	mov	a,r6
	subb	a,r3
	inc	dptr
	movx	@dptr,a
;	_divuint.c:174: x |= 1;
	mov	dptr,#__divuint_x_1_1
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	dptr,#__divuint_x_1_1
	mov	a,#0x01
	orl	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
00106$:
;	_divuint.c:177: while (--count);
	djnz	r4,00105$
;	_divuint.c:178: return x;
	mov	dptr,#__divuint_x_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	dpl,r2
	mov	dph,a
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
