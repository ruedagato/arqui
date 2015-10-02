;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module asincosf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _asincosf
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_asincosf_a_1_1:
	.ds 8
_asincosf_b_1_1:
	.ds 8
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
;../asincosf.c:53: static const float a[2] = { 0.0, QUART_PI };
	ld	hl,#_asincosf_a_1_1
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ld	hl,#0x0004 + _asincosf_a_1_1
	ld	(hl),#0xDB
	inc	hl
	ld	(hl),#0x0F
	inc	hl
	ld	(hl),#0x49
	inc	hl
	ld	(hl),#0x3F
;../asincosf.c:54: static const float b[2] = { HALF_PI, QUART_PI };
	ld	hl,#_asincosf_b_1_1
	ld	(hl),#0xDB
	inc	hl
	ld	(hl),#0x0F
	inc	hl
	ld	(hl),#0xC9
	inc	hl
	ld	(hl),#0x3F
	ld	hl,#0x0004 + _asincosf_b_1_1
	ld	(hl),#0xDB
	inc	hl
	ld	(hl),#0x0F
	inc	hl
	ld	(hl),#0x49
	inc	hl
	ld	(hl),#0x3F
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../asincosf.c:47: float asincosf(const float x, const BOOL isacos)
;	---------------------------------
; Function asincosf
; ---------------------------------
_asincosf_start::
_asincosf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-20
	add	hl,sp
	ld	sp,hl
;../asincosf.c:51: BOOL quartPI = isacos;
	ld	b,8 (ix)
;../asincosf.c:56: y = fabsf(x);
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fabsf
	pop	af
	pop	af
	ld	-1 (ix),d
	ld	-2 (ix),e
	ld	-3 (ix),h
	ld	-4 (ix),l
	ld	hl,#0x3980
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c,l
	pop	af
	ld	b,a
	xor	a,a
	or	a,c
	jr	Z,00107$
;../asincosf.c:59: r = y;
	ld	a,-4 (ix)
	ld	-12 (ix),a
	ld	a,-3 (ix)
	ld	-11 (ix),a
	ld	a,-2 (ix)
	ld	-10 (ix),a
	ld	a,-1 (ix)
	ld	-9 (ix),a
	jp	00108$
00107$:
;../asincosf.c:63: if (y > 0.5)
	push	bc
	ld	hl,#0x3F00
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c,l
	pop	af
	ld	b,a
	xor	a,a
	or	a,c
	jp	Z,00104$
;../asincosf.c:65: quartPI = !isacos;
	ld	a,b
	xor	a,#0x01
	ld	b,a
;../asincosf.c:66: if (y > 1.0)
	push	bc
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c,l
	pop	af
	ld	b,a
	xor	a,a
	or	a,c
	jr	Z,00102$
;../asincosf.c:68: errno = EDOM;
	ld	iy,#_errno
	ld	0 (iy),#0x21
	ld	1 (iy),#0x00
;../asincosf.c:69: return 0.0;
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00117$
00102$:
;../asincosf.c:71: g = (0.5 - y) + 0.5;
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-5 (ix),d
	ld	-6 (ix),e
	ld	-7 (ix),h
	ld	-8 (ix),l
	ld	hl,#0xFFFFFFFF
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_ldexpf
	pop	af
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	pop	bc
	ld	a,-16 (ix)
	ld	-8 (ix),a
	ld	a,-15 (ix)
	ld	-7 (ix),a
	ld	a,-14 (ix)
	ld	-6 (ix),a
	ld	a,-13 (ix)
	ld	-5 (ix),a
;../asincosf.c:73: y = sqrtf(g);
	push	bc
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_sqrtf
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	pop	bc
	ld	a,-16 (ix)
	ld	-4 (ix),a
	ld	a,-15 (ix)
	ld	-3 (ix),a
	ld	a,-14 (ix)
	ld	-2 (ix),a
	ld	a,-13 (ix)
	ld	-1 (ix),a
;../asincosf.c:74: y = -(y + y);
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	pop	bc
	ld	a,-13 (ix)
	xor	a,#0x80
	ld	-13 (ix),a
	ld	a,-16 (ix)
	ld	-16 (ix),a
	ld	a,-15 (ix)
	ld	-15 (ix),a
	ld	a,-14 (ix)
	ld	-14 (ix),a
	ld	a,-16 (ix)
	ld	-4 (ix),a
	ld	a,-15 (ix)
	ld	-3 (ix),a
	ld	a,-14 (ix)
	ld	-2 (ix),a
	ld	a,-13 (ix)
	ld	-1 (ix),a
	jr	00105$
00104$:
;../asincosf.c:78: g = y * y;
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	pop	bc
	ld	a,-16 (ix)
	ld	-8 (ix),a
	ld	a,-15 (ix)
	ld	-7 (ix),a
	ld	a,-14 (ix)
	ld	-6 (ix),a
	ld	a,-13 (ix)
	ld	-5 (ix),a
00105$:
;../asincosf.c:80: r = y + y * ((P(g) * g) / Q(g));
	push	bc
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	hl,#0xBF01
	push	hl
	ld	hl,#0x2065
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	ld	hl,#0x3F6F
	push	hl
	ld	hl,#0x166B
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix),l
	ld	hl,#0xC0B1
	push	hl
	ld	hl,#0x8D0B
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	ld	hl,#0x40B3
	push	hl
	ld	hl,#0x50F0
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	pop	bc
	ld	a,-20 (ix)
	ld	-12 (ix),a
	ld	a,-19 (ix)
	ld	-11 (ix),a
	ld	a,-18 (ix)
	ld	-10 (ix),a
	ld	a,-17 (ix)
	ld	-9 (ix),a
00108$:
;../asincosf.c:82: i = quartPI;
;../asincosf.c:83: if (isacos)
	bit	0,8 (ix)
	jp	Z,00115$
;../asincosf.c:85: if (x < 0.0)
	push	bc
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	ld	c,l
	pop	af
	ld	b,a
	xor	a,a
	or	a,c
	jr	Z,00110$
;../asincosf.c:86: r = (b[i] + r) + b[i];
	ld	a,b
	add	a,a
	add	a,a
	add	a,#<(_asincosf_b_1_1)
	ld	l, a
	ld	a, #>(_asincosf_b_1_1)
	adc	a, #0x00
	ld	h, a
	ld	a,(hl)
	ld	-20 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-17 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
	jp	00116$
00110$:
;../asincosf.c:88: r = (a[i] - r) + a[i];
	ld	a,b
	add	a,a
	add	a,a
	add	a,#<(_asincosf_a_1_1)
	ld	l, a
	ld	a, #>(_asincosf_a_1_1)
	adc	a, #0x00
	ld	h, a
	ld	a,(hl)
	ld	-20 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-17 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
	jp	00116$
00115$:
;../asincosf.c:92: r = (a[i] + r) + a[i];
	ld	a,b
	add	a,a
	add	a,a
	add	a,#<(_asincosf_a_1_1)
	ld	l, a
	ld	a, #>(_asincosf_a_1_1)
	adc	a, #0x00
	ld	h, a
	ld	a,(hl)
	ld	-20 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-17 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../asincosf.c:93: if (x < 0.0)
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00116$
;../asincosf.c:94: r = -r;
	ld	a,-9 (ix)
	xor	a,#0x80
	ld	-9 (ix),a
00116$:
;../asincosf.c:96: return r;
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	e,-10 (ix)
	ld	d,-9 (ix)
00117$:
	ld	sp,ix
	pop	ix
	ret
_asincosf_end::
	.area _CODE
	.area _CABS
