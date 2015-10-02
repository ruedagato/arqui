;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fsneq
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsneq
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
;../_fsneq.c:80: char __fsneq (float a1, float a2)
;	---------------------------------
; Function __fsneq
; ---------------------------------
___fsneq_start::
___fsneq:
	lda	sp,-16(sp)
;../_fsneq.c:84: fl1.f = a1;
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
;../_fsneq.c:85: fl2.f = a2;
	ldhl	sp,#8
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ldhl	sp,#22
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
;../_fsneq.c:87: if (fl1.l == fl2.l)
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
	ldhl	sp,#8
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
	inc	hl
	ld	a,(hl)
	ldhl	sp,#0
	sub	a,(hl)
	jp	NZ,00102$
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#1
	sub	a,(hl)
	jp	NZ,00102$
	ldhl	sp,#6
	ld	a,(hl)
	ldhl	sp,#2
	sub	a,(hl)
	jp	NZ,00102$
	ldhl	sp,#7
	ld	a,(hl)
	ldhl	sp,#3
	sub	a,(hl)
	jp	Z,00110$
00109$:
	jr	00102$
00110$:
;../_fsneq.c:88: return (0);
	ld	e,#0x00
	jp	00105$
00102$:
;../_fsneq.c:89: if (((fl1.l | fl2.l) & 0x7FFFFFFF) == 0)
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
	ldhl	sp,#8
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
	ldhl	sp,#0
	ld	a,(hl)
	or	a,a
	jp	NZ,00104$
	inc	hl
	ld	a,(hl)
	or	a,a
	jp	NZ,00104$
	inc	hl
	ld	a,(hl)
	or	a,a
	jp	NZ,00104$
	inc	hl
	ld	a,(hl)
	and	a,#0x7F
	jp	Z,00112$
00111$:
	jr	00104$
00112$:
;../_fsneq.c:90: return (0);
	ld	e,#0x00
	jr	00105$
00104$:
;../_fsneq.c:91: return (1);
	ld	e,#0x01
00105$:
	lda	sp,16(sp)
	ret
___fsneq_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS