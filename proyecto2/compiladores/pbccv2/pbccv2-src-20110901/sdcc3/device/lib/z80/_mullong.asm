;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _mullong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mullong
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
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
;../_mullong.c:703: _mullong (long a, long b)
;	---------------------------------
; Function _mullong
; ---------------------------------
__mullong_start::
__mullong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-23
	add	hl,sp
	ld	sp,hl
;../_mullong.c:707: t.i.hi = bcast(a)->b.b0 * bcast(b)->b.b2;           // A
	ld	hl,#0x0013
	add	hl,sp
	ld	-8 (ix),l
	ld	-7 (ix),h
	ld	a,-8 (ix)
	add	a,#0x02
	ld	-6 (ix),a
	ld	a,-7 (ix)
	adc	a,#0x00
	ld	-5 (ix),a
	ld	hl,#0x001B
	add	hl,sp
	ex	de,hl
	ld	a,(de)
	ld	-9 (ix),a
	ld	hl,#0x001F
	add	hl,sp
	ld	-11 (ix),l
	ld	-10 (ix),h
	inc	hl
	inc	hl
	ld	a,(hl)
	ld	-12 (ix),a
	push	de
	ld	e,-12 (ix)
	ld	h,-9 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00103$:
	add	hl,hl
	jr	NC,00104$
	add	hl,de
00104$:
	djnz	00103$
	pop	de
	ld	c,l
	ld	b,h
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_mullong.c:708: t.i.lo = bcast(a)->b.b0 * bcast(b)->b.b0;           // A
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
	push	de
	ld	e,-6 (ix)
	ld	h,-9 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00105$:
	add	hl,hl
	jr	NC,00106$
	add	hl,de
00106$:
	djnz	00105$
	pop	de
	ld	c,l
	ld	b,h
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_mullong.c:709: t.b.b3 += bcast(a)->b.b3 * bcast(b)->b.b0;          // G
	ld	hl,#0x0013
	add	hl,sp
	ld	a,l
	add	a,#0x03
	ld	-8 (ix),a
	ld	a,h
	adc	a,#0x00
	ld	-7 (ix),a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	b,(hl)
	ld	hl,#0x0003
	add	hl,de
	ld	-15 (ix),l
	ld	-14 (ix),h
	ld	l,(hl)
	ld	a, b
	push	de
	ld	e,-6 (ix)
	ld	h,l
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00107$:
	add	hl,hl
	jr	NC,00108$
	add	hl,de
00108$:
	djnz	00107$
	pop	de
	ld	c, l
	add	a,c
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),a
;../_mullong.c:710: t.b.b3 += bcast(a)->b.b2 * bcast(b)->b.b1;          // F
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-13 (ix),a
	ld	c,e
	ld	b,d
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	-16 (ix),a
	ld	c,-11 (ix)
	ld	b,-10 (ix)
	inc	bc
	ld	a,(bc)
	ld	-17 (ix),a
	push	de
	ld	e,-17 (ix)
	ld	h,-16 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00109$:
	add	hl,hl
	jr	NC,00110$
	add	hl,de
00110$:
	djnz	00109$
	pop	de
	ld	b,l
	ld	a,-13 (ix)
	add	a,b
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),a
;../_mullong.c:711: t.i.hi += bcast(a)->b.b2 * bcast(b)->b.b0;          // E <- b lost in .lst
	ld	hl,#0x0013
	add	hl,sp
	ld	a,l
	add	a,#0x02
	ld	-8 (ix),a
	ld	a,h
	adc	a,#0x00
	ld	-7 (ix),a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	push	de
	ld	e,-6 (ix)
	ld	h,-16 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00111$:
	add	hl,hl
	jr	NC,00112$
	add	hl,de
00112$:
	djnz	00111$
	pop	de
	ld	c,l
	ld	b,h
	ld	a,-19 (ix)
	add	a,c
	ld	c,a
	ld	a,-18 (ix)
	adc	a,b
	ld	b,a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_mullong.c:713: t.i.hi += bcast(a)->b.b1 * bcast(b)->b.b1;          // D <- b lost in .lst
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	ld	c,e
	ld	b,d
	inc	bc
	ld	a,(bc)
	ld	-16 (ix),a
	push	de
	ld	e,-17 (ix)
	ld	h,-16 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00113$:
	add	hl,hl
	jr	NC,00114$
	add	hl,de
00114$:
	djnz	00113$
	pop	de
	ld	c,l
	ld	b,h
	ld	a,-19 (ix)
	add	a,c
	ld	c,a
	ld	a,-18 (ix)
	adc	a,b
	ld	b,a
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_mullong.c:715: bcast(a)->bi.b3 = bcast(a)->b.b1 * bcast(b)->b.b2;  // C
	push	de
	ld	e,-12 (ix)
	ld	h,-16 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00115$:
	add	hl,hl
	jr	NC,00116$
	add	hl,de
00116$:
	djnz	00115$
	pop	de
	ld	c,l
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	ld	(hl),c
;../_mullong.c:716: bcast(a)->bi.i12 = bcast(a)->b.b1 * bcast(b)->b.b0; // C
	ld	hl,#0x0001
	add	hl,de
	ld	-19 (ix),l
	ld	-18 (ix),h
	ld	c,e
	ld	b,d
	inc	bc
	ld	a,(bc)
	ld	l,a
	push	de
	ld	e,-6 (ix)
	ld	h,l
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00117$:
	add	hl,hl
	jr	NC,00118$
	add	hl,de
00118$:
	djnz	00117$
	pop	de
	ld	c,l
	ld	b,h
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_mullong.c:718: bcast(b)->bi.b3 = bcast(a)->b.b0 * bcast(b)->b.b3;  // B
	ld	a,-11 (ix)
	add	a,#0x03
	ld	-19 (ix),a
	ld	a,-10 (ix)
	adc	a,#0x00
	ld	-18 (ix),a
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	ld	c,(hl)
	push	de
	ld	e,c
	ld	h,-9 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00119$:
	add	hl,hl
	jr	NC,00120$
	add	hl,de
00120$:
	djnz	00119$
	pop	de
	ld	c,l
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	ld	(hl),c
;../_mullong.c:719: bcast(b)->bi.i12 = bcast(a)->b.b0 * bcast(b)->b.b1; // B
	ld	a,-11 (ix)
	add	a,#0x01
	ld	-19 (ix),a
	ld	a,-10 (ix)
	adc	a,#0x00
	ld	-18 (ix),a
	ld	c,-11 (ix)
	ld	b,-10 (ix)
	inc	bc
	ld	a,(bc)
	ld	c,a
	push	de
	ld	e,c
	ld	h,-9 (ix)
	ld	l,#0x00
	ld	d,l
	ld	b,#0x08
00121$:
	add	hl,hl
	jr	NC,00122$
	add	hl,de
00122$:
	djnz	00121$
	pop	de
	ld	c,l
	ld	b,h
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_mullong.c:721: bcast(b)->bi.b0 = 0;                                // B
	ld	l,-11 (ix)
	ld	h,-10 (ix)
	ld	(hl),#0x00
;../_mullong.c:722: bcast(a)->bi.b0 = 0;                                // C
	ld	a,#0x00
	ld	(de),a
;../_mullong.c:723: t.l += a;
	ld	hl,#0x0013
	add	hl,sp
	ld	-19 (ix),l
	ld	-18 (ix),h
	ld	a,(hl)
	ld	-23 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-22 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-21 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-20 (ix),a
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	a,-23 (ix)
	add	a,c
	ld	c,a
	ld	a,-22 (ix)
	adc	a,b
	ld	b,a
	ld	a,-21 (ix)
	adc	a,e
	ld	e,a
	ld	a,-20 (ix)
	adc	a,d
	ld	d,a
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../_mullong.c:725: return t.l + b;
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	inc	hl
	inc	hl
	inc	hl
	ld	a,c
	add	a,8 (ix)
	ld	c,a
	ld	a,b
	adc	a,9 (ix)
	ld	b,a
	ld	a,e
	adc	a,10 (ix)
	ld	e,a
	ld	a,d
	adc	a,11 (ix)
	ld	d,a
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
__mullong_end::
	.area _CODE
	.area _CABS
