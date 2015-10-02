;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module abs
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _abs
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
;../abs.c:58: int abs(int j)
;	---------------------------------
; Function abs
; ---------------------------------
_abs_start::
_abs:
	
;../abs.c:60: return (j < 0) ? -j : j;
	ldhl	sp,#2
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00106$
	bit	7, d
	jp	NZ, 00107$
	cp	a, a
	jr	00107$
00106$:
	bit	7, d
	jp	Z, 00107$
	scf
00107$:
	jp	NC,00103$
	xor	a,a
	ldhl	sp,#2
	ld	a,#0x00
	sbc	a,(hl)
	ld	c,a
	inc	hl
	ld	a,#0x00
	sbc	a,(hl)
	ld	b,a
	jr	00104$
00103$:
	ldhl	sp,#3
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
00104$:
	ld	e,c
	ld	d,b
00101$:
	
	ret
_abs_end::
	.area _CODE
	.area _CABS
