;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module acosf
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _acosf
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
;../acosf.c:36: float acosf(const float x) _FLOAT_FUNC_REENTRANT
;	---------------------------------
; Function acosf
; ---------------------------------
_acosf_start::
_acosf:
	
	push	af
	push	af
;../acosf.c:38: if (x == 1.0) return 0.0;
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fseq
	lda	sp,8(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00108$
	ld	de,#0x0000
	ld	hl,#0x0000
	jp	00110$
00108$:
;../acosf.c:39: else if (x ==-1.0) return PI;
	ld	hl,#0xBF80
	push	hl
	ld	hl,#0x0000
	push	hl
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fseq
	lda	sp,8(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00105$
	ld	de,#0x0FDB
	ld	hl,#0x4049
	jp	00110$
00105$:
;../acosf.c:40: else if (x == 0.0) return HALF_PI;
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00102$
	ld	de,#0x0FDB
	ld	hl,#0x3FC9
	jr	00110$
00102$:
;../acosf.c:41: else               return asincosf(x, true);
	ld	a,#0x01
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
	call	_asincosf
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
00110$:
	lda	sp,4(sp)
	ret
_acosf_end::
	.area _CODE
	.area _CABS
