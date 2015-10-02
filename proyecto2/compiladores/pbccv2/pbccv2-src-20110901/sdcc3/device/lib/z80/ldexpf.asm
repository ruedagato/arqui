;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module ldexpf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ldexpf
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
;../ldexpf.c:34: float ldexpf(const float x, const int pw2)
;	---------------------------------
; Function ldexpf
; ---------------------------------
_ldexpf_start::
_ldexpf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-18
	add	hl,sp
	ld	sp,hl
;../ldexpf.c:39: fl.f = x;
	ld	hl,#0x000E
	add	hl,sp
	ld	a,4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,5 (ix)
	ld	(hl),a
	inc	hl
	ld	a,6 (ix)
	ld	(hl),a
	inc	hl
	ld	a,7 (ix)
	ld	(hl),a
;../ldexpf.c:41: e=(fl.l >> 23) & 0x000000ff;
	ld	hl,#0x000E
	add	hl,sp
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	a,(hl)
	ld	-14 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-13 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-12 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-11 (ix),a
	ld	a,#0x17
	push	af
	inc	sp
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-8 (ix), l
	ld	-7 (ix),#0x00
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
;../ldexpf.c:42: e+=pw2;
	ld	c,8 (ix)
	ld	b,9 (ix)
	ld	a,9 (ix)
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,-8 (ix)
	add	a,c
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,b
	ld	-7 (ix),a
	ld	a,-6 (ix)
	adc	a,e
	ld	-6 (ix),a
	ld	a,-5 (ix)
	adc	a,d
	ld	-5 (ix),a
;../ldexpf.c:43: fl.l= ((e & 0xff) << 23) | (fl.l & 0x807fffff);
	ld	c,-8 (ix)
	ld	b,#0x00
	ld	de,#0x0000
	ld	a,#0x17
	push	af
	inc	sp
	push	de
	push	bc
	call	__rlslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-15 (ix),d
	ld	-16 (ix),e
	ld	-17 (ix),h
	ld	-18 (ix),l
	ld	c,-14 (ix)
	ld	b,-13 (ix)
	ld	a,-12 (ix)
	and	a,#0x7F
	ld	e,a
	ld	a,-11 (ix)
	and	a,#0x80
	ld	d,a
	ld	a,c
	or	a, -18 (ix)
	ld	c,a
	ld	a,b
	or	a, -17 (ix)
	ld	b,a
	ld	a,e
	or	a, -16 (ix)
	ld	e,a
	ld	a,d
	or	a, -15 (ix)
	ld	d,a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../ldexpf.c:45: return(fl.f);
	ld	hl,#0x000E
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
_ldexpf_end::
	.area _CODE
	.area _CABS
