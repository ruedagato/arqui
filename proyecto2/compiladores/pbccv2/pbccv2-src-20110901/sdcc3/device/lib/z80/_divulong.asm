;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _divulong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divulong
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
;../_divulong.c:331: _divulong (unsigned long x, unsigned long y)
;	---------------------------------
; Function _divulong
; ---------------------------------
__divulong_start::
__divulong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;../_divulong.c:333: unsigned long reste = 0L;
	xor	a,a
	ld	-4 (ix),a
	ld	-3 (ix),a
	ld	-2 (ix),a
	ld	-1 (ix),a
;../_divulong.c:337: do
	ld	-5 (ix),#0x20
00105$:
;../_divulong.c:340: c = MSB_SET(x);
	ld	a,7 (ix)
	rlc	a
	and	a,#0x01
	ld	-6 (ix),a
;../_divulong.c:341: x <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	4 (ix), l
	ld	5 (ix), h
	ld	6 (ix),e
	ld	7 (ix),d
;../_divulong.c:342: reste <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../_divulong.c:343: if (c)
	bit	0,-6 (ix)
	jr	Z,00102$
;../_divulong.c:344: reste |= 1L;
	ld	a,-4 (ix)
	set	0, a
	ld	-4 (ix),a
00102$:
;../_divulong.c:346: if (reste >= y)
	ld	a,-4 (ix)
	sub	a, 8 (ix)
	ld	a,-3 (ix)
	sbc	a, 9 (ix)
	ld	a,-2 (ix)
	sbc	a, 10 (ix)
	ld	a,-1 (ix)
	sbc	a, 11 (ix)
	jr	C,00106$
;../_divulong.c:348: reste -= y;
	ld	a,-4 (ix)
	sub	a,8 (ix)
	ld	-4 (ix),a
	ld	a,-3 (ix)
	sbc	a,9 (ix)
	ld	-3 (ix),a
	ld	a,-2 (ix)
	sbc	a,10 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	sbc	a,11 (ix)
	ld	-1 (ix),a
;../_divulong.c:350: x |= 1L;
	ld	a,4 (ix)
	set	0, a
	ld	4 (ix),a
00106$:
;../_divulong.c:353: while (--count);
	dec	-5 (ix)
	jp	NZ,00105$
;../_divulong.c:354: return x;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	sp,ix
	pop	ix
	ret
__divulong_end::
	.area _CODE
	.area _CABS
