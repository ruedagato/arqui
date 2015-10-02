;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _fsadd
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsadd
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
	lda	sp,-26(sp)
;../_fsadd.c:179: pfl2 = (long _AUTOMEM *)&a2;
	ldhl	sp,#32
	ld	c,l
	ld	b,h
;../_fsadd.c:180: exp2 = EXP (*pfl2);
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
	ldhl	sp,#8
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
	ld	a,#0x17
	push	af
	inc	sp
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
	ldhl	sp,#5
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#12
	ld	(hl),a
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
;../_fsadd.c:181: mant2 = MANT (*pfl2) << 4;
	ldhl	sp,#8
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#9
	ld	a,(hl)
	ldhl	sp,#5
	ld	(hl),a
	ldhl	sp,#10
	ld	a,(hl)
	and	a,#0x7F
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	dec	hl
	ld	a,(hl)
	set	7, a
	ld	(hl),a
	ld	a,#0x04
	push	af
	inc	sp
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
	call	__rlulong_rrx_s
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
	ldhl	sp,#18
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
;../_fsadd.c:182: if (SIGN (*pfl2))
	ldhl	sp,#8
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
	ldhl	sp,#7
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	jp	Z,00102$
;../_fsadd.c:183: mant2 = -mant2;
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#18
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
;../_fsadd.c:185: if (!*pfl2)
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00104$
;../_fsadd.c:186: return (a1);
	ldhl	sp,#29
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	00137$
00104$:
;../_fsadd.c:188: pfl1 = (long _AUTOMEM *)&a1;
	ldhl	sp,#28
	ld	c,l
	ld	b,h
	ldhl	sp,#16
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_fsadd.c:189: exp1 = EXP (*pfl1);
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
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
	ld	d,h
	ld	e,l
	ldhl	sp,#8
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
	ld	a,#0x17
	push	af
	inc	sp
	ldhl	sp,#11
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
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ld	(hl),a
;../_fsadd.c:190: mant1 = MANT (*pfl1) << 4;
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#0
	ld	(hl),a
	ldhl	sp,#5
	ld	a,(hl)
	ldhl	sp,#1
	ld	(hl),a
	ldhl	sp,#6
	ld	a,(hl)
	and	a,#0x7F
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	dec	hl
	ld	a,(hl)
	set	7, a
	ld	(hl),a
	ld	a,#0x04
	push	af
	inc	sp
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#3
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlulong_rrx_s
	lda	sp,5(sp)
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
	ldhl	sp,#22
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
;../_fsadd.c:191: if (SIGN(*pfl1))
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#0
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
	ldhl	sp,#3
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	jp	Z,00108$
;../_fsadd.c:192: if (*pfl1 & 0x80000000)
	ldhl	sp,#7
	ld	a,(hl)
	and	a,#0x80
	jp	Z,00108$
00164$:
;../_fsadd.c:193: mant1 = -mant1;
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#22
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
00108$:
;../_fsadd.c:195: if (!*pfl1)
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00110$
;../_fsadd.c:196: return (a2);
	ldhl	sp,#33
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	00137$
00110$:
;../_fsadd.c:198: expd = exp1 - exp2;
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ld	b,a
	ld	c,e
;../_fsadd.c:199: if (expd > 25)
	ld	a, b
	ld	e, a
	ld	a, #0x00
	ld	d, a
	ld	a,#0x19
	sub	a, c
	ld	a,#0x00
	sbc	a, b
	bit	7, e
	jp	Z, 00165$
	bit	7, d
	jp	NZ, 00166$
	cp	a, a
	jr	00166$
00165$:
	bit	7, d
	jp	Z, 00166$
	scf
00166$:
	jp	NC,00112$
;../_fsadd.c:200: return (a1);
	ldhl	sp,#29
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	00137$
00112$:
;../_fsadd.c:201: if (expd < -25)
	ld	a, #0xFF
	ld	e, a
	ld	a, b
	ld	d, a
	ld	a,c
	sub	a, #0xE7
	ld	a,b
	sbc	a, #0xFF
	bit	7, e
	jp	Z, 00167$
	bit	7, d
	jp	NZ, 00168$
	cp	a, a
	jr	00168$
00167$:
	bit	7, d
	jp	Z, 00168$
	scf
00168$:
	jp	NC,00114$
;../_fsadd.c:202: return (a2);
	ldhl	sp,#33
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	00137$
00114$:
;../_fsadd.c:204: if (expd < 0)
	ld	a, #0x00
	ld	e, a
	ld	a, b
	ld	d, a
	ld	a,b
	bit	7,a
	jp	Z,00116$
;../_fsadd.c:206: expd = -expd;
	xor	a,a
	sbc	a,c
	ld	c,a
	ld	a,#0x00
	sbc	a,b
	ld	b,a
;../_fsadd.c:207: exp1 += expd;
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_fsadd.c:208: mant1 >>= expd;
	push	bc
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
	call	__rrslong_rrx_s
	lda	sp,6(sp)
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
	ldhl	sp,#22
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
	jp	00117$
00116$:
;../_fsadd.c:212: mant2 >>= expd;
	push	bc
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
	call	__rrslong_rrx_s
	lda	sp,6(sp)
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
	ldhl	sp,#18
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
00117$:
;../_fsadd.c:214: mant1 += mant2;
	ldhl	sp,#23
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#18
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#25
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#27
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#22
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#25
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../_fsadd.c:216: sign = false;
	ld	c,#0x00
;../_fsadd.c:218: if (mant1 < 0)
	dec	hl
	dec	hl
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
	jp	Z, 00169$
	bit	7, d
	jp	NZ, 00170$
	cp	a, a
	jr	00170$
00169$:
	bit	7, d
	jp	Z, 00170$
	scf
00170$:
	jp	NC,00121$
;../_fsadd.c:220: mant1 = -mant1;
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#22
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
;../_fsadd.c:221: sign = true;
	ld	c,#0x01
	jr	00154$
00121$:
;../_fsadd.c:223: else if (!mant1)
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00154$
;../_fsadd.c:224: return (0);
	ld	de,#0x0000
	ld	hl,#0x0000
	jp	00137$
;../_fsadd.c:227: while (mant1 < (HIDDEN<<4)) {
00154$:
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00123$:
	ldhl	sp,#22
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
	sbc	a, #0x08
	jp	NC,00157$
;../_fsadd.c:228: mant1 <<= 1;
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#27
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#27
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlslong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#8
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	bc
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#22
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
;../_fsadd.c:229: exp1--;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jp	00123$
;../_fsadd.c:233: while (mant1 & 0xf0000000) {
00157$:
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#14
	ld	(hl),a
	inc	hl
	ld	(hl),e
00128$:
	ldhl	sp,#25
	ld	a,(hl)
	and	a,#0xF0
	jp	Z,00163$
00171$:
;../_fsadd.c:234: if (mant1&1)
	ldhl	sp,#22
	ld	a,(hl)
	and	a,#0x01
	jp	Z,00127$
00172$:
;../_fsadd.c:235: mant1 += 2;
	ldhl	sp,#23
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	add	a,#0x02
	ld	e,a
	ld	a,d
	adc	a,#0x00
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#27
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	af
	ld	a,e
	adc	a,#0x00
	ld	e,a
	ld	a,d
	adc	a,#0x00
	ld	(hl),a
	dec	hl
	ld	(hl),e
00127$:
;../_fsadd.c:236: mant1 >>= 1;
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#27
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#27
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rrslong_rrx_s
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
	ld	d,h
	ld	e,l
	ldhl	sp,#22
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
;../_fsadd.c:237: exp1++;
	ldhl	sp,#14
	inc	(hl)
	jp	NZ,00128$
	inc	hl
	inc	(hl)
00173$:
	jp	00128$
00163$:
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_fsadd.c:241: mant1 &= ~(HIDDEN<<4);
	ldhl	sp,#25
	ld	a,(hl)
	and	a,#0xF7
	ld	(hl),a
;../_fsadd.c:244: if (exp1 >= 0x100)
	ldhl	sp,#14
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x01
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00174$
	bit	7, d
	jp	NZ, 00175$
	cp	a, a
	jr	00175$
00174$:
	bit	7, d
	jp	Z, 00175$
	scf
00175$:
	jp	C,00135$
;../_fsadd.c:245: *pfl1 = (sign ? (SIGNBIT | __INFINITY) : __INFINITY);
	bit	0,c
	jp	Z,00139$
	ldhl	sp,#0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x80
	inc	hl
	ld	(hl),#0xFF
	jr	00140$
00139$:
	ldhl	sp,#0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x80
	inc	hl
	ld	(hl),#0x7F
00140$:
	ldhl	sp,#17
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
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
	jp	00136$
00135$:
;../_fsadd.c:246: else if (exp1 < 0)
	ldhl	sp,#14
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00176$
	bit	7, d
	jp	NZ, 00177$
	cp	a, a
	jr	00177$
00176$:
	bit	7, d
	jp	Z, 00177$
	scf
00177$:
	jp	NC,00132$
;../_fsadd.c:247: *pfl1 = 0;
	ldhl	sp,#17
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
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
	jp	00136$
00132$:
;../_fsadd.c:249: *pfl1 = PACK (sign ? SIGNBIT : 0 , exp1, mant1>>4);
	bit	0,c
	jp	Z,00141$
	ldhl	sp,#0
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x80
	jr	00142$
00141$:
	xor	a,a
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
00142$:
	ldhl	sp,#8
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	ldhl	sp,#9
	ld	a,(hl)
	ldhl	sp,#5
	ld	(hl),a
	ldhl	sp,#9
	ld	a,(hl)
	rla	
	sbc	a,a
	ldhl	sp,#6
	ld	(hl),a
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
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlulong_rrx_s
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
	ld	a,#0x04
	push	af
	inc	sp
	ldhl	sp,#25
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#25
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
	ldhl	sp,#17
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
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
00136$:
;../_fsadd.c:250: return (a1);
	ldhl	sp,#29
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00137$:
	lda	sp,26(sp)
	ret
___fsadd_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
