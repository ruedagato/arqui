;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module ceilf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ceilf
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
;../ceilf.c:33: float ceilf(float x) _FLOAT_FUNC_REENTRANT
;	---------------------------------
; Function ceilf
; ---------------------------------
_ceilf_start::
_ceilf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;../ceilf.c:36: r=x;
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fs2slong
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
;../ceilf.c:37: if (r<0)
	ld	-1 (ix), d
	bit	7,d
	jr	Z,00102$
;../ceilf.c:38: return r;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___slong2fs
	pop	af
	pop	af
	ld	-5 (ix),d
	ld	-6 (ix),e
	ld	-7 (ix),h
	ld	-8 (ix), l
	ld	h,-7 (ix)
	ld	e,-6 (ix)
	ld	d,-5 (ix)
	jr	00104$
00102$:
;../ceilf.c:40: return (r+((r<x)?1:0));
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___slong2fs
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	push	de
	push	bc
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00106$
	ld	c,#0x01
	jr	00107$
00106$:
	ld	c,#0x00
00107$:
	ld	a,c
	rla	
	sbc	a,a
	ld	b,a
	ld	e,a
	ld	d,a
	ld	a,-4 (ix)
	add	a,c
	ld	c,a
	ld	a,-3 (ix)
	adc	a,b
	ld	b,a
	ld	a,-2 (ix)
	adc	a,e
	ld	e,a
	ld	a,-1 (ix)
	adc	a,d
	ld	h, a
	ld	l, e
	push	hl
	push	bc
	call	___slong2fs
	pop	af
	pop	af
00104$:
	ld	sp,ix
	pop	ix
	ret
_ceilf_end::
	.area _CODE
	.area _CABS
