;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module asinf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _asinf
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
;../asinf.c:36: float asinf(const float x) _FLOAT_FUNC_REENTRANT
;	---------------------------------
; Function asinf
; ---------------------------------
_asinf_start::
_asinf:
	push	ix
	ld	ix,#0
	add	ix,sp
;../asinf.c:38: if (x == 1.0) return  HALF_PI;
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fseq
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00108$
	ld	hl,#0x0FDB
	ld	de,#0x3FC9
	jr	00110$
00108$:
;../asinf.c:39: else if (x ==-1.0) return -HALF_PI;
	ld	hl,#0xBF80
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fseq
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00105$
	ld	hl,#0x0FDB
	ld	de,#0xBFC9
	jr	00110$
00105$:
;../asinf.c:40: else if (x == 0.0) return 0.0;
	ld	a,4 (ix)
	or	a,5 (ix)
	or	a,6 (ix)
	or	a,7 (ix)
	jr	NZ,00102$
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jr	00110$
00102$:
;../asinf.c:41: else               return asincosf(x, false);
	ld	a,#0x00
	push	af
	inc	sp
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_asincosf
	pop	af
	pop	af
	inc	sp
00110$:
	pop	ix
	ret
_asinf_end::
	.area _CODE
	.area _CABS
