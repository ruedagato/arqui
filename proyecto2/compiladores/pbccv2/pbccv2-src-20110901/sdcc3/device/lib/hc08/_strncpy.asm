;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strncpy
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
	.globl _strncpy_PARM_3
	.globl _strncpy_PARM_2
	.globl _strncpy
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strncpy_sloc0_1_0::
	.ds 2
_strncpy_sloc1_1_0::
	.ds 2
_strncpy_sloc2_1_0::
	.ds 2
_strncpy_sloc3_1_0::
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
_strncpy_PARM_2:
	.ds 2
_strncpy_PARM_3:
	.ds 2
_strncpy_d_1_1:
	.ds 2
_strncpy_d1_1_1:
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
;Allocation info for local variables in function 'strncpy'
;------------------------------------------------------------
;s                         Allocated with name '_strncpy_PARM_2'
;n                         Allocated with name '_strncpy_PARM_3'
;d                         Allocated with name '_strncpy_d_1_1'
;d1                        Allocated with name '_strncpy_d1_1_1'
;sloc0                     Allocated with name '_strncpy_sloc0_1_0'
;sloc1                     Allocated with name '_strncpy_sloc1_1_0'
;sloc2                     Allocated with name '_strncpy_sloc2_1_0'
;sloc3                     Allocated with name '_strncpy_sloc3_1_0'
;------------------------------------------------------------
;../_strncpy.c:31: char *strncpy (
;	-----------------------------------------
;	 function strncpy
;	-----------------------------------------
_strncpy:
	sta	(_strncpy_d_1_1 + 1)
	stx	_strncpy_d_1_1
;../_strncpy.c:36: register char * d1 =  d;
	lda	_strncpy_d_1_1
	sta	_strncpy_d1_1_1
	lda	(_strncpy_d_1_1 + 1)
	sta	(_strncpy_d1_1_1 + 1)
;../_strncpy.c:38: while ( n && *s )
	lda	_strncpy_PARM_3
	sta	*_strncpy_sloc0_1_0
	lda	(_strncpy_PARM_3 + 1)
	sta	*(_strncpy_sloc0_1_0 + 1)
	lda	_strncpy_PARM_2
	sta	*_strncpy_sloc1_1_0
	lda	(_strncpy_PARM_2 + 1)
	sta	*(_strncpy_sloc1_1_0 + 1)
	lda	_strncpy_d_1_1
	sta	*_strncpy_sloc2_1_0
	lda	(_strncpy_d_1_1 + 1)
	sta	*(_strncpy_sloc2_1_0 + 1)
00102$:
	lda	*(_strncpy_sloc0_1_0 + 1)
	ora	*_strncpy_sloc0_1_0
	beq	00114$
00117$:
	ldhx	*_strncpy_sloc1_1_0
	lda	,x
	beq	00114$
00118$:
;../_strncpy.c:40: n-- ;
	lda	*(_strncpy_sloc0_1_0 + 1)
	sub	#0x01
	sta	*(_strncpy_sloc0_1_0 + 1)
	lda	*_strncpy_sloc0_1_0
	sbc	#0x00
	sta	*_strncpy_sloc0_1_0
;../_strncpy.c:41: *d++ = *s++ ;
	ldhx	*_strncpy_sloc1_1_0
	lda	,x
	aix	#1
	sta	*_strncpy_sloc3_1_0
	sthx	*_strncpy_sloc1_1_0
	ldhx	*_strncpy_sloc2_1_0
	lda	*_strncpy_sloc3_1_0
	sta	,x
	aix	#1
	sthx	*_strncpy_sloc2_1_0
	bra	00102$
;../_strncpy.c:43: while ( n-- )
00114$:
	mov	*_strncpy_sloc0_1_0,*_strncpy_sloc1_1_0
	mov	*(_strncpy_sloc0_1_0 + 1),*(_strncpy_sloc1_1_0 + 1)
00105$:
	mov	*_strncpy_sloc1_1_0,*_strncpy_sloc0_1_0
	mov	*(_strncpy_sloc1_1_0 + 1),*(_strncpy_sloc0_1_0 + 1)
	lda	*(_strncpy_sloc1_1_0 + 1)
	sub	#0x01
	sta	*(_strncpy_sloc1_1_0 + 1)
	lda	*_strncpy_sloc1_1_0
	sbc	#0x00
	sta	*_strncpy_sloc1_1_0
	lda	*(_strncpy_sloc0_1_0 + 1)
	ora	*_strncpy_sloc0_1_0
	beq	00107$
00119$:
;../_strncpy.c:45: *d++ = '\0' ;
	ldhx	*_strncpy_sloc2_1_0
	clra
	sta	,x
	aix	#1
	sthx	*_strncpy_sloc2_1_0
	bra	00105$
00107$:
;../_strncpy.c:47: return d1;
	ldx	_strncpy_d1_1_1
	lda	(_strncpy_d1_1_1 + 1)
00108$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
