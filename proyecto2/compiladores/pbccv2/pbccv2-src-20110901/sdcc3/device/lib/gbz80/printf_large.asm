;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module printf_large
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __print_format
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
;../printf_large.c:116: output_digit (unsigned char n, BOOL lower_case, pfn_outputchar output_char, void* p)
;	---------------------------------
; Function output_digit
; ---------------------------------
_output_digit:
	
;../printf_large.c:118: register unsigned char c = n + (unsigned char)'0';
	ldhl	sp,#2
	ld	a,(hl)
	add	a,#0x30
	ld	c,a
;../printf_large.c:120: if (c > (unsigned char)'9')
	ld	a,#0x39
	sub	a, c
	jp	NC,00104$
;../printf_large.c:122: c += (unsigned char)('A' - '0' - 10);
	ld	a,c
	add	a,#0x07
	ld	c,a
;../printf_large.c:123: if (lower_case)
	inc	hl
	bit	0,(hl)
	jp	Z,00104$
;../printf_large.c:124: c += (unsigned char)('a' - 'A');
	ld	a,c
	add	a,#0x20
	ld	c,a
00104$:
;../printf_large.c:126: output_char( c, p );
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,c
	push	af
	inc	sp
	ld	hl,#00109$
	push	hl
	ldhl	sp,#9
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00109$:
	lda	sp,3(sp)
00105$:
	
	ret
;../printf_large.c:149: output_2digits (unsigned char b, BOOL lower_case, pfn_outputchar output_char, void* p)
;	---------------------------------
; Function output_2digits
; ---------------------------------
_output_2digits:
	
;../printf_large.c:151: output_digit( b>>4,   lower_case, output_char, p );
	ldhl	sp,#2
	ld	c,(hl)
	srl	c
	srl	c
	srl	c
	srl	c
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
	ldhl	sp,#7
	ld	a,(hl)
	push	af
	inc	sp
	ld	a,c
	push	af
	inc	sp
	call	_output_digit
	lda	sp,6(sp)
;../printf_large.c:152: output_digit( b&0x0F, lower_case, output_char, p );
	ldhl	sp,#2
	ld	a,(hl)
	and	a,#0x0F
	ld	c,a
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
	ldhl	sp,#7
	ld	a,(hl)
	push	af
	inc	sp
	ld	a,c
	push	af
	inc	sp
	call	_output_digit
	lda	sp,6(sp)
00101$:
	
	ret
;../printf_large.c:168: calculate_digit (value_t _AUTOMEM * value, unsigned char radix)
;	---------------------------------
; Function calculate_digit
; ---------------------------------
_calculate_digit:
	lda	sp,-12(sp)
;../printf_large.c:170: unsigned long ul = value->ul;
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#8
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
;../printf_large.c:171: unsigned char _AUTOMEM * pb4 = &value->byte[4];
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#6
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../printf_large.c:174: do
	ld	b,#0x20
00103$:
;../printf_large.c:176: *pb4 = (*pb4 << 1) | ((ul >> 31) & 0x01);
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	add	a,a
	ld	c,a
	ldhl	sp,#11
	ld	a,(hl)
	rlc	a
	and	a,#0x01
	or	a, c
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
;../printf_large.c:177: ul <<= 1;
	push	bc
	ld	a,#0x01
	push	af
	inc	sp
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
	call	__rlulong_rrx_s
	lda	sp,5(sp)
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
	ldhl	sp,#8
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
;../printf_large.c:179: if (radix <= *pb4 )
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#16
	sub	a, (hl)
	jp	C,00104$
;../printf_large.c:181: *pb4 -= radix;
	ld	a,c
	sub	a,(hl)
	ldhl	sp,#7
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
;../printf_large.c:182: ul |= 1;
	inc	hl
	ld	a,(hl)
	set	0, a
	ld	(hl),a
00104$:
;../printf_large.c:184: } while (--i);
	dec	b
	xor	a,a
	or	a,b
	jp	NZ,00103$
;../printf_large.c:185: value->ul = ul;
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#8
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
00106$:
	lda	sp,12(sp)
	ret
;../printf_large.c:414: _print_format (pfn_outputchar pfn, void* pvoid, const char *format, va_list ap)
;	---------------------------------
; Function _print_format
; ---------------------------------
__print_format_start::
__print_format:
	lda	sp,-53(sp)
;../printf_large.c:446: charsOutputted = 0;
	ldhl	sp,#21
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
;../printf_large.c:454: while( c=*format++ )
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#23
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#27
	ld	c,l
	ld	b,h
	ld	hl,#0x0005
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#17
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#19
	ld	(hl),a
	inc	hl
	ld	(hl),d
00227$:
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#15
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#59
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ld	b,c
	xor	a,a
	or	a,c
	jp	Z,00229$
;../printf_large.c:456: if ( c=='%' )
	ld	a,b
	sub	a,#0x25
	jp	Z,00312$
00311$:
	jp	00225$
00312$:
;../printf_large.c:458: left_justify    = 0;
	ldhl	sp,#52
	ld	(hl),#0x00
;../printf_large.c:459: zero_padding    = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:460: prefix_sign     = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:461: prefix_space    = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:462: signed_argument = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:463: char_argument   = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:464: long_argument   = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:465: float_argument  = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:466: radix           = 0;
	ldhl	sp,#36
	ld	(hl),#0x00
;../printf_large.c:467: width           = 0;
	dec	hl
	ld	(hl),#0x00
;../printf_large.c:468: decimals        = -1;
	dec	hl
	ld	(hl),#0xFF
;../printf_large.c:470: get_conversion_spec:
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#15
	ld	(hl),a
	inc	hl
	ld	(hl),e
00101$:
;../printf_large.c:472: c = *format++;
	ldhl	sp,#16
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	dec	hl
	inc	(hl)
	jp	NZ,00313$
	inc	hl
	inc	(hl)
00313$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#59
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ld	b,c
;../printf_large.c:474: if (c=='%') {
	ld	a,b
	sub	a,#0x25
	jp	Z,00315$
00314$:
	jr	00103$
00315$:
;../printf_large.c:475: OUTPUT_CHAR(c, p);
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	inc	sp
	ld	hl,#00316$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00316$:
	lda	sp,3(sp)
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00227$
	inc	hl
	inc	(hl)
00317$:
;../printf_large.c:476: continue;
	jp	00227$
00103$:
;../printf_large.c:479: if (isdigit(c)) {
	ld	c,b
	ld	a,c
	sub	a, #0x30
	jp	C,00110$
	ld	c,b
	ld	a,#0x39
	sub	a, c
	jp	C,00110$
;../printf_large.c:480: if (decimals==-1) {
	ldhl	sp,#34
	ld	a,(hl)
	inc	a
	jp	Z,00319$
00318$:
	jr	00107$
00319$:
;../printf_large.c:481: width = 10*width + c - '0';
	inc	hl
	ld	a,(hl)
	ld	e,a
	add	a,a
	add	a,a
	add	a,e
	add	a,a
	ld	c,a
	add	a,b
	ld	c,a
	add	a,#0xD0
	ldhl	sp,#35
;../printf_large.c:482: if (width == 0) {
	ld	(hl),a
	or	a,a
	jp	NZ,00101$
;../printf_large.c:484: zero_padding = 1;
	ldhl	sp,#51
	ld	(hl),#0x01
	jp	00101$
00107$:
;../printf_large.c:487: decimals = 10*decimals + c - '0';
	ldhl	sp,#34
	ld	a,(hl)
	ld	e,a
	add	a,a
	add	a,a
	add	a,e
	add	a,a
	ld	c,a
	add	a,b
	ld	c,a
	add	a,#0xD0
	ldhl	sp,#34
	ld	(hl),a
;../printf_large.c:489: goto get_conversion_spec;
	jp	00101$
00110$:
;../printf_large.c:492: if (c=='.') {
	ld	a,b
	sub	a,#0x2E
	jp	Z,00321$
00320$:
	jr	00115$
00321$:
;../printf_large.c:493: if (decimals==-1) decimals=0;
	ldhl	sp,#34
	ld	a,(hl)
	inc	a
	jp	Z,00323$
00322$:
	jp	00101$
00323$:
	ld	(hl),#0x00
;../printf_large.c:496: goto get_conversion_spec;
	jp	00101$
00115$:
;../printf_large.c:499: if (islower(c))
	ld	c,b
	ld	a,c
	sub	a, #0x61
	jp	C,00117$
	ld	c,b
	ld	a,#0x7A
	sub	a, c
	jp	C,00117$
;../printf_large.c:501: c = toupper(c);
	ld	a,b
	and	a,#0xDF
	ld	b,a
;../printf_large.c:502: lower_case = 1;
	ldhl	sp,#44
	ld	(hl),#0x01
	jr	00118$
00117$:
;../printf_large.c:505: lower_case = 0;
	ldhl	sp,#44
	ld	(hl),#0x00
00118$:
;../printf_large.c:507: switch( c )
	ld	a,b
	sub	a,#0x20
	jp	Z,00122$
00324$:
	ld	a,b
	sub	a,#0x2B
	jp	Z,00121$
00325$:
	ld	a,b
	sub	a,#0x2D
	jp	Z,00120$
00326$:
	ld	a,b
	sub	a,#0x42
	jp	Z,00123$
00327$:
	ld	a,b
	sub	a,#0x43
	jp	Z,00125$
00328$:
	ld	a,b
	sub	a,#0x44
	jp	Z,00150$
00329$:
	ld	a,b
	sub	a,#0x46
	jp	Z,00154$
00330$:
	ld	a,b
	sub	a,#0x49
	jp	Z,00150$
00331$:
	ld	a,b
	sub	a,#0x4C
	jp	Z,00124$
00332$:
	ld	a,b
	sub	a,#0x4F
	jp	Z,00151$
00333$:
	ld	a,b
	sub	a,#0x50
	jp	Z,00148$
00334$:
	ld	a,b
	sub	a,#0x53
	jp	Z,00129$
00335$:
	ld	a,b
	sub	a,#0x55
	jp	Z,00152$
00336$:
	ld	a,b
	sub	a,#0x58
	jp	Z,00153$
00337$:
	jp	00155$
;../printf_large.c:509: case '-':
00120$:
;../printf_large.c:510: left_justify = 1;
	ldhl	sp,#52
	ld	(hl),#0x01
;../printf_large.c:511: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:512: case '+':
00121$:
;../printf_large.c:513: prefix_sign = 1;
	ldhl	sp,#50
	ld	(hl),#0x01
;../printf_large.c:514: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:515: case ' ':
00122$:
;../printf_large.c:516: prefix_space = 1;
	ldhl	sp,#49
	ld	(hl),#0x01
;../printf_large.c:517: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:518: case 'B':
00123$:
;../printf_large.c:519: char_argument = 1;
	ldhl	sp,#47
	ld	(hl),#0x01
;../printf_large.c:520: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:521: case 'L':
00124$:
;../printf_large.c:522: long_argument = 1;
	ldhl	sp,#46
	ld	(hl),#0x01
;../printf_large.c:523: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:525: case 'C':
00125$:
;../printf_large.c:526: if( char_argument )
	ldhl	sp,#47
	bit	0,(hl)
	jp	Z,00127$
;../printf_large.c:527: c = va_arg(ap,char);
	ldhl	sp,#61
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	dec	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	dec	bc
	ld	a,(bc)
	ld	b,a
	jr	00128$
00127$:
;../printf_large.c:529: c = va_arg(ap,int);
	ldhl	sp,#61
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	dec	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	dec	bc
	dec	bc
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#15
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	b,(hl)
00128$:
;../printf_large.c:530: OUTPUT_CHAR( c, p );
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	inc	sp
	ld	hl,#00338$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00338$:
	lda	sp,3(sp)
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00156$
	inc	hl
	inc	(hl)
00339$:
;../printf_large.c:531: break;
	jp	00156$
;../printf_large.c:533: case 'S':
00129$:
;../printf_large.c:534: PTR = va_arg(ap,ptr_t);
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ldhl	sp,#62
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#61
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#14
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	e,c
	ld	d,b
	dec	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../printf_large.c:544: length = strlen(PTR);
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_strlen
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	ldhl	sp,#12
	ld	(hl),c
;../printf_large.c:546: if ( decimals == -1 )
	ldhl	sp,#34
	ld	a,(hl)
	inc	a
	jp	Z,00341$
00340$:
	jr	00131$
00341$:
;../printf_large.c:548: decimals = length;
	push	hl
	ldhl	sp,#12
	ld	a,(hl)
	ldhl	sp,#34
	ld	(hl),a
	pop	hl
00131$:
;../printf_large.c:550: if ( ( !left_justify ) && (length < width) )
	ldhl	sp,#52
	bit	0,(hl)
	jp	NZ,00269$
	ldhl	sp,#12
	ld	a,(hl)
	ldhl	sp,#35
	sub	a, (hl)
	jp	NC,00269$
;../printf_large.c:552: width -= length;
	ld	a,(hl)
	ldhl	sp,#12
	sub	a,(hl)
	ldhl	sp,#35
	ld	(hl),a
;../printf_large.c:553: while( width-- != 0 )
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#35
	ld	b,(hl)
00132$:
	ld	c,b
	dec	b
	ldhl	sp,#35
	ld	(hl),b
	xor	a,a
	or	a,c
	jp	Z,00304$
;../printf_large.c:555: OUTPUT_CHAR( ' ', p );
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00342$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00342$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#13
	inc	(hl)
	jp	NZ,00343$
	inc	hl
	inc	(hl)
00343$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jr	00132$
;../printf_large.c:559: while ( (c = *PTR)  && (decimals-- > 0))
00304$:
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#35
	ld	(hl),b
00269$:
	push	hl
	ldhl	sp,#34
	ld	a,(hl)
	ldhl	sp,#15
	ld	(hl),a
	pop	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),e
00139$:
	ldhl	sp,#24
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	ld	a,(bc)
	ld	c,a
	ld	b,c
	xor	a,a
	or	a,c
	jp	Z,00305$
	ldhl	sp,#15
	ld	c,(hl)
	dec	(hl)
	ld	a, c
	ld	e, a
	ld	a, #0x00
	ld	d, a
	ld	a,#0x00
	sub	a, c
	bit	7, e
	jp	Z, 00344$
	bit	7, d
	jp	NZ, 00345$
	cp	a, a
	jr	00345$
00344$:
	bit	7, d
	jp	Z, 00345$
	scf
00345$:
	jp	NC,00305$
;../printf_large.c:561: OUTPUT_CHAR( c, p );
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	inc	sp
	ld	hl,#00346$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00346$:
	lda	sp,3(sp)
	ldhl	sp,#13
	inc	(hl)
	jp	NZ,00347$
	inc	hl
	inc	(hl)
00347$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../printf_large.c:562: PTR++;
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#8
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	inc	(hl)
	jp	NZ,00348$
	inc	hl
	inc	(hl)
00348$:
	ld	e,c
	ld	d,b
	dec	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	jp	00139$
00305$:
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../printf_large.c:565: if ( left_justify && (length < width))
	ldhl	sp,#52
	bit	0,(hl)
	jp	Z,00156$
	ldhl	sp,#12
	ld	a,(hl)
	ldhl	sp,#35
	sub	a, (hl)
	jp	NC,00156$
;../printf_large.c:567: width -= length;
	ld	a,(hl)
	ldhl	sp,#12
	sub	a,(hl)
	ldhl	sp,#35
	ld	(hl),a
;../printf_large.c:568: while( width-- != 0 )
	ldhl	sp,#13
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#37
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#35
	ld	b,(hl)
00142$:
	ld	c,b
	dec	b
	ldhl	sp,#35
	ld	(hl),b
	xor	a,a
	or	a,c
	jp	Z,00306$
;../printf_large.c:570: OUTPUT_CHAR( ' ', p );
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00349$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00349$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#37
	inc	(hl)
	jp	NZ,00350$
	inc	hl
	inc	(hl)
00350$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jr	00142$
;../printf_large.c:575: case 'P':
00148$:
;../printf_large.c:576: PTR = va_arg(ap,ptr_t);
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ldhl	sp,#62
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#61
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#14
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	e,c
	ld	d,b
	dec	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../printf_large.c:620: OUTPUT_CHAR('0', p);
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x30
	push	af
	inc	sp
	ld	hl,#00351$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00351$:
	lda	sp,3(sp)
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00352$
	inc	hl
	inc	(hl)
00352$:
;../printf_large.c:621: OUTPUT_CHAR('x', p);
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x78
	push	af
	inc	sp
	ld	hl,#00353$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00353$:
	lda	sp,3(sp)
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00354$
	inc	hl
	inc	(hl)
00354$:
;../printf_large.c:622: OUTPUT_2DIGITS( value.byte[1] );
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	inc	bc
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#48
	ld	a,(hl)
	push	af
	inc	sp
	ld	a,c
	push	af
	inc	sp
	call	_output_2digits
	lda	sp,6(sp)
	ldhl	sp,#22
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../printf_large.c:623: OUTPUT_2DIGITS( value.byte[0] );
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#48
	ld	a,(hl)
	push	af
	inc	sp
	ld	a,c
	push	af
	inc	sp
	call	_output_2digits
	lda	sp,6(sp)
	ldhl	sp,#22
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../printf_large.c:625: break;
	jp	00156$
;../printf_large.c:628: case 'I':
00150$:
;../printf_large.c:629: signed_argument = 1;
	ldhl	sp,#48
	ld	(hl),#0x01
;../printf_large.c:630: radix = 10;
	ldhl	sp,#36
	ld	(hl),#0x0A
;../printf_large.c:631: break;
	jp	00156$
;../printf_large.c:633: case 'O':
00151$:
;../printf_large.c:634: radix = 8;
	ldhl	sp,#36
	ld	(hl),#0x08
;../printf_large.c:635: break;
	jp	00156$
;../printf_large.c:637: case 'U':
00152$:
;../printf_large.c:638: radix = 10;
	ldhl	sp,#36
	ld	(hl),#0x0A
;../printf_large.c:639: break;
	jr	00156$
;../printf_large.c:641: case 'X':
00153$:
;../printf_large.c:642: radix = 16;
	ldhl	sp,#36
	ld	(hl),#0x10
;../printf_large.c:643: break;
	jr	00156$
;../printf_large.c:645: case 'F':
00154$:
;../printf_large.c:646: float_argument=1;
	ldhl	sp,#45
	ld	(hl),#0x01
;../printf_large.c:647: break;
	jr	00156$
;../printf_large.c:649: default:
00155$:
;../printf_large.c:651: OUTPUT_CHAR( c, p );
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	inc	sp
	ld	hl,#00355$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00355$:
	lda	sp,3(sp)
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00156$
	inc	hl
	inc	(hl)
00356$:
;../printf_large.c:828: return charsOutputted;
	jr	00156$
;../printf_large.c:653: }
00306$:
	ldhl	sp,#37
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#35
	ld	(hl),b
00156$:
;../printf_large.c:655: if (float_argument) {
	ldhl	sp,#45
	bit	0,(hl)
	jp	Z,00222$
;../printf_large.c:656: value.f=va_arg(ap,float);
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ldhl	sp,#62
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#61
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ldhl	sp,#11
	ld	(hl),a
	dec	hl
	ld	(hl),e
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	e,c
	ld	d,b
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../printf_large.c:658: PTR="<NO FLOAT>";
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,#<(__str_0)
	ld	(de),a
	inc	de
	ld	a,#>(__str_0)
	ld	(de),a
;../printf_large.c:659: while (c=*PTR++)
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
00157$:
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#10
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#13
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ld	e,c
	ld	d,b
	dec	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	b,c
	xor	a,a
	or	a,c
	jp	Z,00227$
;../printf_large.c:661: OUTPUT_CHAR (c, p);
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	inc	sp
	ld	hl,#00357$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00357$:
	lda	sp,3(sp)
	ldhl	sp,#4
	inc	(hl)
	jp	NZ,00358$
	inc	hl
	inc	(hl)
00358$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jp	00157$
00222$:
;../printf_large.c:678: } else if (radix != 0)
	xor	a,a
	ldhl	sp,#36
	or	a,(hl)
	jp	Z,00227$
;../printf_large.c:683: unsigned char MEM_SPACE_BUF_PP *pstore = &store[5];
	ldhl	sp,#17
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#25
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../printf_large.c:686: if (char_argument)
	ldhl	sp,#47
	bit	0,(hl)
	jp	Z,00168$
;../printf_large.c:688: value.l = va_arg(ap,char);
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#61
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	dec	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	dec	bc
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#0
	ld	(hl),c
	ld	a,c
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#0
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../printf_large.c:689: if (!signed_argument)
	ldhl	sp,#48
	bit	0,(hl)
	jp	NZ,00169$
;../printf_large.c:691: value.l &= 0xFF;
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	dec	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#0
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	jp	00169$
00168$:
;../printf_large.c:694: else if (long_argument)
	ldhl	sp,#46
	bit	0,(hl)
	jp	Z,00165$
;../printf_large.c:696: value.l = va_arg(ap,long);
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ldhl	sp,#62
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#61
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ldhl	sp,#5
	ld	(hl),a
	dec	hl
	ld	(hl),e
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ld	e,c
	ld	d,b
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	jp	00169$
00165$:
;../printf_large.c:700: value.l = va_arg(ap,int);
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ldhl	sp,#62
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#61
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ldhl	sp,#5
	ld	(hl),a
	dec	hl
	ld	(hl),e
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	dec	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	ld	(hl),a
	ld	a,(hl)
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	ld	e,c
	ld	d,b
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
;../printf_large.c:701: if (!signed_argument)
	ldhl	sp,#48
	bit	0,(hl)
	jp	NZ,00169$
;../printf_large.c:703: value.l &= 0xFFFF;
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	dec	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ld	e,c
	ld	d,b
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
00169$:
;../printf_large.c:707: if ( signed_argument )
	ldhl	sp,#48
	bit	0,(hl)
	jp	Z,00174$
;../printf_large.c:709: if (value.l < 0)
	ldhl	sp,#39
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ldhl	sp,#4
	ld	a, (hl)
	sub	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	inc	hl
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jp	Z, 00359$
	bit	7, d
	jp	NZ, 00360$
	cp	a, a
	jr	00360$
00359$:
	bit	7, d
	jp	Z, 00360$
	scf
00360$:
	jp	NC,00171$
;../printf_large.c:710: value.l = -value.l;
	ld	de,#0x0000
	ld	a,e
	ldhl	sp,#4
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ld	de,#0x0000
	inc	hl
	inc	hl
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ld	e,c
	ld	d,b
	dec	hl
	dec	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	jr	00174$
00171$:
;../printf_large.c:712: signed_argument = 0;
	ldhl	sp,#48
	ld	(hl),#0x00
00174$:
;../printf_large.c:716: lsd = 1;
	ld	b,#0x01
;../printf_large.c:718: do {
	ldhl	sp,#25
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#33
	ld	(hl),#0x00
00178$:
;../printf_large.c:719: value.byte[4] = 0;
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x00
	ld	(de),a
;../printf_large.c:721: calculate_digit(&value, radix);
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	push	bc
	ldhl	sp,#38
	ld	a,(hl)
	push	af
	inc	sp
	ldhl	sp,#7
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_calculate_digit
	lda	sp,3(sp)
	pop	bc
;../printf_large.c:725: if (!lsd)
	bit	0,b
	jp	NZ,00176$
;../printf_large.c:727: *pstore = (value.byte[4] << 4) | (value.byte[4] >> 4) | *pstore;
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ldhl	sp,#8
	ld	(hl),a
	srl	c
	srl	c
	srl	c
	srl	c
	ld	a,c
	or	a, (hl)
	ld	c,a
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	or	a, c
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
;../printf_large.c:728: pstore--;
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	de
	dec	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#25
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jr	00177$
00176$:
;../printf_large.c:732: *pstore = value.byte[4];
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
00177$:
;../printf_large.c:734: length++;
	ldhl	sp,#33
	inc	(hl)
	push	hl
	ld	a,(hl)
	ldhl	sp,#12
	ld	(hl),a
	pop	hl
;../printf_large.c:735: lsd = !lsd;
	ld	a,b
	xor	a,#0x01
	ld	b,a
;../printf_large.c:736: } while( value.ul );
	ldhl	sp,#20
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ldhl	sp,#4
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00178$
;../printf_large.c:738: if (width == 0)
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#25
	ld	(hl),a
	inc	hl
	ld	(hl),e
	push	hl
	ldhl	sp,#33
	ld	a,(hl)
	ldhl	sp,#12
	ld	(hl),a
	pop	hl
	xor	a,a
	ldhl	sp,#35
	or	a,(hl)
	jp	NZ,00182$
;../printf_large.c:743: width=1;
	ld	(hl),#0x01
00182$:
;../printf_large.c:747: if (!zero_padding && !left_justify)
	ldhl	sp,#51
	bit	0,(hl)
	jp	NZ,00187$
	inc	hl
	bit	0,(hl)
	jp	NZ,00187$
;../printf_large.c:749: while ( width > (unsigned char) (length+1) )
	ldhl	sp,#12
	ld	c,(hl)
	inc	c
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	push	hl
	ldhl	sp,#35
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	pop	hl
00183$:
	ld	a,c
	ldhl	sp,#4
	sub	a, (hl)
	jp	NC,00308$
;../printf_large.c:751: OUTPUT_CHAR( ' ', p );
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00361$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00361$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00362$
	inc	hl
	inc	(hl)
00362$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../printf_large.c:752: width--;
	ldhl	sp,#4
	dec	(hl)
	jr	00183$
00308$:
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	push	hl
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#35
	ld	(hl),a
	pop	hl
00187$:
;../printf_large.c:756: if (signed_argument) // this now means the original value was negative
	ldhl	sp,#48
	bit	0,(hl)
	jp	Z,00197$
;../printf_large.c:758: OUTPUT_CHAR( '-', p );
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x2D
	push	af
	inc	sp
	ld	hl,#00363$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00363$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00364$
	inc	hl
	inc	(hl)
00364$:
;../printf_large.c:760: width--;
	ldhl	sp,#35
	dec	(hl)
	jp	00198$
00197$:
;../printf_large.c:762: else if (length != 0)
	xor	a,a
	ldhl	sp,#12
	or	a,(hl)
	jp	Z,00198$
;../printf_large.c:765: if (prefix_sign)
	ldhl	sp,#50
	bit	0,(hl)
	jp	Z,00192$
;../printf_large.c:767: OUTPUT_CHAR( '+', p );
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x2B
	push	af
	inc	sp
	ld	hl,#00365$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00365$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00366$
	inc	hl
	inc	(hl)
00366$:
;../printf_large.c:769: width--;
	ldhl	sp,#35
	dec	(hl)
	jr	00198$
00192$:
;../printf_large.c:771: else if (prefix_space)
	ldhl	sp,#49
	bit	0,(hl)
	jp	Z,00198$
;../printf_large.c:773: OUTPUT_CHAR( ' ', p );
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00367$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00367$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00368$
	inc	hl
	inc	(hl)
00368$:
;../printf_large.c:775: width--;
	ldhl	sp,#35
	dec	(hl)
00198$:
;../printf_large.c:780: if (!left_justify)
	ldhl	sp,#52
	bit	0,(hl)
	jp	NZ,00206$
;../printf_large.c:781: while ( width-- > length )
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	push	hl
	ldhl	sp,#35
	ld	a,(hl)
	ldhl	sp,#4
	ld	(hl),a
	pop	hl
00199$:
	ldhl	sp,#4
	ld	c,(hl)
	dec	(hl)
	push	hl
	ld	a,(hl)
	ldhl	sp,#35
	ld	(hl),a
	pop	hl
	ldhl	sp,#12
	ld	a,(hl)
	sub	a, c
	jp	NC,00309$
;../printf_large.c:783: OUTPUT_CHAR( zero_padding ? '0' : ' ', p );
	ldhl	sp,#51
	bit	0,(hl)
	jp	Z,00232$
	ld	c,#0x30
	jr	00233$
00232$:
	ld	c,#0x20
00233$:
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,c
	push	af
	inc	sp
	ld	hl,#00369$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00369$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00370$
	inc	hl
	inc	(hl)
00370$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jp	00199$
00206$:
;../printf_large.c:788: if (width > length)
	ldhl	sp,#12
	ld	a,(hl)
	ldhl	sp,#35
	sub	a, (hl)
	jp	NC,00203$
;../printf_large.c:789: width -= length;
	ld	a,(hl)
	ldhl	sp,#12
	sub	a,(hl)
	ldhl	sp,#35
	ld	(hl),a
	jr	00301$
00203$:
;../printf_large.c:791: width = 0;
	ldhl	sp,#35
	ld	(hl),#0x00
;../printf_large.c:828: return charsOutputted;
	jr	00301$
;../printf_large.c:795: while( length-- )
00309$:
	ldhl	sp,#0
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	push	hl
	ldhl	sp,#4
	ld	a,(hl)
	ldhl	sp,#35
	ld	(hl),a
	pop	hl
00301$:
	ldhl	sp,#25
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),e
	push	hl
	ldhl	sp,#12
	ld	a,(hl)
	ldhl	sp,#8
	ld	(hl),a
	pop	hl
00211$:
	ldhl	sp,#8
	ld	c,(hl)
	dec	(hl)
	xor	a,a
	or	a,c
	jp	Z,00310$
;../printf_large.c:797: lsd = !lsd;
	ld	a,b
	xor	a,#0x01
	ld	b,a
;../printf_large.c:798: if (!lsd)
	bit	0,b
	jp	NZ,00209$
;../printf_large.c:800: pstore++;
	ldhl	sp,#0
	inc	(hl)
	jp	NZ,00371$
	inc	hl
	inc	(hl)
00371$:
;../printf_large.c:801: value.byte[4] = *pstore >> 4;
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	srl	c
	srl	c
	srl	c
	srl	c
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,c
	ld	(de),a
	jr	00210$
00209$:
;../printf_large.c:805: value.byte[4] = *pstore & 0x0F;
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#1
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	and	a,#0x0F
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	(de),a
00210$:
;../printf_large.c:808: output_digit( value.byte[4], lower_case, output_char, p );
	ldhl	sp,#39
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#50
	ld	a,(hl)
	push	af
	inc	sp
	ld	a,c
	push	af
	inc	sp
	call	_output_digit
	lda	sp,6(sp)
	pop	bc
;../printf_large.c:809: charsOutputted++;
	ldhl	sp,#4
	inc	(hl)
	jp	NZ,00372$
	inc	hl
	inc	(hl)
00372$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jp	00211$
00310$:
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
;../printf_large.c:814: if (left_justify)
	ldhl	sp,#52
	bit	0,(hl)
	jp	Z,00227$
;../printf_large.c:815: while (width-- > 0)
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#37
	ld	(hl),a
	inc	hl
	ld	(hl),e
	ldhl	sp,#35
	ld	b,(hl)
00214$:
	ld	c,b
	dec	b
	xor	a,a
	or	a,c
	jp	Z,00227$
;../printf_large.c:817: OUTPUT_CHAR(' ', p);
	push	bc
	ldhl	sp,#59
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00373$
	push	hl
	ldhl	sp,#62
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00373$:
	lda	sp,3(sp)
	pop	bc
	ldhl	sp,#37
	inc	(hl)
	jp	NZ,00374$
	inc	hl
	inc	(hl)
00374$:
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#21
	ld	(hl),a
	inc	hl
	ld	(hl),e
	jr	00214$
00225$:
;../printf_large.c:824: OUTPUT_CHAR( c, p );
	ldhl	sp,#57
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	inc	sp
	ld	hl,#00375$
	push	hl
	ldhl	sp,#60
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	jp	(hl)
00375$:
	lda	sp,3(sp)
	ldhl	sp,#21
	inc	(hl)
	jp	NZ,00227$
	inc	hl
	inc	(hl)
00376$:
	jp	00227$
00229$:
;../printf_large.c:828: return charsOutputted;
	ldhl	sp,#22
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
00230$:
	lda	sp,53(sp)
	ret
__print_format_end::
__str_0:
	.ascii "<NO FLOAT>"
	.db 0x00
	.area _CODE
	.area _CABS
