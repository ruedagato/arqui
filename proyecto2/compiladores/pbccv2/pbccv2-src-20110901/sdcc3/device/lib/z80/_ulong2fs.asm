;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _ulong2fs
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
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
;../_ulong2fs.c:83: float __ulong2fs (unsigned long a )
;	---------------------------------
; Function __ulong2fs
; ---------------------------------
___ulong2fs_start::
___ulong2fs:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;../_ulong2fs.c:88: if (!a)
	ld	a,4 (ix)
	or	a,5 (ix)
	or	a,6 (ix)
	or	a,7 (ix)
	jr	NZ,00115$
;../_ulong2fs.c:90: return 0.0;
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00111$
;../_ulong2fs.c:93: while (a & NORM) 
00115$:
	ld	-2 (ix),#0x96
	ld	-1 (ix),#0x00
00103$:
	ld	a,7 (ix)
	or	a,a
	jr	Z,00117$
;../_ulong2fs.c:96: a >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,d
	ld	c,e
	ld	4 (ix), l
	ld	5 (ix), h
	ld	6 (ix),c
	ld	7 (ix),b
;../_ulong2fs.c:97: exp++;
	inc	-2 (ix)
	jr	NZ,00103$
	inc	-1 (ix)
	jr	00103$
;../_ulong2fs.c:100: while (a < HIDDEN)
00117$:
00106$:
	ld	a,6 (ix)
	sub	a, #0x80
	ld	a,7 (ix)
	sbc	a, #0x00
	jr	NC,00120$
;../_ulong2fs.c:102: a <<= 1;
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
	ld	b,d
	ld	c,e
	ld	4 (ix), l
	ld	5 (ix), h
	ld	6 (ix),c
	ld	7 (ix),b
;../_ulong2fs.c:103: exp--;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	dec	hl
	ld	-2 (ix),l
	ld	-1 (ix),h
	jr	00106$
00120$:
	ld	a,-2 (ix)
	ld	-8 (ix),a
	ld	a,-1 (ix)
	ld	-7 (ix),a
;../_ulong2fs.c:107: if ((a&0x7fffff)==0x7fffff) {
	ld	e,4 (ix)
	ld	d,5 (ix)
	ld	a,6 (ix)
	and	a,#0x7F
	ld	c,a
	ld	b,#0x00
	ld	a,e
	inc	a
	jr	NZ,00110$
	ld	a,d
	inc	a
	jr	NZ,00110$
	ld	a,c
	sub	a,#0x7F
	jr	NZ,00110$
	ld	a,b
	or	a,a
	jr	NZ,00110$
;../_ulong2fs.c:108: a=0;
	xor	a,a
	ld	4 (ix),a
	ld	5 (ix),a
	ld	6 (ix),a
	ld	7 (ix),a
;../_ulong2fs.c:109: exp++;
	ld	a,-2 (ix)
	add	a,#0x01
	ld	-8 (ix),a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	-7 (ix),a
00110$:
;../_ulong2fs.c:113: a &= ~HIDDEN ;
	ld	a,6 (ix)
	and	a,#0x7F
	ld	6 (ix),a
;../_ulong2fs.c:115: fl.l = PACK(0,(unsigned long)exp, a);
	ld	hl,#0x0004
	add	hl,sp
	ld	-10 (ix),l
	ld	-9 (ix),h
	ld	e,-8 (ix)
	ld	d,-7 (ix)
	ld	a,-7 (ix)
	rla	
	sbc	a,a
	ld	c,a
	ld	b,a
	ld	a,#0x17
	push	af
	inc	sp
	push	bc
	push	de
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,h
	ld	a, l
	or	a, 4 (ix)
	ld	c,a
	ld	a,b
	or	a, 5 (ix)
	ld	b,a
	ld	a,e
	or	a, 6 (ix)
	ld	e,a
	ld	a,d
	or	a, 7 (ix)
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
;../_ulong2fs.c:117: return (fl.f);
	ld	hl,#0x0004
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
00111$:
	ld	sp,ix
	pop	ix
	ret
___ulong2fs_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
