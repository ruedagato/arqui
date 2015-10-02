;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fs2uint
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2uint
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
;../_fs2uint.c:54: unsigned int __fs2uint (float f)
;	---------------------------------
; Function __fs2uint
; ---------------------------------
___fs2uint_start::
___fs2uint:
	
	push	af
	push	af
;../_fs2uint.c:56: unsigned long ul=__fs2ulong(f);
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
	call	___fs2ulong
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
;../_fs2uint.c:57: if (ul>=UINT_MAX) return UINT_MAX;
	ldhl	sp,#0
	ld	a, (hl)
	sub	a, #0xFF
	inc	hl
	ld	a, (hl)
	sbc	a, #0xFF
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	jp	C,00102$
	ld	de,#0xFFFF
	jr	00103$
00102$:
;../_fs2uint.c:58: return ul;
	ldhl	sp,#0
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	e,c
	ld	d,b
00103$:
	lda	sp,4(sp)
	ret
___fs2uint_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
