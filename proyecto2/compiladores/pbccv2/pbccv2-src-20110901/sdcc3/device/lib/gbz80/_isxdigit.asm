;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _isxdigit
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isxdigit
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
;../_isxdigit.c:33: char isxdigit (unsigned char c)
;	---------------------------------
; Function isxdigit
; ---------------------------------
_isxdigit_start::
_isxdigit:
	
;../_isxdigit.c:35: if ( ( c >= UC('0') && c <= UC('9')) ||
	ldhl	sp,#2
	ld	a,(hl)
	sub	a, #0x30
	jp	C,00105$
	ld	a,#0x39
	sub	a, (hl)
	jp	NC,00101$
00105$:
;../_isxdigit.c:36: ( c >= UC('a') && c <= UC('f')) ||
	ldhl	sp,#2
	ld	a,(hl)
	sub	a, #0x61
	jp	C,00107$
	ld	a,#0x66
	sub	a, (hl)
	jp	NC,00101$
00107$:
;../_isxdigit.c:37: ( c >= UC('A') && c <= UC('F')) )
	ldhl	sp,#2
	ld	a,(hl)
	sub	a, #0x41
	jp	C,00102$
	ld	a,#0x46
	sub	a, (hl)
	jp	C,00102$
00101$:
;../_isxdigit.c:38: return 1;
	ld	e,#0x01
	jr	00108$
00102$:
;../_isxdigit.c:39: return 0;
	ld	e,#0x00
00108$:
	
	ret
_isxdigit_end::
	.area _CODE
	.area _CABS
