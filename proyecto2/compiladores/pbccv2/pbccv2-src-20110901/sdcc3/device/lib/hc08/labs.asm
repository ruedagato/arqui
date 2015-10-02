;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module labs
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
	.globl _labs_PARM_1
	.globl _labs
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_labs_sloc0_1_0::
	.ds 4
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
_labs_PARM_1:
	.ds 4
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
;Allocation info for local variables in function 'labs'
;------------------------------------------------------------
;j                         Allocated with name '_labs_PARM_1'
;sloc0                     Allocated with name '_labs_sloc0_1_0'
;------------------------------------------------------------
;../labs.c:63: long int labs(long int j)
;	-----------------------------------------
;	 function labs
;	-----------------------------------------
_labs:
;../labs.c:65: return (j < 0) ? -j : j;
	lda	_labs_PARM_1
	sub	#0x00
	bge	00103$
00106$:
	clra
	sub	(_labs_PARM_1 + 3)
	sta	*(_labs_sloc0_1_0 + 3)
	clra
	sbc	(_labs_PARM_1 + 2)
	sta	*(_labs_sloc0_1_0 + 2)
	clra
	sbc	(_labs_PARM_1 + 1)
	sta	*(_labs_sloc0_1_0 + 1)
	clra
	sbc	_labs_PARM_1
	sta	*_labs_sloc0_1_0
	bra	00104$
00103$:
	lda	_labs_PARM_1
	sta	*_labs_sloc0_1_0
	lda	(_labs_PARM_1 + 1)
	sta	*(_labs_sloc0_1_0 + 1)
	lda	(_labs_PARM_1 + 2)
	sta	*(_labs_sloc0_1_0 + 2)
	lda	(_labs_PARM_1 + 3)
	sta	*(_labs_sloc0_1_0 + 3)
00104$:
	mov	*_labs_sloc0_1_0,*__ret3
	mov	*(_labs_sloc0_1_0 + 1),*__ret2
	ldx	*(_labs_sloc0_1_0 + 2)
	lda	*(_labs_sloc0_1_0 + 3)
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
