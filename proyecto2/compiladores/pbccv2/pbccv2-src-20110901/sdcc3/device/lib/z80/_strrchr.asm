;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _strrchr
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strrchr
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
;../_strrchr.c:31: char * strrchr (
;	---------------------------------
; Function strrchr
; ---------------------------------
_strrchr_start::
_strrchr:
	push	ix
	ld	ix,#0
	add	ix,sp
;../_strrchr.c:36: const char * start = string;
	ld	c,4 (ix)
	ld	b,5 (ix)
;../_strrchr.c:38: while (*string++)                       /* find end of string */
	ld	e,c
	ld	d,b
00101$:
	ld	a,(de)
	inc	de
	or	a,a
	jr	NZ,00101$
;../_strrchr.c:41: while (--string != start && *string != ch)
00105$:
	dec	de
	ld	a,e
	sub	a,c
	jr	NZ,00118$
	ld	a,d
	sub	a,b
	jr	Z,00107$
00118$:
	ld	a,(de)
	sub	a,6 (ix)
	jr	NZ,00105$
00107$:
;../_strrchr.c:44: if (*string == ch)                /* char found ? */
	ld	a,(de)
	sub	a,6 (ix)
	jr	NZ,00109$
;../_strrchr.c:45: return( (char *)string );
	ex	de,hl
	jr	00110$
00109$:
;../_strrchr.c:47: return (NULL) ;
	ld	hl,#0x0000
00110$:
	pop	ix
	ret
_strrchr_end::
	.area _CODE
	.area _CABS
