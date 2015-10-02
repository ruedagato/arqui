;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _atoi
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atoi
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
;../_atoi.c:29: int atoi(const char * s)
;	---------------------------------
; Function atoi
; ---------------------------------
_atoi_start::
_atoi:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;../_atoi.c:31: register int rv=0; 
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
;../_atoi.c:35: while (*s) {
	ld	e,4 (ix)
	ld	d,5 (ix)
00107$:
	ld	a,(de)
	ld	l,a
	or	a,a
	jr	Z,00133$
;../_atoi.c:36: if (*s <= '9' && *s >= '0')
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
;../_atoi.c:37: break;
00102$:
;../_atoi.c:38: if (*s == '-' || *s == '+') 
	ld	a,(de)
	ld	l,a
	sub	a,#0x2D
	jr	Z,00133$
	ld	a,l
	sub	a,#0x2B
	jr	Z,00133$
;../_atoi.c:40: s++;
	inc	de
	jr	00107$
00133$:
	ld	4 (ix),e
	ld	5 (ix),d
;../_atoi.c:43: sign = (*s == '-');
	ld	c,e
	ld	b,d
	ld	a,(de)
	ld	l,a
	sub	a,#0x2D
	jr	NZ,00139$
	ld	a,#0x01
	jr	00140$
00139$:
	xor	a,a
00140$:
	ld	e,a
	ld	d,e
;../_atoi.c:44: if (*s == '-' || *s == '+') s++;
	xor	a,a
	or	a,e
	jr	NZ,00110$
	ld	a,l
	sub	a,#0x2B
	jr	NZ,00131$
00110$:
	ld	hl,#0x0001
	add	hl,bc
	ld	4 (ix),l
	ld	5 (ix),h
;../_atoi.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
00115$:
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	e,(hl)
	xor	a,a
	or	a,e
	jr	Z,00117$
	ld	a,e
	sub	a, #0x30
	jp	PO, 00143$
	xor	a, #0x80
00143$:
	jp	M,00117$
	ld	a,#0x39
	sub	a, e
	jp	PO, 00144$
	xor	a, #0x80
00144$:
	jp	M,00117$
;../_atoi.c:47: rv = (rv * 10) + (*s - '0');
	push	de
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	ld	l,e
	ld	h,d
	add	hl,hl
	add	hl,hl
	add	hl,de
	add	hl,hl
	pop	de
	ld	c,l
	ld	b,h
	ld	a,e
	ld	l,a
	rla	
	sbc	a,a
	ld	h,a
	ld	a,l
	add	a,#0xD0
	ld	l,a
	ld	a,h
	adc	a,#0xFF
	ld	h,a
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	-2 (ix),c
	ld	-1 (ix),b
;../_atoi.c:48: s++;
	inc	-4 (ix)
	jr	NZ,00115$
	inc	-3 (ix)
	jr	00115$
00117$:
;../_atoi.c:51: return (sign ? -rv : rv);
	xor	a,a
	or	a,d
	jr	Z,00120$
	xor	a,a
	sbc	a,-2 (ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,-1 (ix)
	ld	b,a
	jr	00121$
00120$:
	ld	c,-2 (ix)
	ld	b,-1 (ix)
00121$:
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
_atoi_end::
	.area _CODE
	.area _CABS
