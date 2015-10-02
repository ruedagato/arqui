;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module sincosf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincosf
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
;../sincosf.c:50: float sincosf(const float x, const BOOL iscos)
;	---------------------------------
; Function sincosf
; ---------------------------------
_sincosf_start::
_sincosf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-26
	add	hl,sp
	ld	sp,hl
;../sincosf.c:56: if(iscos)
	bit	0,8 (ix)
	jr	Z,00105$
;../sincosf.c:58: y=fabsf(x)+HALF_PI;
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
	ld	hl,#0x3FC9
	push	hl
	ld	hl,#0x0FDB
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../sincosf.c:59: sign=0;
	ld	-21 (ix),#0x00
	jr	00106$
00105$:
;../sincosf.c:63: if(x<0.0)
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
	ld	-22 (ix),l
	xor	a,a
	or	a,-22 (ix)
	jr	Z,00102$
;../sincosf.c:64: { y=-x; sign=1; }
	ld	a,7 (ix)
	xor	a,#0x80
	ld	d,a
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	e,6 (ix)
	ld	-4 (ix),c
	ld	-3 (ix),b
	ld	-2 (ix),e
	ld	-1 (ix),d
	ld	-21 (ix),#0x01
	jr	00106$
00102$:
;../sincosf.c:66: { y=x; sign=0; }
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	ld	a,6 (ix)
	ld	-2 (ix),a
	ld	a,7 (ix)
	ld	-1 (ix),a
	ld	-21 (ix),#0x00
00106$:
;../sincosf.c:69: if(y>YMAX)
	ld	hl,#0x4649
	push	hl
	ld	hl,#0x0C00
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00108$
;../sincosf.c:71: errno=ERANGE;
	ld	iy,#_errno
	ld	0 (iy),#0x22
	ld	1 (iy),#0x00
;../sincosf.c:72: return 0.0;
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00115$
00108$:
;../sincosf.c:76: N=((y*iPI)+0.5); /*y is positive*/
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	hl,#0x3EA2
	push	hl
	ld	hl,#0xF983
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0x3F00
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
	ld	b,h
	ld	c,l
	push	de
	push	bc
	call	___fs2sint
	pop	af
	pop	af
	ld	b,h
	ld	c,l
;../sincosf.c:79: if(N&1) sign=!sign;
	ld	a,c
	and	a,#0x01
	jr	Z,00110$
	ld	a,-21 (ix)
	xor	a,#0x01
	ld	-21 (ix),a
00110$:
;../sincosf.c:81: XN=N;
	push	bc
	call	___sint2fs
	pop	af
	ld	-20 (ix), l
	ld	-19 (ix), h
	ld	-18 (ix),e
	ld	-17 (ix),d
;../sincosf.c:83: if(iscos) XN-=0.5;
	bit	0,8 (ix)
	jr	Z,00112$
	ld	hl,#0x3F00
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
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
00112$:
;../sincosf.c:85: y=fabsf(x);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_fabsf
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../sincosf.c:86: r=(int)y;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fs2sint
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	bc
	call	___sint2fs
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../sincosf.c:87: g=y-r;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-16 (ix), l
	ld	-15 (ix), h
	ld	-14 (ix),e
	ld	-13 (ix),d
;../sincosf.c:88: f=((r-XN*C1)+g)-XN*C2;
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	hl,#0x4049
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
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
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
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	hl,#0x3A7D
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
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
;../sincosf.c:90: g=f*f;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-16 (ix), l
	ld	-15 (ix), h
	ld	-14 (ix),e
	ld	-13 (ix),d
;../sincosf.c:91: if(g>EPS2) //Used to be if(fabsf(f)>EPS)
	ld	hl,#0x337F
	push	hl
	ld	hl,#0xFFF3
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jp	Z,00114$
;../sincosf.c:93: r=(((r4*g+r3)*g+r2)*g+r1)*g;
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	hl,#0x362E
	push	hl
	ld	hl,#0x9C5B
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0xB94F
	push	hl
	ld	hl,#0xB222
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
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
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
	ld	hl,#0x3C08
	push	hl
	ld	hl,#0x873E
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
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
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
	ld	hl,#0xBE2A
	push	hl
	ld	hl,#0xAAA4
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
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	push	de
	push	bc
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../sincosf.c:94: f+=f*r;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
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
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
00114$:
;../sincosf.c:96: return (sign?-f:f);
	bit	0,-21 (ix)
	jr	Z,00117$
	ld	a,-5 (ix)
	xor	a,#0x80
	ld	d,a
	ld	c,-8 (ix)
	ld	b,-7 (ix)
	ld	e,-6 (ix)
	jr	00118$
00117$:
	ld	c,-8 (ix)
	ld	b,-7 (ix)
	ld	e,-6 (ix)
	ld	d,-5 (ix)
00118$:
	ld	l,c
	ld	h,b
00115$:
	ld	sp,ix
	pop	ix
	ret
_sincosf_end::
	.area _CODE
	.area _CABS
