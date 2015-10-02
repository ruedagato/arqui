;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strcmp
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcmp
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
;../_strcmp.c:34: int strcmp (
;	---------------------------------
; Function strcmp
; ---------------------------------
_strcmp_start::
_strcmp:
	lda	sp,-7(sp)
;../_strcmp.c:43: const char * src = asrc;
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#5
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strcmp.c:44: const char * dst = adst;
	ldhl	sp,#11
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#3
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strcmp.c:46: while( ! (*src - *dst) && *dst)
00102$:
	ldhl	sp,#6
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#0
	ld	(hl),c
	ld	a,c
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	ldhl	sp,#4
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	dec	hl
	ld	(hl),a
	ld	c,(hl)
	ld	a,(hl)
	rla	
	sbc	a,a
	ld	b,a
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	sub	a,c
	ld	e,a
	ld	a,d
	sbc	a,b
	ld	b,a
	ld	c,e
	ld	a,c
	or	a,b
	jp	NZ,00104$
	xor	a,a
	inc	hl
	or	a,(hl)
	jp	Z,00104$
;../_strcmp.c:47: ++src, ++dst;
	ldhl	sp,#5
	inc	(hl)
	jp	NZ,00110$
	inc	hl
	inc	(hl)
00110$:
	ldhl	sp,#3
	inc	(hl)
	jp	NZ,00102$
	inc	hl
	inc	(hl)
00111$:
	jp	00102$
00104$:
;../_strcmp.c:49: return *src - *dst;
	ldhl	sp,#6
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#0
	ld	(hl),c
	ld	a,c
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	ldhl	sp,#4
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	sub	a,c
	ld	e,a
	ld	a,d
	sbc	a,b
	ld	b,a
	ld	c,e
	ld	e,c
	ld	d,b
00105$:
	lda	sp,7(sp)
	ret
_strcmp_end::
	.area _CODE
	.area _CABS
