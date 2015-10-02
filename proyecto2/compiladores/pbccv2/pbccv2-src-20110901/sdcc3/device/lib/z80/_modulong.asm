;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _modulong
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modulong
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
;../_modulong.c:340: _modulong (unsigned long a, unsigned long b)
;	---------------------------------
; Function _modulong
; ---------------------------------
__modulong_start::
__modulong:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;../_modulong.c:342: unsigned char count = 0;
	ld	-2 (ix),#0x00
;../_modulong.c:344: while (!MSB_SET(b))
	ld	-1 (ix),#0x00
00103$:
	ld	a,11 (ix)
	rlca
	jr	C,00117$
;../_modulong.c:346: b <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	c,d
	ld	b,e
	ld	8 (ix), l
	ld	9 (ix), h
	ld	10 (ix),b
	ld	11 (ix),c
;../_modulong.c:347: if (b > a)
	ld	a,4 (ix)
	sub	a, 8 (ix)
	ld	a,5 (ix)
	sbc	a, 9 (ix)
	ld	a,6 (ix)
	sbc	a, 10 (ix)
	ld	a,7 (ix)
	sbc	a, 11 (ix)
	jr	NC,00102$
;../_modulong.c:349: b >>=1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	8 (ix), l
	ld	9 (ix), h
	ld	10 (ix),e
	ld	11 (ix),d
;../_modulong.c:350: break;
	jr	00117$
00102$:
;../_modulong.c:352: count++;
	inc	-1 (ix)
	ld	a,-1 (ix)
	ld	-2 (ix),a
	jr	00103$
;../_modulong.c:354: do
00117$:
00108$:
;../_modulong.c:356: if (a >= b)
	ld	a,4 (ix)
	sub	a, 8 (ix)
	ld	a,5 (ix)
	sbc	a, 9 (ix)
	ld	a,6 (ix)
	sbc	a, 10 (ix)
	ld	a,7 (ix)
	sbc	a, 11 (ix)
	jr	C,00107$
;../_modulong.c:357: a -= b;
	ld	a,4 (ix)
	sub	a,8 (ix)
	ld	4 (ix),a
	ld	a,5 (ix)
	sbc	a,9 (ix)
	ld	5 (ix),a
	ld	a,6 (ix)
	sbc	a,10 (ix)
	ld	6 (ix),a
	ld	a,7 (ix)
	sbc	a,11 (ix)
	ld	7 (ix),a
00107$:
;../_modulong.c:358: b >>= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,10 (ix)
	ld	h,11 (ix)
	push	hl
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	call	__rrulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	c,d
	ld	d,e
	ld	8 (ix), l
	ld	9 (ix), h
	ld	10 (ix),d
	ld	11 (ix),c
;../_modulong.c:360: while (count--);
	ld	l,-2 (ix)
	dec	-2 (ix)
	xor	a,a
	or	a,l
	jr	NZ,00108$
;../_modulong.c:362: return a;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	sp,ix
	pop	ix
	ret
__modulong_end::
	.area _CODE
	.area _CABS
