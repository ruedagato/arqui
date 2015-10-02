;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fs2ulong
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2ulong
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
;../_fs2ulong.c:103: __fs2ulong (float a1)
;	---------------------------------
; Function __fs2ulong
; ---------------------------------
___fs2ulong_start::
___fs2ulong:
	lda	sp,-14(sp)
;../_fs2ulong.c:109: fl1.f = a1;
	ldhl	sp,#10
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ldhl	sp,#16
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
;../_fs2ulong.c:111: if (!fl1.l || SIGN(fl1.l))
	ldhl	sp,#10
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
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00101$
	ldhl	sp,#10
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
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	jp	Z,00102$
00101$:
;../_fs2ulong.c:112: return (0);
	ld	de,#0x0000
	ld	hl,#0x0000
	jp	00104$
00102$:
;../_fs2ulong.c:114: exp = EXP (fl1.l) - EXCESS - 24;
	ldhl	sp,#10
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
	ld	a,#0x17
	push	af
	inc	sp
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#3
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rrulong_rrx_s
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
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	sub	a,#0x96
	ld	e,a
	ld	a,d
	sbc	a,#0x00
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	af
	ld	a,e
	sbc	a,#0x00
	ld	e,a
	ld	a,d
	sbc	a,#0x00
	ld	(hl),a
	dec	hl
	ld	(hl),e
	dec	hl
	dec	hl
	ld	a,(hl)
	ldhl	sp,#8
	ld	(hl),a
	ldhl	sp,#1
	ld	a,(hl)
	ldhl	sp,#9
	ld	(hl),a
;../_fs2ulong.c:115: l = MANT (fl1.l);
	ldhl	sp,#10
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
	ld	a,(hl)
	and	a,#0x7F
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#0
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#1
	ld	a,(hl)
	ldhl	sp,#5
	ld	(hl),a
	ldhl	sp,#2
	ld	a,(hl)
	set	7, a
	ldhl	sp,#6
	ld	(hl),a
	ldhl	sp,#3
	ld	a,(hl)
	ldhl	sp,#7
	ld	(hl),a
;../_fs2ulong.c:117: l >>= -exp;
	xor	a,a
	inc	hl
	ld	a,#0x00
	sbc	a,(hl)
	ld	c,a
	inc	hl
	ld	a,#0x00
	sbc	a,(hl)
	ld	b,a
	push	bc
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
	call	__rrslong_rrx_s
	lda	sp,6(sp)
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
;../_fs2ulong.c:119: return l;
	ldhl	sp,#4
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
	lda	sp,14(sp)
	ret
___fs2ulong_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
