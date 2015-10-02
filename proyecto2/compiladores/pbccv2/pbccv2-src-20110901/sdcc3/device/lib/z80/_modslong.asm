;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _modslong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modslong
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
;../_modslong.c:259: _modslong (long a, long b)
;	---------------------------------
; Function _modslong
; ---------------------------------
__modslong_start::
__modslong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;../_modslong.c:264: (b < 0 ? -b : b));
	bit	7,11 (ix)
	jr	Z,00106$
	xor	a,a
	sbc	a,8 (ix)
	ld	c,a
	ld	a,#0x00
	sbc	a,9 (ix)
	ld	b,a
	ld	a,#0x00
	sbc	a,10 (ix)
	ld	e,a
	ld	a,#0x00
	sbc	a,11 (ix)
	ld	d,a
	jr	00107$
00106$:
	ld	c,8 (ix)
	ld	b,9 (ix)
	ld	e,10 (ix)
	ld	d,11 (ix)
00107$:
;../_modslong.c:263: r = _modulong((a < 0 ? -a : a),
	ld	a,7 (ix)
	rlca
	and	a,#0x01
	ld	-5 (ix),a
	xor	a,a
	or	a,-5 (ix)
	jr	Z,00108$
	xor	a,a
	sbc	a,4 (ix)
	ld	-9 (ix),a
	ld	a,#0x00
	sbc	a,5 (ix)
	ld	-8 (ix),a
	ld	a,#0x00
	sbc	a,6 (ix)
	ld	-7 (ix),a
	ld	a,#0x00
	sbc	a,7 (ix)
	ld	-6 (ix),a
	jr	00109$
00108$:
	ld	a,4 (ix)
	ld	-9 (ix),a
	ld	a,5 (ix)
	ld	-8 (ix),a
	ld	a,6 (ix)
	ld	-7 (ix),a
	ld	a,7 (ix)
	ld	-6 (ix),a
00109$:
	push	de
	push	bc
	ld	l,-7 (ix)
	ld	h,-6 (ix)
	push	hl
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	push	hl
	call	__modulong
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../_modslong.c:265: if (a < 0)
	xor	a,a
	or	a,-5 (ix)
	jr	Z,00102$
;../_modslong.c:266: return -r;
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
	ld	l,c
	ld	h,b
	jr	00104$
00102$:
;../_modslong.c:268: return r;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	e,-2 (ix)
	ld	d,-1 (ix)
00104$:
	ld	sp,ix
	pop	ix
	ret
__modslong_end::
	.area _CODE
	.area _CABS
