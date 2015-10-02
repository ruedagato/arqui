;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _strpbrk
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strpbrk
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../_strpbrk.c:31: char * strpbrk (
;	---------------------------------
; Function strpbrk
; ---------------------------------
_strpbrk_start::
_strpbrk:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;../_strpbrk.c:36: char *ret = NULL;
	ld	bc,#0x0000
;../_strpbrk.c:39: while (ch = *control) {
	ld	e,6 (ix)
	ld	d,7 (ix)
00105$:
	ld	a,(de)
	ld	l,a
	ld	-1 (ix),l
	xor	a,a
	or	a,l
	jr	Z,00107$
;../_strpbrk.c:40: char * p = strchr(string, ch);
	push	bc
	push	de
	ld	a,-1 (ix)
	push	af
	inc	sp
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_strchr
	pop	af
	inc	sp
	pop	de
	pop	bc
;../_strpbrk.c:41: if (p != NULL && (ret == NULL || p < ret)) {
	ld	a,l
	or	a,h
	jr	Z,00102$
	ld	a,c
	or	a,b
	jr	Z,00101$
	ld	a,l
	sub	a, c
	ld	a,h
	sbc	a, b
	jp	PO, 00117$
	xor	a, #0x80
00117$:
	jp	P,00102$
00101$:
;../_strpbrk.c:42: ret = p;
	ld	c,l
	ld	b,h
00102$:
;../_strpbrk.c:44: control++;
	inc	de
	jr	00105$
00107$:
;../_strpbrk.c:47: return (ret);
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
_strpbrk_end::
	.area _CODE
	.area _CABS
