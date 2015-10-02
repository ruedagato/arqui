;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:30 2015
;--------------------------------------------------------
	.module ldexpf
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ldexpf
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
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
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
;Allocation info for local variables in function 'ldexpf'
;------------------------------------------------------------
;pw2                       Allocated to stack - offset -4
;x                         Allocated to registers r2 r3 r4 r5 
;fl                        Allocated to stack - offset 1
;e                         Allocated to stack - offset 5
;sloc0                     Allocated to stack - offset 13
;sloc1                     Allocated to stack - offset 9
;sloc2                     Allocated to stack - offset 13
;------------------------------------------------------------
;	ldexpf.c:34: float ldexpf(const float x, const int pw2)
;	-----------------------------------------
;	 function ldexpf
;	-----------------------------------------
_ldexpf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bp
	mov	_bp,sp
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0x10
	mov	sp,a
;	ldexpf.c:39: fl.f = x;
	mov	a,_bp
	inc	a
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;	ldexpf.c:41: e=(fl.l >> 23) & 0x000000ff;
	mov	r0,_bp
	inc	r0
	mov	a,_bp
	add	a,#0x09
	mov	r1,a
	mov	a,@r0
	mov	@r1,a
	inc	r0
	mov	a,@r0
	inc	r1
	mov	@r1,a
	inc	r0
	mov	a,@r0
	inc	r1
	mov	@r1,a
	inc	r0
	mov	a,@r0
	inc	r1
	mov	@r1,a
	dec	r0
	dec	r0
	dec	r0
	mov	a,_bp
	add	a,#0x09
	mov	r1,a
	inc	r1
	inc	r1
	mov	ar6,@r1
	inc	r1
	mov	a,@r1
	mov	c,acc.7
	xch	a,r6
	rlc	a
	xch	a,r6
	rlc	a
	xch	a,r6
	anl	a,#0x01
	jnb	acc.0,00103$
	orl	a,#0xfe
00103$:
	rlc	a
	subb	a,acc
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	@r1,ar6
	inc	r1
	mov	@r1,#0x00
	inc	r1
	mov	@r1,#0x00
	inc	r1
	mov	@r1,#0x00
;	ldexpf.c:42: e+=pw2;
	mov	a,_bp
	add	a,#0xfc
	mov	r1,a
	mov	ar4,@r1
	inc	r1
	mov	ar5,@r1
	mov	a,@r1
	rlc	a
	subb	a,acc
	mov	r2,a
	mov	r3,a
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	a,r4
	add	a,@r1
	mov	@r1,a
	mov	a,r5
	inc	r1
	addc	a,@r1
	mov	@r1,a
	mov	a,r2
	inc	r1
	addc	a,@r1
	mov	@r1,a
	mov	a,r3
	inc	r1
	addc	a,@r1
	mov	@r1,a
;	ldexpf.c:43: fl.l= ((e & 0xff) << 23) | (fl.l & 0x807fffff);
	mov	a,_bp
	add	a,#0x05
	mov	r1,a
	mov	ar2,@r1
	clr	a
	mov	r3,a
	mov	a,_bp
	add	a,#0x0d
	mov	r1,a
	inc	r1
	inc	r1
	mov	@r1,ar2
	mov	a,r3
	anl	a,#0x01
	mov	c,acc.0
	xch	a,@r1
	rrc	a
	xch	a,@r1
	rrc	a
	xch	a,@r1
	inc	r1
	mov	@r1,a
	dec	r1
	dec	r1
	mov	@r1,#0x00
	dec	r1
	mov	@r1,#0x00
	mov	a,_bp
	add	a,#0x09
	mov	r1,a
	mov	ar6,@r1
	inc	r1
	mov	ar7,@r1
	mov	a,#0x7F
	inc	r1
	anl	a,@r1
	mov	r2,a
	mov	a,#0x80
	inc	r1
	anl	a,@r1
	mov	r3,a
	mov	a,_bp
	add	a,#0x0d
	mov	r1,a
	mov	a,@r1
	orl	ar6,a
	inc	r1
	mov	a,@r1
	orl	ar7,a
	inc	r1
	mov	a,@r1
	orl	ar2,a
	inc	r1
	mov	a,@r1
	orl	ar3,a
	mov	@r0,ar6
	inc	r0
	mov	@r0,ar7
	inc	r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;	ldexpf.c:45: return(fl.f);
	mov	r0,_bp
	inc	r0
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
