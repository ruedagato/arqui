;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module cotf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cotf
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
;../cotf.c:37: float cotf(const float x) _FLOAT_FUNC_REENTRANT
;	---------------------------------
; Function cotf
; ---------------------------------
_cotf_start::
_cotf:
	push	ix
	ld	ix,#0
	add	ix,sp
;../cotf.c:41: y=fabsf(x);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fabsf
	pop	af
	pop	af
	ld	b,h
	ld	c,l
;../cotf.c:42: if (y<1.0E-30) //This one requires more thinking...
	ld	hl,#0x0DA2
	push	hl
	ld	hl,#0x4260
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
	jr	Z,00105$
;../cotf.c:44: errno = ERANGE;
	ld	iy,#_errno
	ld	0 (iy),#0x22
	ld	1 (iy),#0x00
;../cotf.c:45: if (x<0.0)
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00102$
;../cotf.c:46: return -HUGE_VALF;
	ld	hl,#0xFFFF
	ld	de,#0xFF7F
	jr	00106$
00102$:
;../cotf.c:48: return +HUGE_VALF;
	ld	hl,#0xFFFF
	ld	de,#0x7F7F
	jr	00106$
00105$:
;../cotf.c:50: return tancotf(x, 1);
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_tancotf
	pop	af
	pop	af
	inc	sp
00106$:
	pop	ix
	ret
_cotf_end::
	.area _CODE
	.area _CABS
