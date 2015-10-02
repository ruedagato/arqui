;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fs2schar
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2schar
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
;../_fs2schar.c:87: signed char __fs2schar (float f)
;	---------------------------------
; Function __fs2schar
; ---------------------------------
___fs2schar_start::
___fs2schar:
	
	push	af
	push	af
;../_fs2schar.c:89: signed long sl=__fs2slong(f);
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fs2slong
	lda	sp,4(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../_fs2schar.c:90: if (sl>=SCHAR_MAX)
	ldhl	sp,#0
	ld	a, (hl)
	sub	a, #0x7F
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00109$
	bit	7, d
	jp	NZ, 00110$
	cp	a, a
	jr	00110$
00109$:
	bit	7, d
	jp	Z, 00110$
	scf
00110$:
	jp	C,00102$
;../_fs2schar.c:91: return SCHAR_MAX;
	ld	e,#0x7F
	jr	00105$
00102$:
;../_fs2schar.c:92: if (sl<=SCHAR_MIN)
	ldhl	sp,#0
	ld	a, #0x80
	sub	a, (hl)
	inc	hl
	ld	a, #0xFF
	sbc	a, (hl)
	inc	hl
	ld	a, #0xFF
	sbc	a, (hl)
	inc	hl
	ld	a, #0xFF
	sbc	a, (hl)
	ld	a, #0xFF
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00111$
	bit	7, d
	jp	NZ, 00112$
	cp	a, a
	jr	00112$
00111$:
	bit	7, d
	jp	Z, 00112$
	scf
00112$:
	jp	C,00104$
;../_fs2schar.c:93: return -SCHAR_MIN;
	ld	e,#0x80
	jr	00105$
00104$:
;../_fs2schar.c:94: return sl;
	ldhl	sp,#0
	ld	c,(hl)
	ld	e,c
00105$:
	lda	sp,4(sp)
	ret
___fs2schar_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
