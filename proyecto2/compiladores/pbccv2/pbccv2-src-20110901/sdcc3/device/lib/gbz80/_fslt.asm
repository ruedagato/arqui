;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fslt
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fslt
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
;../_fslt.c:108: char __fslt (float a1, float a2)
;	---------------------------------
; Function __fslt
; ---------------------------------
___fslt_start::
___fslt:
	lda	sp,-16(sp)
;../_fslt.c:112: fl1.f = a1;
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
;../_fslt.c:113: fl2.f = a2;
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
;../_fslt.c:115: if (fl1.l<0 && fl2.l<0) {
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
	ldhl	sp,#4
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
	jp	Z, 00114$
	bit	7, d
	jp	NZ, 00115$
	cp	a, a
	jr	00115$
00114$:
	bit	7, d
	jp	Z, 00115$
	scf
00115$:
	jp	NC,00104$
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
	ldhl	sp,#4
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
	jp	Z, 00116$
	bit	7, d
	jp	NZ, 00117$
	cp	a, a
	jr	00117$
00116$:
	bit	7, d
	jp	Z, 00117$
	scf
00117$:
	jp	NC,00104$
;../_fslt.c:116: if (fl2.l < fl1.l)
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
	inc	hl
	ld	d, h
	ld	e, l
	ldhl	sp,#0
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
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00118$
	bit	7, d
	jp	NZ, 00119$
	cp	a, a
	jr	00119$
00118$:
	bit	7, d
	jp	Z, 00119$
	scf
00119$:
	jp	NC,00102$
;../_fslt.c:117: return (1);
	ld	e,#0x01
	jp	00108$
00102$:
;../_fslt.c:118: return (0);
	ld	e,#0x00
	jp	00108$
00104$:
;../_fslt.c:121: if (fl1.l < fl2.l)
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
	ld	d, h
	ld	e, l
	ldhl	sp,#4
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
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00120$
	bit	7, d
	jp	NZ, 00121$
	cp	a, a
	jr	00121$
00120$:
	bit	7, d
	jp	Z, 00121$
	scf
00121$:
	jp	NC,00107$
;../_fslt.c:122: return (1);
	ld	e,#0x01
	jr	00108$
00107$:
;../_fslt.c:123: return (0);
	ld	e,#0x00
00108$:
	lda	sp,16(sp)
	ret
___fslt_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
