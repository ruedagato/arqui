;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memmove
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
;../_memmove.c:39: void * memmove (
;	---------------------------------
; Function memmove
; ---------------------------------
_memmove_start::
_memmove:
	lda	sp,-12(sp)
;../_memmove.c:45: void * ret = dst;
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_memmove.c:49: if (((int)src < (int)dst) && ((((int)src)+acount) > (int)dst)) {
	ldhl	sp,#16
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ldhl	sp,#14
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#15
	ld	a,(hl)
	ldhl	sp,#5
	ld	(hl),a
	dec	hl
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00121$
	bit	7, d
	jp	NZ, 00122$
	cp	a, a
	jr	00122$
00121$:
	bit	7, d
	jp	Z, 00122$
	scf
00122$:
	jp	NC,00108$
	ldhl	sp,#18
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),d
	inc	hl
	inc	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ldhl	sp,#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	NC,00108$
;../_memmove.c:53: d = ((char *)dst)+acount-1;
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#18
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,de
	ld	c,l
	ld	b,h
	ld	de,#0x0001
	ld	a,c
	sub	a,e
	ld	e,a
	ld	a,b
	sbc	a,d
	ldhl	sp,#9
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_memmove.c:54: s = ((char *)src)+acount-1;
	ldhl	sp,#17
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,bc
	ld	c,l
	ld	b,h
	dec	bc
;../_memmove.c:55: while (acount--) {
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#18
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
00101$:
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	a,c
	or	a,b
	jp	Z,00109$
;../_memmove.c:56: *d-- = *s--;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	ld	(de),a
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jp	00101$
00108$:
;../_memmove.c:64: s = src;
	ldhl	sp,#17
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../_memmove.c:65: while (acount--) {
	ldhl	sp,#6
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#18
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00104$:
	ldhl	sp,#1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	a,c
	or	a,b
	jp	Z,00109$
;../_memmove.c:66: *d++ = *s++;
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	inc	(hl)
	jp	NZ,00123$
	inc	hl
	inc	(hl)
00123$:
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00104$
	inc	hl
	inc	(hl)
00124$:
	jr	00104$
00109$:
;../_memmove.c:70: return(ret);
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00111$:
	lda	sp,12(sp)
	ret
_memmove_end::
	.area _CODE
	.area _CABS
