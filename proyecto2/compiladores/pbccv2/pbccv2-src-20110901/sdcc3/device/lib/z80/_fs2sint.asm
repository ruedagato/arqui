;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fs2sint
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2sint
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
;../_fs2sint.c:81: signed int __fs2sint (float f)
;	---------------------------------
; Function __fs2sint
; ---------------------------------
___fs2sint_start::
___fs2sint:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_fs2sint.c:83: signed long sl=__fs2slong(f);
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
;../_fs2sint.c:84: if (sl>=INT_MAX)
	ld	a,c
	sub	a, #0xFF
	ld	a,b
	sbc	a, #0x7F
	ld	a,e
	sbc	a, #0x00
	ld	a,d
	sbc	a, #0x00
	jp	PO, 00109$
	xor	a, #0x80
00109$:
	jp	M,00102$
;../_fs2sint.c:85: return INT_MAX;
	ld	hl,#0x7FFF
	jr	00105$
00102$:
;../_fs2sint.c:86: if (sl<=INT_MIN)
	ld	a,#0x00
	sub	a, c
	ld	a,#0x80
	sbc	a, b
	ld	a,#0xFF
	sbc	a, e
	ld	a,#0xFF
	sbc	a, d
	jp	PO, 00110$
	xor	a, #0x80
00110$:
	jp	M,00104$
;../_fs2sint.c:87: return -INT_MIN;
	ld	hl,#0xFFFF8000
	jr	00105$
00104$:
;../_fs2sint.c:88: return sl;
	ld	l,c
	ld	h,b
00105$:
	pop	ix
	ret
___fs2sint_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
