;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module _divslong
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divslong_PARM_2
	.globl __divslong
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
__divslong_sloc0_1_0:
	.ds 4
__divslong_sloc1_1_0:
	.ds 4
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
__divslong_PARM_2:
	.ds 4
__divslong_x_1_1:
	.ds 4
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
;Allocation info for local variables in function '_divslong'
;------------------------------------------------------------
;sloc0                     Allocated with name '__divslong_sloc0_1_0'
;sloc1                     Allocated with name '__divslong_sloc1_1_0'
;y                         Allocated with name '__divslong_PARM_2'
;x                         Allocated with name '__divslong_x_1_1'
;r                         Allocated with name '__divslong_r_1_1'
;------------------------------------------------------------
;	_divslong.c:259: _divslong (long x, long y)
;	-----------------------------------------
;	 function _divslong
;	-----------------------------------------
__divslong:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_divslong.c:263: r = _divulong((x < 0 ? -x : x),
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#__divslong_x_1_1
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
	rlc	a
	clr	a
	rlc	a
	mov	r6,a
	jz	00106$
	clr	c
	clr	a
	subb	a,r2
	mov	__divslong_sloc0_1_0,a
	clr	a
	subb	a,r3
	mov	(__divslong_sloc0_1_0 + 1),a
	clr	a
	subb	a,r4
	mov	(__divslong_sloc0_1_0 + 2),a
	clr	a
	subb	a,r5
	mov	(__divslong_sloc0_1_0 + 3),a
	sjmp	00107$
00106$:
	mov	__divslong_sloc0_1_0,r2
	mov	(__divslong_sloc0_1_0 + 1),r3
	mov	(__divslong_sloc0_1_0 + 2),r4
	mov	(__divslong_sloc0_1_0 + 3),r5
00107$:
	mov	r2,__divslong_sloc0_1_0
	mov	r3,(__divslong_sloc0_1_0 + 1)
	mov	r4,(__divslong_sloc0_1_0 + 2)
	mov	r5,(__divslong_sloc0_1_0 + 3)
;	_divslong.c:264: (y < 0 ? -y : y));
	mov	dptr,#__divslong_PARM_2
	movx	a,@dptr
	mov	__divslong_sloc0_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(__divslong_sloc0_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(__divslong_sloc0_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(__divslong_sloc0_1_0 + 3),a
	rlc	a
	clr	a
	rlc	a
	mov	r7,a
	jz	00108$
	clr	c
	clr	a
	subb	a,__divslong_sloc0_1_0
	mov	__divslong_sloc1_1_0,a
	clr	a
	subb	a,(__divslong_sloc0_1_0 + 1)
	mov	(__divslong_sloc1_1_0 + 1),a
	clr	a
	subb	a,(__divslong_sloc0_1_0 + 2)
	mov	(__divslong_sloc1_1_0 + 2),a
	clr	a
	subb	a,(__divslong_sloc0_1_0 + 3)
	mov	(__divslong_sloc1_1_0 + 3),a
	sjmp	00109$
00108$:
	mov	__divslong_sloc1_1_0,__divslong_sloc0_1_0
	mov	(__divslong_sloc1_1_0 + 1),(__divslong_sloc0_1_0 + 1)
	mov	(__divslong_sloc1_1_0 + 2),(__divslong_sloc0_1_0 + 2)
	mov	(__divslong_sloc1_1_0 + 3),(__divslong_sloc0_1_0 + 3)
00109$:
	mov	dptr,#__divulong_PARM_2
	mov	a,__divslong_sloc1_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(__divslong_sloc1_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(__divslong_sloc1_1_0 + 2)
	movx	@dptr,a
	inc	dptr
	mov	a,(__divslong_sloc1_1_0 + 3)
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	push	ar6
	push	ar7
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	pop	ar7
	pop	ar6
;	_divslong.c:265: if ( (x < 0) ^ (y < 0))
	mov	a,r7
	xrl	a,r6
	jz	00102$
;	_divslong.c:266: return -r;
	clr	c
	clr	a
	subb	a,r2
	mov	r6,a
	clr	a
	subb	a,r3
	mov	r7,a
	clr	a
	subb	a,r4
	mov	r0,a
	clr	a
	subb	a,r5
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	ret
00102$:
;	_divslong.c:268: return r;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
