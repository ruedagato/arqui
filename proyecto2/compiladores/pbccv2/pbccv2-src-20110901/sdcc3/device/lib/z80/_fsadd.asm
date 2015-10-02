;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fsadd
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsadd
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
;../_fsadd.c:171: float __fsadd (float a1, float a2)
;	---------------------------------
; Function __fsadd
; ---------------------------------
___fsadd_start::
___fsadd:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-21
	add	hl,sp
	ld	sp,hl
;../_fsadd.c:179: pfl2 = (long _AUTOMEM *)&a2;
	ld	hl,#0x001D
	add	hl,sp
;../_fsadd.c:180: exp2 = EXP (*pfl2);
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-17 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-16 (ix),a
	ld	c,-19 (ix)
	ld	b,-18 (ix)
	ld	e,-17 (ix)
	ld	d,-16 (ix)
	ld	a,#0x17
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-14 (ix), l
	ld	-13 (ix), #0x00
;../_fsadd.c:181: mant2 = MANT (*pfl2) << 4;
	ld	e,-19 (ix)
	ld	d,-18 (ix)
	ld	a,-17 (ix)
	and	a,#0x7F
	ld	b, #0x00
	set	7, a
	ld	c,a
	ld	a,#0x04
	push	af
	inc	sp
	push	bc
	push	de
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
;../_fsadd.c:182: if (SIGN (*pfl2))
	ld	c,-19 (ix)
	ld	b,-18 (ix)
	ld	e,-17 (ix)
	ld	a, -16 (ix)
	rlca
	jr	NC,00102$
;../_fsadd.c:183: mant2 = -mant2;
	xor	a,a
	sbc	a,-8 (ix)
	ld	-8 (ix),a
	ld	a,#0x00
	sbc	a,-7 (ix)
	ld	-7 (ix),a
	ld	a,#0x00
	sbc	a,-6 (ix)
	ld	-6 (ix),a
	ld	a,#0x00
	sbc	a,-5 (ix)
	ld	-5 (ix),a
00102$:
;../_fsadd.c:185: if (!*pfl2)
	ld	a,-19 (ix)
	or	a,-18 (ix)
	or	a,-17 (ix)
	or	a,-16 (ix)
	jr	NZ,00104$
;../_fsadd.c:186: return (a1);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	jp	00137$
00104$:
;../_fsadd.c:188: pfl1 = (long _AUTOMEM *)&a1;
	ld	hl,#0x0019
	add	hl,sp
;../_fsadd.c:189: exp1 = EXP (*pfl1);
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-17 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-16 (ix),a
	ld	c,-19 (ix)
	ld	b,-18 (ix)
	ld	e,-17 (ix)
	ld	d,-16 (ix)
	ld	a,#0x17
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-21 (ix), l
	ld	-20 (ix), #0x00
;../_fsadd.c:190: mant1 = MANT (*pfl1) << 4;
	ld	e,-19 (ix)
	ld	d,-18 (ix)
	ld	a,-17 (ix)
	and	a,#0x7F
	ld	b, #0x00
	set	7, a
	ld	c,a
	ld	a,#0x04
	push	af
	inc	sp
	push	bc
	push	de
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../_fsadd.c:191: if (SIGN(*pfl1))
	ld	c,-19 (ix)
	ld	b,-18 (ix)
	ld	e,-17 (ix)
	ld	d,-16 (ix)
	ld	a,d
	rlca
	jr	NC,00108$
;../_fsadd.c:192: if (*pfl1 & 0x80000000)
	ld	a,-16 (ix)
	and	a,#0x80
	jr	Z,00108$
;../_fsadd.c:193: mant1 = -mant1;
	xor	a,a
	sbc	a,-4 (ix)
	ld	-4 (ix),a
	ld	a,#0x00
	sbc	a,-3 (ix)
	ld	-3 (ix),a
	ld	a,#0x00
	sbc	a,-2 (ix)
	ld	-2 (ix),a
	ld	a,#0x00
	sbc	a,-1 (ix)
	ld	-1 (ix),a
00108$:
;../_fsadd.c:195: if (!*pfl1)
	ld	a,-19 (ix)
	or	a,-18 (ix)
	or	a,-17 (ix)
	or	a,-16 (ix)
	jr	NZ,00110$
;../_fsadd.c:196: return (a2);
	ld	l,8 (ix)
	ld	h,9 (ix)
	ld	e,10 (ix)
	ld	d,11 (ix)
	jp	00137$
00110$:
;../_fsadd.c:198: expd = exp1 - exp2;
	ld	a,-21 (ix)
	sub	a,-14 (ix)
	ld	l,a
	ld	a,-20 (ix)
	sbc	a,-13 (ix)
	ld	h, a
	ld	c, l
	ld	b, a
;../_fsadd.c:199: if (expd > 25)
	ld	a,#0x19
	sub	a, c
	ld	a,#0x00
	sbc	a, b
	jp	PO, 00165$
	xor	a, #0x80
00165$:
	jp	P,00112$
;../_fsadd.c:200: return (a1);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	jp	00137$
00112$:
;../_fsadd.c:201: if (expd < -25)
	ld	a,c
	sub	a, #0xE7
	ld	a,b
	sbc	a, #0xFF
	jp	PO, 00166$
	xor	a, #0x80
00166$:
	jp	P,00114$
;../_fsadd.c:202: return (a2);
	ld	l,8 (ix)
	ld	h,9 (ix)
	ld	e,10 (ix)
	ld	d,11 (ix)
	jp	00137$
00114$:
;../_fsadd.c:204: if (expd < 0)
	bit	7,b
	jr	Z,00116$
;../_fsadd.c:206: expd = -expd;
	xor	a,a
	sbc	a,c
	ld	c,a
	ld	a,#0x00
	sbc	a,b
	ld	b,a
;../_fsadd.c:207: exp1 += expd;
	ld	a,-21 (ix)
	add	a,c
	ld	-21 (ix),a
	ld	a,-20 (ix)
	adc	a,b
	ld	-20 (ix),a
;../_fsadd.c:208: mant1 >>= expd;
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
	jr	00117$
00116$:
;../_fsadd.c:212: mant2 >>= expd;
	push	bc
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	pop	af
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
00117$:
;../_fsadd.c:214: mant1 += mant2;
	ld	a,-4 (ix)
	add	a,-8 (ix)
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a,-7 (ix)
	ld	-3 (ix),a
	ld	a,-2 (ix)
	adc	a,-6 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a,-5 (ix)
	ld	-1 (ix),a
;../_fsadd.c:216: sign = false;
	ld	-15 (ix),#0x00
;../_fsadd.c:218: if (mant1 < 0)
	bit	7,-1 (ix)
	jr	Z,00121$
;../_fsadd.c:220: mant1 = -mant1;
	xor	a,a
	sbc	a,-4 (ix)
	ld	-4 (ix),a
	ld	a,#0x00
	sbc	a,-3 (ix)
	ld	-3 (ix),a
	ld	a,#0x00
	sbc	a,-2 (ix)
	ld	-2 (ix),a
	ld	a,#0x00
	sbc	a,-1 (ix)
	ld	-1 (ix),a
;../_fsadd.c:221: sign = true;
	ld	-15 (ix),#0x01
	jr	00154$
00121$:
;../_fsadd.c:223: else if (!mant1)
	ld	a,-4 (ix)
	or	a,-3 (ix)
	or	a,-2 (ix)
	or	a,-1 (ix)
	jr	NZ,00154$
;../_fsadd.c:224: return (0);
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00137$
;../_fsadd.c:227: while (mant1 < (HIDDEN<<4)) {
00154$:
	ld	a,-21 (ix)
	ld	-19 (ix),a
	ld	a,-20 (ix)
	ld	-18 (ix),a
00123$:
	ld	b,-4 (ix)
	ld	c,-3 (ix)
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	ld	a,d
	sub	a, #0x08
	jr	NC,00157$
;../_fsadd.c:228: mant1 <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__rlslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../_fsadd.c:229: exp1--;
	ld	l,-19 (ix)
	ld	h,-18 (ix)
	dec	hl
	ld	-19 (ix),l
	ld	-18 (ix),h
	jr	00123$
;../_fsadd.c:233: while (mant1 & 0xf0000000) {
00157$:
	ld	a,-19 (ix)
	ld	-12 (ix),a
	ld	a,-18 (ix)
	ld	-11 (ix),a
00128$:
	ld	a,-1 (ix)
	and	a,#0xF0
	jr	Z,00163$
;../_fsadd.c:234: if (mant1&1)
	ld	a,-4 (ix)
	and	a,#0x01
	jr	Z,00127$
;../_fsadd.c:235: mant1 += 2;
	ld	a,-4 (ix)
	add	a,#0x02
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a,#0x00
	ld	-3 (ix),a
	ld	a,-2 (ix)
	adc	a,#0x00
	ld	-2 (ix),a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	-1 (ix),a
00127$:
;../_fsadd.c:236: mant1 >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,d
	ld	c,e
	ld	d,h
	ld	e,l
	ld	-4 (ix),e
	ld	-3 (ix),d
	ld	-2 (ix),c
	ld	-1 (ix),b
;../_fsadd.c:237: exp1++;
	inc	-12 (ix)
	jr	NZ,00128$
	inc	-11 (ix)
	jr	00128$
00163$:
	ld	a,-12 (ix)
	ld	-21 (ix),a
	ld	a,-11 (ix)
	ld	-20 (ix),a
;../_fsadd.c:241: mant1 &= ~(HIDDEN<<4);
	ld	a,-1 (ix)
	and	a,#0xF7
	ld	-1 (ix),a
;../_fsadd.c:244: if (exp1 >= 0x100)
	ld	a,-11 (ix)
	sub	a, #0x01
	jp	PO, 00170$
	xor	a, #0x80
00170$:
	jp	M,00135$
;../_fsadd.c:245: *pfl1 = (sign ? (SIGNBIT | __INFINITY) : __INFINITY);
	bit	0,-15 (ix)
	jr	Z,00139$
	ld	bc,#0x0000
	ld	de,#0xFF80
	jr	00140$
00139$:
	ld	bc,#0x0000
	ld	de,#0x7F80
00140$:
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jp	00136$
00135$:
;../_fsadd.c:246: else if (exp1 < 0)
	bit	7,-11 (ix)
	jr	Z,00132$
;../_fsadd.c:247: *pfl1 = 0;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	jp	00136$
00132$:
;../_fsadd.c:249: *pfl1 = PACK (sign ? SIGNBIT : 0 , exp1, mant1>>4);
	bit	0,-15 (ix)
	jr	Z,00141$
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x00
	ld	-17 (ix),#0x00
	ld	-16 (ix),#0x80
	jr	00142$
00141$:
	xor	a,a
	ld	-19 (ix),a
	ld	-18 (ix),a
	ld	-17 (ix),a
	ld	-16 (ix),a
00142$:
	ld	c,-21 (ix)
	ld	b,-20 (ix)
	ld	a,-20 (ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,#0x17
	push	af
	inc	sp
	push	de
	push	bc
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	c,l
	ld	a,-19 (ix)
	or	a, c
	ld	-19 (ix),a
	ld	a,-18 (ix)
	or	a, b
	ld	-18 (ix),a
	ld	a,-17 (ix)
	or	a, e
	ld	-17 (ix),a
	ld	a,-16 (ix)
	or	a, d
	ld	-16 (ix),a
	ld	a,#0x04
	push	af
	inc	sp
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	a, l
	or	a, -19 (ix)
	ld	c,a
	ld	a,b
	or	a, -18 (ix)
	ld	b,a
	ld	a,e
	or	a, -17 (ix)
	ld	e,a
	ld	a,d
	or	a, -16 (ix)
	ld	d,a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
00136$:
;../_fsadd.c:250: return (a1);
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
00137$:
	ld	sp,ix
	pop	ix
	ret
___fsadd_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
