;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _realloc
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
	.globl _realloc_PARM_2
	.globl _realloc
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_realloc_sloc0_1_0:
	.ds 2
_realloc_sloc1_1_0:
	.ds 2
_realloc_sloc2_1_0:
	.ds 2
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
_realloc_PARM_2:
	.ds 2
_realloc_p_1_1:
	.ds 2
_realloc_pthis_1_1:
	.ds 2
_realloc_pnew_1_1:
	.ds 2
_realloc_ret_1_1:
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
;Allocation info for local variables in function 'realloc'
;------------------------------------------------------------
;sloc0                     Allocated with name '_realloc_sloc0_1_0'
;sloc1                     Allocated with name '_realloc_sloc1_1_0'
;sloc2                     Allocated with name '_realloc_sloc2_1_0'
;size                      Allocated with name '_realloc_PARM_2'
;p                         Allocated with name '_realloc_p_1_1'
;pthis                     Allocated with name '_realloc_pthis_1_1'
;pnew                      Allocated with name '_realloc_pnew_1_1'
;ret                       Allocated with name '_realloc_ret_1_1'
;------------------------------------------------------------
;../_realloc.c:84: void __xdata * realloc (void * p, size_t size)
;	-----------------------------------------
;	 function realloc
;	-----------------------------------------
_realloc:
	sta	(_realloc_p_1_1 + 1)
	stx	_realloc_p_1_1
;../_realloc.c:92: pthis = _sdcc_find_memheader(p);
	ldx	_realloc_p_1_1
	lda	(_realloc_p_1_1 + 1)
	jsr	__sdcc_find_memheader
	sta	(_realloc_pthis_1_1 + 1)
	stx	_realloc_pthis_1_1
;../_realloc.c:93: if (pthis)
	lda	(_realloc_pthis_1_1 + 1)
	ora	_realloc_pthis_1_1
	bne	00124$
	jmp	00114$
00124$:
;../_realloc.c:95: if (size > (0xFFFF-HEADER_SIZE))
	lda	#0xFB
	sub	(_realloc_PARM_2 + 1)
	lda	#0xFF
	sbc	_realloc_PARM_2
	bcc	00111$
00125$:
;../_realloc.c:97: ret = (void __xdata *) NULL; //To prevent overflow in next line
	clra
	sta	_realloc_ret_1_1
	sta	(_realloc_ret_1_1 + 1)
	jmp	00115$
00111$:
;../_realloc.c:101: size += HEADER_SIZE; //We need a memory for header too
	lda	(_realloc_PARM_2 + 1)
	add	#0x04
	sta	(_realloc_PARM_2 + 1)
	bcc	00126$
	lda	_realloc_PARM_2
	inca
	sta	_realloc_PARM_2
00126$:
;../_realloc.c:103: if ((((unsigned int)pthis->next) - ((unsigned int)pthis)) >= size)
	lda	_realloc_pthis_1_1
	ldx	(_realloc_pthis_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	*_realloc_sloc0_1_0
	lda	,x
	sta	*(_realloc_sloc0_1_0 + 1)
	lda	(_realloc_pthis_1_1 + 1)
	sta	*(_realloc_sloc1_1_0 + 1)
	lda	_realloc_pthis_1_1
	sta	*_realloc_sloc1_1_0
	lda	*(_realloc_sloc0_1_0 + 1)
	sub	*(_realloc_sloc1_1_0 + 1)
	sta	*(_realloc_sloc1_1_0 + 1)
	lda	*_realloc_sloc0_1_0
	sbc	*_realloc_sloc1_1_0
	sta	*_realloc_sloc1_1_0
	lda	*(_realloc_sloc1_1_0 + 1)
	sub	(_realloc_PARM_2 + 1)
	lda	*_realloc_sloc1_1_0
	sbc	_realloc_PARM_2
	bcs	00108$
00127$:
;../_realloc.c:105: pthis->len = size;
	lda	(_realloc_pthis_1_1 + 1)
	add	#0x02
	sta	*(_realloc_sloc1_1_0 + 1)
	lda	_realloc_pthis_1_1
	adc	#0x00
	sta	*_realloc_sloc1_1_0
	ldhx	*_realloc_sloc1_1_0
	lda	_realloc_PARM_2
	sta	,x
	aix	#1
	lda	(_realloc_PARM_2 + 1)
	sta	,x
;../_realloc.c:106: ret = p;
	lda	_realloc_p_1_1
	sta	_realloc_ret_1_1
	lda	(_realloc_p_1_1 + 1)
	sta	(_realloc_ret_1_1 + 1)
	jmp	00115$
00108$:
;../_realloc.c:110: if ((_sdcc_prev_memheader) &&
	lda	(__sdcc_prev_memheader + 1)
	ora	__sdcc_prev_memheader
	bne	00128$
	jmp	00104$
00128$:
;../_realloc.c:111: ((((unsigned int)pthis->next) -
	lda	_realloc_pthis_1_1
	ldx	(_realloc_pthis_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	*_realloc_sloc1_1_0
	lda	,x
	sta	*(_realloc_sloc1_1_0 + 1)
;../_realloc.c:112: ((unsigned int)_sdcc_prev_memheader) -
	lda	(__sdcc_prev_memheader + 1)
	sta	*(_realloc_sloc0_1_0 + 1)
	lda	__sdcc_prev_memheader
	sta	*_realloc_sloc0_1_0
	lda	*(_realloc_sloc1_1_0 + 1)
	sub	*(_realloc_sloc0_1_0 + 1)
	sta	*(_realloc_sloc1_1_0 + 1)
	lda	*_realloc_sloc1_1_0
	sbc	*_realloc_sloc0_1_0
	sta	*_realloc_sloc1_1_0
;../_realloc.c:113: _sdcc_prev_memheader->len) >= size))
	lda	__sdcc_prev_memheader
	sta	*_realloc_sloc0_1_0
	lda	(__sdcc_prev_memheader + 1)
	sta	*(_realloc_sloc0_1_0 + 1)
	ldhx	*_realloc_sloc0_1_0
	aix	#2
	sthx	*_realloc_sloc2_1_0
	ldhx	*_realloc_sloc2_1_0
	lda	,x
	aix	#1
	sta	*_realloc_sloc2_1_0
	lda	,x
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	*(_realloc_sloc1_1_0 + 1)
	sub	*(_realloc_sloc2_1_0 + 1)
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	*_realloc_sloc1_1_0
	sbc	*_realloc_sloc2_1_0
	sta	*_realloc_sloc2_1_0
	lda	*(_realloc_sloc2_1_0 + 1)
	sub	(_realloc_PARM_2 + 1)
	lda	*_realloc_sloc2_1_0
	sbc	_realloc_PARM_2
	bcc	00129$
	jmp	00104$
00129$:
;../_realloc.c:115: pnew = (MEMHEADER __xdata * )((char __xdata *)_sdcc_prev_memheader + _sdcc_prev_memheader->len);
	lda	*_realloc_sloc0_1_0
	sta	__sdcc_prev_memheader
	lda	*(_realloc_sloc0_1_0 + 1)
	sta	(__sdcc_prev_memheader + 1)
	ldhx	*_realloc_sloc0_1_0
	aix	#2
	sthx	*_realloc_sloc2_1_0
	ldhx	*_realloc_sloc2_1_0
	lda	,x
	aix	#1
	sta	*_realloc_sloc2_1_0
	lda	,x
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	(__sdcc_prev_memheader + 1)
	add	*(_realloc_sloc2_1_0 + 1)
	sta	(_realloc_pnew_1_1 + 1)
	lda	__sdcc_prev_memheader
	adc	*_realloc_sloc2_1_0
	sta	_realloc_pnew_1_1
;../_realloc.c:116: _sdcc_prev_memheader->next = pnew;
	ldhx	*_realloc_sloc0_1_0
	lda	_realloc_pnew_1_1
	sta	,x
	aix	#1
	lda	(_realloc_pnew_1_1 + 1)
	sta	,x
;../_realloc.c:122: memmove(pnew, pthis, pthis->len);
	lda	(_realloc_pthis_1_1 + 1)
	add	#0x02
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	_realloc_pthis_1_1
	adc	#0x00
	sta	*_realloc_sloc2_1_0
	ldhx	*_realloc_sloc2_1_0
	lda	,x
	aix	#1
	sta	_memmove_PARM_3
	lda	,x
	sta	(_memmove_PARM_3 + 1)
	lda	_realloc_pthis_1_1
	sta	_memmove_PARM_2
	lda	(_realloc_pthis_1_1 + 1)
	sta	(_memmove_PARM_2 + 1)
	ldx	_realloc_pnew_1_1
	lda	(_realloc_pnew_1_1 + 1)
	jsr	_memmove
;../_realloc.c:123: pnew->len = size;
	lda	(_realloc_pnew_1_1 + 1)
	add	#0x02
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	_realloc_pnew_1_1
	adc	#0x00
	sta	*_realloc_sloc2_1_0
	ldhx	*_realloc_sloc2_1_0
	lda	_realloc_PARM_2
	sta	,x
	aix	#1
	lda	(_realloc_PARM_2 + 1)
	sta	,x
;../_realloc.c:124: ret = MEM(pnew);
	lda	(_realloc_pnew_1_1 + 1)
	add	#0x04
	sta	(_realloc_ret_1_1 + 1)
	lda	_realloc_pnew_1_1
	adc	#0x00
	sta	_realloc_ret_1_1
	jmp	00115$
00104$:
;../_realloc.c:128: ret = malloc(size - HEADER_SIZE);
	lda	(_realloc_PARM_2 + 1)
	sub	#0x04
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	_realloc_PARM_2
	sbc	#0x00
	sta	*_realloc_sloc2_1_0
	ldx	*_realloc_sloc2_1_0
	lda	*(_realloc_sloc2_1_0 + 1)
	jsr	_malloc
	sta	(_realloc_ret_1_1 + 1)
	stx	_realloc_ret_1_1
;../_realloc.c:129: if (ret)
	lda	(_realloc_ret_1_1 + 1)
	ora	_realloc_ret_1_1
	beq	00115$
00130$:
;../_realloc.c:131: memcpy(ret, MEM(pthis), pthis->len - HEADER_SIZE);
	lda	(_realloc_pthis_1_1 + 1)
	add	#0x04
	sta	(_memcpy_PARM_2 + 1)
	lda	_realloc_pthis_1_1
	adc	#0x00
	sta	_memcpy_PARM_2
	lda	(_realloc_pthis_1_1 + 1)
	add	#0x02
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	_realloc_pthis_1_1
	adc	#0x00
	sta	*_realloc_sloc2_1_0
	ldhx	*_realloc_sloc2_1_0
	lda	,x
	aix	#1
	sta	*_realloc_sloc2_1_0
	lda	,x
	sta	*(_realloc_sloc2_1_0 + 1)
	lda	*(_realloc_sloc2_1_0 + 1)
	sub	#0x04
	sta	(_memcpy_PARM_3 + 1)
	lda	*_realloc_sloc2_1_0
	sbc	#0x00
	sta	_memcpy_PARM_3
	ldx	_realloc_ret_1_1
	lda	(_realloc_ret_1_1 + 1)
	jsr	_memcpy
;../_realloc.c:132: free(p);
	ldx	_realloc_p_1_1
	lda	(_realloc_p_1_1 + 1)
	jsr	_free
	bra	00115$
00114$:
;../_realloc.c:140: ret = malloc(size);
	ldx	_realloc_PARM_2
	lda	(_realloc_PARM_2 + 1)
	jsr	_malloc
	sta	(_realloc_ret_1_1 + 1)
	stx	_realloc_ret_1_1
00115$:
;../_realloc.c:143: return ret;
	ldx	_realloc_ret_1_1
	lda	(_realloc_ret_1_1 + 1)
00116$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
