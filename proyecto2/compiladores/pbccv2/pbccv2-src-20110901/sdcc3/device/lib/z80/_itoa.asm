;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _itoa
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __itoa
	.globl __uitoa
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
;../_itoa.c:40: void _uitoa(unsigned int value, char* string, unsigned char radix)
;	---------------------------------
; Function _uitoa
; ---------------------------------
__uitoa_start::
__uitoa:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;../_itoa.c:45: do {
	ld	-1 (ix),#0x00
00103$:
;../_itoa.c:46: string[index] = '0' + (value % radix);
	ld	a,6 (ix)
	add	a,-1 (ix)
	ld	e,a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	d,a
	ld	a,8 (ix)
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
	push	de
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	pop	de
	ld	l,c
	ld	a,l
	add	a,#0x30
	ld	c,a
	ld	(de),a
;../_itoa.c:47: if (string[index] > '9')
	ld	a,#0x39
	sub	a, c
	jp	PO, 00118$
	xor	a, #0x80
00118$:
	jp	P,00102$
;../_itoa.c:48: string[index] += 'A' - '9' - 1;
	ld	a,(de)
	add	a,#0x07
	ld	(de),a
00102$:
;../_itoa.c:49: value /= radix;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	ld	b,h
	ld	4 (ix), l
	ld	5 (ix),b
;../_itoa.c:50: ++index;
	inc	-1 (ix)
;../_itoa.c:51: } while (value != 0);
	ld	a,4 (ix)
	or	a,5 (ix)
	jr	NZ,00103$
;../_itoa.c:54: string[index--] = '\0';
	ld	a,-1 (ix)
	dec	a
	ld	c,a
	ld	a,6 (ix)
	add	a,-1 (ix)
	ld	e,a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	d,a
	ld	a,#0x00
	ld	(de),a
;../_itoa.c:57: while (index > i) {
	ld	-2 (ix),#0x00
00106$:
	ld	a,-2 (ix)
	sub	a, c
	jp	PO, 00119$
	xor	a, #0x80
00119$:
	jp	P,00109$
;../_itoa.c:58: char tmp = string[i];
	ld	a,6 (ix)
	add	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	-3 (ix),a
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	d, (hl)
;../_itoa.c:59: string[i] = string[index];
	ld	a,6 (ix)
	add	a,c
	ld	b,a
	ld	a,7 (ix)
	adc	a,#0x00
	ld	e, a
	ld	l, b
	ld	h, a
	ld	a,(hl)
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),a
;../_itoa.c:60: string[index] = tmp;
	ld	l,b
	ld	h,e
	ld	(hl),d
;../_itoa.c:61: ++i;
	inc	-2 (ix)
;../_itoa.c:62: --index;
	dec	c
	jr	00106$
00109$:
	ld	sp,ix
	pop	ix
	ret
__uitoa_end::
;../_itoa.c:66: void _itoa(int value, char* string, unsigned char radix)
;	---------------------------------
; Function _itoa
; ---------------------------------
__itoa_start::
__itoa:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_itoa.c:68: if (value < 0 && radix == 10) {
	bit	7,5 (ix)
	jr	Z,00102$
	ld	a,8 (ix)
	sub	a,#0x0A
	jr	NZ,00102$
;../_itoa.c:69: *string++ = '-';
	ld	l,6 (ix)
	ld	h,7 (ix)
	ld	(hl),#0x2D
	ld	a,l
	add	a,#0x01
	ld	6 (ix),a
	ld	a,h
	adc	a,#0x00
	ld	7 (ix),a
;../_itoa.c:70: value = -value;
	xor	a,a
	sbc	a,4 (ix)
	ld	4 (ix),a
	ld	a,#0x00
	sbc	a,5 (ix)
	ld	5 (ix),a
00102$:
;../_itoa.c:72: _uitoa(value, string, radix);
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	a,8 (ix)
	push	af
	inc	sp
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	call	__uitoa
	pop	af
	pop	af
	inc	sp
	pop	ix
	ret
__itoa_end::
	.area _CODE
	.area _CABS
