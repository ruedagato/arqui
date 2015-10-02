;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:25 2015
;--------------------------------------------------------
	.module _modsint
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modsint_PARM_2
	.globl __modsint
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
__modsint_PARM_2:
	.ds 2
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
;Allocation info for local variables in function '_modsint'
;------------------------------------------------------------
;r                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	_modsint.c:203: int _modsint (int a, int b)
;	-----------------------------------------
;	 function _modsint
;	-----------------------------------------
__modsint:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
;	_modsint.c:207: r = _moduint((a < 0 ? -a : a),
	mov	a,dph
	mov	r3,a
	rlc	a
	clr	a
	rlc	a
	mov	r4,a
	jz	00106$
	clr	c
	clr	a
	subb	a,r2
	mov	r5,a
	clr	a
	subb	a,r3
	mov	r6,a
	sjmp	00107$
00106$:
	mov	ar5,r2
	mov	ar6,r3
00107$:
	mov	ar2,r5
	mov	ar3,r6
;	_modsint.c:208: (b < 0 ? -b : b));
	mov	r0,#(__modsint_PARM_2 + 1)
	movx	a,@r0
	jnb	acc.7,00108$
	mov	r0,#__modsint_PARM_2
	movx	a,@r0
	setb	c
	cpl	a
	addc	a,#0x00
	mov	r5,a
	inc	r0
	movx	a,@r0
	cpl	a
	addc	a,#0x00
	mov	r6,a
	sjmp	00109$
00108$:
	mov	r0,#__modsint_PARM_2
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
00109$:
	mov	r0,#__moduint_PARM_2
	mov	a,r5
	movx	@r0,a
	inc	r0
	mov	a,r6
	movx	@r0,a
	mov	dpl,r2
	mov	dph,r3
	push	ar4
	lcall	__moduint
	mov	r2,dpl
	mov	r3,dph
	pop	ar4
;	_modsint.c:210: if (a < 0)
	mov	a,r4
	jz	00102$
;	_modsint.c:211: return -r;
	clr	c
	clr	a
	subb	a,r2
	mov	dpl,a
	clr	a
	subb	a,r3
	mov	dph,a
	ret
00102$:
;	_modsint.c:213: return r;
	mov	dpl,r2
	mov	dph,r3
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
