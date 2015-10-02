;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fssub
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fssub
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
;../_fssub.c:73: float __fssub (float a1, float a2)
;	---------------------------------
; Function __fssub
; ---------------------------------
___fssub_start::
___fssub:
	lda	sp,-8(sp)
;../_fssub.c:75: float neg = -a1;
	ldhl	sp,#13
	ld	a,(hl)
	xor	a,#0x80
	ldhl	sp,#7
	ld	(hl),a
	ldhl	sp,#10
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#11
	ld	a,(hl)
	ldhl	sp,#5
	ld	(hl),a
	ldhl	sp,#12
	ld	a,(hl)
	ldhl	sp,#6
	ld	(hl),a
;../_fssub.c:76: return -(neg + a2);
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fsadd
	lda	sp,8(sp)
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
00101$:
	lda	sp,8(sp)
	ret
___fssub_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
