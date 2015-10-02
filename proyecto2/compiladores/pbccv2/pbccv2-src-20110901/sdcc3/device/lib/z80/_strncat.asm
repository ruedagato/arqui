;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:17 2015
;--------------------------------------------------------
	.module _strncat
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncat
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
;../_strncat.c:31: char * strncat (
;	---------------------------------
; Function strncat
; ---------------------------------
_strncat_start::
_strncat:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-6
	add	hl,sp
	ld	sp,hl
;../_strncat.c:37: char *start = front;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
;../_strncat.c:39: while (*front++);
	ld	e,-2 (ix)
	ld	d,-1 (ix)
00101$:
	ld	a,(de)
	inc	de
	or	a,a
	jr	NZ,00101$
;../_strncat.c:41: front--;
	ld	a,e
	add	a,#0xFF
	ld	4 (ix),a
	ld	a,d
	adc	a,#0xFF
	ld	5 (ix),a
;../_strncat.c:43: while (count--)
	ld	e,6 (ix)
	ld	d,7 (ix)
	ld	a,4 (ix)
	ld	-4 (ix),a
	ld	a,5 (ix)
	ld	-3 (ix),a
	ld	a,8 (ix)
	ld	-6 (ix),a
	ld	a,9 (ix)
	ld	-5 (ix),a
00106$:
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	dec	hl
	ld	-6 (ix),l
	ld	-5 (ix),h
	ld	a,l
	or	a,h
	jr	Z,00108$
;../_strncat.c:44: if (!(*front++ = *back++))
	ld	a,(de)
	ld	c,a
	inc	de
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),c
	inc	-4 (ix)
	jr	NZ,00117$
	inc	-3 (ix)
00117$:
	ld	a,-4 (ix)
	ld	4 (ix),a
	ld	a,-3 (ix)
	ld	5 (ix),a
	xor	a,a
	or	a,c
	jr	NZ,00106$
;../_strncat.c:45: return(start);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	jr	00109$
00108$:
;../_strncat.c:47: *front = '\0';
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	(hl),#0x00
;../_strncat.c:48: return(start);
	ld	l,-2 (ix)
	ld	h,-1 (ix)
00109$:
	ld	sp,ix
	pop	ix
	ret
_strncat_end::
	.area _CODE
	.area _CABS
