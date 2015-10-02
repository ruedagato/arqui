;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _calloc
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
	.globl _calloc_PARM_2
	.globl _calloc
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
_calloc_PARM_2:
	.ds 2
_calloc_nmemb_1_1:
	.ds 2
_calloc_ptr_1_1:
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
;Allocation info for local variables in function 'calloc'
;------------------------------------------------------------
;size                      Allocated with name '_calloc_PARM_2'
;nmemb                     Allocated with name '_calloc_nmemb_1_1'
;ptr                       Allocated with name '_calloc_ptr_1_1'
;------------------------------------------------------------
;../_calloc.c:70: void __xdata * calloc (size_t nmemb, size_t size)
;	-----------------------------------------
;	 function calloc
;	-----------------------------------------
_calloc:
	sta	(_calloc_nmemb_1_1 + 1)
	stx	_calloc_nmemb_1_1
;../_calloc.c:74: ptr = malloc(nmemb * size);
	lda	_calloc_PARM_2
	sta	__mulint_PARM_2
	lda	(_calloc_PARM_2 + 1)
	sta	(__mulint_PARM_2 + 1)
	ldx	_calloc_nmemb_1_1
	lda	(_calloc_nmemb_1_1 + 1)
	jsr	__mulint
	jsr	_malloc
	sta	(_calloc_ptr_1_1 + 1)
	stx	_calloc_ptr_1_1
;../_calloc.c:75: if (ptr)
	lda	(_calloc_ptr_1_1 + 1)
	ora	_calloc_ptr_1_1
	beq	00102$
00106$:
;../_calloc.c:77: memset(ptr, 0, nmemb * size);
	lda	_calloc_PARM_2
	sta	__mulint_PARM_2
	lda	(_calloc_PARM_2 + 1)
	sta	(__mulint_PARM_2 + 1)
	ldx	_calloc_nmemb_1_1
	lda	(_calloc_nmemb_1_1 + 1)
	jsr	__mulint
	sta	(_memset_PARM_3 + 1)
	stx	_memset_PARM_3
	clra
	sta	_memset_PARM_2
	ldx	_calloc_ptr_1_1
	lda	(_calloc_ptr_1_1 + 1)
	jsr	_memset
00102$:
;../_calloc.c:79: return ptr;
	ldx	_calloc_ptr_1_1
	lda	(_calloc_ptr_1_1 + 1)
00103$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
