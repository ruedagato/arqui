;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _slong2fs
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___slong2fs
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
;../_slong2fs.c:79: float __slong2fs (signed long sl) {
;	---------------------------------
; Function __slong2fs
; ---------------------------------
___slong2fs_start::
___slong2fs:
	
	push	af
	push	af
;../_slong2fs.c:80: if (sl<0) 
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
	jp	Z, 00107$
	bit	7, d
	jp	NZ, 00108$
	cp	a, a
	jr	00108$
00107$:
	bit	7, d
	jp	Z, 00108$
	scf
00108$:
	jp	NC,00102$
;../_slong2fs.c:81: return -__ulong2fs(-sl);
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
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___ulong2fs
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
	ldhl	sp,#3
	ld	a,(hl)
	xor	a,#0x80
	ld	(hl),a
	ldhl	sp,#0
	ld	a,(hl)
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ld	(hl),a
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jr	00104$
00102$:
;../_slong2fs.c:83: return __ulong2fs(sl);
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
	call	___ulong2fs
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
00104$:
	lda	sp,4(sp)
	ret
___slong2fs_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
