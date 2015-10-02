;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _slong2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___slong2fs
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
;../_slong2fs.c:79: float __slong2fs (signed long sl) {
;	---------------------------------
; Function __slong2fs
; ---------------------------------
___slong2fs_start::
___slong2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_slong2fs.c:80: if (sl<0) 
	bit	7,7 (ix)
	jr	Z,00102$
;../_slong2fs.c:81: return -__ulong2fs(-sl);
	xor	a,a
	sbc	a,4 (ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,5 (ix)
	ld	b,a
	ld	a,#0x00
	sbc	a,6 (ix)
	ld	e,a
	ld	a,#0x00
	sbc	a,7 (ix)
	ld	h, a
	ld	l, e
	push	hl
	push	bc
	call	___ulong2fs
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	a,d
	xor	a,#0x80
	ld	d,a
	ld	l,c
	ld	h,b
	jr	00104$
00102$:
;../_slong2fs.c:83: return __ulong2fs(sl);
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	push	hl
	push	bc
	call	___ulong2fs
	pop	af
	pop	af
00104$:
	pop	ix
	ret
___slong2fs_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
