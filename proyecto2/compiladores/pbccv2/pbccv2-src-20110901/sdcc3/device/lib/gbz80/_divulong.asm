;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _divulong
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divulong
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
;../_divulong.c:331: _divulong (unsigned long x, unsigned long y)
;	---------------------------------
; Function _divulong
; ---------------------------------
__divulong_start::
__divulong:
	lda	sp,-8(sp)
;../_divulong.c:333: unsigned long reste = 0L;
	xor	a,a
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
;../_divulong.c:337: do
	ld	b,#0x20
00105$:
;../_divulong.c:340: c = MSB_SET(x);
	ldhl	sp,#13
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	ld	c,a
;../_divulong.c:341: x <<= 1;
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#15
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlulong_rrx_s
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
	ld	d,h
	ld	e,l
	ldhl	sp,#10
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
;../_divulong.c:342: reste <<= 1;
	push	bc
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
	call	__rlulong_rrx_s
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
	ld	d,h
	ld	e,l
	ldhl	sp,#4
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
;../_divulong.c:343: if (c)
	bit	0,c
	jp	Z,00102$
;../_divulong.c:344: reste |= 1L;
	ldhl	sp,#4
	ld	a,(hl)
	set	0, a
	ld	(hl),a
00102$:
;../_divulong.c:346: if (reste >= y)
	ldhl	sp,#4
	ld	d, h
	ld	e, l
	ldhl	sp,#14
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jp	C,00106$
;../_divulong.c:348: reste -= y;
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#14
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#7
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#18
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#7
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_divulong.c:350: x |= 1L;
	ldhl	sp,#10
	ld	a,(hl)
	set	0, a
	ld	(hl),a
00106$:
;../_divulong.c:353: while (--count);
	dec	b
	xor	a,a
	or	a,b
	jp	NZ,00105$
;../_divulong.c:354: return x;
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00108$:
	lda	sp,8(sp)
	ret
__divulong_end::
	.area _CODE
	.area _CABS
