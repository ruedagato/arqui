;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _isspace
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isspace
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
;../_isspace.c:33: char isspace (unsigned char c)
;	---------------------------------
; Function isspace
; ---------------------------------
_isspace_start::
_isspace:
	
;../_isspace.c:35: if ( c == UC(' ')  ||
	ldhl	sp,#2
	ld	a,(hl)
	sub	a,#0x20
	jp	Z,00101$
00115$:
;../_isspace.c:36: c == UC('\f') ||
	ld	a,(hl)
	sub	a,#0x0C
	jp	Z,00101$
00116$:
;../_isspace.c:37: c == UC('\n') ||
	ld	a,(hl)
	sub	a,#0x0A
	jp	Z,00101$
00117$:
;../_isspace.c:38: c == UC('\r') ||
	ld	a,(hl)
	sub	a,#0x0D
	jp	Z,00101$
00118$:
;../_isspace.c:39: c == UC('\t') ||
	ld	a,(hl)
	sub	a,#0x09
	jp	Z,00101$
00119$:
;../_isspace.c:40: c == UC('\v') )
	ld	a,(hl)
	sub	a,#0x0B
	jp	Z,00121$
00120$:
	jr	00102$
00121$:
00101$:
;../_isspace.c:41: return 1;
	ld	e,#0x01
	jr	00108$
00102$:
;../_isspace.c:42: return 0;
	ld	e,#0x00
00108$:
	
	ret
_isspace_end::
	.area _CODE
	.area _CABS
