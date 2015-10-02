;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _memchr
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memchr
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
;../_memchr.c:31: void *memchr(const void *s, int c, size_t n)
;	---------------------------------
; Function memchr
; ---------------------------------
_memchr_start::
_memchr:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;../_memchr.c:33: unsigned char *p = (unsigned char *)s;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	c,l
	ld	b,h
;../_memchr.c:34: unsigned char *end = p + n;
	ld	a,l
	add	a,8 (ix)
	ld	e,a
	ld	a,h
	adc	a,9 (ix)
	ld	-2 (ix), e
	ld	-1 (ix), a
;../_memchr.c:38: return(0);
	ex	de,hl
00103$:
;../_memchr.c:35: for(; p != end; p++)
	ld	a,e
	sub	a,-2 (ix)
	jr	NZ,00112$
	ld	a,d
	sub	a,-1 (ix)
	jr	Z,00106$
00112$:
;../_memchr.c:36: if(*p == c)
	ld	a,(de)
	ld	h, #0x00
	sub	a,6 (ix)
	jr	NZ,00105$
	ld	a,h
	sub	a,7 (ix)
	jr	NZ,00105$
;../_memchr.c:37: return((void *)p);
	ld	l,c
	ld	h,b
	jr	00107$
00105$:
;../_memchr.c:35: for(; p != end; p++)
	inc	de
	ld	c,e
	ld	b,d
	jr	00103$
00106$:
;../_memchr.c:38: return(0);
	ld	hl,#0x0000
00107$:
	ld	sp,ix
	pop	ix
	ret
_memchr_end::
	.area _CODE
	.area _CABS
