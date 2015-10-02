;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fsgt
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsgt
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
;../_fsgt.c:108: char __fsgt (float a1, float a2)
;	---------------------------------
; Function __fsgt
; ---------------------------------
___fsgt_start::
___fsgt:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-12
	add	hl,sp
	ld	sp,hl
;../_fsgt.c:112: fl1.f = a1;
	ld	hl,#0x0008
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
;../_fsgt.c:113: fl2.f = a2;
	ld	hl,#0x0004
	add	hl,sp
	ld	a,8 (ix)
	ld	(hl),a
	inc	hl
	ld	a,9 (ix)
	ld	(hl),a
	inc	hl
	ld	a,10 (ix)
	ld	(hl),a
	inc	hl
	ld	a,11 (ix)
	ld	(hl),a
;../_fsgt.c:115: if (fl1.l<0 && fl2.l<0) {
	ld	hl,#0x0008+1+1+1
	add	hl,sp
	ld	a, (hl)
	bit	7,a
	jr	Z,00104$
	ld	hl,#0x0004+1+1+1
	add	hl,sp
	ld	a, (hl)
	bit	7,a
	jr	Z,00104$
;../_fsgt.c:116: if (fl2.l > fl1.l)
	ld	hl,#0x0004
	add	hl,sp
	ld	a,(hl)
	ld	-12 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-11 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-10 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-9 (ix),a
	ld	hl,#0x0008
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	sub	a, -12 (ix)
	ld	a,b
	sbc	a, -11 (ix)
	ld	a,e
	sbc	a, -10 (ix)
	ld	a,d
	sbc	a, -9 (ix)
	jp	PO, 00114$
	xor	a, #0x80
00114$:
	jp	P,00102$
;../_fsgt.c:117: return (1);
	ld	l,#0x01
	jr	00108$
00102$:
;../_fsgt.c:118: return (0);
	ld	l,#0x00
	jr	00108$
00104$:
;../_fsgt.c:121: if (fl1.l > fl2.l)
	ld	hl,#0x0008
	add	hl,sp
	ld	a,(hl)
	ld	-12 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-11 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-10 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-9 (ix),a
	ld	hl,#0x0004
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	sub	a, -12 (ix)
	ld	a,b
	sbc	a, -11 (ix)
	ld	a,e
	sbc	a, -10 (ix)
	ld	a,d
	sbc	a, -9 (ix)
	jp	PO, 00115$
	xor	a, #0x80
00115$:
	jp	P,00107$
;../_fsgt.c:122: return (1);
	ld	l,#0x01
	jr	00108$
00107$:
;../_fsgt.c:123: return (0);
	ld	l,#0x00
00108$:
	ld	sp,ix
	pop	ix
	ret
___fsgt_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
