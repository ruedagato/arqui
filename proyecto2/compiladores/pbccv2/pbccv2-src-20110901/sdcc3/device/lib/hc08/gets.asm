;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module gets
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gets
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area OSEG    (OVR)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
_gets_s_1_1:
	.ds 2
_gets_c_1_1:
	.ds 1
_gets_count_1_1:
	.ds 2
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'gets'
;------------------------------------------------------------
;s                         Allocated with name '_gets_s_1_1'
;c                         Allocated with name '_gets_c_1_1'
;count                     Allocated with name '_gets_count_1_1'
;------------------------------------------------------------
;../gets.c:32: gets (char *s)
;	-----------------------------------------
;	 function gets
;	-----------------------------------------
_gets:
	sta	(_gets_s_1_1 + 1)
	stx	_gets_s_1_1
;../gets.c:35: unsigned int count = 0;
	clra
	sta	_gets_count_1_1
	sta	(_gets_count_1_1 + 1)
;../gets.c:37: while (1)
00109$:
;../gets.c:39: c = getchar ();
	jsr	_getchar
	sta	_gets_c_1_1
;../gets.c:40: switch(c)
	lda	_gets_c_1_1
	cmp	#0x08
	beq	00101$
00118$:
	lda	_gets_c_1_1
	cmp	#0x0A
	beq	00105$
00119$:
	lda	_gets_c_1_1
	cmp	#0x0D
	beq	00105$
00120$:
	bra	00106$
;../gets.c:42: case '\b': /* backspace */
00101$:
;../gets.c:43: if (count)
	lda	(_gets_count_1_1 + 1)
	ora	_gets_count_1_1
	beq	00109$
00121$:
;../gets.c:45: putchar ('\b');
	lda	#0x08
	jsr	_putchar
;../gets.c:46: putchar (' ');
	lda	#0x20
	jsr	_putchar
;../gets.c:47: putchar ('\b');
	lda	#0x08
	jsr	_putchar
;../gets.c:48: --s;
	lda	(_gets_s_1_1 + 1)
	sub	#0x01
	sta	(_gets_s_1_1 + 1)
	lda	_gets_s_1_1
	sbc	#0x00
	sta	_gets_s_1_1
;../gets.c:49: --count;
	lda	(_gets_count_1_1 + 1)
	sub	#0x01
	sta	(_gets_count_1_1 + 1)
	lda	_gets_count_1_1
	sbc	#0x00
	sta	_gets_count_1_1
;../gets.c:51: break;
	bra	00109$
;../gets.c:54: case '\r': /* CR or LF */
00105$:
;../gets.c:55: putchar ('\r');
	lda	#0x0D
	jsr	_putchar
;../gets.c:56: putchar ('\n');
	lda	#0x0A
	jsr	_putchar
;../gets.c:57: *s = 0;
	lda	_gets_s_1_1
	ldx	(_gets_s_1_1 + 1)
	psha
	pulh
	clra
	sta	,x
;../gets.c:58: return s;
	ldx	_gets_s_1_1
	lda	(_gets_s_1_1 + 1)
	rts
;../gets.c:60: default:
00106$:
;../gets.c:61: *s++ = c;
	lda	_gets_s_1_1
	ldx	(_gets_s_1_1 + 1)
	psha
	pulh
	lda	_gets_c_1_1
	sta	,x
	aix	#1
	pshh
	pula
	sta	_gets_s_1_1
	stx	(_gets_s_1_1 + 1)
;../gets.c:62: ++count;
	lda	(_gets_count_1_1 + 1)
	inca
	sta	(_gets_count_1_1 + 1)
	bne	00122$
	lda	_gets_count_1_1
	inca
	sta	_gets_count_1_1
00122$:
;../gets.c:63: putchar (c);
	lda	_gets_c_1_1
	jsr	_putchar
;../gets.c:65: }
	jmp	00109$
00111$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
