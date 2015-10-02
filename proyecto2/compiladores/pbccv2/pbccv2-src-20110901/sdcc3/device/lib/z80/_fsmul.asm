;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fsmul
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsmul
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
;../_fsmul.c:241: float __fsmul (float a1, float a2) {
;	---------------------------------
; Function __fsmul
; ---------------------------------
___fsmul_start::
___fsmul:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-22
	add	hl,sp
	ld	sp,hl
;../_fsmul.c:247: fl1.f = a1;
	ld	hl,#0x0012
	add	hl,sp
	ld	a,4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,5 (ix)
	ld	(hl),a
	inc	hl
	ld	a,6 (ix)
	ld	(hl),a
	inc	hl
	ld	a,7 (ix)
	ld	(hl),a
;../_fsmul.c:248: fl2.f = a2;
	ld	hl,#0x000E
	add	hl,sp
	ld	a,8 (ix)
	ld	(hl),a
	inc	hl
	ld	a,9 (ix)
	ld	(hl),a
	inc	hl
	ld	a,10 (ix)
	ld	(hl),a
	inc	hl
	ld	a,11 (ix)
	ld	(hl),a
;../_fsmul.c:250: if (!fl1.l || !fl2.l)
	ld	hl,#0x0012
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	or	a,b
	or	a,e
	or	a,d
	jr	Z,00101$
	ld	hl,#0x000E
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	or	a,b
	or	a,e
	or	a,d
	jr	NZ,00102$
00101$:
;../_fsmul.c:251: return (0);
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00113$
00102$:
;../_fsmul.c:254: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	ld	hl,#0x0012+1+1+1
	add	hl,sp
	ld	a, (hl)
	rlc	a
	and	a,#0x01
	ld	-16 (ix),a
	ld	hl,#0x000E+1+1+1
	add	hl,sp
	ld	a, (hl)
	rlc	a
	and	a,#0x01
	xor	a,-16 (ix)
	ld	-15 (ix),a
;../_fsmul.c:255: exp = EXP (fl1.l) - EXCESS;
	ld	hl,#0x0012
	add	hl,sp
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	ld	a,#0x17
	push	af
	inc	sp
	ld	l,d
	ld	h,c
	push	hl
	ld	l,b
	ld	h,e
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	c,l
	ld	b,#0x00
	ld	de,#0x0000
	ld	a,c
	add	a,#0x82
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	ld	a,e
	adc	a,#0xFF
	ld	a,d
	adc	a,#0xFF
	ld	-14 (ix),c
	ld	-13 (ix),b
;../_fsmul.c:256: exp += EXP (fl2.l);
	ld	hl,#0x000E
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x17
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-20 (ix), l
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
	ld	-17 (ix),#0x00
	ld	c,-14 (ix)
	ld	b,-13 (ix)
	ld	a,-13 (ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,c
	add	a,-20 (ix)
	ld	c,a
	ld	a,b
	adc	a,-19 (ix)
	ld	b,a
	ld	a,e
	adc	a,-18 (ix)
	ld	a,d
	adc	a,-17 (ix)
	ld	-14 (ix),c
	ld	-13 (ix),b
;../_fsmul.c:258: fl1.l = MANT (fl1.l);
	ld	hl,#0x0012
	add	hl,sp
	ld	-20 (ix),l
	ld	-19 (ix),h
	ld	hl,#0x0012
	add	hl,sp
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	a,c
	and	a,#0x7F
	ld	b, #0x00
	set	7, a
	ld	c,a
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_fsmul.c:259: fl2.l = MANT (fl2.l);
	ld	hl,#0x000E
	add	hl,sp
	ld	-20 (ix),l
	ld	-19 (ix),h
	ld	hl,#0x000E
	add	hl,sp
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	a,c
	and	a,#0x7F
	ld	b, #0x00
	set	7, a
	ld	c,a
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_fsmul.c:262: result = (fl1.l >> 8) * (fl2.l >> 8);
	ld	hl,#0x0012
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x08
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-17 (ix),d
	ld	-18 (ix),e
	ld	-19 (ix),h
	ld	-20 (ix),l
	ld	hl,#0x000E
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x08
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../_fsmul.c:263: result += ((fl1.l & (unsigned long) 0xFF) * (fl2.l >> 8)) >> 8;
	ld	hl,#0x0012
	add	hl,sp
	ld	c,(hl)
	inc	hl
	inc	hl
	inc	hl
	ld	-20 (ix),c
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
	ld	-17 (ix),#0x00
	ld	hl,#0x000E
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x08
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	a,#0x08
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	a,-12 (ix)
	add	a,c
	ld	-12 (ix),a
	ld	a,-11 (ix)
	adc	a,b
	ld	-11 (ix),a
	ld	a,-10 (ix)
	adc	a,e
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,d
	ld	-9 (ix),a
;../_fsmul.c:264: result += ((fl2.l & (unsigned long) 0xFF) * (fl1.l >> 8)) >> 8;
	ld	hl,#0x000E
	add	hl,sp
	ld	c,(hl)
	inc	hl
	inc	hl
	inc	hl
	ld	-20 (ix),c
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
	ld	-17 (ix),#0x00
	ld	hl,#0x0012
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x08
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	a,#0x08
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	a,-12 (ix)
	add	a,c
	ld	-12 (ix),a
	ld	a,-11 (ix)
	adc	a,b
	ld	-11 (ix),a
	ld	a,-10 (ix)
	adc	a,e
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,d
	ld	-9 (ix),a
;../_fsmul.c:267: result += 0x40;
	ld	a,-12 (ix)
	add	a,#0x40
	ld	-12 (ix),a
	ld	a,-11 (ix)
	adc	a,#0x00
	ld	-11 (ix),a
	ld	a,-10 (ix)
	adc	a,#0x00
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,#0x00
;../_fsmul.c:269: if (result & SIGNBIT)
	ld	-9 (ix), a
	and	a,#0x80
	jr	Z,00105$
;../_fsmul.c:272: result += 0x40;
	ld	a,-12 (ix)
	add	a,#0x40
	ld	-12 (ix),a
	ld	a,-11 (ix)
	adc	a,#0x00
	ld	-11 (ix),a
	ld	a,-10 (ix)
	adc	a,#0x00
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,#0x00
	ld	-9 (ix),a
;../_fsmul.c:273: result >>= 8;
	ld	a,#0x08
	push	af
	inc	sp
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	-12 (ix),c
	ld	-11 (ix),b
	ld	-10 (ix),e
	ld	-9 (ix),d
	jr	00106$
00105$:
;../_fsmul.c:277: result >>= 7;
	ld	a,#0x07
	push	af
	inc	sp
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	-12 (ix),c
	ld	-11 (ix),b
	ld	-10 (ix),e
	ld	-9 (ix),d
;../_fsmul.c:278: exp--;
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	dec	hl
	ld	-14 (ix),l
	ld	-13 (ix),h
00106$:
;../_fsmul.c:281: result &= ~HIDDEN;
	ld	a,-10 (ix)
	and	a,#0x7F
	ld	-10 (ix),a
;../_fsmul.c:284: if (exp >= 0x100)
	ld	a,-13 (ix)
	sub	a, #0x01
	jp	PO, 00126$
	xor	a, #0x80
00126$:
	jp	M,00111$
;../_fsmul.c:285: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	ld	hl,#0x0012
	add	hl,sp
	xor	a,a
	or	a,-15 (ix)
	jr	Z,00115$
	ld	bc,#0x0000
	ld	de,#0x8000
	jr	00116$
00115$:
	ld	bc,#0x0000
	ld	de,#0x0000
00116$:
	set	7, e
	ld	a,d
	or	a, #0x7F
	ld	d,a
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jp	00112$
00111$:
;../_fsmul.c:286: else if (exp < 0)
	bit	7,-13 (ix)
	jr	Z,00108$
;../_fsmul.c:287: fl1.l = 0;
	ld	hl,#0x0012
	add	hl,sp
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	jp	00112$
00108$:
;../_fsmul.c:289: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	ld	hl,#0x0012
	add	hl,sp
	ld	-22 (ix),l
	ld	-21 (ix),h
	xor	a,a
	or	a,-15 (ix)
	jr	Z,00117$
	ld	-20 (ix),#0x00
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
	ld	-17 (ix),#0x80
	jr	00118$
00117$:
	xor	a,a
	ld	-20 (ix),a
	ld	-19 (ix),a
	ld	-18 (ix),a
	ld	-17 (ix),a
00118$:
	ld	e,-14 (ix)
	ld	d,-13 (ix)
	ld	a,-13 (ix)
	rla	
	sbc	a,a
	ld	c,a
	ld	b,a
	ld	a,#0x17
	push	af
	inc	sp
	push	bc
	push	de
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	a, l
	or	a, -20 (ix)
	ld	c,a
	ld	a,b
	or	a, -19 (ix)
	ld	b,a
	ld	a,e
	or	a, -18 (ix)
	ld	e,a
	ld	a,d
	or	a, -17 (ix)
	ld	d,a
	ld	a,c
	or	a, -12 (ix)
	ld	c,a
	ld	a,b
	or	a, -11 (ix)
	ld	b,a
	ld	a,e
	or	a, -10 (ix)
	ld	e,a
	ld	a,d
	or	a, -9 (ix)
	ld	d,a
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
00112$:
;../_fsmul.c:290: return (fl1.f);
	ld	hl,#0x0012
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,c
	ld	h,b
00113$:
	ld	sp,ix
	pop	ix
	ret
___fsmul_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
