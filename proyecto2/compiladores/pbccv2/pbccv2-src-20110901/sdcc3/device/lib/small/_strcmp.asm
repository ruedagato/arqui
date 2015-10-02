;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _strcmp
	.optsdcc -mmcs51 --model-small
	
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
_strcmp_PARM_2::
	.ds 3
_strcmp_sloc0_1_0::
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
;adst                      Allocated with name '_strcmp_PARM_2'
;asrc                      Allocated to registers r2 r3 r4 
;ret                       Allocated with name '_strcmp_sloc0_1_0'
;sloc0                     Allocated with name '_strcmp_sloc0_1_0'
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
	mov	r5,_strcmp_PARM_2
	mov	r6,(_strcmp_PARM_2 + 1)
	mov	r7,(_strcmp_PARM_2 + 2)
00102$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r0,a
	mov	r1,#0x00
	push	ar2
	push	ar3
	push	ar4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r2,a
	mov	r3,#0x00
	mov	a,r0
	clr	c
	subb	a,r2
	mov	r0,a
	mov	a,r1
	subb	a,r3
	mov	r1,a
	mov	_strcmp_sloc0_1_0,r0
	mov	(_strcmp_sloc0_1_0 + 1),r1
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r0
	orl	a,r1
	jnz	00104$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	jz	00104$
;	_strcmp.c:54: ++asrc, ++adst;
	inc	r2
	cjne	r2,#0x00,00113$
	inc	r3
00113$:
	inc	r5
	cjne	r5,#0x00,00102$
	inc	r6
	sjmp	00102$
00104$:
;	_strcmp.c:56: return( ret );
	mov	dpl,_strcmp_sloc0_1_0
	mov	dph,(_strcmp_sloc0_1_0 + 1)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
