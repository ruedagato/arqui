;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module sinf
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sinf
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
;../sinf.c:36: float sinf(const float x) _FLOAT_FUNC_REENTRANT
;	---------------------------------
; Function sinf
; ---------------------------------
_sinf_start::
_sinf:
	
	push	af
	push	af
;../sinf.c:38: if (x==0.0) return 0.0;
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00102$
	ld	de,#0x0000
	ld	hl,#0x0000
	jr	00103$
00102$:
;../sinf.c:39: return sincosf(x, 0);
	ld	a,#0x00
	push	af
	inc	sp
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_sincosf
	lda	sp,5(sp)
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
00103$:
	lda	sp,4(sp)
	ret
_sinf_end::
	.area _CODE
	.area _CABS
