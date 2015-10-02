;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module sqrtf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sqrtf
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
;../sqrtf.c:37: float sqrtf(const float x) _FLOAT_FUNC_REENTRANT
;	---------------------------------
; Function sqrtf
; ---------------------------------
_sqrtf_start::
_sqrtf:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-14
	add	hl,sp
	ld	sp,hl
;../sqrtf.c:42: if (x==0.0) return x;
	ld	a,4 (ix)
	or	a,5 (ix)
	or	a,6 (ix)
	or	a,7 (ix)
	jr	NZ,00107$
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	jp	00111$
00107$:
;../sqrtf.c:43: else if (x==1.0) return 1.0;
	ld	hl,#0x3F80
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	___fseq
	pop	af
	pop	af
	pop	af
	pop	af
	xor	a,a
	or	a,l
	jr	Z,00104$
	ld	hl,#0x0000
	ld	de,#0x3F80
	jp	00111$
00104$:
;../sqrtf.c:44: else if (x<0.0)
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
	jr	Z,00108$
;../sqrtf.c:46: errno=EDOM;
	ld	iy,#_errno
	ld	0 (iy),#0x21
	ld	1 (iy),#0x00
;../sqrtf.c:47: return 0.0;
	ld	hl,#0x0000
	ld	e,l
	ld	d,h
	jp	00111$
00108$:
;../sqrtf.c:49: f=frexpf(x, &n);
	ld	hl,#0x0004
	add	hl,sp
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_frexpf
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../sqrtf.c:50: y=0.41731+0.59016*f; /*Educated guess*/
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	hl,#0x3F17
	push	hl
	ld	hl,#0x14BA
	push	hl
	call	___fsmul
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	hl,#0x3ED5
	push	hl
	ld	hl,#0xA9A8
	push	hl
	push	de
	push	bc
	call	___fsadd
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-8 (ix), l
	ld	-7 (ix), h
	ld	-6 (ix),e
	ld	-5 (ix),d
;../sqrtf.c:52: y+=f/y;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
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
;../sqrtf.c:53: y=ldexpf(y, -2) + f/y; /*Faster version of 0.25 * y + f/y*/
	ld	hl,#0xFFFFFFFE
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_ldexpf
	pop	af
	pop	af
	pop	af
	ld	-11 (ix),d
	ld	-12 (ix),e
	ld	-13 (ix),h
	ld	-14 (ix),l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
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
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	ld	l,-14 (ix)
	ld	h,-13 (ix)
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
;../sqrtf.c:55: if (n&1)
	ld	a,-10 (ix)
	and	a,#0x01
	jr	Z,00110$
;../sqrtf.c:57: y*=0.7071067812;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	hl,#0x3F35
	push	hl
	ld	hl,#0x04F3
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
;../sqrtf.c:58: ++n;
	inc	-10 (ix)
	jr	NZ,00118$
	inc	-9 (ix)
00118$:
00110$:
;../sqrtf.c:60: return ldexpf(y, n/2);
	ld	hl,#0x0002
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	call	__divsint_rrx_s
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	push	bc
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	call	_ldexpf
	pop	af
	pop	af
	pop	af
00111$:
	ld	sp,ix
	pop	ix
	ret
_sqrtf_end::
	.area _CODE
	.area _CABS
