;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _ulong2fs
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
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
	lda	sp,-14(sp)
;../_ulong2fs.c:88: if (!a)
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00115$
;../_ulong2fs.c:90: return 0.0;
	ld	de,#0x0000
	ld	hl,#0x0000
	jp	00111$
;../_ulong2fs.c:93: while (a & NORM) 
00115$:
	ld	bc,#0x0096
00103$:
	ldhl	sp,#19
	ld	a,(hl)
	or	a,a
	jp	Z,00117$
00121$:
;../_ulong2fs.c:96: a >>= 1;
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rrulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#8
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	bc
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#16
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_ulong2fs.c:97: exp++;
	inc	bc
	jp	00103$
;../_ulong2fs.c:100: while (a < HIDDEN)
00117$:
	ldhl	sp,#12
	ld	(hl),c
	inc	hl
	ld	(hl),b
00106$:
	ldhl	sp,#16
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x80
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC,00120$
;../_ulong2fs.c:102: a <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#16
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_ulong2fs.c:103: exp--;
	ldhl	sp,#13
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jp	00106$
00120$:
	ldhl	sp,#13
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../_ulong2fs.c:107: if ((a&0x7fffff)==0x7fffff) {
	ldhl	sp,#16
	ld	a,(hl)
	ldhl	sp,#0
	ld	(hl),a
	ldhl	sp,#17
	ld	a,(hl)
	ldhl	sp,#1
	ld	(hl),a
	ldhl	sp,#18
	ld	a,(hl)
	and	a,#0x7F
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#0
	ld	a,(hl)
	inc	a
	jp	NZ,00110$
	inc	hl
	ld	a,(hl)
	inc	a
	jp	NZ,00110$
	inc	hl
	ld	a,(hl)
	sub	a,#0x7F
	jp	NZ,00110$
	inc	hl
	ld	a,(hl)
	or	a,a
	jp	Z,00123$
00122$:
	jr	00110$
00123$:
;../_ulong2fs.c:108: a=0;
	xor	a,a
	ldhl	sp,#16
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
;../_ulong2fs.c:109: exp++;
	ldhl	sp,#12
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
00110$:
;../_ulong2fs.c:113: a &= ~HIDDEN ;
	ldhl	sp,#18
	ld	a,(hl)
	and	a,#0x7F
	ld	(hl),a
;../_ulong2fs.c:115: fl.l = PACK(0,(unsigned long)exp, a);
	ldhl	sp,#8
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	ld	a,#0x17
	push	af
	inc	sp
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__rlulong_rrx_s
	lda	sp,5(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#16
	or	a, (hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#17
	or	a, (hl)
	ldhl	sp,#5
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#18
	or	a, (hl)
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ldhl	sp,#19
	or	a, (hl)
	ldhl	sp,#7
	ld	(hl),a
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../_ulong2fs.c:117: return (fl.f);
	ldhl	sp,#8
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00111$:
	lda	sp,14(sp)
	ret
___ulong2fs_end::
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _CABS
