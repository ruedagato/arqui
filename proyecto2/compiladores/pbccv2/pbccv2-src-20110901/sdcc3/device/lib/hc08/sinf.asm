;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module sinf
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
	.globl _sinf
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
;Allocation info for local variables in function 'sinf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;sloc0                     Allocated to stack - offset -4
;------------------------------------------------------------
;../sinf.c:36: float sinf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function sinf
;	-----------------------------------------
_sinf:
	ais	#-4
;../sinf.c:38: if (x==0.0) return 0.0;
	lda	10,s
	ora	9,s
	ora	8,s
	ora	7,s
	bne	00102$
00106$:
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	bra	00103$
00102$:
;../sinf.c:39: return sincosf(x, 0);
	lda	7,s
	sta	_sincosf_PARM_1
	lda	8,s
	sta	(_sincosf_PARM_1 + 1)
	lda	9,s
	sta	(_sincosf_PARM_1 + 2)
	lda	10,s
	sta	(_sincosf_PARM_1 + 3)
	clra
	sta	_sincosf_PARM_2
	jsr	_sincosf
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	*__ret3
	lda	2,s
	sta	*__ret2
	ldx	3,s
	lda	4,s
00103$:
	ais	#4
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
