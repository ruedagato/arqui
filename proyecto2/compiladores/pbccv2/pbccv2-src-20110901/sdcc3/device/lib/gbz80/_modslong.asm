;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _modslong
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modslong
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
;../_modslong.c:259: _modslong (long a, long b)
;	---------------------------------
; Function _modslong
; ---------------------------------
__modslong_start::
__modslong:
	lda	sp,-12(sp)
;../_modslong.c:264: (b < 0 ? -b : b));
	ldhl	sp,#18
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
	jp	Z, 00113$
	bit	7, d
	jp	NZ, 00114$
	cp	a, a
	jr	00114$
00113$:
	bit	7, d
	jp	Z, 00114$
	scf
00114$:
	jp	NC,00106$
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#18
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
	ld	de,#0x0000
	ldhl	sp,#22
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
	jr	00107$
00106$:
	ldhl	sp,#18
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
00107$:
;../_modslong.c:263: r = _modulong((a < 0 ? -a : a),
	ldhl	sp,#14
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
	jp	Z, 00115$
	bit	7, d
	jp	NZ, 00116$
	cp	a, a
	jr	00116$
00115$:
	bit	7, d
	jp	Z, 00116$
	scf
00116$:
	ld	a,#0x00
	rla
	ld	c,a
	or	a,a
	jp	Z,00108$
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#14
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
	ldhl	sp,#18
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
	jr	00109$
00108$:
	ldhl	sp,#14
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
00109$:
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
	call	__modulong
	lda	sp,8(sp)
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
	ldhl	sp,#8
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
;../_modslong.c:265: if (a < 0)
	xor	a,a
	or	a,c
	jp	Z,00102$
;../_modslong.c:266: return -r;
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#8
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
	ldhl	sp,#12
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
;../_modslong.c:268: return r;
	ldhl	sp,#9
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
	lda	sp,12(sp)
	ret
__modslong_end::
	.area _CODE
	.area _CABS
