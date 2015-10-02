;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module sincoshf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincoshf
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
;../sincoshf.c:53: float sincoshf(const float x, const int iscosh)
;	---------------------------------
; Function sincoshf
; ---------------------------------
_sincoshf_start::
_sincoshf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-17
	add	hl,sp
	ld	sp,hl
;../sincoshf.c:58: if (x<0.0) { y=-x; sign=1; }
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
	ld	-13 (ix),#0x01
	jr	00103$
00102$:
;../sincoshf.c:59: else { y=x;  sign=0; }
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	ld	a,6 (ix)
	ld	-2 (ix),a
	ld	a,7 (ix)
	ld	-1 (ix),a
	ld	-13 (ix),#0x00
00103$:
;../sincoshf.c:61: if ((y>1.0) || iscosh)
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
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
	jr	NZ,00117$
	ld	a,8 (ix)
	or	a,9 (ix)
	jp	Z,00118$
00117$:
;../sincoshf.c:63: if(y>YBAR)
	ld	hl,#0x4110
	push	hl
	ld	hl,#0x0000
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
	jp	Z,00110$
;../sincoshf.c:65: w=y-K1;
	ld	hl,#0x3F31
	push	hl
	ld	hl,#0x7300
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
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
;../sincoshf.c:66: if (w>WMAX)
	ld	hl,#0x4233
	push	hl
	ld	hl,#0xBDCF
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	___fsgt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00105$
;../sincoshf.c:68: errno=ERANGE;
	ld	iy,#_errno
	ld	0 (iy),#0x22
	ld	1 (iy),#0x00
;../sincoshf.c:69: z=HUGE_VALF;
	ld	-12 (ix),#0xFF
	ld	-11 (ix),#0xFF
	ld	-10 (ix),#0x7F
	ld	-9 (ix),#0x7F
	jp	00111$
00105$:
;../sincoshf.c:73: z=expf(w);
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_expf
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../sincoshf.c:74: z+=K3*z;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	hl,#0x3768
	push	hl
	ld	hl,#0x0897
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
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
	jp	00111$
00110$:
;../sincoshf.c:79: z=expf(y);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	_expf
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../sincoshf.c:80: w=1.0/z;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
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
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
;../sincoshf.c:81: if(!iscosh) w=-w;
	ld	a,8 (ix)
	or	a,9 (ix)
	jr	NZ,00108$
	ld	a,-5 (ix)
	xor	a,#0x80
	ld	-5 (ix),a
00108$:
;../sincoshf.c:82: z=(z+w)*0.5;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
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
	ld	hl,#0x3F00
	push	hl
	ld	hl,#0x0000
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
00111$:
;../sincoshf.c:84: if(sign) z=-z;
	bit	0,-13 (ix)
	jp	Z,00119$
	ld	a,-9 (ix)
	xor	a,#0x80
	ld	-9 (ix),a
	jp	00119$
00118$:
;../sincoshf.c:88: if (y<EPS)
	ld	hl,#0x3980
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	___fslt
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00115$
;../sincoshf.c:89: z=x;
	ld	a,4 (ix)
	ld	-12 (ix),a
	ld	a,5 (ix)
	ld	-11 (ix),a
	ld	a,6 (ix)
	ld	-10 (ix),a
	ld	a,7 (ix)
	ld	-9 (ix),a
	jp	00119$
00115$:
;../sincoshf.c:92: z=x*x;
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
;../sincoshf.c:93: z=x+x*z*P(z)/Q(z);
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-14 (ix),d
	ld	-15 (ix),e
	ld	-16 (ix),h
	ld	-17 (ix),l
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	hl,#0xBE42
	push	hl
	ld	hl,#0xE6EA
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0xC0E4
	push	hl
	ld	hl,#0x69F0
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
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-14 (ix),d
	ld	-15 (ix),e
	ld	-16 (ix),h
	ld	-17 (ix),l
	ld	hl,#0xC22B
	push	hl
	ld	hl,#0x4F93
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	ld	l,-12 (ix)
	ld	h,-11 (ix)
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
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	push	hl
	ld	l,-17 (ix)
	ld	h,-16 (ix)
	push	hl
	call	___fsdiv
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	de
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-12 (ix), l
	ld	-11 (ix), h
	ld	-10 (ix),e
	ld	-9 (ix),d
00119$:
;../sincoshf.c:96: return z;
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	e,-10 (ix)
	ld	d,-9 (ix)
	ld	sp,ix
	pop	ix
	ret
_sincoshf_end::
	.area _CODE
	.area _CABS
