;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module fabsf
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fabsf
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area OSEG    (OVR)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'fabsf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;fl                        Allocated to stack - offset -4
;sloc0                     Allocated to stack - offset -6
;sloc1                     Allocated to stack - offset -8
;sloc2                     Allocated to stack - offset -12
;------------------------------------------------------------
;../fabsf.c:34: float fabsf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function fabsf
;	-----------------------------------------
_fabsf:
	ais	#-12
;../fabsf.c:38: fl.f = x;
	tsx
	aix	#8
	pshh
	pula
	sta	7,s
	stx	8,s
	lda	7,s
	ldx	8,s
	psha
	pulh
	lda	15,s
	sta	,x
	aix	#1
	lda	16,s
	sta	,x
	aix	#1
	lda	17,s
	sta	,x
	aix	#1
	lda	18,s
	sta	,x
;../fabsf.c:39: fl.l &= 0x7fffffff;
	tsx
	aix	#8
	pshh
	pula
	sta	7,s
	stx	8,s
	tsx
	aix	#8
	pshh
	pula
	sta	5,s
	stx	6,s
	lda	5,s
	ldx	6,s
	psha
	pulh
	lda	,x
	aix	#1
	sta	1,s
	lda	,x
	aix	#1
	sta	2,s
	lda	,x
	aix	#1
	sta	3,s
	lda	,x
	sta	4,s
	lda	1,s
	and	#0x7F
	sta	1,s
	lda	7,s
	ldx	8,s
	psha
	pulh
	lda	1,s
	sta	,x
	aix	#1
	lda	2,s
	sta	,x
	aix	#1
	lda	3,s
	sta	,x
	aix	#1
	lda	4,s
	sta	,x
;../fabsf.c:40: return fl.f;
	tsx
	aix	#8
	pshh
	pula
	sta	1,s
	stx	2,s
	lda	1,s
	ldx	2,s
	psha
	pulh
	lda	,x
	aix	#1
	sta	1,s
	lda	,x
	aix	#1
	sta	2,s
	lda	,x
	aix	#1
	sta	3,s
	lda	,x
	sta	4,s
	lda	1,s
	sta	*__ret3
	lda	2,s
	sta	*__ret2
	ldx	3,s
	lda	4,s
00101$:
	ais	#12
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
