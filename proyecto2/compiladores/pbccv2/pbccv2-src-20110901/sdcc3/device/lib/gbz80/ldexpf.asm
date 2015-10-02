;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module ldexpf
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ldexpf
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
;../ldexpf.c:34: float ldexpf(const float x, const int pw2)
;	---------------------------------
; Function ldexpf
; ---------------------------------
_ldexpf_start::
_ldexpf:
	lda	sp,-16(sp)
;../ldexpf.c:39: fl.f = x;
	ldhl	sp,#12
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ldhl	sp,#18
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../ldexpf.c:41: e=(fl.l >> 23) & 0x000000ff;
	ldhl	sp,#12
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	push	bc
	ld	a,#0x17
	push	af
	inc	sp
	dec	hl
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
	call	__rrslong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#4
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	bc
	ldhl	sp,#0
	ld	a,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../ldexpf.c:42: e+=pw2;
	ldhl	sp,#22
	ld	a,(hl)
	ldhl	sp,#0
	ld	(hl),a
	ldhl	sp,#23
	ld	a,(hl)
	ldhl	sp,#1
	ld	(hl),a
	ldhl	sp,#23
	ld	a,(hl)
	rla	
	sbc	a,a
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),a
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#11
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#13
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#11
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../ldexpf.c:43: fl.l= ((e & 0xff) << 23) | (fl.l & 0x807fffff);
	dec	hl
	dec	hl
	ld	a,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	push	bc
	ld	a,#0x17
	push	af
	inc	sp
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#5
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlslong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#4
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	bc
	ldhl	sp,#6
	ld	a,(hl)
	and	a,#0x7F
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	and	a,#0x80
	ld	(hl),a
	ldhl	sp,#0
	ld	a,(hl)
	ldhl	sp,#4
	or	a, (hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#5
	or	a, (hl)
	ldhl	sp,#1
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#6
	or	a, (hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#7
	or	a, (hl)
	ldhl	sp,#3
	ld	(hl),a
	ld	e,c
	ld	d,b
	ldhl	sp,#0
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../ldexpf.c:45: return(fl.f);
	ldhl	sp,#12
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
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
	lda	sp,16(sp)
	ret
_ldexpf_end::
	.area _CODE
	.area _CABS
