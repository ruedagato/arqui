;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module abs
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
	.globl _abs
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_abs_sloc0_1_0::
	.ds 2
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
_abs_j_1_1:
	.ds 2
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
;Allocation info for local variables in function 'abs'
;------------------------------------------------------------
;j                         Allocated with name '_abs_j_1_1'
;sloc0                     Allocated with name '_abs_sloc0_1_0'
;------------------------------------------------------------
;../abs.c:58: int abs(int j)
;	-----------------------------------------
;	 function abs
;	-----------------------------------------
_abs:
	sta	(_abs_j_1_1 + 1)
	stx	_abs_j_1_1
;../abs.c:60: return (j < 0) ? -j : j;
	lda	_abs_j_1_1
	sub	#0x00
	bge	00103$
00106$:
	clra
	sub	(_abs_j_1_1 + 1)
	sta	*(_abs_sloc0_1_0 + 1)
	clra
	sbc	_abs_j_1_1
	sta	*_abs_sloc0_1_0
	bra	00104$
00103$:
	lda	_abs_j_1_1
	sta	*_abs_sloc0_1_0
	lda	(_abs_j_1_1 + 1)
	sta	*(_abs_sloc0_1_0 + 1)
00104$:
	ldx	*_abs_sloc0_1_0
	lda	*(_abs_sloc0_1_0 + 1)
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
