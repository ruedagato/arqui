;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _ispunct
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ispunct
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
	
;../_ispunct.c:33: if ( isprint (c) &&
	ldhl	sp,#2
	ld	a,(hl)
	push	af
	inc	sp
	call	_isprint
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00102$
;../_ispunct.c:34: !islower(c) &&
	ldhl	sp,#2
	ld	a,(hl)
	push	af
	inc	sp
	call	_islower
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	NZ,00102$
;../_ispunct.c:35: !isupper(c) &&
	ldhl	sp,#2
	ld	a,(hl)
	push	af
	inc	sp
	call	_isupper
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	NZ,00102$
;../_ispunct.c:36: !isspace(c) &&
	ldhl	sp,#2
	ld	a,(hl)
	push	af
	inc	sp
	call	_isspace
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	NZ,00102$
;../_ispunct.c:37: !isdigit(c) )
	ldhl	sp,#2
	ld	a,(hl)
	push	af
	inc	sp
	call	_isdigit
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	NZ,00102$
;../_ispunct.c:38: return 1;
	ld	e,#0x01
	jr	00107$
00102$:
;../_ispunct.c:39: return 0;
	ld	e,#0x00
00107$:
	
	ret
_ispunct_end::
	.area _CODE
	.area _CABS
