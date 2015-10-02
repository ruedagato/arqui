;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _memcmp
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
	.globl _memcmp_PARM_3
	.globl _memcmp_PARM_2
	.globl _memcmp
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_memcmp_sloc0_1_0::
	.ds 2
_memcmp_sloc1_1_0::
	.ds 2
_memcmp_sloc2_1_0::
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
_memcmp_PARM_2:
	.ds 2
_memcmp_PARM_3:
	.ds 2
_memcmp_buf1_1_1:
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
;Allocation info for local variables in function 'memcmp'
;------------------------------------------------------------
;buf2                      Allocated with name '_memcmp_PARM_2'
;count                     Allocated with name '_memcmp_PARM_3'
;buf1                      Allocated with name '_memcmp_buf1_1_1'
;sloc0                     Allocated with name '_memcmp_sloc0_1_0'
;sloc1                     Allocated with name '_memcmp_sloc1_1_0'
;sloc2                     Allocated with name '_memcmp_sloc2_1_0'
;------------------------------------------------------------
;../_memcmp.c:31: int memcmp (
;	-----------------------------------------
;	 function memcmp
;	-----------------------------------------
_memcmp:
	sta	(_memcmp_buf1_1_1 + 1)
	stx	_memcmp_buf1_1_1
;../_memcmp.c:37: if (!count)
	lda	(_memcmp_PARM_3 + 1)
	ora	_memcmp_PARM_3
	bne	00112$
00114$:
;../_memcmp.c:38: return(0);
	clrx
	clra
	rts
;../_memcmp.c:40: while ( --count && *((char *)buf1) == *((char *)buf2) ) {
00112$:
	lda	_memcmp_buf1_1_1
	sta	*_memcmp_sloc0_1_0
	lda	(_memcmp_buf1_1_1 + 1)
	sta	*(_memcmp_sloc0_1_0 + 1)
	lda	_memcmp_PARM_3
	sta	*_memcmp_sloc1_1_0
	lda	(_memcmp_PARM_3 + 1)
	sta	*(_memcmp_sloc1_1_0 + 1)
00104$:
	lda	*(_memcmp_sloc1_1_0 + 1)
	sub	#0x01
	sta	*(_memcmp_sloc1_1_0 + 1)
	lda	*_memcmp_sloc1_1_0
	sbc	#0x00
	sta	*_memcmp_sloc1_1_0
	lda	*(_memcmp_sloc1_1_0 + 1)
	ora	*_memcmp_sloc1_1_0
	beq	00106$
00115$:
	ldhx	*_memcmp_sloc0_1_0
	lda	,x
	sta	*_memcmp_sloc2_1_0
	lda	_memcmp_PARM_2
	ldx	(_memcmp_PARM_2 + 1)
	psha
	pulh
	lda	,x
	cmp	*_memcmp_sloc2_1_0
	bne	00106$
00116$:
;../_memcmp.c:41: buf1 = (char *)buf1 + 1;
	ldhx	*_memcmp_sloc0_1_0
	aix	#1
	sthx	*_memcmp_sloc0_1_0
;../_memcmp.c:42: buf2 = (char *)buf2 + 1;
	lda	(_memcmp_PARM_2 + 1)
	inca
	sta	(_memcmp_PARM_2 + 1)
	bne	00117$
	lda	_memcmp_PARM_2
	inca
	sta	_memcmp_PARM_2
00117$:
	bra	00104$
00106$:
;../_memcmp.c:45: return( *((unsigned char *)buf1) - *((unsigned char *)buf2) );
	ldhx	*_memcmp_sloc0_1_0
	lda	,x
	sta	*(_memcmp_sloc1_1_0 + 1)
	clr	*_memcmp_sloc1_1_0
	lda	_memcmp_PARM_2
	ldx	(_memcmp_PARM_2 + 1)
	psha
	pulh
	lda	,x
	sta	*(_memcmp_sloc0_1_0 + 1)
	clr	*_memcmp_sloc0_1_0
	lda	*(_memcmp_sloc1_1_0 + 1)
	sub	*(_memcmp_sloc0_1_0 + 1)
	sta	*(_memcmp_sloc1_1_0 + 1)
	lda	*_memcmp_sloc1_1_0
	sbc	*_memcmp_sloc0_1_0
	sta	*_memcmp_sloc1_1_0
	ldx	*_memcmp_sloc1_1_0
	lda	*(_memcmp_sloc1_1_0 + 1)
00107$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
