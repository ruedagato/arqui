;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:26 2015
;--------------------------------------------------------
	.module _strcmp
	.optsdcc -mmcs51 --model-medium
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcmp_PARM_2
	.globl _strcmp
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
_strcmp_sloc0_1_0::
	.ds 3
_strcmp_sloc1_1_0::
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
_strcmp_PARM_2:
	.ds 3
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
;Allocation info for local variables in function 'strcmp'
;------------------------------------------------------------
;ret                       Allocated with name '_strcmp_sloc1_1_0'
;sloc0                     Allocated with name '_strcmp_sloc0_1_0'
;sloc1                     Allocated with name '_strcmp_sloc1_1_0'
;------------------------------------------------------------
;	_strcmp.c:34: int strcmp (
;	-----------------------------------------
;	 function strcmp
;	-----------------------------------------
_strcmp:
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
;	_strcmp.c:53: while( ! (ret = *(unsigned char *)asrc - *(unsigned char *)adst) && *adst)
	mov	_strcmp_sloc0_1_0,r2
	mov	(_strcmp_sloc0_1_0 + 1),r3
	mov	(_strcmp_sloc0_1_0 + 2),r4
	mov	r0,#_strcmp_PARM_2
	movx	a,@r0
	mov	r5,a
	inc	r0
	movx	a,@r0
	mov	r6,a
	inc	r0
	movx	a,@r0
	mov	r7,a
00102$:
	mov	dpl,_strcmp_sloc0_1_0
	mov	dph,(_strcmp_sloc0_1_0 + 1)
	mov	b,(_strcmp_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r2,a
	mov	r3,#0x00
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r4,a
	push	ar5
	push	ar6
	push	ar7
	mov	r5,#0x00
	mov	a,r2
	clr	c
	subb	a,r4
	mov	r2,a
	mov	a,r3
	subb	a,r5
	mov	r3,a
	mov	_strcmp_sloc1_1_0,r2
	mov	(_strcmp_sloc1_1_0 + 1),r3
	pop	ar7
	pop	ar6
	pop	ar5
	mov	a,r2
	orl	a,r3
	jnz	00104$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	jz	00104$
;	_strcmp.c:54: ++asrc, ++adst;
	inc	_strcmp_sloc0_1_0
	clr	a
	cjne	a,_strcmp_sloc0_1_0,00113$
	inc	(_strcmp_sloc0_1_0 + 1)
00113$:
	inc	r5
	cjne	r5,#0x00,00102$
	inc	r6
	sjmp	00102$
00104$:
;	_strcmp.c:56: return( ret );
	mov	dpl,_strcmp_sloc1_1_0
	mov	dph,(_strcmp_sloc1_1_0 + 1)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
