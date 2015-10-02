;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _memcmp
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcmp
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
;../_memcmp.c:31: int memcmp (
;	---------------------------------
; Function memcmp
; ---------------------------------
_memcmp_start::
_memcmp:
	
	push	af
;../_memcmp.c:37: if (!count)
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00112$
;../_memcmp.c:38: return(0);
	ld	de,#0x0000
	jp	00107$
;../_memcmp.c:40: while ( --count && *((char *)buf1) == *((char *)buf2) ) {
00112$:
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
00104$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00106$
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	b,a
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,b
	sub	a,c
	jp	Z,00115$
00114$:
	jr	00106$
00115$:
;../_memcmp.c:41: buf1 = (char *)buf1 + 1;
	dec	hl
	dec	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#0x0001
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../_memcmp.c:42: buf2 = (char *)buf2 + 1;
	inc	hl
	inc	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,#0x0001
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),d
	jp	00104$
00106$:
;../_memcmp.c:45: return( *((unsigned char *)buf1) - *((unsigned char *)buf2) );
	ldhl	sp,#5
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#7
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(bc)
	ld	c,a
	ld	b,#0x00
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	sub	a,c
	ld	e,a
	ld	a,d
	sbc	a,b
	ld	b,a
	ld	c,e
	ld	e,c
	ld	d,b
00107$:
	lda	sp,2(sp)
	ret
_memcmp_end::
	.area _CODE
	.area _CABS
