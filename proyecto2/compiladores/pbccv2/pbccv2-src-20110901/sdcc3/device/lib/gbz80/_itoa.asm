;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _itoa
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __itoa
	.globl __uitoa
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
;../_itoa.c:40: void _uitoa(unsigned int value, char* string, unsigned char radix)
;	---------------------------------
; Function _uitoa
; ---------------------------------
__uitoa_start::
__uitoa:
	lda	sp,-7(sp)
;../_itoa.c:45: do {
	ldhl	sp,#6
	ld	(hl),#0x00
00103$:
;../_itoa.c:46: string[index] = '0' + (value % radix);
	ldhl	sp,#12
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#6
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#13
	ld	a,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#11
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__moduint_rrx_s
	lda	sp,4(sp)
	ld	b,d
	ld	c,e
	ld	a,c
	add	a,#0x30
	ld	c,a
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	ld	(de),a
;../_itoa.c:47: if (string[index] > '9')
	ld	a, c
	ld	e, a
	ld	a, #0x39
	ld	d, a
	ld	a,#0x39
	sub	a, c
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
;../_itoa.c:48: string[index] += 'A' - '9' - 1;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	add	a,#0x07
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
00102$:
;../_itoa.c:49: value /= radix;
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#11
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__divuint_rrx_s
	lda	sp,4(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#9
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_itoa.c:50: ++index;
	ldhl	sp,#6
	inc	(hl)
;../_itoa.c:51: } while (value != 0);
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00103$
;../_itoa.c:54: string[index--] = '\0';
	ldhl	sp,#6
	ld	a,(hl)
	dec	a
	ldhl	sp,#0
	ld	(hl),a
	ldhl	sp,#12
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#6
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,#0x00
	ld	(bc),a
;../_itoa.c:57: while (index > i) {
	ldhl	sp,#5
	ld	(hl),#0x00
	push	hl
	ldhl	sp,#0
	ld	a,(hl)
	ld	(hl),a
	pop	hl
00106$:
	ldhl	sp,#0
	ld	a, (hl)
	ld	e, a
	ldhl	sp,#5
	ld	a, (hl)
	ld	d, a
	ld	a,(hl)
	ldhl	sp,#0
	sub	a, (hl)
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
	jp	NC,00109$
;../_itoa.c:58: char tmp = string[i];
	ldhl	sp,#12
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#5
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	inc	hl
	ld	(hl),a
;../_itoa.c:59: string[i] = string[index];
	ldhl	sp,#12
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#0
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
;../_itoa.c:60: string[index] = tmp;
	inc	hl
	ld	a,(hl)
	ld	(bc),a
;../_itoa.c:61: ++i;
	inc	hl
	inc	(hl)
;../_itoa.c:62: --index;
	ldhl	sp,#0
	dec	(hl)
	jp	00106$
00109$:
	lda	sp,7(sp)
	ret
__uitoa_end::
;../_itoa.c:66: void _itoa(int value, char* string, unsigned char radix)
;	---------------------------------
; Function _itoa
; ---------------------------------
__itoa_start::
__itoa:
	
;../_itoa.c:68: if (value < 0 && radix == 10) {
	ldhl	sp,#2
	ld	a, (hl)
	sub	a, #0x00
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
	ldhl	sp,#6
	ld	a,(hl)
	sub	a,#0x0A
	jp	Z,00111$
00110$:
	jr	00102$
00111$:
;../_itoa.c:69: *string++ = '-';
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
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_itoa.c:70: value = -value;
	xor	a,a
	ldhl	sp,#2
	ld	a,#0x00
	sbc	a,(hl)
	ld	(hl),a
	inc	hl
	ld	a,#0x00
	sbc	a,(hl)
	ld	(hl),a
00102$:
;../_itoa.c:72: _uitoa(value, string, radix);
	ldhl	sp,#3
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ldhl	sp,#6
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
	push	bc
	call	__uitoa
	lda	sp,5(sp)
00104$:
	
	ret
__itoa_end::
	.area _CODE
	.area _CABS
