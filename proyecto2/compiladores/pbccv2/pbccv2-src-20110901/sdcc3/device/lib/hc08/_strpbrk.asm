;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strpbrk
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
	.globl _strpbrk_PARM_2
	.globl _strpbrk
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_strpbrk_ch_1_1:
	.ds 1
_strpbrk_sloc0_1_0:
	.ds 2
_strpbrk_sloc1_1_0:
	.ds 1
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
_strpbrk_PARM_2:
	.ds 2
_strpbrk_string_1_1:
	.ds 2
_strpbrk_ret_1_1:
	.ds 2
_strpbrk_p_2_2:
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
;Allocation info for local variables in function 'strpbrk'
;------------------------------------------------------------
;ch                        Allocated with name '_strpbrk_ch_1_1'
;sloc0                     Allocated with name '_strpbrk_sloc0_1_0'
;sloc1                     Allocated with name '_strpbrk_sloc1_1_0'
;control                   Allocated with name '_strpbrk_PARM_2'
;string                    Allocated with name '_strpbrk_string_1_1'
;ret                       Allocated with name '_strpbrk_ret_1_1'
;p                         Allocated with name '_strpbrk_p_2_2'
;------------------------------------------------------------
;../_strpbrk.c:31: char * strpbrk (
;	-----------------------------------------
;	 function strpbrk
;	-----------------------------------------
_strpbrk:
	sta	(_strpbrk_string_1_1 + 1)
	stx	_strpbrk_string_1_1
;../_strpbrk.c:36: char *ret = NULL;
	clra
	sta	_strpbrk_ret_1_1
	sta	(_strpbrk_ret_1_1 + 1)
;../_strpbrk.c:39: while (ch = *control) {
	lda	_strpbrk_PARM_2
	sta	*_strpbrk_sloc0_1_0
	lda	(_strpbrk_PARM_2 + 1)
	sta	*(_strpbrk_sloc0_1_0 + 1)
00105$:
	ldhx	*_strpbrk_sloc0_1_0
	lda	,x
	sta	*_strpbrk_ch_1_1
	mov	*_strpbrk_ch_1_1,*_strpbrk_sloc1_1_0
	tst	*_strpbrk_ch_1_1
	beq	00107$
00115$:
;../_strpbrk.c:40: char * p = strchr(string, ch);
	lda	*_strpbrk_sloc1_1_0
	sta	_strchr_PARM_2
	ldx	_strpbrk_string_1_1
	lda	(_strpbrk_string_1_1 + 1)
	jsr	_strchr
	sta	(_strpbrk_p_2_2 + 1)
	stx	_strpbrk_p_2_2
;../_strpbrk.c:41: if (p != NULL && (ret == NULL || p < ret)) {
	lda	(_strpbrk_p_2_2 + 1)
	cmp	#0x00
	bne	00116$
	lda	_strpbrk_p_2_2
	cmp	#0x00
	beq	00102$
00116$:
	lda	(_strpbrk_ret_1_1 + 1)
	cmp	#0x00
	bne	00117$
	lda	_strpbrk_ret_1_1
	cmp	#0x00
	beq	00101$
00117$:
	lda	(_strpbrk_p_2_2 + 1)
	sub	(_strpbrk_ret_1_1 + 1)
	lda	_strpbrk_p_2_2
	sbc	_strpbrk_ret_1_1
	bge	00102$
00118$:
00101$:
;../_strpbrk.c:42: ret = p;
	lda	_strpbrk_p_2_2
	sta	_strpbrk_ret_1_1
	lda	(_strpbrk_p_2_2 + 1)
	sta	(_strpbrk_ret_1_1 + 1)
00102$:
;../_strpbrk.c:44: control++;
	ldhx	*_strpbrk_sloc0_1_0
	aix	#1
	sthx	*_strpbrk_sloc0_1_0
	bra	00105$
00107$:
;../_strpbrk.c:47: return (ret);
	ldx	_strpbrk_ret_1_1
	lda	(_strpbrk_ret_1_1 + 1)
00108$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
