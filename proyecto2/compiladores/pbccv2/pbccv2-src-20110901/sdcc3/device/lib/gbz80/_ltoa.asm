;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _ltoa
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __ltoa
	.globl __ultoa
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
;../_ltoa.c:56: void _ultoa(unsigned long value, char* string, unsigned char radix)
;	---------------------------------
; Function _ultoa
; ---------------------------------
__ultoa_start::
__ultoa:
	lda	sp,-44(sp)
;../_ltoa.c:61: do {
	ldhl	sp,#12
	ld	a,l
	ld	d,h
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),d
	inc	hl
	inc	hl
	ld	(hl),#0x20
00103$:
;../_ltoa.c:62: unsigned char c = '0' + (value % radix);
	ldhl	sp,#52
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#52
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#52
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modulong_rrx_s
	lda	sp,8(sp)
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
	ld	c,(hl)
	ld	a,c
	add	a,#0x30
	ldhl	sp,#10
	ld	(hl),a
;../_ltoa.c:63: if (c > (unsigned char)'9')
	ld	a,#0x39
	sub	a, (hl)
	jp	NC,00102$
;../_ltoa.c:64: c += 'A' - '9' - 1;
	ld	a,(hl)
	add	a,#0x07
	ld	(hl),a
00102$:
;../_ltoa.c:65: buffer[--index] = c;
	ldhl	sp,#11
	dec	(hl)
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	c,l
	ld	b,h
	ldhl	sp,#10
	ld	a,(hl)
	ld	(bc),a
;../_ltoa.c:66: value /= radix;
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#52
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#52
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__divulong_rrx_s
	lda	sp,8(sp)
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
	ldhl	sp,#46
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
;../_ltoa.c:67: } while (value);
	ldhl	sp,#46
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00103$
;../_ltoa.c:69: do {
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00106$:
;../_ltoa.c:70: *string++ = buffer[index];
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
	dec	hl
	inc	(hl)
	jp	NZ,00117$
	inc	hl
	inc	(hl)
00117$:
;../_ltoa.c:71: } while ( ++index != NUMBER_OF_DIGITS );
	ldhl	sp,#11
	inc	(hl)
	ld	a,(hl)
	sub	a,#0x20
	jp	Z,00119$
00118$:
	jr	00106$
00119$:
;../_ltoa.c:73: *string = 0;  /* string terminator */
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x00
	ld	(de),a
00109$:
	lda	sp,44(sp)
	ret
__ultoa_end::
;../_ltoa.c:76: void _ltoa(long value, char* string, unsigned char radix)
;	---------------------------------
; Function _ltoa
; ---------------------------------
__ltoa_start::
__ltoa:
	
;../_ltoa.c:78: if (value < 0 && radix == 10) {
	ldhl	sp,#2
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
	jp	Z, 00108$
	bit	7, d
	jp	NZ, 00109$
	cp	a, a
	jr	00109$
00108$:
	bit	7, d
	jp	Z, 00109$
	scf
00109$:
	jp	NC,00102$
	ldhl	sp,#8
	ld	a,(hl)
	sub	a,#0x0A
	jp	Z,00111$
00110$:
	jr	00102$
00111$:
;../_ltoa.c:79: *string++ = '-';
	dec	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x2D
	ld	(bc),a
	ld	hl,#0x0001
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_ltoa.c:80: value = -value;
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#2
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ld	de,#0x0000
	inc	hl
	inc	hl
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ld	(hl),a
	dec	hl
	ld	(hl),e
00102$:
;../_ltoa.c:82: _ultoa(value, string, radix);
	ldhl	sp,#8
	ld	a,(hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__ultoa
	lda	sp,7(sp)
00104$:
	
	ret
__ltoa_end::
	.area _CODE
	.area _CABS
