;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strtok
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
	.globl _strtok_PARM_2
	.globl _strtok
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_strtok_sloc0_1_0:
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
_strtok_PARM_2:
	.ds 2
_strtok_str_1_1:
	.ds 2
_strtok_s_1_1:
	.ds 2
_strtok_s1_1_1:
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
;Allocation info for local variables in function 'strtok'
;------------------------------------------------------------
;sloc0                     Allocated with name '_strtok_sloc0_1_0'
;control                   Allocated with name '_strtok_PARM_2'
;str                       Allocated with name '_strtok_str_1_1'
;s                         Allocated with name '_strtok_s_1_1'
;s1                        Allocated with name '_strtok_s1_1_1'
;------------------------------------------------------------
;../_strtok.c:36: char * strtok (
;	-----------------------------------------
;	 function strtok
;	-----------------------------------------
_strtok:
	sta	(_strtok_str_1_1 + 1)
	stx	_strtok_str_1_1
;../_strtok.c:43: if ( str )
	lda	(_strtok_str_1_1 + 1)
	ora	_strtok_str_1_1
	beq	00102$
00130$:
;../_strtok.c:44: s = str ;
	lda	_strtok_str_1_1
	sta	_strtok_s_1_1
	lda	(_strtok_str_1_1 + 1)
	sta	(_strtok_s_1_1 + 1)
00102$:
;../_strtok.c:45: if ( !s )
	lda	(_strtok_s_1_1 + 1)
	ora	_strtok_s_1_1
	bne	00108$
00131$:
;../_strtok.c:46: return NULL;
	clrx
	clra
	rts
;../_strtok.c:48: while (*s) {
00108$:
	lda	_strtok_s_1_1
	sta	*_strtok_sloc0_1_0
	lda	(_strtok_s_1_1 + 1)
	sta	*(_strtok_sloc0_1_0 + 1)
	ldhx	*_strtok_sloc0_1_0
	lda	,x
	beq	00110$
00132$:
;../_strtok.c:49: if (strchr(control,*s))
	ldhx	*_strtok_sloc0_1_0
	lda	,x
	sta	_strchr_PARM_2
	ldx	_strtok_PARM_2
	lda	(_strtok_PARM_2 + 1)
	jsr	_strchr
	tsta
	bne	00133$
	tstx
00133$:
	beq	00110$
00134$:
;../_strtok.c:50: s++;
	lda	(_strtok_s_1_1 + 1)
	inca
	sta	(_strtok_s_1_1 + 1)
	bne	00135$
	lda	_strtok_s_1_1
	inca
	sta	_strtok_s_1_1
00135$:
	bra	00108$
;../_strtok.c:52: break;
00110$:
;../_strtok.c:55: s1 = s ;
	lda	_strtok_s_1_1
	sta	_strtok_s1_1_1
	lda	(_strtok_s_1_1 + 1)
	sta	(_strtok_s1_1_1 + 1)
;../_strtok.c:57: while (*s) {
00113$:
	lda	_strtok_s_1_1
	sta	*_strtok_sloc0_1_0
	lda	(_strtok_s_1_1 + 1)
	sta	*(_strtok_sloc0_1_0 + 1)
	ldhx	*_strtok_sloc0_1_0
	lda	,x
	beq	00115$
00136$:
;../_strtok.c:58: if (strchr(control,*s)) {
	ldhx	*_strtok_sloc0_1_0
	lda	,x
	sta	_strchr_PARM_2
	ldx	_strtok_PARM_2
	lda	(_strtok_PARM_2 + 1)
	jsr	_strchr
	tsta
	bne	00137$
	tstx
00137$:
	beq	00112$
00138$:
;../_strtok.c:59: *s++ = '\0';
	lda	_strtok_s_1_1
	sta	*_strtok_sloc0_1_0
	lda	(_strtok_s_1_1 + 1)
	sta	*(_strtok_sloc0_1_0 + 1)
	ldhx	*_strtok_sloc0_1_0
	clra
	sta	,x
	lda	*(_strtok_sloc0_1_0 + 1)
	add	#0x01
	sta	(_strtok_s_1_1 + 1)
	lda	*_strtok_sloc0_1_0
	adc	#0x00
	sta	_strtok_s_1_1
;../_strtok.c:60: return s1 ;
	ldx	_strtok_s1_1_1
	lda	(_strtok_s1_1_1 + 1)
	rts
00112$:
;../_strtok.c:62: s++ ;
	lda	(_strtok_s_1_1 + 1)
	inca
	sta	(_strtok_s_1_1 + 1)
	bne	00139$
	lda	_strtok_s_1_1
	inca
	sta	_strtok_s_1_1
00139$:
	bra	00113$
00115$:
;../_strtok.c:65: s = NULL;
	clra
	sta	_strtok_s_1_1
	sta	(_strtok_s_1_1 + 1)
;../_strtok.c:67: if (*s1)
	lda	_strtok_s1_1_1
	ldx	(_strtok_s1_1_1 + 1)
	psha
	pulh
	lda	,x
	beq	00117$
00140$:
;../_strtok.c:68: return s1;
	ldx	_strtok_s1_1_1
	lda	(_strtok_s1_1_1 + 1)
	rts
00117$:
;../_strtok.c:70: return NULL;
	clrx
	clra
00119$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
