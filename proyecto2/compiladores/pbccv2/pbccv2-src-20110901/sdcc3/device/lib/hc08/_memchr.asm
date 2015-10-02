;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _memchr
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
	.globl _memchr_PARM_3
	.globl _memchr_PARM_2
	.globl _memchr
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_memchr_sloc0_1_0::
	.ds 2
_memchr_sloc1_1_0::
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
_memchr_PARM_2:
	.ds 2
_memchr_PARM_3:
	.ds 2
_memchr_s_1_1:
	.ds 2
_memchr_p_1_1:
	.ds 2
_memchr_end_1_1:
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
;Allocation info for local variables in function 'memchr'
;------------------------------------------------------------
;c                         Allocated with name '_memchr_PARM_2'
;n                         Allocated with name '_memchr_PARM_3'
;s                         Allocated with name '_memchr_s_1_1'
;p                         Allocated with name '_memchr_p_1_1'
;end                       Allocated with name '_memchr_end_1_1'
;sloc0                     Allocated with name '_memchr_sloc0_1_0'
;sloc1                     Allocated with name '_memchr_sloc1_1_0'
;------------------------------------------------------------
;../_memchr.c:31: void *memchr(const void *s, int c, size_t n)
;	-----------------------------------------
;	 function memchr
;	-----------------------------------------
_memchr:
	sta	(_memchr_s_1_1 + 1)
	stx	_memchr_s_1_1
;../_memchr.c:33: unsigned char *p = (unsigned char *)s;
	lda	_memchr_s_1_1
	sta	_memchr_p_1_1
	lda	(_memchr_s_1_1 + 1)
	sta	(_memchr_p_1_1 + 1)
;../_memchr.c:34: unsigned char *end = p + n;
	lda	(_memchr_s_1_1 + 1)
	add	(_memchr_PARM_3 + 1)
	sta	(_memchr_end_1_1 + 1)
	lda	_memchr_s_1_1
	adc	_memchr_PARM_3
	sta	_memchr_end_1_1
;../_memchr.c:38: return(0);
	lda	_memchr_s_1_1
	sta	*_memchr_sloc0_1_0
	lda	(_memchr_s_1_1 + 1)
	sta	*(_memchr_sloc0_1_0 + 1)
00103$:
;../_memchr.c:35: for(; p != end; p++)
	lda	*(_memchr_sloc0_1_0 + 1)
	cmp	(_memchr_end_1_1 + 1)
	bne	00112$
	lda	*_memchr_sloc0_1_0
	cmp	_memchr_end_1_1
	beq	00106$
00112$:
;../_memchr.c:36: if(*p == c)
	ldhx	*_memchr_sloc0_1_0
	lda	,x
	sta	*(_memchr_sloc1_1_0 + 1)
	clr	*_memchr_sloc1_1_0
	lda	*(_memchr_sloc1_1_0 + 1)
	cmp	(_memchr_PARM_2 + 1)
	bne	00113$
	lda	*_memchr_sloc1_1_0
	cmp	_memchr_PARM_2
	beq	00114$
00113$:
	bra	00105$
00114$:
;../_memchr.c:37: return((void *)p);
	ldx	_memchr_p_1_1
	lda	(_memchr_p_1_1 + 1)
	rts
00105$:
;../_memchr.c:35: for(; p != end; p++)
	ldhx	*_memchr_sloc0_1_0
	aix	#1
	sthx	*_memchr_sloc0_1_0
	lda	*_memchr_sloc0_1_0
	sta	_memchr_p_1_1
	lda	*(_memchr_sloc0_1_0 + 1)
	sta	(_memchr_p_1_1 + 1)
	bra	00103$
00106$:
;../_memchr.c:38: return(0);
	clrx
	clra
00107$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
