;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strcpy
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
	.globl _strcpy_PARM_2
	.globl _strcpy
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strcpy_sloc0_1_0::
	.ds 2
_strcpy_sloc1_1_0::
	.ds 2
_strcpy_sloc2_1_0::
	.ds 1
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
_strcpy_PARM_2:
	.ds 2
_strcpy_d_1_1:
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
;Allocation info for local variables in function 'strcpy'
;------------------------------------------------------------
;s                         Allocated with name '_strcpy_PARM_2'
;d                         Allocated with name '_strcpy_d_1_1'
;d1                        Allocated to registers 
;sloc0                     Allocated with name '_strcpy_sloc0_1_0'
;sloc1                     Allocated with name '_strcpy_sloc1_1_0'
;sloc2                     Allocated with name '_strcpy_sloc2_1_0'
;------------------------------------------------------------
;../_strcpy.c:34: char * strcpy (
;	-----------------------------------------
;	 function strcpy
;	-----------------------------------------
_strcpy:
	sta	(_strcpy_d_1_1 + 1)
	stx	_strcpy_d_1_1
;../_strcpy.c:48: while (*d1++ = *s++) ;
	lda	_strcpy_PARM_2
	sta	*_strcpy_sloc0_1_0
	lda	(_strcpy_PARM_2 + 1)
	sta	*(_strcpy_sloc0_1_0 + 1)
	lda	_strcpy_d_1_1
	sta	*_strcpy_sloc1_1_0
	lda	(_strcpy_d_1_1 + 1)
	sta	*(_strcpy_sloc1_1_0 + 1)
00101$:
	ldhx	*_strcpy_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_strcpy_sloc2_1_0
	sthx	*_strcpy_sloc0_1_0
	ldhx	*_strcpy_sloc1_1_0
	lda	*_strcpy_sloc2_1_0
	sta	,x
	aix	#1
	sthx	*_strcpy_sloc1_1_0
	tst	*_strcpy_sloc2_1_0
	bne	00101$
00109$:
;../_strcpy.c:50: return d;
	ldx	_strcpy_d_1_1
	lda	(_strcpy_d_1_1 + 1)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
