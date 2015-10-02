;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module expf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _expf
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
;../expf.c:332: float expf(const float x)
;	---------------------------------
; Function expf
; ---------------------------------
_expf_start::
_expf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-27
	add	hl,sp
	ld	sp,hl
;../expf.c:338: if(x>=0.0)
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
	jr	NZ,00102$
;../expf.c:339: { y=x;  sign=0; }
	ld	a,4 (ix)
	ld	-22 (ix),a
	ld	a,5 (ix)
	ld	-21 (ix),a
	ld	a,6 (ix)
	ld	-20 (ix),a
	ld	a,7 (ix)
	ld	-19 (ix),a
	ld	-23 (ix),#0x00
	jr	00103$
00102$:
;../expf.c:341: { y=-x; sign=1; }
	ld	a,7 (ix)
	xor	a,#0x80
	ld	d,a
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	e,6 (ix)
	ld	-22 (ix),c
	ld	-21 (ix),b
	ld	-20 (ix),e
	ld	-19 (ix),d
	ld	-23 (ix),#0x01
00103$:
;../expf.c:343: if(y<EXPEPS) return 1.0;
	ld	hl,#0x33D6
	push	hl
	ld	hl,#0xBF95
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00105$
	ld	hl,#0x0000
	ld	de,#0x3F80
	jp	00118$
00105$:
;../expf.c:345: if(y>BIGX)
	ld	hl,#0x42B1
	push	hl
	ld	hl,#0x7218
	push	hl
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00110$
;../expf.c:347: if(sign)
	bit	0,-23 (ix)
	jr	Z,00107$
;../expf.c:349: errno=ERANGE;
	ld	iy,#_errno
	ld	0 (iy),#0x22
	ld	1 (iy),#0x00
;../expf.c:351: ;
	ld	hl,#0xFFFF
	ld	de,#0x7F7F
	jp	00118$
00107$:
;../expf.c:355: return 0.0;
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00118$
00110$:
;../expf.c:359: z=y*K1;
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	ld	hl,#0x3FB8
	push	hl
	ld	hl,#0xAA3B
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-18 (ix), l
	ld	-17 (ix), h
	ld	-16 (ix),e
	ld	-15 (ix),d
;../expf.c:360: n=z;
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	call	___fs2sint
	pop	af
	pop	af
	ld	-2 (ix), l
;../expf.c:362: if(n<0) --n;
	ld	-1 (ix), h
	ld	a, h
	bit	7,a
	jr	Z,00112$
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	dec	hl
	ld	-2 (ix),l
	ld	-1 (ix),h
00112$:
;../expf.c:363: if(z-n>=0.5) ++n;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	___sint2fs
	pop	af
	ld	b,d
	ld	c,e
	push	bc
	push	hl
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	call	___fssub
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
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	NZ,00114$
	inc	-2 (ix)
	jr	NZ,00127$
	inc	-1 (ix)
00127$:
00114$:
;../expf.c:364: xn=n;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	___sint2fs
	pop	af
	ld	-6 (ix), l
	ld	-5 (ix), h
	ld	-4 (ix),e
	ld	-3 (ix),d
;../expf.c:365: g=((y-xn*C1))-xn*C2;
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	hl,#0x3F31
	push	hl
	ld	hl,#0x8000
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
	ld	l,-20 (ix)
	ld	h,-19 (ix)
	push	hl
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-24 (ix),d
	ld	-25 (ix),e
	ld	-26 (ix),h
	ld	-27 (ix),l
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	hl,#0xB95E
	push	hl
	ld	hl,#0x8083
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
	ld	l,-25 (ix)
	ld	h,-24 (ix)
	push	hl
	ld	l,-27 (ix)
	ld	h,-26 (ix)
	push	hl
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-10 (ix), l
	ld	-9 (ix), h
	ld	-8 (ix),e
	ld	-7 (ix),d
;../expf.c:366: z=g*g;
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-18 (ix), l
	ld	-17 (ix), h
	ld	-16 (ix),e
	ld	-15 (ix),d
;../expf.c:367: r=P(z)*g;
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	hl,#0x3B88
	push	hl
	ld	hl,#0x5308
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0x3E80
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
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	push	de
	push	bc
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-14 (ix), l
	ld	-13 (ix), h
	ld	-12 (ix),e
	ld	-11 (ix),d
;../expf.c:368: r=0.5+(r/(Q(z)-r));
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	hl,#0x3D4C
	push	hl
	ld	hl,#0xBF5B
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
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	push	de
	push	bc
	call	___fssub
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	___fsdiv
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
	ld	-14 (ix), l
	ld	-13 (ix), h
	ld	-12 (ix),e
	ld	-11 (ix),d
;../expf.c:370: n++;
	inc	-2 (ix)
	jr	NZ,00128$
	inc	-1 (ix)
00128$:
;../expf.c:371: z=ldexpf(r, n);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
	push	hl
	call	_ldexpf
	pop	af
	pop	af
	pop	af
	ld	-18 (ix), l
	ld	-17 (ix), h
	ld	-16 (ix),e
	ld	-15 (ix),d
;../expf.c:372: if(sign)
	bit	0,-23 (ix)
	jr	Z,00116$
;../expf.c:373: return 1.0/z;
	ld	l,-16 (ix)
	ld	h,-15 (ix)
	push	hl
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	push	hl
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
	jr	00118$
00116$:
;../expf.c:375: return z;
	ld	l,-18 (ix)
	ld	h,-17 (ix)
	ld	e,-16 (ix)
	ld	d,-15 (ix)
00118$:
	ld	sp,ix
	pop	ix
	ret
_expf_end::
	.area _CODE
	.area _CABS
