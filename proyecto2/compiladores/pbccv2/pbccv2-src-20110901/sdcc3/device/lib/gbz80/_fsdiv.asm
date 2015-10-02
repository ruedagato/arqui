;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fsdiv
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsdiv
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
	lda	sp,-39(sp)
;../_fsdiv.c:283: fl1.f = a1;
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ldhl	sp,#41
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_fsdiv.c:284: fl2.f = a2;
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ldhl	sp,#45
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_fsdiv.c:287: exp = EXP (fl1.l) ;
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#8
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	a,#0x17
	push	af
	inc	sp
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
	call	__rrulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#10
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#9
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#8
	ld	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	ldhl	sp,#9
	ld	a,(hl)
	ldhl	sp,#14
	ld	(hl),a
;../_fsdiv.c:288: exp -= EXP (fl2.l);
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#8
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	a,#0x17
	push	af
	inc	sp
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
	call	__rrulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#10
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#9
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	inc	hl
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#14
	ld	a,(hl)
	ldhl	sp,#5
	ld	(hl),a
	ldhl	sp,#14
	ld	a,(hl)
	rla	
	sbc	a,a
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),a
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#8
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
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#12
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
	dec	hl
	dec	hl
	ld	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#14
	ld	(hl),a
;../_fsdiv.c:289: exp += EXCESS;
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x007E
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_fsdiv.c:292: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#8
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	ldhl	sp,#4
	xor	a,(hl)
	ldhl	sp,#12
	ld	(hl),a
;../_fsdiv.c:295: if (!fl2.l)
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00102$
;../_fsdiv.c:297: fl2.l = 0x7FC00000;
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0xC0
	ld	(de),a
	inc	de
	ld	a,#0x7F
	ld	(de),a
;../_fsdiv.c:298: return (fl2.f);
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
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
	jp	00118$
00102$:
;../_fsdiv.c:302: if (!fl1.l)
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00104$
;../_fsdiv.c:303: return (0);
	ld	de,#0x0000
	ld	hl,#0x0000
	jp	00118$
00104$:
;../_fsdiv.c:306: mant1 = MANT (fl1.l);
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	and	a,#0x7F
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#19
	ld	(hl),a
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#20
	ld	(hl),a
	ldhl	sp,#6
	ld	a,(hl)
	set	7, a
	ldhl	sp,#21
	ld	(hl),a
	ldhl	sp,#7
	ld	a,(hl)
	ldhl	sp,#22
	ld	(hl),a
;../_fsdiv.c:307: mant2 = MANT (fl2.l);
	ldhl	sp,#31
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	and	a,#0x7F
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#15
	ld	(hl),a
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#16
	ld	(hl),a
	ldhl	sp,#6
	ld	a,(hl)
	set	7, a
	ldhl	sp,#17
	ld	(hl),a
	ldhl	sp,#7
	ld	a,(hl)
	ldhl	sp,#18
	ld	(hl),a
;../_fsdiv.c:310: if (mant1 < mant2)
	inc	hl
	ld	d, h
	ld	e, l
	ldhl	sp,#15
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00134$
	bit	7, d
	jp	NZ, 00135$
	cp	a, a
	jr	00135$
00134$:
	bit	7, d
	jp	Z, 00135$
	scf
00135$:
	jp	NC,00106$
;../_fsdiv.c:312: mant1 <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlslong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#19
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
;../_fsdiv.c:313: exp--;
	ldhl	sp,#14
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
00106$:
;../_fsdiv.c:317: mask = 0x1000000;
	ldhl	sp,#23
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x01
;../_fsdiv.c:318: result = 0;
	xor	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
;../_fsdiv.c:319: while (mask)
00109$:
	ldhl	sp,#23
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00111$
;../_fsdiv.c:321: if (mant1 >= mant2)
	ldhl	sp,#19
	ld	d, h
	ld	e, l
	ldhl	sp,#15
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00136$
	bit	7, d
	jp	NZ, 00137$
	cp	a, a
	jr	00137$
00136$:
	bit	7, d
	jp	Z, 00137$
	scf
00137$:
	jp	C,00108$
;../_fsdiv.c:323: result |= mask;
	ldhl	sp,#27
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
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#23
	or	a, (hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#24
	or	a, (hl)
	ldhl	sp,#5
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#25
	or	a, (hl)
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#26
	or	a, (hl)
	ldhl	sp,#7
	ld	(hl),a
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#27
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
;../_fsdiv.c:324: mant1 -= mant2;
	ldhl	sp,#20
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#15
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#22
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#24
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#19
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#22
	ld	(hl),a
	dec	hl
	ld	(hl),e
00108$:
;../_fsdiv.c:326: mant1 <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlslong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#19
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
;../_fsdiv.c:327: mask >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#26
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#26
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rrulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#23
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
	jp	00109$
00111$:
;../_fsdiv.c:331: result += 1;
	ldhl	sp,#27
	inc	(hl)
	jp	NZ,00138$
	inc	hl
	inc	(hl)
	jp	NZ,00138$
	inc	hl
	inc	(hl)
	jp	NZ,00138$
	inc	hl
	inc	(hl)
00138$:
;../_fsdiv.c:334: exp++;
	ldhl	sp,#13
	inc	(hl)
	jp	NZ,00139$
	inc	hl
	inc	(hl)
00139$:
;../_fsdiv.c:335: result >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#30
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#30
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rrslong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#27
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
;../_fsdiv.c:337: result &= ~HIDDEN;
	ldhl	sp,#27
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
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#27
	ld	(hl),a
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#28
	ld	(hl),a
	ldhl	sp,#6
	ld	a,(hl)
	and	a,#0x7F
	ldhl	sp,#29
	ld	(hl),a
	ldhl	sp,#7
	ld	a,(hl)
	ldhl	sp,#30
	ld	(hl),a
;../_fsdiv.c:340: if (exp >= 0x100)
	ldhl	sp,#13
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x01
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00140$
	bit	7, d
	jp	NZ, 00141$
	cp	a, a
	jr	00141$
00140$:
	bit	7, d
	jp	Z, 00141$
	scf
00141$:
	jp	C,00116$
;../_fsdiv.c:341: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	xor	a,a
	ldhl	sp,#12
	or	a,(hl)
	jp	Z,00120$
	ldhl	sp,#4
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x80
	jr	00121$
00120$:
	xor	a,a
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
00121$:
	ldhl	sp,#6
	ld	a,(hl)
	set	7, a
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	or	a, #0x7F
	ld	(hl),a
	ld	e,c
	ld	d,b
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	jp	00117$
00116$:
;../_fsdiv.c:342: else if (exp < 0)
	ldhl	sp,#13
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00142$
	bit	7, d
	jp	NZ, 00143$
	cp	a, a
	jr	00143$
00142$:
	bit	7, d
	jp	Z, 00143$
	scf
00143$:
	jp	NC,00113$
;../_fsdiv.c:343: fl1.l = 0;
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
	jp	00117$
00113$:
;../_fsdiv.c:345: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	xor	a,a
	ldhl	sp,#12
	or	a,(hl)
	jp	Z,00122$
	ldhl	sp,#4
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x80
	jr	00123$
00122$:
	xor	a,a
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
00123$:
	ldhl	sp,#13
	ld	a,(hl)
	ldhl	sp,#0
	ld	(hl),a
	ldhl	sp,#14
	ld	a,(hl)
	ldhl	sp,#1
	ld	(hl),a
	ldhl	sp,#14
	ld	a,(hl)
	rla	
	sbc	a,a
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),a
	push	bc
	ld	a,#0x17
	push	af
	inc	sp
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#5
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlulong_rrx_s
	lda	sp,5(sp)
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
	ld	a,(hl)
	ldhl	sp,#4
	or	a, (hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#5
	or	a, (hl)
	ldhl	sp,#1
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#6
	or	a, (hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#7
	or	a, (hl)
	ldhl	sp,#3
	ld	(hl),a
	ldhl	sp,#27
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
	ldhl	sp,#0
	ld	a,(hl)
	ldhl	sp,#4
	or	a, (hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#5
	or	a, (hl)
	ldhl	sp,#1
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#6
	or	a, (hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#7
	or	a, (hl)
	ldhl	sp,#3
	ld	(hl),a
	ld	e,c
	ld	d,b
	ldhl	sp,#0
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
00117$:
;../_fsdiv.c:346: return (fl1.f);
	ldhl	sp,#35
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
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
00118$:
	lda	sp,39(sp)
	ret
___fsdiv_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
