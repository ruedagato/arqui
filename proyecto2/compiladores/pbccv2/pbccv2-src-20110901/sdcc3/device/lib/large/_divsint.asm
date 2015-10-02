;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module _divsint
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divsint_PARM_2
	.globl __divsint
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
__divsint_PARM_2:
	.ds 2
__divsint_x_1_1:
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
;Allocation info for local variables in function '_divsint'
;------------------------------------------------------------
;r                         Allocated to registers r2 r3 
;y                         Allocated with name '__divsint_PARM_2'
;x                         Allocated with name '__divsint_x_1_1'
;------------------------------------------------------------
;	_divsint.c:207: _divsint (int x, int y)
;	-----------------------------------------
;	 function _divsint
;	-----------------------------------------
__divsint:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_divsint.c:211: r = _divuint((x < 0 ? -x : x),
	mov	r2,dph
	mov	a,dpl
	mov	dptr,#__divsint_x_1_1
	movx	@dptr,a
	inc	dptr
	xch	a,r2
	movx	@dptr,a
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
;	_divsint.c:212: (y < 0 ? -y : y));
	mov	dptr,#__divsint_PARM_2
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	rlc	a
	clr	a
	rlc	a
	mov	r7,a
	jz	00108$
	clr	c
	clr	a
	subb	a,r5
	mov	r0,a
	clr	a
	subb	a,r6
	mov	r1,a
	sjmp	00109$
00108$:
	mov	ar0,r5
	mov	ar1,r6
00109$:
	mov	dptr,#__divuint_PARM_2
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	push	ar4
	push	ar7
	lcall	__divuint
	mov	r2,dpl
	mov	r3,dph
	pop	ar7
	pop	ar4
;	_divsint.c:213: if ( (x < 0) ^ (y < 0))
	mov	a,r7
	xrl	a,r4
	jz	00102$
;	_divsint.c:214: return -r;
	clr	c
	clr	a
	subb	a,r2
	mov	r4,a
	clr	a
	subb	a,r3
	mov	r5,a
	mov	dpl,r4
	mov	dph,r5
	ret
00102$:
;	_divsint.c:216: return r;
	mov	dpl,r2
	mov	dph,r3
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
