;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module _strlen
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
	.globl _strlen
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strlen_i_1_1::
	.ds 2
_strlen_sloc0_1_0::
	.ds 2
_strlen_sloc1_1_0::
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
_strlen_str_1_1:
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
;Allocation info for local variables in function 'strlen'
;------------------------------------------------------------
;str                       Allocated with name '_strlen_str_1_1'
;i                         Allocated with name '_strlen_i_1_1'
;sloc0                     Allocated with name '_strlen_sloc0_1_0'
;sloc1                     Allocated with name '_strlen_sloc1_1_0'
;------------------------------------------------------------
;../_strlen.c:35: size_t strlen ( const char * str )
;	-----------------------------------------
;	 function strlen
;	-----------------------------------------
_strlen:
	sta	(_strlen_str_1_1 + 1)
	stx	_strlen_str_1_1
;../_strlen.c:39: while (*str++)
	clr	*_strlen_i_1_1
	clr	*(_strlen_i_1_1 + 1)
	lda	_strlen_str_1_1
	sta	*_strlen_sloc0_1_0
	lda	(_strlen_str_1_1 + 1)
	sta	*(_strlen_sloc0_1_0 + 1)
00101$:
	ldhx	*_strlen_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_strlen_sloc1_1_0
	sthx	*_strlen_sloc0_1_0
	tst	*_strlen_sloc1_1_0
	beq	00103$
00109$:
;../_strlen.c:40: i++ ;
	ldhx	*_strlen_i_1_1
	aix	#1
	sthx	*_strlen_i_1_1
	bra	00101$
00103$:
;../_strlen.c:42: return i;
	ldx	*_strlen_i_1_1
	lda	*(_strlen_i_1_1 + 1)
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
