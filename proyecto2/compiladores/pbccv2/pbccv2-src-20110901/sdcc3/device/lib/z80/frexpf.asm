;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module frexpf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _frexpf
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
;../frexpf.c:34: float frexpf(const float x, int *pw2)
;	---------------------------------
; Function frexpf
; ---------------------------------
_frexpf_start::
_frexpf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;../frexpf.c:39: fl.f=x;
	ld	hl,#0x0006
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
;../frexpf.c:41: i  = ( fl.l >> 23) & 0x000000ff;
	ld	hl,#0x0006
	add	hl,sp
	ld	-6 (ix),l
	ld	-5 (ix),h
	ld	a,(hl)
	ld	-10 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-9 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-8 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-7 (ix),a
	ld	a,#0x17
	push	af
	inc	sp
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	c,l
	ld	b,#0x00
	ld	de,#0x0000
;../frexpf.c:42: i -= 0x7e;
	ld	a,c
	add	a,#0x82
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	ld	a,e
	adc	a,#0xFF
	ld	a,d
	adc	a,#0xFF
;../frexpf.c:43: *pw2 = i;
	ld	l,8 (ix)
	ld	h,9 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../frexpf.c:44: fl.l &= 0x807fffff; /* strip all exponent bits */
	ld	c,-10 (ix)
	ld	b,-9 (ix)
	ld	a,-8 (ix)
	and	a,#0x7F
	ld	e,a
	ld	a,-7 (ix)
	and	a,#0x80
	ld	d,a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../frexpf.c:45: fl.l |= 0x3f000000; /* mantissa between 0.5 and 1 */
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	a, (hl)
	or	a, #0x3F
	ld	d,a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../frexpf.c:46: return(fl.f);
	ld	hl,#0x0006
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
_frexpf_end::
	.area _CODE
	.area _CABS
