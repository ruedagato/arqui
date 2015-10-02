;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module tancotf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tancotf
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
;../tancotf.c:53: float tancotf(const float x, const BOOL iscotan)
;	---------------------------------
; Function tancotf
; ---------------------------------
_tancotf_start::
_tancotf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-26
	add	hl,sp
	ld	sp,hl
;../tancotf.c:58: if (fabsf(x) > YMAX)
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
	ld	hl,#0x45C9
	push	hl
	ld	hl,#0x0800
	push	hl
	push	de
	push	bc
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00102$
;../tancotf.c:60: errno = ERANGE;
	ld	iy,#_errno
	ld	0 (iy),#0x22
	ld	1 (iy),#0x00
;../tancotf.c:61: return 0.0;
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00115$
00102$:
;../tancotf.c:65: n=(x*TWO_O_PI+(x>0.0?0.5:-0.5)); /*works for +-x*/
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	hl,#0x3F22
	push	hl
	ld	hl,#0xF983
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-23 (ix),d
	ld	-24 (ix),e
	ld	-25 (ix),h
	ld	-26 (ix),l
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
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00117$
	ld	bc,#0x0000
	ld	de,#0x3F00
	jr	00118$
00117$:
	ld	bc,#0x0000
	ld	de,#0xBF00
00118$:
	push	de
	push	bc
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	push	hl
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	de
	push	bc
	call	___fs2sint
	pop	af
	pop	af
;../tancotf.c:66: xn=n;
	ld	-22 (ix),l
	ld	-21 (ix),h
	push	hl
	call	___sint2fs
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../tancotf.c:68: xnum=(int)x;
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fs2sint
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	bc
	call	___sint2fs
	pop	af
	ld	-16 (ix), l
	ld	-15 (ix), h
	ld	-14 (ix),e
	ld	-13 (ix),d
;../tancotf.c:69: xden=x-xnum;
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-20 (ix), l
	ld	-19 (ix), h
	ld	-18 (ix),e
	ld	-17 (ix),d
;../tancotf.c:70: f=((xnum-xn*C1)+xden)-xn*C2;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	hl,#0x3FC9
	push	hl
	ld	hl,#0x0000
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-23 (ix),d
	ld	-24 (ix),e
	ld	-25 (ix),h
	ld	-26 (ix),l
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	hl,#0x39FD
	push	hl
	ld	hl,#0xAA22
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,-24 (ix)
	ld	h,-23 (ix)
	push	hl
	ld	l,-26 (ix)
	ld	h,-25 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../tancotf.c:72: if (fabsf(f) < EPS)
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_fabsf
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0x3980
	push	hl
	ld	hl,#0x0000
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
	jr	Z,00104$
;../tancotf.c:74: xnum = f;
	ld	a,-4 (ix)
	ld	-16 (ix),a
	ld	a,-3 (ix)
	ld	-15 (ix),a
	ld	a,-2 (ix)
	ld	-14 (ix),a
	ld	a,-1 (ix)
	ld	-13 (ix),a
;../tancotf.c:75: xden = 1.0;
	ld	-20 (ix),#0x00
	ld	-19 (ix),#0x00
	ld	-18 (ix),#0x80
	ld	-17 (ix),#0x3F
	jp	00105$
00104$:
;../tancotf.c:79: g = f*f;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
;../tancotf.c:80: xnum = P(f,g);
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	hl,#0xBDC4
	push	hl
	ld	hl,#0x33B8
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	push	de
	push	bc
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-16 (ix), l
	ld	-15 (ix), h
	ld	-14 (ix),e
	ld	-13 (ix),d
;../tancotf.c:81: xden = Q(g);
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	hl,#0x3C1F
	push	hl
	ld	hl,#0x3375
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0xBEDB
	push	hl
	ld	hl,#0xB7AF
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	push	de
	push	bc
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-20 (ix), l
	ld	-19 (ix), h
	ld	-18 (ix),e
	ld	-17 (ix),d
00105$:
;../tancotf.c:84: if(n&1)
	ld	a,-22 (ix)
	and	a,#0x01
	jr	Z,00113$
;../tancotf.c:87: if(iscotan) return (-xnum/xden);
	bit	0,8 (ix)
	jr	Z,00107$
	ld	a,-13 (ix)
	xor	a,#0x80
	ld	d,a
	ld	c,-16 (ix)
	ld	b,-15 (ix)
	ld	e,-14 (ix)
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	push	de
	push	bc
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
	jr	00115$
00107$:
;../tancotf.c:88: else return (-xden/xnum);
	ld	a,-17 (ix)
	xor	a,#0x80
	ld	d,a
	ld	c,-20 (ix)
	ld	b,-19 (ix)
	ld	e,-18 (ix)
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	push	de
	push	bc
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
	jr	00115$
00113$:
;../tancotf.c:92: if(iscotan) return (xden/xnum);
	bit	0,8 (ix)
	jr	Z,00110$
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
	jr	00115$
00110$:
;../tancotf.c:93: else return (xnum/xden);
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
00115$:
	ld	sp,ix
	pop	ix
	ret
_tancotf_end::
	.area _CODE
	.area _CABS
