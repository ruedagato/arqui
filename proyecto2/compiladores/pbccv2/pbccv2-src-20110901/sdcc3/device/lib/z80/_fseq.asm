;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:16 2015
;--------------------------------------------------------
	.module _fseq
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fseq
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
;../_fseq.c:83: __fseq (float a1, float a2)
;	---------------------------------
; Function __fseq
; ---------------------------------
___fseq_start::
___fseq:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-12
	add	hl,sp
	ld	sp,hl
;../_fseq.c:87: fl1.f = a1;
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
;../_fseq.c:88: fl2.f = a2;
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
;../_fseq.c:90: if (fl1.l == fl2.l)
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
	ld	a,-12 (ix)
	sub	a,c
	jr	NZ,00102$
	ld	a,-11 (ix)
	sub	a,b
	jr	NZ,00102$
	ld	a,-10 (ix)
	sub	a,e
	jr	NZ,00102$
	ld	a,-9 (ix)
	sub	a,d
	jr	NZ,00102$
;../_fseq.c:91: return (1);
	ld	l,#0x01
	jr	00105$
00102$:
;../_fseq.c:92: if (((fl1.l | fl2.l) & 0x7FFFFFFF) == 0)
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
	or	a, -12 (ix)
	ld	c,a
	ld	a,b
	or	a, -11 (ix)
	ld	b,a
	ld	a,e
	or	a, -10 (ix)
	ld	e,a
	ld	a,d
	or	a, -9 (ix)
	ld	d,a
	ld	a,c
	or	a,a
	jr	NZ,00104$
	ld	a,b
	or	a,a
	jr	NZ,00104$
	ld	a,e
	or	a,a
	jr	NZ,00104$
	ld	a,d
	and	a,#0x7F
	jr	NZ,00104$
;../_fseq.c:93: return (1);
	ld	l,#0x01
	jr	00105$
00104$:
;../_fseq.c:94: return (0);
	ld	l,#0x00
00105$:
	ld	sp,ix
	pop	ix
	ret
___fseq_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
