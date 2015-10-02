;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _atol
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atol
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
;../_atol.c:29: long atol(char * s)
;	---------------------------------
; Function atol
; ---------------------------------
_atol_start::
_atol:
	lda	sp,-17(sp)
;../_atol.c:31: register long rv=0; 
	xor	a,a
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
;../_atol.c:35: while (*s) {
	ldhl	sp,#20
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
00107$:
	ld	a,(bc)
	ldhl	sp,#12
	ld	(hl),a
	or	a,a
	jp	Z,00133$
;../_atol.c:36: if (*s <= '9' && *s >= '0')
	ld	a, (hl)
	ld	e, a
	ld	a, #0x39
	ld	d, a
	ld	a,#0x39
	sub	a, (hl)
	bit	7, e
	jp	Z, 00135$
	bit	7, d
	jp	NZ, 00136$
	cp	a, a
	jr	00136$
00135$:
	bit	7, d
	jp	Z, 00136$
	scf
00136$:
	jp	C,00102$
	ld	a, #0x30
	ld	e, a
	ldhl	sp,#12
	ld	a, (hl)
	ld	d, a
	ld	a,(hl)
	sub	a, #0x30
	bit	7, e
	jp	Z, 00137$
	bit	7, d
	jp	NZ, 00138$
	cp	a, a
	jr	00138$
00137$:
	bit	7, d
	jp	Z, 00138$
	scf
00138$:
	jp	NC,00133$
;../_atol.c:37: break;
00102$:
;../_atol.c:38: if (*s == '-' || *s == '+') 
	ld	a,(bc)
	ldhl	sp,#12
	ld	(hl),a
	ld	a,(hl)
	sub	a,#0x2D
	jp	Z,00133$
00139$:
	ld	a,(hl)
	sub	a,#0x2B
	jp	Z,00133$
00140$:
;../_atol.c:40: s++;
	inc	bc
	jp	00107$
00133$:
	ldhl	sp,#19
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_atol.c:43: sign = (*s == '-');
	ldhl	sp,#10
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,(bc)
	ld	c,a
	sub	a,#0x2D
	jp	NZ,00141$
	ld	a,#0x01
	jr	00142$
00141$:
	xor	a,a
00142$:
	ld	b,a
	ldhl	sp,#12
	ld	(hl),b
;../_atol.c:44: if (*s == '-' || *s == '+') s++;
	xor	a,a
	or	a,b
	jp	NZ,00110$
	ld	a,c
	sub	a,#0x2B
	jp	Z,00144$
00143$:
	jr	00131$
00144$:
00110$:
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#19
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_atol.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
00115$:
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	or	a,a
	jp	Z,00117$
	ld	a, #0x30
	ld	e, a
	ld	a, c
	ld	d, a
	ld	a,c
	sub	a, #0x30
	bit	7, e
	jp	Z, 00145$
	bit	7, d
	jp	NZ, 00146$
	cp	a, a
	jr	00146$
00145$:
	bit	7, d
	jp	Z, 00146$
	scf
00146$:
	jp	C,00117$
	ld	a, c
	ld	e, a
	ld	a, #0x39
	ld	d, a
	ld	a,#0x39
	sub	a, c
	bit	7, e
	jp	Z, 00147$
	bit	7, d
	jp	NZ, 00148$
	cp	a, a
	jr	00148$
00147$:
	bit	7, d
	jp	Z, 00148$
	scf
00148$:
	jp	C,00117$
;../_atol.c:47: rv = (rv * 10) + (*s - '0');
	push	bc
	ldhl	sp,#17
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#17
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x000A
	push	hl
	call	__mullong_rrx_s
	lda	sp,8(sp)
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
	ld	a,c
	rla	
	sbc	a,a
	ld	b,a
	ld	a,c
	add	a,#0xD0
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ld	(hl),a
	dec	hl
	ld	(hl),e
	dec	hl
	dec	hl
	ld	d,h
	ld	e,l
	ldhl	sp,#13
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
;../_atol.c:48: s++;
	ldhl	sp,#8
	inc	(hl)
	jp	NZ,00115$
	inc	hl
	inc	(hl)
00149$:
	jp	00115$
00117$:
;../_atol.c:51: return (sign ? -rv : rv);
	xor	a,a
	ldhl	sp,#12
	or	a,(hl)
	jp	Z,00120$
	ld	de,#0x0000
	ld	a,e
	inc	hl
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#3
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ld	de,#0x0000
	ldhl	sp,#17
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#3
	ld	(hl),a
	dec	hl
	ld	(hl),e
	jr	00121$
00120$:
	ldhl	sp,#13
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
00121$:
	ldhl	sp,#1
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
	lda	sp,17(sp)
	ret
_atol_end::
	.area _CODE
	.area _CABS