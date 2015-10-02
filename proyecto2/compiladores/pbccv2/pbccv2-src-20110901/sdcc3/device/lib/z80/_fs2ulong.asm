;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fs2ulong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2ulong
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
;../_fs2ulong.c:103: __fs2ulong (float a1)
;	---------------------------------
; Function __fs2ulong
; ---------------------------------
___fs2ulong_start::
___fs2ulong:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;../_fs2ulong.c:109: fl1.f = a1;
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
;../_fs2ulong.c:111: if (!fl1.l || SIGN(fl1.l))
	ld	hl,#0x0006
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	or	a,b
	or	a,e
	or	a,d
	jr	Z,00101$
	ld	hl,#0x0006+1+1+1
	add	hl,sp
	ld	a, (hl)
	rlca
	jr	NC,00102$
00101$:
;../_fs2ulong.c:112: return (0);
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00104$
00102$:
;../_fs2ulong.c:114: exp = EXP (fl1.l) - EXCESS - 24;
	ld	hl,#0x0006
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x17
	push	af
	inc	sp
	push	de
	push	bc
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	c,l
	ld	b,#0x00
	ld	de,#0x0000
	ld	a,c
	add	a,#0x6A
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	ld	a,e
	adc	a,#0xFF
	ld	a,d
	adc	a,#0xFF
	ld	-6 (ix),c
	ld	-5 (ix),b
;../_fs2ulong.c:115: l = MANT (fl1.l);
	ld	hl,#0x0006
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	a,e
	and	a,#0x7F
	ld	e,a
	ld	d,#0x00
	ld	-10 (ix),c
	ld	-9 (ix),b
	ld	a,e
	set	7, a
	ld	-8 (ix),a
	ld	-7 (ix),d
;../_fs2ulong.c:117: l >>= -exp;
	xor	a,a
	sbc	a,-6 (ix)
	ld	l,a
	ld	a,#0x00
	sbc	a,-5 (ix)
	ld	h,a
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	call	__rrslong_rrx_s
	pop	af
	pop	af
	pop	af
	ld	-10 (ix), l
	ld	-9 (ix), h
	ld	-8 (ix),e
	ld	-7 (ix),d
;../_fs2ulong.c:119: return l;
	ld	c,-10 (ix)
	ld	b,-9 (ix)
	ld	e,-8 (ix)
	ld	d,-7 (ix)
	ld	l,c
	ld	h,b
00104$:
	ld	sp,ix
	pop	ix
	ret
___fs2ulong_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
