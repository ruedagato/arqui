;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strstr
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strstr
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
	lda	sp,-12(sp)
;../_strstr.c:36: const char * cp = str1;
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strstr.c:40: if ( !*str2 )
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a,a
	jp	NZ,00122$
;../_strstr.c:41: return str1;
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jp	00113$
;../_strstr.c:43: while (*cp)
00122$:
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
00110$:
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a,a
	jp	Z,00112$
;../_strstr.c:46: s2 = str2;
	dec	hl
	dec	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../_strstr.c:48: while ( *s1 && *s2 && !(*s1-*s2) )
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#2
	ld	(hl),c
	inc	hl
	ld	(hl),b
00105$:
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	or	a,a
	jp	Z,00107$
	dec	hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	b,a
	or	a,a
	jp	Z,00107$
	ldhl	sp,#0
	ld	(hl),c
	ld	a,c
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	ld	a,b
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
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
	ld	a,c
	or	a,b
	jp	NZ,00107$
;../_strstr.c:49: s1++, s2++;
	ldhl	sp,#4
	inc	(hl)
	jp	NZ,00124$
	inc	hl
	inc	(hl)
00124$:
	ldhl	sp,#2
	inc	(hl)
	jp	NZ,00105$
	inc	hl
	inc	(hl)
00125$:
	jp	00105$
00107$:
;../_strstr.c:51: if (!*s2)
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a,a
	jp	NZ,00109$
;../_strstr.c:52: return( (char*)cp );
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00113$
00109$:
;../_strstr.c:54: cp++;
	ldhl	sp,#8
	inc	(hl)
	jp	NZ,00126$
	inc	hl
	inc	(hl)
00126$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jp	00110$
00112$:
;../_strstr.c:57: return (NULL) ;
	ld	de,#0x0000
00113$:
	lda	sp,12(sp)
	ret
_strstr_end::
	.area _CODE
	.area _CABS
