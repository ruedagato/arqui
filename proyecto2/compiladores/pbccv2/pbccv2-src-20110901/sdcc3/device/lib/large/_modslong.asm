;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:28 2015
;--------------------------------------------------------
	.module _modslong
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modslong_PARM_2
	.globl __modslong
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
__modslong_sloc0_1_0:
	.ds 4
__modslong_sloc1_1_0:
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
__modslong_PARM_2:
	.ds 4
__modslong_a_1_1:
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
;Allocation info for local variables in function '_modslong'
;------------------------------------------------------------
;sloc0                     Allocated with name '__modslong_sloc0_1_0'
;sloc1                     Allocated with name '__modslong_sloc1_1_0'
;b                         Allocated with name '__modslong_PARM_2'
;a                         Allocated with name '__modslong_a_1_1'
;r                         Allocated with name '__modslong_r_1_1'
;------------------------------------------------------------
;	_modslong.c:259: _modslong (long a, long b)
;	-----------------------------------------
;	 function _modslong
;	-----------------------------------------
__modslong:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_modslong.c:263: r = _modulong((a < 0 ? -a : a),
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	dptr,#__modslong_a_1_1
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
	mov	__modslong_sloc0_1_0,a
	clr	a
	subb	a,r3
	mov	(__modslong_sloc0_1_0 + 1),a
	clr	a
	subb	a,r4
	mov	(__modslong_sloc0_1_0 + 2),a
	clr	a
	subb	a,r5
	mov	(__modslong_sloc0_1_0 + 3),a
	sjmp	00107$
00106$:
	mov	__modslong_sloc0_1_0,r2
	mov	(__modslong_sloc0_1_0 + 1),r3
	mov	(__modslong_sloc0_1_0 + 2),r4
	mov	(__modslong_sloc0_1_0 + 3),r5
00107$:
	mov	r2,__modslong_sloc0_1_0
	mov	r3,(__modslong_sloc0_1_0 + 1)
	mov	r4,(__modslong_sloc0_1_0 + 2)
	mov	r5,(__modslong_sloc0_1_0 + 3)
;	_modslong.c:264: (b < 0 ? -b : b));
	mov	dptr,#__modslong_PARM_2
	movx	a,@dptr
	mov	__modslong_sloc0_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(__modslong_sloc0_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(__modslong_sloc0_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(__modslong_sloc0_1_0 + 3),a
	jnb	acc.7,00108$
	clr	c
	clr	a
	subb	a,__modslong_sloc0_1_0
	mov	__modslong_sloc1_1_0,a
	clr	a
	subb	a,(__modslong_sloc0_1_0 + 1)
	mov	(__modslong_sloc1_1_0 + 1),a
	clr	a
	subb	a,(__modslong_sloc0_1_0 + 2)
	mov	(__modslong_sloc1_1_0 + 2),a
	clr	a
	subb	a,(__modslong_sloc0_1_0 + 3)
	mov	(__modslong_sloc1_1_0 + 3),a
	sjmp	00109$
00108$:
	mov	__modslong_sloc1_1_0,__modslong_sloc0_1_0
	mov	(__modslong_sloc1_1_0 + 1),(__modslong_sloc0_1_0 + 1)
	mov	(__modslong_sloc1_1_0 + 2),(__modslong_sloc0_1_0 + 2)
	mov	(__modslong_sloc1_1_0 + 3),(__modslong_sloc0_1_0 + 3)
00109$:
	mov	dptr,#__modulong_PARM_2
	mov	a,__modslong_sloc1_1_0
	movx	@dptr,a
	inc	dptr
	mov	a,(__modslong_sloc1_1_0 + 1)
	movx	@dptr,a
	inc	dptr
	mov	a,(__modslong_sloc1_1_0 + 2)
	movx	@dptr,a
	inc	dptr
	mov	a,(__modslong_sloc1_1_0 + 3)
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	push	ar6
	lcall	__modulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	pop	ar6
;	_modslong.c:265: if (a < 0)
	mov	a,r6
	jz	00102$
;	_modslong.c:266: return -r;
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
;	_modslong.c:268: return r;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
