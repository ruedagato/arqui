;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _memchr
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memchr
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
;../_memchr.c:31: void *memchr(const void *s, int c, size_t n)
;	---------------------------------
; Function memchr
; ---------------------------------
_memchr_start::
_memchr:
	lda	sp,-6(sp)
;../_memchr.c:33: unsigned char *p = (unsigned char *)s;
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_memchr.c:34: unsigned char *end = p + n;
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#12
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,de
	ld	c,l
	ld	b,h
	ldhl	sp,#2
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../_memchr.c:38: return(0);
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
00103$:
;../_memchr.c:35: for(; p != end; p++)
	ldhl	sp,#4
	ld	a,(hl)
	dec	hl
	dec	hl
	sub	a,(hl)
	jp	NZ,00112$
	ldhl	sp,#5
	ld	a,(hl)
	dec	hl
	dec	hl
	sub	a,(hl)
	jp	Z,00106$
00112$:
;../_memchr.c:36: if(*p == c)
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	b,#0x00
	ld	a,c
	ldhl	sp,#10
	sub	a,(hl)
	jp	NZ,00105$
	ld	a,b
	inc	hl
	sub	a,(hl)
	jp	Z,00114$
00113$:
	jr	00105$
00114$:
;../_memchr.c:37: return((void *)p);
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00107$
00105$:
;../_memchr.c:35: for(; p != end; p++)
	ldhl	sp,#4
	inc	(hl)
	jp	NZ,00115$
	inc	hl
	inc	(hl)
00115$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jp	00103$
00106$:
;../_memchr.c:38: return(0);
	ld	de,#0x0000
00107$:
	lda	sp,6(sp)
	ret
_memchr_end::
	.area _CODE
	.area _CABS
