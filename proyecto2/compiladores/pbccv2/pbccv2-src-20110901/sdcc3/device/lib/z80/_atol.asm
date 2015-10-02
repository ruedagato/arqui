;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _atol
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atol
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
;../_atol.c:29: long atol(char * s)
;	---------------------------------
; Function atol
; ---------------------------------
_atol_start::
_atol:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-11
	add	hl,sp
	ld	sp,hl
;../_atol.c:31: register long rv=0; 
	xor	a,a
	ld	-4 (ix),a
	ld	-3 (ix),a
	ld	-2 (ix),a
	ld	-1 (ix),a
;../_atol.c:35: while (*s) {
	ld	c,4 (ix)
	ld	b,5 (ix)
00107$:
	ld	a,(bc)
	ld	l,a
	or	a,a
	jr	Z,00133$
;../_atol.c:36: if (*s <= '9' && *s >= '0')
	ld	a,#0x39
	sub	a, l
	jp	PO, 00135$
	xor	a, #0x80
00135$:
	jp	M,00102$
	ld	a,l
	sub	a, #0x30
	jp	PO, 00136$
	xor	a, #0x80
00136$:
	jp	P,00133$
;../_atol.c:37: break;
00102$:
;../_atol.c:38: if (*s == '-' || *s == '+') 
	ld	a,(bc)
	ld	l,a
	sub	a,#0x2D
	jr	Z,00133$
	ld	a,l
	sub	a,#0x2B
	jr	Z,00133$
;../_atol.c:40: s++;
	inc	bc
	jr	00107$
00133$:
	ld	4 (ix),c
	ld	5 (ix),b
;../_atol.c:43: sign = (*s == '-');
	ld	e,c
	ld	d,b
	ld	a,(bc)
	ld	l,a
	sub	a,#0x2D
	jr	NZ,00139$
	ld	a,#0x01
	jr	00140$
00139$:
	xor	a,a
00140$:
	ld	c,a
	ld	-5 (ix),c
;../_atol.c:44: if (*s == '-' || *s == '+') s++;
	xor	a,a
	or	a,c
	jr	NZ,00110$
	ld	a,l
	sub	a,#0x2B
	jr	NZ,00131$
00110$:
	ld	hl,#0x0001
	add	hl,de
	ld	4 (ix),l
	ld	5 (ix),h
;../_atol.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	ld	a,4 (ix)
	ld	-7 (ix),a
	ld	a,5 (ix)
	ld	-6 (ix),a
00115$:
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	ld	c,(hl)
	xor	a,a
	or	a,c
	jr	Z,00117$
	ld	a,c
	sub	a, #0x30
	jp	PO, 00143$
	xor	a, #0x80
00143$:
	jp	M,00117$
	ld	a,#0x39
	sub	a, c
	jp	PO, 00144$
	xor	a, #0x80
00144$:
	jp	M,00117$
;../_atol.c:47: rv = (rv * 10) + (*s - '0');
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x000A
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-8 (ix),d
	ld	-9 (ix),e
	ld	-10 (ix),h
	ld	-11 (ix),l
	pop	bc
	ld	a,c
	ld	l,a
	rla	
	sbc	a,a
	ld	h,a
	ld	de, #0xFFD0
	add	hl, de
	ld	b, h
	ld	c, l
	ld	a,h
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,-11 (ix)
	add	a,c
	ld	c,a
	ld	a,-10 (ix)
	adc	a,b
	ld	b,a
	ld	a,-9 (ix)
	adc	a,e
	ld	e,a
	ld	a,-8 (ix)
	adc	a,d
	ld	d,a
	ld	-4 (ix),c
	ld	-3 (ix),b
	ld	-2 (ix),e
	ld	-1 (ix),d
;../_atol.c:48: s++;
	inc	-7 (ix)
	jp	NZ,00115$
	inc	-6 (ix)
	jp	00115$
00117$:
;../_atol.c:51: return (sign ? -rv : rv);
	xor	a,a
	or	a,-5 (ix)
	jr	Z,00120$
	xor	a,a
	sbc	a,-4 (ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,-3 (ix)
	ld	b,a
	ld	a,#0x00
	sbc	a,-2 (ix)
	ld	e,a
	ld	a,#0x00
	sbc	a,-1 (ix)
	ld	d,a
	jr	00121$
00120$:
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	ld	e,-2 (ix)
	ld	d,-1 (ix)
00121$:
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
_atol_end::
	.area _CODE
	.area _CABS
