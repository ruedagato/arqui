;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fs2schar
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2schar
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
;../_fs2schar.c:87: signed char __fs2schar (float f)
;	---------------------------------
; Function __fs2schar
; ---------------------------------
___fs2schar_start::
___fs2schar:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_fs2schar.c:89: signed long sl=__fs2slong(f);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fs2slong
	pop	af
	pop	af
	ld	b,h
	ld	c,l
;../_fs2schar.c:90: if (sl>=SCHAR_MAX)
	ld	a,c
	sub	a, #0x7F
	ld	a,b
	sbc	a, #0x00
	ld	a,e
	sbc	a, #0x00
	ld	a,d
	sbc	a, #0x00
	jp	PO, 00109$
	xor	a, #0x80
00109$:
	jp	M,00102$
;../_fs2schar.c:91: return SCHAR_MAX;
	ld	l,#0x7F
	jr	00105$
00102$:
;../_fs2schar.c:92: if (sl<=SCHAR_MIN)
	ld	a,#0x80
	sub	a, c
	ld	a,#0xFF
	sbc	a, b
	ld	a,#0xFF
	sbc	a, e
	ld	a,#0xFF
	sbc	a, d
	jp	PO, 00110$
	xor	a, #0x80
00110$:
	jp	M,00104$
;../_fs2schar.c:93: return -SCHAR_MIN;
	ld	l,#0x80
	jr	00105$
00104$:
;../_fs2schar.c:94: return sl;
	ld	l,c
00105$:
	pop	ix
	ret
___fs2schar_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
