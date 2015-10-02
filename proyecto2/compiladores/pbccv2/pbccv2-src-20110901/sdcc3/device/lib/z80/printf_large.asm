;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module printf_large
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __print_format
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
;../printf_large.c:116: output_digit (unsigned char n, BOOL lower_case, pfn_outputchar output_char, void* p)
;	---------------------------------
; Function output_digit
; ---------------------------------
_output_digit:
	push	ix
	ld	ix,#0
	add	ix,sp
;../printf_large.c:118: register unsigned char c = n + (unsigned char)'0';
	ld	a,4 (ix)
	add	a,#0x30
	ld	c,a
;../printf_large.c:120: if (c > (unsigned char)'9')
	ld	a,#0x39
	sub	a, c
	jr	NC,00104$
;../printf_large.c:122: c += (unsigned char)('A' - '0' - 10);
	ld	a,c
	add	a,#0x07
	ld	c,a
;../printf_large.c:123: if (lower_case)
	bit	0,5 (ix)
	jr	Z,00104$
;../printf_large.c:124: c += (unsigned char)('a' - 'A');
	ld	a,c
	add	a,#0x20
	ld	c,a
00104$:
;../printf_large.c:126: output_char( c, p );
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	a,c
	push	af
	inc	sp
	ld	hl,#00109$
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	jp	(hl)
00109$:
	pop	af
	inc	sp
	pop	ix
	ret
;../printf_large.c:149: output_2digits (unsigned char b, BOOL lower_case, pfn_outputchar output_char, void* p)
;	---------------------------------
; Function output_2digits
; ---------------------------------
_output_2digits:
	push	ix
	ld	ix,#0
	add	ix,sp
;../printf_large.c:151: output_digit( b>>4,   lower_case, output_char, p );
	ld	c,4 (ix)
	srl	c
	srl	c
	srl	c
	srl	c
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	b, 5 (ix)
	push	bc
	call	_output_digit
	pop	af
	pop	af
	pop	af
;../printf_large.c:152: output_digit( b&0x0F, lower_case, output_char, p );
	ld	a,4 (ix)
	and	a,#0x0F
	ld	c,a
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	b, 5 (ix)
	push	bc
	call	_output_digit
	pop	af
	pop	af
	pop	af
	pop	ix
	ret
;../printf_large.c:168: calculate_digit (value_t _AUTOMEM * value, unsigned char radix)
;	---------------------------------
; Function calculate_digit
; ---------------------------------
_calculate_digit:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-9
	add	hl,sp
	ld	sp,hl
;../printf_large.c:170: unsigned long ul = value->ul;
	ld	a,4 (ix)
	ld	-9 (ix),a
	ld	a,5 (ix)
	ld	-8 (ix),a
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	-4 (ix),c
	ld	-3 (ix),b
	ld	-2 (ix),e
	ld	-1 (ix),d
;../printf_large.c:171: unsigned char _AUTOMEM * pb4 = &value->byte[4];
	ld	a,-9 (ix)
	add	a,#0x04
	ld	-6 (ix),a
	ld	a,-8 (ix)
	adc	a,#0x00
	ld	-5 (ix),a
;../printf_large.c:174: do
	ld	-7 (ix),#0x20
00103$:
;../printf_large.c:176: *pb4 = (*pb4 << 1) | ((ul >> 31) & 0x01);
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	a,(hl)
	add	a,a
	ld	d,a
	ld	a,-1 (ix)
	rlc	a
	and	a,#0x01
	or	a, d
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),a
;../printf_large.c:177: ul <<= 1;
	ld	a,#0x01
	push	af
	inc	sp
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__rlulong_rrx_s
	pop	af
	pop	af
	inc	sp
	ld	b,d
	ld	c,e
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),c
	ld	-1 (ix),b
;../printf_large.c:179: if (radix <= *pb4 )
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	l,(hl)
	ld	a,l
	sub	a, 6 (ix)
	jr	C,00104$
;../printf_large.c:181: *pb4 -= radix;
	ld	a,l
	sub	a,6 (ix)
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),a
;../printf_large.c:182: ul |= 1;
	ld	a,-4 (ix)
	set	0, a
	ld	-4 (ix),a
00104$:
;../printf_large.c:184: } while (--i);
	dec	-7 (ix)
	jr	NZ,00103$
;../printf_large.c:185: value->ul = ul;
	ld	l,-9 (ix)
	ld	h,-8 (ix)
	ld	a,-4 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-3 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-2 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-1 (ix)
	ld	(hl),a
	ld	sp,ix
	pop	ix
	ret
;../printf_large.c:414: _print_format (pfn_outputchar pfn, void* pvoid, const char *format, va_list ap)
;	---------------------------------
; Function _print_format
; ---------------------------------
__print_format_start::
__print_format:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-47
	add	hl,sp
	ld	sp,hl
;../printf_large.c:446: charsOutputted = 0;
	ld	-32 (ix),#0x00
	ld	-31 (ix),#0x00
;../printf_large.c:454: while( c=*format++ )
	ld	hl,#0x0021
	add	hl,sp
	ld	-36 (ix),l
	ld	-35 (ix),h
	ld	hl,#0x0017
	add	hl,sp
	ld	a,l
	add	a,#0x05
	ld	-28 (ix),a
	ld	a,h
	adc	a,#0x00
	ld	-27 (ix),a
	ld	hl,#0x0021
	add	hl,sp
	ld	-30 (ix),l
	ld	-29 (ix),h
00227$:
	ld	l,8 (ix)
	ld	h,9 (ix)
	ld	c,(hl)
	ld	a,l
	add	a,#0x01
	ld	8 (ix),a
	ld	a,h
	adc	a,#0x00
	ld	9 (ix),a
	ld	b,c
	xor	a,a
	or	a,c
	jp	Z,00229$
;../printf_large.c:456: if ( c=='%' )
	ld	a,b
	sub	a,#0x25
	jp	NZ,00225$
;../printf_large.c:458: left_justify    = 0;
	ld	-1 (ix),#0x00
;../printf_large.c:459: zero_padding    = 0;
	ld	-2 (ix),#0x00
;../printf_large.c:460: prefix_sign     = 0;
	ld	-3 (ix),#0x00
;../printf_large.c:461: prefix_space    = 0;
	ld	-4 (ix),#0x00
;../printf_large.c:462: signed_argument = 0;
	ld	-5 (ix),#0x00
;../printf_large.c:463: char_argument   = 0;
	ld	-6 (ix),#0x00
;../printf_large.c:464: long_argument   = 0;
	ld	-7 (ix),#0x00
;../printf_large.c:465: float_argument  = 0;
	ld	-8 (ix),#0x00
;../printf_large.c:466: radix           = 0;
	ld	-15 (ix),#0x00
;../printf_large.c:467: width           = 0;
	ld	-16 (ix),#0x00
;../printf_large.c:468: decimals        = -1;
	ld	-17 (ix),#0xFF
;../printf_large.c:470: get_conversion_spec:
	ld	e,8 (ix)
	ld	d,9 (ix)
00101$:
;../printf_large.c:472: c = *format++;
	ld	a,(de)
	ld	c,a
	inc	de
	ld	8 (ix),e
	ld	9 (ix),d
	ld	b,c
;../printf_large.c:474: if (c=='%') {
	ld	a,b
	sub	a,#0x25
	jr	NZ,00103$
;../printf_large.c:475: OUTPUT_CHAR(c, p);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	ld	hl,#00315$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00315$:
	pop	af
	inc	sp
	inc	-32 (ix)
	jp	NZ,00227$
	inc	-31 (ix)
;../printf_large.c:476: continue;
	jp	00227$
00103$:
;../printf_large.c:479: if (isdigit(c)) {
	ld	a, b
	sub	a, #0x30
	jr	C,00110$
	ld	l,b
	ld	a,#0x39
	sub	a, l
	jr	C,00110$
;../printf_large.c:480: if (decimals==-1) {
	ld	a,-17 (ix)
	inc	a
	jr	NZ,00107$
;../printf_large.c:481: width = 10*width + c - '0';
	push	de
	ld	a,-16 (ix)
	ld	e,a
	add	a,a
	add	a,a
	add	a,e
	add	a,a
	pop	de
	add	a,b
	add	a,#0xD0
	ld	-16 (ix),a
;../printf_large.c:482: if (width == 0) {
	xor	a,a
	or	a,-16 (ix)
	jr	NZ,00101$
;../printf_large.c:484: zero_padding = 1;
	ld	-2 (ix),#0x01
	jr	00101$
00107$:
;../printf_large.c:487: decimals = 10*decimals + c - '0';
	push	de
	ld	a,-17 (ix)
	ld	e,a
	add	a,a
	add	a,a
	add	a,e
	add	a,a
	pop	de
	add	a,b
	add	a,#0xD0
	ld	-17 (ix),a
;../printf_large.c:489: goto get_conversion_spec;
	jr	00101$
00110$:
;../printf_large.c:492: if (c=='.') {
	ld	a,b
	sub	a,#0x2E
	jr	NZ,00115$
;../printf_large.c:493: if (decimals==-1) decimals=0;
	ld	a,-17 (ix)
	inc	a
	jp	NZ,00101$
	ld	-17 (ix),#0x00
;../printf_large.c:496: goto get_conversion_spec;
	jp	00101$
00115$:
;../printf_large.c:499: if (islower(c))
	ld	a, b
	sub	a, #0x61
	jr	C,00117$
	ld	l,b
	ld	a,#0x7A
	sub	a, l
	jr	C,00117$
;../printf_large.c:501: c = toupper(c);
	ld	a,b
	and	a,#0xDF
	ld	b,a
;../printf_large.c:502: lower_case = 1;
	ld	-9 (ix),#0x01
	jr	00118$
00117$:
;../printf_large.c:505: lower_case = 0;
	ld	-9 (ix),#0x00
00118$:
;../printf_large.c:507: switch( c )
	ld	a,b
	cp	a,#0x20
	jr	Z,00122$
	cp	a,##0x2B
	jr	Z,00121$
	cp	a,#0x2D
	jr	Z,00120$
	cp	a,##0x42
	jr	Z,00123$
	cp	a,#0x43
	jr	Z,00125$
	cp	a,##0x44
	jp	Z,00150$
	cp	a,#0x46
	jp	Z,00154$
	cp	a,##0x49
	jp	Z,00150$
	cp	a,#0x4C
	jr	Z,00124$
	cp	a,##0x4F
	jp	Z,00151$
	cp	a,#0x50
	jp	Z,00148$
	cp	a,##0x53
	jp	Z,00129$
	cp	a,#0x55
	jp	Z,00152$
	sub	a,#0x58
	jp	Z,00153$
	jp	00155$
;../printf_large.c:509: case '-':
00120$:
;../printf_large.c:510: left_justify = 1;
	ld	-1 (ix),#0x01
;../printf_large.c:511: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:512: case '+':
00121$:
;../printf_large.c:513: prefix_sign = 1;
	ld	-3 (ix),#0x01
;../printf_large.c:514: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:515: case ' ':
00122$:
;../printf_large.c:516: prefix_space = 1;
	ld	-4 (ix),#0x01
;../printf_large.c:517: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:518: case 'B':
00123$:
;../printf_large.c:519: char_argument = 1;
	ld	-6 (ix),#0x01
;../printf_large.c:520: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:521: case 'L':
00124$:
;../printf_large.c:522: long_argument = 1;
	ld	-7 (ix),#0x01
;../printf_large.c:523: goto get_conversion_spec;
	jp	00101$
;../printf_large.c:525: case 'C':
00125$:
;../printf_large.c:526: if( char_argument )
	bit	0,-6 (ix)
	jr	Z,00127$
;../printf_large.c:527: c = va_arg(ap,char);
	ld	a,10 (ix)
	add	a,#0x01
	ld	c,a
	ld	a,11 (ix)
	adc	a,#0x00
	ld	e,a
	ld	10 (ix),c
	ld	11 (ix),e
	ld	l,c
	ld	h,e
	dec	hl
	ld	a,(hl)
	ld	b,a
	jr	00128$
00127$:
;../printf_large.c:529: c = va_arg(ap,int);
	ld	e,10 (ix)
	ld	d,11 (ix)
	inc	de
	inc	de
	ld	10 (ix),e
	ld	11 (ix),d
	ld	l,e
	ld	h,d
	dec	hl
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	b, a
00128$:
;../printf_large.c:530: OUTPUT_CHAR( c, p );
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	ld	hl,#00337$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00337$:
	pop	af
	inc	sp
	inc	-32 (ix)
	jp	NZ,00156$
	inc	-31 (ix)
;../printf_large.c:531: break;
	jp	00156$
;../printf_large.c:533: case 'S':
00129$:
;../printf_large.c:534: PTR = va_arg(ap,ptr_t);
	ld	hl,#0x0021
	add	hl,sp
	ld	-34 (ix),l
	ld	-33 (ix),h
	ld	a,10 (ix)
	add	a,#0x02
	ld	c,a
	ld	a,11 (ix)
	adc	a,#0x00
	ld	e,a
	ld	10 (ix),c
	ld	11 (ix),e
	ld	l,c
	ld	h,e
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,-34 (ix)
	ld	h,-33 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../printf_large.c:544: length = strlen(PTR);
	push	de
	call	_strlen
	pop	af
	ld	-37 (ix),l
;../printf_large.c:546: if ( decimals == -1 )
	ld	a,-17 (ix)
	inc	a
	jr	NZ,00131$
;../printf_large.c:548: decimals = length;
	ld	a,-37 (ix)
	ld	-17 (ix),a
00131$:
;../printf_large.c:550: if ( ( !left_justify ) && (length < width) )
	bit	0,-1 (ix)
	jr	NZ,00269$
	ld	a,-37 (ix)
	sub	a, -16 (ix)
	jr	NC,00269$
;../printf_large.c:552: width -= length;
	ld	a,-16 (ix)
	sub	a,-37 (ix)
	ld	-16 (ix),a
;../printf_large.c:553: while( width-- != 0 )
	ld	e,-32 (ix)
	ld	d,-31 (ix)
	ld	c,-16 (ix)
00132$:
	ld	l,c
	dec	c
	ld	-16 (ix),c
	xor	a,a
	or	a,l
	jr	Z,00304$
;../printf_large.c:555: OUTPUT_CHAR( ' ', p );
	push	bc
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00341$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00341$:
	pop	af
	inc	sp
	pop	de
	pop	bc
	inc	de
	ld	-32 (ix),e
	ld	-31 (ix),d
	jr	00132$
;../printf_large.c:559: while ( (c = *PTR)  && (decimals-- > 0))
00304$:
	ld	-32 (ix),e
	ld	-31 (ix),d
	ld	-16 (ix),c
00269$:
	ld	d,-17 (ix)
	ld	a,-32 (ix)
	ld	-34 (ix),a
	ld	a,-31 (ix)
	ld	-33 (ix),a
00139$:
	ld	l,-36 (ix)
	ld	h,-35 (ix)
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	l,(hl)
	ld	b,l
	xor	a,a
	or	a,l
	jr	Z,00305$
	ld	l,d
	dec	d
	ld	a,#0x00
	sub	a, l
	jp	PO, 00342$
	xor	a, #0x80
00342$:
	jp	P,00305$
;../printf_large.c:561: OUTPUT_CHAR( c, p );
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	ld	hl,#00343$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00343$:
	pop	af
	inc	sp
	pop	de
	inc	-34 (ix)
	jr	NZ,00344$
	inc	-33 (ix)
00344$:
	ld	a,-34 (ix)
	ld	-32 (ix),a
	ld	a,-33 (ix)
	ld	-31 (ix),a
;../printf_large.c:562: PTR++;
	ld	hl,#0x0021
	add	hl,sp
	ld	-39 (ix),l
	ld	-38 (ix),h
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	add	a,#0x01
	ld	e,a
	ld	a,h
	adc	a,#0x00
	ld	c,a
	ld	l,-39 (ix)
	ld	h,-38 (ix)
	ld	(hl),e
	inc	hl
	ld	(hl),c
	jr	00139$
00305$:
	ld	a,-34 (ix)
	ld	-32 (ix),a
	ld	a,-33 (ix)
	ld	-31 (ix),a
;../printf_large.c:565: if ( left_justify && (length < width))
	bit	0,-1 (ix)
	jp	Z,00156$
	ld	a,-37 (ix)
	sub	a, -16 (ix)
	jp	NC,00156$
;../printf_large.c:567: width -= length;
	ld	a,-16 (ix)
	sub	a,-37 (ix)
	ld	-16 (ix),a
;../printf_large.c:568: while( width-- != 0 )
	ld	e,-34 (ix)
	ld	d,-33 (ix)
	ld	c,-16 (ix)
00142$:
	ld	l,c
	dec	c
	ld	-16 (ix),c
	xor	a,a
	or	a,l
	jp	Z,00306$
;../printf_large.c:570: OUTPUT_CHAR( ' ', p );
	push	bc
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00345$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00345$:
	pop	af
	inc	sp
	pop	de
	pop	bc
	inc	de
	ld	-32 (ix),e
	ld	-31 (ix),d
	jr	00142$
;../printf_large.c:575: case 'P':
00148$:
;../printf_large.c:576: PTR = va_arg(ap,ptr_t);
	ld	hl,#0x0021
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	e,10 (ix)
	ld	d,11 (ix)
	inc	de
	inc	de
	ld	10 (ix),e
	ld	11 (ix),d
	ex	de,hl
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,c
	ld	h,b
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../printf_large.c:620: OUTPUT_CHAR('0', p);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x30
	push	af
	inc	sp
	ld	hl,#00346$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00346$:
	pop	af
	inc	sp
	inc	-32 (ix)
	jr	NZ,00347$
	inc	-31 (ix)
00347$:
;../printf_large.c:621: OUTPUT_CHAR('x', p);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x78
	push	af
	inc	sp
	ld	hl,#00348$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00348$:
	pop	af
	inc	sp
	inc	-32 (ix)
	jr	NZ,00349$
	inc	-31 (ix)
00349$:
;../printf_large.c:622: OUTPUT_2DIGITS( value.byte[1] );
	ld	hl,#0x0021+1
	add	hl,sp
	ld	c, (hl)
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	b, -9 (ix)
	push	bc
	call	_output_2digits
	pop	af
	pop	af
	pop	af
	ld	a,-32 (ix)
	add	a,#0x02
	ld	-32 (ix),a
	ld	a,-31 (ix)
	adc	a,#0x00
	ld	-31 (ix),a
;../printf_large.c:623: OUTPUT_2DIGITS( value.byte[0] );
	ld	hl,#0x0021
	add	hl,sp
	ld	c,(hl)
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	b, -9 (ix)
	push	bc
	call	_output_2digits
	pop	af
	pop	af
	pop	af
	ld	a,-32 (ix)
	add	a,#0x02
	ld	-32 (ix),a
	ld	a,-31 (ix)
	adc	a,#0x00
	ld	-31 (ix),a
;../printf_large.c:625: break;
	jr	00156$
;../printf_large.c:628: case 'I':
00150$:
;../printf_large.c:629: signed_argument = 1;
	ld	-5 (ix),#0x01
;../printf_large.c:630: radix = 10;
	ld	-15 (ix),#0x0A
;../printf_large.c:631: break;
	jr	00156$
;../printf_large.c:633: case 'O':
00151$:
;../printf_large.c:634: radix = 8;
	ld	-15 (ix),#0x08
;../printf_large.c:635: break;
	jr	00156$
;../printf_large.c:637: case 'U':
00152$:
;../printf_large.c:638: radix = 10;
	ld	-15 (ix),#0x0A
;../printf_large.c:639: break;
	jr	00156$
;../printf_large.c:641: case 'X':
00153$:
;../printf_large.c:642: radix = 16;
	ld	-15 (ix),#0x10
;../printf_large.c:643: break;
	jr	00156$
;../printf_large.c:645: case 'F':
00154$:
;../printf_large.c:646: float_argument=1;
	ld	-8 (ix),#0x01
;../printf_large.c:647: break;
	jr	00156$
;../printf_large.c:649: default:
00155$:
;../printf_large.c:651: OUTPUT_CHAR( c, p );
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	ld	hl,#00350$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00350$:
	pop	af
	inc	sp
	inc	-32 (ix)
	jr	NZ,00156$
	inc	-31 (ix)
;../printf_large.c:828: return charsOutputted;
	jr	00156$
;../printf_large.c:653: }
00306$:
	ld	-32 (ix),e
	ld	-31 (ix),d
	ld	-16 (ix),c
00156$:
;../printf_large.c:655: if (float_argument) {
	bit	0,-8 (ix)
	jp	Z,00222$
;../printf_large.c:656: value.f=va_arg(ap,float);
	ld	hl,#0x0021
	add	hl,sp
	ld	b,l
	ld	d,h
	ld	a,10 (ix)
	add	a,#0x04
	ld	c,a
	ld	a,11 (ix)
	adc	a,#0x00
	ld	e,a
	ld	10 (ix),c
	ld	11 (ix),e
	ld	a,c
	add	a,#0xFC
	ld	l,a
	ld	a,e
	adc	a,#0xFF
	ld	h,a
	ld	a,(hl)
	ld	-43 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-42 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-41 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-40 (ix),a
	ld	l,b
	ld	h,d
	ld	a,-43 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-42 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-41 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-40 (ix)
	ld	(hl),a
;../printf_large.c:658: PTR="<NO FLOAT>";
	ld	hl,#0x0021
	add	hl,sp
	ld	(hl),#<(__str_0)
	inc	hl
	ld	(hl),#>(__str_0)
;../printf_large.c:659: while (c=*PTR++)
	ld	a,-32 (ix)
	ld	-43 (ix),a
	ld	a,-31 (ix)
	ld	-42 (ix),a
00157$:
	ld	hl,#0x0021
	add	hl,sp
	ld	b,l
	ld	d,h
	ld	a,(hl)
	ld	-34 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-33 (ix),a
	ld	a,-34 (ix)
	add	a,#0x01
	ld	e,a
	ld	a,-33 (ix)
	adc	a,#0x00
	ld	c,a
	ld	l,b
	ld	h,d
	ld	(hl),e
	inc	hl
	ld	(hl),c
	ld	l,-34 (ix)
	ld	h,-33 (ix)
	ld	l,(hl)
	ld	b,l
	xor	a,a
	or	a,l
	jp	Z,00227$
;../printf_large.c:661: OUTPUT_CHAR (c, p);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	ld	hl,#00352$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00352$:
	pop	af
	inc	sp
	inc	-43 (ix)
	jr	NZ,00353$
	inc	-42 (ix)
00353$:
	ld	a,-43 (ix)
	ld	-32 (ix),a
	ld	a,-42 (ix)
	ld	-31 (ix),a
	jr	00157$
00222$:
;../printf_large.c:678: } else if (radix != 0)
	xor	a,a
	or	a,-15 (ix)
	jp	Z,00227$
;../printf_large.c:683: unsigned char MEM_SPACE_BUF_PP *pstore = &store[5];
	ld	a,-28 (ix)
	ld	-26 (ix),a
	ld	a,-27 (ix)
	ld	-25 (ix),a
;../printf_large.c:686: if (char_argument)
	bit	0,-6 (ix)
	jp	Z,00168$
;../printf_large.c:688: value.l = va_arg(ap,char);
	ld	hl,#0x0021
	add	hl,sp
	ld	b,l
	ld	e,h
	ld	a,10 (ix)
	add	a,#0x01
	ld	d,a
	ld	a,11 (ix)
	adc	a,#0x00
	ld	c,a
	ld	10 (ix),d
	ld	11 (ix),c
	ld	l,d
	ld	h,c
	dec	hl
	ld	l,(hl)
	ld	-47 (ix),l
	ld	a,l
	rla	
	sbc	a,a
	ld	-46 (ix),a
	ld	-45 (ix),a
	ld	-44 (ix),a
	ld	l,b
	ld	h,e
	ld	a,-47 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-46 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-45 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-44 (ix)
	ld	(hl),a
;../printf_large.c:689: if (!signed_argument)
	bit	0,-5 (ix)
	jp	NZ,00169$
;../printf_large.c:691: value.l &= 0xFF;
	ld	l,b
	ld	h,e
	ld	a,(hl)
	ld	-47 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-46 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-45 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-44 (ix),a
	ld	-46 (ix),#0x00
	ld	-45 (ix),#0x00
	ld	-44 (ix),#0x00
	ld	l,b
	ld	h,e
	ld	a,-47 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-46 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-45 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-44 (ix)
	ld	(hl),a
	jp	00169$
00168$:
;../printf_large.c:694: else if (long_argument)
	bit	0,-7 (ix)
	jr	Z,00165$
;../printf_large.c:696: value.l = va_arg(ap,long);
	ld	hl,#0x0021
	add	hl,sp
	ld	b,l
	ld	d,h
	ld	a,10 (ix)
	add	a,#0x04
	ld	c,a
	ld	a,11 (ix)
	adc	a,#0x00
	ld	e,a
	ld	10 (ix),c
	ld	11 (ix),e
	ld	a,c
	add	a,#0xFC
	ld	l,a
	ld	a,e
	adc	a,#0xFF
	ld	h,a
	ld	a,(hl)
	ld	-43 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-42 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-41 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-40 (ix),a
	ld	l,b
	ld	h,d
	ld	a,-43 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-42 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-41 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-40 (ix)
	ld	(hl),a
	jp	00169$
00165$:
;../printf_large.c:700: value.l = va_arg(ap,int);
	ld	hl,#0x0021
	add	hl,sp
	ld	b,l
	ld	d,h
	ld	a,10 (ix)
	add	a,#0x02
	ld	c,a
	ld	a,11 (ix)
	adc	a,#0x00
	ld	e,a
	ld	10 (ix),c
	ld	11 (ix),e
	ld	l,c
	ld	h,e
	dec	hl
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	-43 (ix), a
	ld	-42 (ix),h
	ld	a,h
	rla	
	sbc	a,a
	ld	-41 (ix),a
	ld	-40 (ix),a
	ld	l,b
	ld	h,d
	ld	a,-43 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-42 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-41 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-40 (ix)
	ld	(hl),a
;../printf_large.c:701: if (!signed_argument)
	bit	0,-5 (ix)
	jr	NZ,00169$
;../printf_large.c:703: value.l &= 0xFFFF;
	ld	l,b
	ld	h,d
	ld	a,(hl)
	ld	-43 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-42 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-41 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-40 (ix),a
	ld	-41 (ix),#0x00
	ld	-40 (ix),#0x00
	ld	l,b
	ld	h,d
	ld	a,-43 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-42 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-41 (ix)
	ld	(hl),a
	inc	hl
	ld	a,-40 (ix)
	ld	(hl),a
00169$:
;../printf_large.c:707: if ( signed_argument )
	bit	0,-5 (ix)
	jr	Z,00174$
;../printf_large.c:709: if (value.l < 0)
	ld	hl,#0x0021
	add	hl,sp
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	dec	hl
	dec	hl
	dec	hl
	bit	7,d
	jr	Z,00171$
;../printf_large.c:710: value.l = -value.l;
	xor	a,a
	sbc	a,c
	ld	c,a
	ld	a,#0x00
	sbc	a,b
	ld	b,a
	ld	a,#0x00
	sbc	a,e
	ld	e,a
	ld	a,#0x00
	sbc	a,d
	ld	d,a
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	jr	00174$
00171$:
;../printf_large.c:712: signed_argument = 0;
	ld	-5 (ix),#0x00
00174$:
;../printf_large.c:716: lsd = 1;
	ld	b,#0x01
;../printf_large.c:718: do {
	ld	a,-26 (ix)
	ld	-47 (ix),a
	ld	a,-25 (ix)
	ld	-46 (ix),a
	ld	-18 (ix),#0x00
00178$:
;../printf_large.c:719: value.byte[4] = 0;
	ld	hl,#0x0021
	add	hl,sp
	ld	a, l
	ld	e, h
	add	a,#0x04
	ld	c,a
	ld	a,e
	adc	a,#0x00
	ld	h, a
	ld	l, c
	ld	(hl),#0x00
;../printf_large.c:721: calculate_digit(&value, radix);
	ld	hl,#0x0021
	add	hl,sp
	ex	de,hl
	push	bc
	ld	a,-15 (ix)
	push	af
	inc	sp
	push	de
	call	_calculate_digit
	pop	af
	inc	sp
	pop	bc
;../printf_large.c:725: if (!lsd)
	bit	0,b
	jr	NZ,00176$
;../printf_large.c:727: *pstore = (value.byte[4] << 4) | (value.byte[4] >> 4) | *pstore;
	ld	hl, #0x0021+1+1+1+1
	add	hl, sp
	ex	de, hl
	ld	a,(de)
	ld	l,a
	rlca
	rlca
	rlca
	rlca
	and	a,#0xF0
	ld	c,a
	ld	a,l
	srl	a
	srl	a
	srl	a
	srl	a
	or	a,c
	ld	c,a
	ld	l,-47 (ix)
	ld	h,-46 (ix)
	ld	a,(hl)
	or	a, c
	ld	l,-47 (ix)
	ld	h,-46 (ix)
	ld	(hl),a
;../printf_large.c:728: pstore--;
	ld	l,-47 (ix)
	ld	h,-46 (ix)
	dec	hl
	ld	-47 (ix),l
	ld	-46 (ix),h
	ld	a,-47 (ix)
	ld	-26 (ix),a
	ld	a,-46 (ix)
	ld	-25 (ix),a
	jr	00177$
00176$:
;../printf_large.c:732: *pstore = value.byte[4];
	ld	hl, #0x0021+1+1+1+1
	add	hl, sp
	ex	de, hl
	ld	a,(de)
	ld	l,-47 (ix)
	ld	h,-46 (ix)
	ld	(hl),a
00177$:
;../printf_large.c:734: length++;
	inc	-18 (ix)
	ld	a,-18 (ix)
	ld	-37 (ix),a
;../printf_large.c:735: lsd = !lsd;
	ld	a,b
	xor	a,#0x01
	ld	b,a
;../printf_large.c:736: } while( value.ul );
	ld	l,-30 (ix)
	ld	h,-29 (ix)
	ld	a,(hl)
	ld	-43 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-42 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-41 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-40 (ix),a
	ld	a,-43 (ix)
	or	a,-42 (ix)
	or	a,-41 (ix)
	or	a,-40 (ix)
	jp	NZ,00178$
;../printf_large.c:738: if (width == 0)
	ld	a,-47 (ix)
	ld	-26 (ix),a
	ld	a,-46 (ix)
	ld	-25 (ix),a
	ld	a,-18 (ix)
	ld	-37 (ix),a
	xor	a,a
	or	a,-16 (ix)
	jr	NZ,00182$
;../printf_large.c:743: width=1;
	ld	-16 (ix),#0x01
00182$:
;../printf_large.c:747: if (!zero_padding && !left_justify)
	bit	0,-2 (ix)
	jr	NZ,00187$
	bit	0,-1 (ix)
	jr	NZ,00187$
;../printf_large.c:749: while ( width > (unsigned char) (length+1) )
	ld	c,-37 (ix)
	inc	c
	ld	e,-32 (ix)
	ld	d,-31 (ix)
	ld	a,-16 (ix)
	ld	-47 (ix),a
00183$:
	ld	a,c
	sub	a, -47 (ix)
	jr	NC,00308$
;../printf_large.c:751: OUTPUT_CHAR( ' ', p );
	push	bc
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00354$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00354$:
	pop	af
	inc	sp
	pop	de
	pop	bc
	inc	de
	ld	-32 (ix),e
	ld	-31 (ix),d
;../printf_large.c:752: width--;
	dec	-47 (ix)
	jr	00183$
00308$:
	ld	-32 (ix),e
	ld	-31 (ix),d
	ld	a,-47 (ix)
	ld	-16 (ix),a
00187$:
;../printf_large.c:756: if (signed_argument) // this now means the original value was negative
	bit	0,-5 (ix)
	jr	Z,00197$
;../printf_large.c:758: OUTPUT_CHAR( '-', p );
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x2D
	push	af
	inc	sp
	ld	hl,#00355$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00355$:
	pop	af
	inc	sp
	pop	bc
	inc	-32 (ix)
	jr	NZ,00356$
	inc	-31 (ix)
00356$:
;../printf_large.c:760: width--;
	dec	-16 (ix)
	jr	00198$
00197$:
;../printf_large.c:762: else if (length != 0)
	xor	a,a
	or	a,-37 (ix)
	jr	Z,00198$
;../printf_large.c:765: if (prefix_sign)
	bit	0,-3 (ix)
	jr	Z,00192$
;../printf_large.c:767: OUTPUT_CHAR( '+', p );
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x2B
	push	af
	inc	sp
	ld	hl,#00357$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00357$:
	pop	af
	inc	sp
	pop	bc
	inc	-32 (ix)
	jr	NZ,00358$
	inc	-31 (ix)
00358$:
;../printf_large.c:769: width--;
	dec	-16 (ix)
	jr	00198$
00192$:
;../printf_large.c:771: else if (prefix_space)
	bit	0,-4 (ix)
	jr	Z,00198$
;../printf_large.c:773: OUTPUT_CHAR( ' ', p );
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00359$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00359$:
	pop	af
	inc	sp
	pop	bc
	inc	-32 (ix)
	jr	NZ,00360$
	inc	-31 (ix)
00360$:
;../printf_large.c:775: width--;
	dec	-16 (ix)
00198$:
;../printf_large.c:780: if (!left_justify)
	bit	0,-1 (ix)
	jr	NZ,00206$
;../printf_large.c:781: while ( width-- > length )
	ld	e,-32 (ix)
	ld	d,-31 (ix)
	ld	c,-16 (ix)
00199$:
	ld	l,c
	dec	c
	ld	-16 (ix),c
	ld	a,-37 (ix)
	sub	a, l
	jr	NC,00309$
;../printf_large.c:783: OUTPUT_CHAR( zero_padding ? '0' : ' ', p );
	bit	0,-2 (ix)
	jr	Z,00232$
	ld	-47 (ix),#0x30
	jr	00233$
00232$:
	ld	-47 (ix),#0x20
00233$:
	push	bc
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,-47 (ix)
	push	af
	inc	sp
	ld	hl,#00361$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00361$:
	pop	af
	inc	sp
	pop	de
	pop	bc
	inc	de
	ld	-32 (ix),e
	ld	-31 (ix),d
	jr	00199$
00206$:
;../printf_large.c:788: if (width > length)
	ld	a,-37 (ix)
	sub	a, -16 (ix)
	jr	NC,00203$
;../printf_large.c:789: width -= length;
	ld	a,-16 (ix)
	sub	a,-37 (ix)
	ld	-16 (ix),a
	jr	00301$
00203$:
;../printf_large.c:791: width = 0;
	ld	-16 (ix),#0x00
;../printf_large.c:828: return charsOutputted;
	jr	00301$
;../printf_large.c:795: while( length-- )
00309$:
	ld	-32 (ix),e
	ld	-31 (ix),d
	ld	-16 (ix),c
00301$:
	ld	a,-26 (ix)
	ld	-39 (ix),a
	ld	a,-25 (ix)
	ld	-38 (ix),a
	ld	a,-32 (ix)
	ld	-47 (ix),a
	ld	a,-31 (ix)
	ld	-46 (ix),a
	ld	a,-37 (ix)
	ld	-43 (ix),a
00211$:
	ld	l,-43 (ix)
	dec	-43 (ix)
	xor	a,a
	or	a,l
	jp	Z,00310$
;../printf_large.c:797: lsd = !lsd;
	ld	a,b
	xor	a,#0x01
	ld	b,a
;../printf_large.c:798: if (!lsd)
	bit	0,b
	jr	NZ,00209$
;../printf_large.c:800: pstore++;
	inc	-39 (ix)
	jr	NZ,00362$
	inc	-38 (ix)
00362$:
;../printf_large.c:801: value.byte[4] = *pstore >> 4;
	ld	hl,#0x0021
	add	hl,sp
	ld	a, l
	ld	e, h
	add	a,#0x04
	ld	c,a
	ld	a,e
	adc	a,#0x00
	ld	e,a
	ld	l,-39 (ix)
	ld	h,-38 (ix)
	ld	d, (hl)
	srl	d
	srl	d
	srl	d
	srl	d
	ld	l,c
	ld	h,e
	ld	(hl),d
	jr	00210$
00209$:
;../printf_large.c:805: value.byte[4] = *pstore & 0x0F;
	ld	hl, #0x0021+1+1+1+1
	add	hl, sp
	ex	de, hl
	ld	l,-39 (ix)
	ld	h,-38 (ix)
	ld	a,(hl)
	and	a,#0x0F
	ld	(de),a
00210$:
;../printf_large.c:808: output_digit( value.byte[4], lower_case, output_char, p );
	ld	hl, #0x0021+1+1+1+1
	add	hl, sp
	ex	de, hl
	ld	a,(de)
	ld	c,a
	push	bc
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	ld	b, -9 (ix)
	push	bc
	call	_output_digit
	pop	af
	pop	af
	pop	af
	pop	bc
;../printf_large.c:809: charsOutputted++;
	inc	-47 (ix)
	jr	NZ,00363$
	inc	-46 (ix)
00363$:
	ld	a,-47 (ix)
	ld	-32 (ix),a
	ld	a,-46 (ix)
	ld	-31 (ix),a
	jp	00211$
00310$:
	ld	a,-47 (ix)
	ld	-32 (ix),a
	ld	a,-46 (ix)
	ld	-31 (ix),a
;../printf_large.c:814: if (left_justify)
	bit	0,-1 (ix)
	jp	Z,00227$
;../printf_large.c:815: while (width-- > 0)
	ld	e,-47 (ix)
	ld	d,-46 (ix)
	ld	c,-16 (ix)
00214$:
	ld	l,c
	dec	c
	xor	a,a
	or	a,l
	jp	Z,00227$
;../printf_large.c:817: OUTPUT_CHAR(' ', p);
	push	bc
	push	de
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	a,#0x20
	push	af
	inc	sp
	ld	hl,#00364$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00364$:
	pop	af
	inc	sp
	pop	de
	pop	bc
	inc	de
	ld	-32 (ix),e
	ld	-31 (ix),d
	jr	00214$
00225$:
;../printf_large.c:824: OUTPUT_CHAR( c, p );
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	inc	sp
	ld	hl,#00365$
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	jp	(hl)
00365$:
	pop	af
	inc	sp
	inc	-32 (ix)
	jp	NZ,00227$
	inc	-31 (ix)
	jp	00227$
00229$:
;../printf_large.c:828: return charsOutputted;
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	ld	sp,ix
	pop	ix
	ret
__print_format_end::
__str_0:
	.ascii "<NO FLOAT>"
	.db 0x00
	.area _CODE
	.area _CABS
