;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module labs
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _labs
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
;../labs.c:63: long int labs(long int j)
;	---------------------------------
; Function labs
; ---------------------------------
_labs_start::
_labs:
	
	push	af
	push	af
;../labs.c:65: return (j < 0) ? -j : j;
	ldhl	sp,#6
	ld	a, (hl)
	sub	a, #0x00
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
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#6
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#3
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ld	de,#0x0000
	ldhl	sp,#10
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#3
	ld	(hl),a
	dec	hl
	ld	(hl),e
	jr	00104$
00103$:
	ldhl	sp,#6
	ld	d,h
	ld	e,l
	ldhl	sp,#0
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
00104$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00101$:
	lda	sp,4(sp)
	ret
_labs_end::
	.area _CODE
	.area _CABS
