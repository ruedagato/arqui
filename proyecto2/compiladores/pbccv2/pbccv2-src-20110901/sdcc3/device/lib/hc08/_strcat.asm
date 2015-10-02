;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strcat
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
	.globl _strcat_PARM_2
	.globl _strcat
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strcat_sloc0_1_0::
	.ds 2
_strcat_sloc1_1_0::
	.ds 2
_strcat_sloc2_1_0::
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
_strcat_PARM_2:
	.ds 2
_strcat_dst_1_1:
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
;Allocation info for local variables in function 'strcat'
;------------------------------------------------------------
;src                       Allocated with name '_strcat_PARM_2'
;dst                       Allocated with name '_strcat_dst_1_1'
;cp                        Allocated to registers 
;sloc0                     Allocated with name '_strcat_sloc0_1_0'
;sloc1                     Allocated with name '_strcat_sloc1_1_0'
;sloc2                     Allocated with name '_strcat_sloc2_1_0'
;------------------------------------------------------------
;../_strcat.c:31: char * strcat (
;	-----------------------------------------
;	 function strcat
;	-----------------------------------------
_strcat:
	sta	(_strcat_dst_1_1 + 1)
	stx	_strcat_dst_1_1
;../_strcat.c:38: while( *cp )
	lda	_strcat_dst_1_1
	sta	*_strcat_sloc0_1_0
	lda	(_strcat_dst_1_1 + 1)
	sta	*(_strcat_sloc0_1_0 + 1)
00101$:
	ldhx	*_strcat_sloc0_1_0
	lda	,x
	beq	00111$
00115$:
;../_strcat.c:39: cp++;                   /* find end of dst */
	ldhx	*_strcat_sloc0_1_0
	aix	#1
	sthx	*_strcat_sloc0_1_0
	bra	00101$
;../_strcat.c:41: while( *cp++ = *src++ ) ;       /* Copy src to end of dst */
00111$:
	lda	_strcat_PARM_2
	sta	*_strcat_sloc1_1_0
	lda	(_strcat_PARM_2 + 1)
	sta	*(_strcat_sloc1_1_0 + 1)
00104$:
	ldhx	*_strcat_sloc1_1_0
	lda	,x
	aix	#1
	sta	*_strcat_sloc2_1_0
	sthx	*_strcat_sloc1_1_0
	ldhx	*_strcat_sloc0_1_0
	lda	*_strcat_sloc2_1_0
	sta	,x
	aix	#1
	sthx	*_strcat_sloc0_1_0
	tst	*_strcat_sloc2_1_0
	bne	00104$
00116$:
;../_strcat.c:43: return( dst );                  /* return dst */
	ldx	_strcat_dst_1_1
	lda	(_strcat_dst_1_1 + 1)
00107$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
