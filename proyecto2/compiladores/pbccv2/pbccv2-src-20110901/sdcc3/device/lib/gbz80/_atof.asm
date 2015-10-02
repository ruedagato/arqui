;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:19 2015
;--------------------------------------------------------
	.module _atof
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atof
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
;../_atof.c:33: float atof(const char * s)
;	---------------------------------
; Function atof
; ---------------------------------
_atof_start::
_atof:
	lda	sp,-19(sp)
;../_atof.c:40: while (isspace(*s)) s++;
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
00101$:
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	push	af
	inc	sp
	call	_isspace
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00148$
	ldhl	sp,#8
	inc	(hl)
	jp	NZ,00101$
	inc	hl
	inc	(hl)
00151$:
	jr	00101$
00148$:
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_atof.c:43: if (*s == '-')
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	sub	a,#0x2D
	jp	Z,00153$
00152$:
	jr	00107$
00153$:
;../_atof.c:45: sign=1;
	inc	hl
	ld	(hl),#0x01
;../_atof.c:46: s++;
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),d
	jr	00108$
00107$:
;../_atof.c:50: sign=0;
	ldhl	sp,#10
	ld	(hl),#0x00
;../_atof.c:51: if (*s == '+') s++;
	ld	a,c
	sub	a,#0x2B
	jp	Z,00155$
00154$:
	jr	00108$
00155$:
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),d
00108$:
;../_atof.c:55: for (value=0.0; isdigit(*s); s++)
	ldhl	sp,#15
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
00121$:
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	push	af
	inc	sp
	call	_isdigit
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00149$
;../_atof.c:57: value=10.0*value+(*s-'0');
	ldhl	sp,#17
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#17
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x4120
	push	hl
	ld	hl,#0x0000
	push	hl
	call	___fsmul
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
	ld	a,c
	add	a,#0xD0
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	push	bc
	call	___sint2fs
	lda	sp,2(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fsadd
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#0
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_atof.c:55: for (value=0.0; isdigit(*s); s++)
	ldhl	sp,#8
	inc	(hl)
	jp	NZ,00121$
	inc	hl
	inc	(hl)
00156$:
	jp	00121$
00149$:
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../_atof.c:61: if (*s == '.')
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	sub	a,#0x2E
	jp	Z,00158$
00157$:
	jp	00110$
00158$:
;../_atof.c:63: s++;
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
;../_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	inc	hl
	inc	hl
	ld	(hl),#0xCD
	inc	hl
	ld	(hl),#0xCC
	inc	hl
	ld	(hl),#0xCC
	inc	hl
	ld	(hl),#0x3D
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
00125$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	push	af
	inc	sp
	call	_isdigit
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00150$
;../_atof.c:66: value+=(*s-'0')*fraction;
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	rla	
	sbc	a,a
	ld	b,a
	ld	a,c
	add	a,#0xD0
	ld	c,a
	ld	a,b
	adc	a,#0xFF
	ld	b,a
	push	bc
	call	___sint2fs
	lda	sp,2(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fsmul
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	___fsadd
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_atof.c:67: fraction*=0.1;
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x3DCC
	push	hl
	ld	hl,#0xCCCD
	push	hl
	call	___fsmul
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#11
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00125$
	inc	hl
	inc	(hl)
00159$:
	jp	00125$
00150$:
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
00110$:
;../_atof.c:72: if (toupper(*s)=='E')
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	push	af
	inc	sp
	call	_islower
	lda	sp,1(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00131$
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	and	a,#0xDF
	ld	c,a
	jr	00132$
00131$:
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
00132$:
	ld	a,c
	sub	a,#0x45
	jp	Z,00161$
00160$:
	jp	00118$
00161$:
;../_atof.c:74: s++;
	ldhl	sp,#0
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
;../_atof.c:75: iexp=(signed char)atoi(s);
	push	bc
	call	_atoi
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
;../_atof.c:77: while(iexp!=0)
00114$:
	xor	a,a
	or	a,c
	jp	Z,00118$
;../_atof.c:79: if(iexp<0)
	ld	a, #0x00
	ld	e, a
	ld	a, c
	ld	d, a
	ld	a,c
	bit	7,a
	jp	Z,00112$
;../_atof.c:81: value*=0.1;
	push	bc
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x3DCC
	push	hl
	ld	hl,#0xCCCD
	push	hl
	call	___fsmul
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#4
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	bc
	ldhl	sp,#0
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_atof.c:82: iexp++;
	inc	c
	jp	00114$
00112$:
;../_atof.c:86: value*=10.0;
	push	bc
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#19
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x4120
	push	hl
	ld	hl,#0x0000
	push	hl
	call	___fsmul
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#4
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	bc
	ldhl	sp,#0
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../_atof.c:87: iexp--;
	dec	c
	jp	00114$
00118$:
;../_atof.c:93: if(sign) value*=-1.0;
	ldhl	sp,#10
	bit	0,(hl)
	jp	Z,00120$
	ldhl	sp,#18
	ld	a,(hl)
	xor	a,#0x80
	ld	(hl),a
00120$:
;../_atof.c:94: return (value);
	ldhl	sp,#16
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00129$:
	lda	sp,19(sp)
	ret
_atof_end::
	.area _CODE
	.area _CABS
