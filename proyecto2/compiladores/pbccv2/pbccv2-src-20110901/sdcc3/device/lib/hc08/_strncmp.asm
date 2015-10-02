;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strncmp
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
	.globl _strncmp_PARM_3
	.globl _strncmp_PARM_2
	.globl _strncmp
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strncmp_sloc0_1_0::
	.ds 2
_strncmp_sloc1_1_0::
	.ds 2
_strncmp_sloc2_1_0::
	.ds 2
_strncmp_sloc3_1_0::
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
_strncmp_PARM_2:
	.ds 2
_strncmp_PARM_3:
	.ds 2
_strncmp_first_1_1:
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
;Allocation info for local variables in function 'strncmp'
;------------------------------------------------------------
;last                      Allocated with name '_strncmp_PARM_2'
;count                     Allocated with name '_strncmp_PARM_3'
;first                     Allocated with name '_strncmp_first_1_1'
;sloc0                     Allocated with name '_strncmp_sloc0_1_0'
;sloc1                     Allocated with name '_strncmp_sloc1_1_0'
;sloc2                     Allocated with name '_strncmp_sloc2_1_0'
;sloc3                     Allocated with name '_strncmp_sloc3_1_0'
;------------------------------------------------------------
;../_strncmp.c:31: int strncmp (
;	-----------------------------------------
;	 function strncmp
;	-----------------------------------------
_strncmp:
	sta	(_strncmp_first_1_1 + 1)
	stx	_strncmp_first_1_1
;../_strncmp.c:37: if (!count)
	lda	(_strncmp_PARM_3 + 1)
	ora	_strncmp_PARM_3
	bne	00114$
00116$:
;../_strncmp.c:38: return(0);
	clrx
	clra
	rts
;../_strncmp.c:40: while (--count && *first && *first == *last) {
00114$:
	lda	_strncmp_first_1_1
	sta	*_strncmp_sloc0_1_0
	lda	(_strncmp_first_1_1 + 1)
	sta	*(_strncmp_sloc0_1_0 + 1)
	lda	_strncmp_PARM_2
	sta	*_strncmp_sloc1_1_0
	lda	(_strncmp_PARM_2 + 1)
	sta	*(_strncmp_sloc1_1_0 + 1)
	lda	_strncmp_PARM_3
	sta	*_strncmp_sloc2_1_0
	lda	(_strncmp_PARM_3 + 1)
	sta	*(_strncmp_sloc2_1_0 + 1)
00105$:
	lda	*(_strncmp_sloc2_1_0 + 1)
	sub	#0x01
	sta	*(_strncmp_sloc2_1_0 + 1)
	lda	*_strncmp_sloc2_1_0
	sbc	#0x00
	sta	*_strncmp_sloc2_1_0
	lda	*(_strncmp_sloc2_1_0 + 1)
	ora	*_strncmp_sloc2_1_0
	beq	00107$
00117$:
	ldhx	*_strncmp_sloc0_1_0
	lda	,x
	beq	00107$
00118$:
	ldhx	*_strncmp_sloc0_1_0
	lda	,x
	sta	*_strncmp_sloc3_1_0
	ldhx	*_strncmp_sloc1_1_0
	lda	,x
	cmp	*_strncmp_sloc3_1_0
	bne	00107$
00119$:
;../_strncmp.c:41: first++;
	ldhx	*_strncmp_sloc0_1_0
	aix	#1
	sthx	*_strncmp_sloc0_1_0
;../_strncmp.c:42: last++;
	ldhx	*_strncmp_sloc1_1_0
	aix	#1
	sthx	*_strncmp_sloc1_1_0
	bra	00105$
00107$:
;../_strncmp.c:45: return( *first - *last );
	ldhx	*_strncmp_sloc0_1_0
	lda	,x
	sta	*(_strncmp_sloc2_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_strncmp_sloc2_1_0
	ldhx	*_strncmp_sloc1_1_0
	lda	,x
	sta	*(_strncmp_sloc1_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_strncmp_sloc1_1_0
	lda	*(_strncmp_sloc2_1_0 + 1)
	sub	*(_strncmp_sloc1_1_0 + 1)
	sta	*(_strncmp_sloc2_1_0 + 1)
	lda	*_strncmp_sloc2_1_0
	sbc	*_strncmp_sloc1_1_0
	sta	*_strncmp_sloc2_1_0
	ldx	*_strncmp_sloc2_1_0
	lda	*(_strncmp_sloc2_1_0 + 1)
00108$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
