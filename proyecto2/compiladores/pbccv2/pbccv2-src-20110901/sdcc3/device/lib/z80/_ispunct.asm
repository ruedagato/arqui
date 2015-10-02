;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _ispunct
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ispunct
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
;../_ispunct.c:31: char ispunct (unsigned char c)
;	---------------------------------
; Function ispunct
; ---------------------------------
_ispunct_start::
_ispunct:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_ispunct.c:33: if ( isprint (c) &&
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_isprint
	inc	sp
	xor	a,a
	or	a,l
	jr	Z,00102$
;../_ispunct.c:34: !islower(c) &&
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_islower
	inc	sp
	xor	a,a
	or	a,l
	jr	NZ,00102$
;../_ispunct.c:35: !isupper(c) &&
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_isupper
	inc	sp
	xor	a,a
	or	a,l
	jr	NZ,00102$
;../_ispunct.c:36: !isspace(c) &&
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_isspace
	inc	sp
	xor	a,a
	or	a,l
	jr	NZ,00102$
;../_ispunct.c:37: !isdigit(c) )
	ld	a,4 (ix)
	push	af
	inc	sp
	call	_isdigit
	inc	sp
	xor	a,a
	or	a,l
	jr	NZ,00102$
;../_ispunct.c:38: return 1;
	ld	l,#0x01
	jr	00107$
00102$:
;../_ispunct.c:39: return 0;
	ld	l,#0x00
00107$:
	pop	ix
	ret
_ispunct_end::
	.area _CODE
	.area _CABS
