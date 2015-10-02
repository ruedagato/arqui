;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strchr
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
	.globl _strchr_PARM_2
	.globl _strchr
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strchr_sloc0_1_0::
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
_strchr_PARM_2:
	.ds 1
_strchr_string_1_1:
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
;Allocation info for local variables in function 'strchr'
;------------------------------------------------------------
;ch                        Allocated with name '_strchr_PARM_2'
;string                    Allocated with name '_strchr_string_1_1'
;sloc0                     Allocated with name '_strchr_sloc0_1_0'
;------------------------------------------------------------
;../_strchr.c:31: char * strchr (
;	-----------------------------------------
;	 function strchr
;	-----------------------------------------
_strchr:
	sta	(_strchr_string_1_1 + 1)
	stx	_strchr_string_1_1
;../_strchr.c:36: while (*string && *string != ch)
	lda	_strchr_string_1_1
	sta	*_strchr_sloc0_1_0
	lda	(_strchr_string_1_1 + 1)
	sta	*(_strchr_sloc0_1_0 + 1)
00102$:
	ldhx	*_strchr_sloc0_1_0
	lda	,x
	beq	00104$
00114$:
	ldhx	*_strchr_sloc0_1_0
	lda	,x
	cmp	_strchr_PARM_2
	beq	00104$
00115$:
;../_strchr.c:37: string++;
	ldhx	*_strchr_sloc0_1_0
	aix	#1
	sthx	*_strchr_sloc0_1_0
	bra	00102$
00104$:
;../_strchr.c:39: if (*string == ch)
	ldhx	*_strchr_sloc0_1_0
	lda	,x
	cmp	_strchr_PARM_2
	bne	00106$
00116$:
;../_strchr.c:40: return(string);
	ldx	*_strchr_sloc0_1_0
	lda	*(_strchr_sloc0_1_0 + 1)
	rts
00106$:
;../_strchr.c:41: return ( NULL );
	clrx
	clra
00107$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
