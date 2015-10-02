;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module _strtok
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strtok
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_strtok_s_1_1:
	.ds 2
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
;../_strtok.c:36: char * strtok (
;	---------------------------------
; Function strtok
; ---------------------------------
_strtok_start::
_strtok:
	
	push	af
;../_strtok.c:43: if ( str )
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00102$
;../_strtok.c:44: s = str ;
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ld	hl,#_strtok_s_1_1
	ld	(hl),a
	inc	hl
	ld	(hl),e
00102$:
;../_strtok.c:45: if ( !s )
	ld	hl,#_strtok_s_1_1
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00108$
;../_strtok.c:46: return NULL;
	ld	de,#0x0000
	jp	00119$
;../_strtok.c:48: while (*s) {
00108$:
	ld	hl,#_strtok_s_1_1 + 1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(bc)
	or	a,a
	jp	Z,00110$
;../_strtok.c:49: if (strchr(control,*s))
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(bc)
	ld	c,a
	push	af
	inc	sp
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_strchr
	lda	sp,3(sp)
	ld	b,d
	ld	c,e
	ld	a,c
	or	a,b
	jp	Z,00110$
;../_strtok.c:50: s++;
	ld	hl,#_strtok_s_1_1
	inc	(hl)
	jp	NZ,00108$
	inc	hl
	inc	(hl)
00130$:
	jr	00108$
;../_strtok.c:52: break;
00110$:
;../_strtok.c:55: s1 = s ;
	ld	hl,#_strtok_s_1_1
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_strtok.c:57: while (*s) {
00113$:
	ld	hl,#_strtok_s_1_1 + 1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(bc)
	or	a,a
	jp	Z,00115$
;../_strtok.c:58: if (strchr(control,*s)) {
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(bc)
	ld	c,a
	push	af
	inc	sp
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_strchr
	lda	sp,3(sp)
	ld	b,d
	ld	c,e
	ld	a,c
	or	a,b
	jp	Z,00112$
;../_strtok.c:59: *s++ = '\0';
	ld	hl,#_strtok_s_1_1 + 1
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,#0x00
	ld	(bc),a
	dec	hl
	inc	(hl)
	jp	NZ,00131$
	inc	hl
	inc	(hl)
00131$:
;../_strtok.c:60: return s1 ;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00119$
00112$:
;../_strtok.c:62: s++ ;
	ld	hl,#_strtok_s_1_1
	inc	(hl)
	jp	NZ,00113$
	inc	hl
	inc	(hl)
00132$:
	jp	00113$
00115$:
;../_strtok.c:65: s = NULL;
	ld	hl,#_strtok_s_1_1
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../_strtok.c:67: if (*s1)
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a,a
	jp	Z,00117$
;../_strtok.c:68: return s1;
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	00119$
00117$:
;../_strtok.c:70: return NULL;
	ld	de,#0x0000
00119$:
	lda	sp,2(sp)
	ret
_strtok_end::
	.area _CODE
	.area _CABS
