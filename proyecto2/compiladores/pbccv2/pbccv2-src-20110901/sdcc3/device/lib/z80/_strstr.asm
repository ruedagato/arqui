;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module _strstr
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strstr
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
;../_strstr.c:31: char * strstr (
;	---------------------------------
; Function strstr
; ---------------------------------
_strstr_start::
_strstr:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-8
	add	hl,sp
	ld	sp,hl
;../_strstr.c:36: const char * cp = str1;
	ld	a,4 (ix)
	ld	-2 (ix),a
	ld	a,5 (ix)
	ld	-1 (ix),a
;../_strstr.c:40: if ( !*str2 )
	ld	a,6 (ix)
	ld	-6 (ix),a
	ld	a,7 (ix)
	ld	-5 (ix),a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	or	a,a
	jr	NZ,00122$
;../_strstr.c:41: return str1;
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	jp	00113$
;../_strstr.c:43: while (*cp)
00122$:
	ld	a,-2 (ix)
	ld	-4 (ix),a
	ld	a,-1 (ix)
	ld	-3 (ix),a
00110$:
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	a,(hl)
	or	a,a
	jr	Z,00112$
;../_strstr.c:46: s2 = str2;
	ld	l,-6 (ix)
	ld	h,-5 (ix)
;../_strstr.c:48: while ( *s1 && *s2 && !(*s1-*s2) )
	ld	e,-4 (ix)
	ld	d,-3 (ix)
	ld	-8 (ix),l
	ld	-7 (ix),h
00105$:
	ld	a,(de)
	ld	c,a
	or	a,a
	jr	Z,00107$
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l,(hl)
	xor	a,a
	or	a,l
	jr	Z,00107$
	ld	a,c
	rla	
	sbc	a,a
	ld	b,a
	ld	a,l
	rla	
	sbc	a,a
	ld	h,a
	ld	a,c
	sub	a,l
	ld	l,a
	ld	a,b
	sbc	a,h
	or	a,l
	jr	NZ,00107$
;../_strstr.c:49: s1++, s2++;
	inc	de
	inc	-8 (ix)
	jr	NZ,00105$
	inc	-7 (ix)
	jr	00105$
00107$:
;../_strstr.c:51: if (!*s2)
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	a,(hl)
	or	a,a
	jr	NZ,00109$
;../_strstr.c:52: return( (char*)cp );
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	jr	00113$
00109$:
;../_strstr.c:54: cp++;
	inc	-4 (ix)
	jr	NZ,00125$
	inc	-3 (ix)
00125$:
	ld	a,-4 (ix)
	ld	-2 (ix),a
	ld	a,-3 (ix)
	ld	-1 (ix),a
	jr	00110$
00112$:
;../_strstr.c:57: return (NULL) ;
	ld	hl,#0x0000
00113$:
	ld	sp,ix
	pop	ix
	ret
_strstr_end::
	.area _CODE
	.area _CABS
