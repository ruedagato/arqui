;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fsdiv
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsdiv
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
;../_fsdiv.c:274: float __fsdiv (float a1, float a2)
;	---------------------------------
; Function __fsdiv
; ---------------------------------
___fsdiv_start::
___fsdiv:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-33
	add	hl,sp
	ld	sp,hl
;../_fsdiv.c:283: fl1.f = a1;
	ld	hl,#0x001D
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
;../_fsdiv.c:284: fl2.f = a2;
	ld	hl,#0x0019
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
;../_fsdiv.c:287: exp = EXP (fl1.l) ;
	ld	hl,#0x001D
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
	ld	-26 (ix), l
	ld	-25 (ix), #0x00
;../_fsdiv.c:288: exp -= EXP (fl2.l);
	ld	hl,#0x0019
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
	ld	-31 (ix), l
	ld	-30 (ix),#0x00
	ld	-29 (ix),#0x00
	ld	-28 (ix),#0x00
	ld	c,-26 (ix)
	ld	b,-25 (ix)
	ld	a,-25 (ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,c
	sub	a,-31 (ix)
	ld	c,a
	ld	a,b
	sbc	a,-30 (ix)
	ld	b,a
	ld	a,e
	sbc	a,-29 (ix)
	ld	a,d
	sbc	a,-28 (ix)
	ld	-26 (ix),c
	ld	-25 (ix),b
;../_fsdiv.c:289: exp += EXCESS;
	ld	a,-26 (ix)
	add	a,#0x7E
	ld	-26 (ix),a
	ld	a,-25 (ix)
	adc	a,#0x00
	ld	-25 (ix),a
;../_fsdiv.c:292: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	ld	hl,#0x001D+1+1+1
	add	hl,sp
	ld	a, (hl)
	rlc	a
	and	a,#0x01
	ld	-31 (ix),a
	ld	hl,#0x0019+1+1+1
	add	hl,sp
	ld	a, (hl)
	rlc	a
	and	a,#0x01
	xor	a,-31 (ix)
	ld	-27 (ix),a
;../_fsdiv.c:295: if (!fl2.l)
	ld	hl,#0x0019
	add	hl,sp
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	ld	a,b
	or	a,e
	or	a,d
	or	a,c
	jr	NZ,00102$
;../_fsdiv.c:297: fl2.l = 0x7FC00000;
	ld	hl,#0x0019
	add	hl,sp
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0xC0
	inc	hl
	ld	(hl),#0x7F
;../_fsdiv.c:298: return (fl2.f);
	ld	hl,#0x0019
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
	jp	00118$
00102$:
;../_fsdiv.c:302: if (!fl1.l)
	ld	hl,#0x001D
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
	jr	NZ,00104$
;../_fsdiv.c:303: return (0);
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00118$
00104$:
;../_fsdiv.c:306: mant1 = MANT (fl1.l);
	ld	hl,#0x001D
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	a,e
	and	a,#0x7F
	ld	e,a
	ld	d,#0x00
	ld	-20 (ix),c
	ld	-19 (ix),b
	ld	a,e
	set	7, a
	ld	-18 (ix),a
	ld	-17 (ix),d
;../_fsdiv.c:307: mant2 = MANT (fl2.l);
	ld	hl,#0x0019
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	a,e
	and	a,#0x7F
	ld	e,a
	ld	d,#0x00
	ld	-24 (ix),c
	ld	-23 (ix),b
	ld	a,e
	set	7, a
	ld	-22 (ix),a
	ld	-21 (ix),d
;../_fsdiv.c:310: if (mant1 < mant2)
	ld	a,-20 (ix)
	sub	a, -24 (ix)
	ld	a,-19 (ix)
	sbc	a, -23 (ix)
	ld	a,-18 (ix)
	sbc	a, -22 (ix)
	ld	a,-17 (ix)
	sbc	a, -21 (ix)
	jp	PO, 00134$
	xor	a, #0x80
00134$:
	jp	P,00106$
;../_fsdiv.c:312: mant1 <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__rlslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	-20 (ix),c
	ld	-19 (ix),b
	ld	-18 (ix),e
	ld	-17 (ix),d
;../_fsdiv.c:313: exp--;
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	dec	hl
	ld	-26 (ix),l
	ld	-25 (ix),h
00106$:
;../_fsdiv.c:317: mask = 0x1000000;
	ld	-16 (ix),#0x00
	ld	-15 (ix),#0x00
	ld	-14 (ix),#0x00
	ld	-13 (ix),#0x01
;../_fsdiv.c:318: result = 0;
	xor	a,a
	ld	-12 (ix),a
	ld	-11 (ix),a
	ld	-10 (ix),a
	ld	-9 (ix),a
;../_fsdiv.c:319: while (mask)
00109$:
	ld	a,-16 (ix)
	or	a,-15 (ix)
	or	a,-14 (ix)
	or	a,-13 (ix)
	jp	Z,00111$
;../_fsdiv.c:321: if (mant1 >= mant2)
	ld	a,-20 (ix)
	sub	a, -24 (ix)
	ld	a,-19 (ix)
	sbc	a, -23 (ix)
	ld	a,-18 (ix)
	sbc	a, -22 (ix)
	ld	a,-17 (ix)
	sbc	a, -21 (ix)
	jp	PO, 00135$
	xor	a, #0x80
00135$:
	jp	M,00108$
;../_fsdiv.c:323: result |= mask;
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	a,c
	or	a, -16 (ix)
	ld	c,a
	ld	a,b
	or	a, -15 (ix)
	ld	b,a
	ld	a,e
	or	a, -14 (ix)
	ld	e,a
	ld	a,d
	or	a, -13 (ix)
	ld	d,a
	ld	-12 (ix),c
	ld	-11 (ix),b
	ld	-10 (ix),e
	ld	-9 (ix),d
;../_fsdiv.c:324: mant1 -= mant2;
	ld	a,-20 (ix)
	sub	a,-24 (ix)
	ld	-20 (ix),a
	ld	a,-19 (ix)
	sbc	a,-23 (ix)
	ld	-19 (ix),a
	ld	a,-18 (ix)
	sbc	a,-22 (ix)
	ld	-18 (ix),a
	ld	a,-17 (ix)
	sbc	a,-21 (ix)
	ld	-17 (ix),a
00108$:
;../_fsdiv.c:326: mant1 <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	__rlslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-20 (ix), l
	ld	-19 (ix), h
	ld	-18 (ix),e
	ld	-17 (ix),d
;../_fsdiv.c:327: mask >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	-16 (ix),c
	ld	-15 (ix),b
	ld	-14 (ix),e
	ld	-13 (ix),d
	jp	00109$
00111$:
;../_fsdiv.c:331: result += 1;
	inc	-12 (ix)
	jr	NZ,00136$
	inc	-11 (ix)
	jr	NZ,00136$
	inc	-10 (ix)
	jr	NZ,00136$
	inc	-9 (ix)
00136$:
;../_fsdiv.c:334: exp++;
	inc	-26 (ix)
	jr	NZ,00137$
	inc	-25 (ix)
00137$:
;../_fsdiv.c:335: result >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../_fsdiv.c:337: result &= ~HIDDEN;
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	-12 (ix),c
	ld	-11 (ix),b
	ld	a,e
	and	a,#0x7F
	ld	-10 (ix),a
	ld	-9 (ix),d
;../_fsdiv.c:340: if (exp >= 0x100)
	ld	a,-25 (ix)
	sub	a, #0x01
	jp	PO, 00138$
	xor	a, #0x80
00138$:
	jp	M,00116$
;../_fsdiv.c:341: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	ld	hl,#0x001D
	add	hl,sp
	xor	a,a
	or	a,-27 (ix)
	jr	Z,00120$
	ld	bc,#0x0000
	ld	de,#0x8000
	jr	00121$
00120$:
	ld	bc,#0x0000
	ld	de,#0x0000
00121$:
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
	jp	00117$
00116$:
;../_fsdiv.c:342: else if (exp < 0)
	bit	7,-25 (ix)
	jr	Z,00113$
;../_fsdiv.c:343: fl1.l = 0;
	ld	hl,#0x001D
	add	hl,sp
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	jp	00117$
00113$:
;../_fsdiv.c:345: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	ld	hl,#0x001D
	add	hl,sp
	ld	-33 (ix),l
	ld	-32 (ix),h
	xor	a,a
	or	a,-27 (ix)
	jr	Z,00122$
	ld	-31 (ix),#0x00
	ld	-30 (ix),#0x00
	ld	-29 (ix),#0x00
	ld	-28 (ix),#0x80
	jr	00123$
00122$:
	xor	a,a
	ld	-31 (ix),a
	ld	-30 (ix),a
	ld	-29 (ix),a
	ld	-28 (ix),a
00123$:
	ld	e,-26 (ix)
	ld	d,-25 (ix)
	ld	a,-25 (ix)
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
	ld	c,l
	ld	a,-31 (ix)
	or	a, c
	ld	-31 (ix),a
	ld	a,-30 (ix)
	or	a, b
	ld	-30 (ix),a
	ld	a,-29 (ix)
	or	a, e
	ld	-29 (ix),a
	ld	a,-28 (ix)
	or	a, d
	ld	-28 (ix),a
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	a,c
	or	a, -31 (ix)
	ld	c,a
	ld	a,b
	or	a, -30 (ix)
	ld	b,a
	ld	a,e
	or	a, -29 (ix)
	ld	e,a
	ld	a,d
	or	a, -28 (ix)
	ld	d,a
	ld	l,-33 (ix)
	ld	h,-32 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
00117$:
;../_fsdiv.c:346: return (fl1.f);
	ld	hl,#0x001D
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
00118$:
	ld	sp,ix
	pop	ix
	ret
___fsdiv_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
