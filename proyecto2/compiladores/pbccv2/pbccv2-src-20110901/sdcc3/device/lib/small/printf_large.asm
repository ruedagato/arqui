;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:24 2015
;--------------------------------------------------------
	.module printf_large
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __print_format_PARM_4
	.globl __print_format_PARM_3
	.globl __print_format_PARM_2
	.globl __print_format
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_output_char:
	.ds 2
_p:
	.ds 3
_value:
	.ds 5
_charsOutputted:
	.ds 2
__print_format_PARM_2:
	.ds 3
__print_format_PARM_3:
	.ds 3
__print_format_PARM_4:
	.ds 1
__print_format_radix_1_1:
	.ds 1
__print_format_width_1_1:
	.ds 1
__print_format_pstore_4_22:
	.ds 1
__print_format_sloc0_1_0:
	.ds 3
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
_calculate_digit_radix_1_1::
	.ds 1
_calculate_digit_i_1_1::
	.ds 1
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
__print_format_store_4_22:
	.ds 6
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
_lower_case:
	.ds 1
__print_format_left_justify_1_1:
	.ds 1
__print_format_zero_padding_1_1:
	.ds 1
__print_format_prefix_sign_1_1:
	.ds 1
__print_format_prefix_space_1_1:
	.ds 1
__print_format_signed_argument_1_1:
	.ds 1
__print_format_char_argument_1_1:
	.ds 1
__print_format_long_argument_1_1:
	.ds 1
__print_format_float_argument_1_1:
	.ds 1
__print_format_lsd_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function '_output_char'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	printf_large.c:105: _output_char (unsigned char c)
;	-----------------------------------------
;	 function _output_char
;	-----------------------------------------
__output_char:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
;	printf_large.c:107: output_char( c, p );
	push	_p
	push	(_p + 1)
	push	(_p + 2)
	mov	a,#00103$
	push	acc
	mov	a,#(00103$ >> 8)
	push	acc
	push	_output_char
	push	(_output_char + 1)
	mov	dpl,r2
	ret
00103$:
	dec	sp
	dec	sp
	dec	sp
;	printf_large.c:108: charsOutputted++;
	inc	_charsOutputted
	clr	a
	cjne	a,_charsOutputted,00104$
	inc	(_charsOutputted + 1)
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'output_digit'
;------------------------------------------------------------
;n                         Allocated to registers r2 
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	printf_large.c:130: output_digit (unsigned char n)
;	-----------------------------------------
;	 function output_digit
;	-----------------------------------------
_output_digit:
	mov	r2,dpl
;	printf_large.c:132: register unsigned char c = n + (unsigned char)'0';
	mov	a,#0x30
	add	a,r2
	mov	r2,a
;	printf_large.c:134: if (c > (unsigned char)'9')
	mov	a,#0x39
	cjne	a,ar2,00109$
00109$:
	jnc	00104$
;	printf_large.c:136: c += (unsigned char)('A' - '0' - 10);
	mov	a,#0x07
	add	a,r2
	mov	r2,a
;	printf_large.c:137: if (lower_case)
	jnb	_lower_case,00104$
;	printf_large.c:138: c = tolower(c);
	orl	ar2,#0x20
00104$:
;	printf_large.c:140: _output_char( c );
	mov	dpl,r2
	ljmp	__output_char
;------------------------------------------------------------
;Allocation info for local variables in function 'output_2digits'
;------------------------------------------------------------
;b                         Allocated to registers r2 
;------------------------------------------------------------
;	printf_large.c:157: output_2digits (unsigned char b)
;	-----------------------------------------
;	 function output_2digits
;	-----------------------------------------
_output_2digits:
;	printf_large.c:159: output_digit( b>>4   );
	mov	a,dpl
	mov	r2,a
	swap	a
	anl	a,#0x0f
	mov	dpl,a
	push	ar2
	lcall	_output_digit
	pop	ar2
;	printf_large.c:160: output_digit( b&0x0F );
	mov	a,#0x0F
	anl	a,r2
	mov	dpl,a
	ljmp	_output_digit
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_digit'
;------------------------------------------------------------
;radix                     Allocated with name '_calculate_digit_radix_1_1'
;ul                        Allocated to registers r3 r4 r5 r6 
;b4                        Allocated to registers r7 
;i                         Allocated with name '_calculate_digit_i_1_1'
;------------------------------------------------------------
;	printf_large.c:189: calculate_digit (unsigned char radix)
;	-----------------------------------------
;	 function calculate_digit
;	-----------------------------------------
_calculate_digit:
	mov	_calculate_digit_radix_1_1,dpl
;	printf_large.c:191: register unsigned long ul = value.ul;
	mov	r3,_value
	mov	r4,(_value + 1)
	mov	r5,(_value + 2)
	mov	r6,(_value + 3)
;	printf_large.c:192: register unsigned char b4 = value.byte[4];
	mov	r7,(_value + 0x0004)
;	printf_large.c:195: do
	mov	_calculate_digit_i_1_1,#0x20
00103$:
;	printf_large.c:197: b4 = (b4 << 1);
	mov	a,r7
	add	a,r7
	mov	r7,a
;	printf_large.c:198: b4 |= (ul >> 31) & 0x01;
	mov	a,r6
	rl	a
	anl	a,#0x01
	mov	r2,a
	orl	ar7,a
;	printf_large.c:199: ul <<= 1;
	mov	a,r3
	add	a,r3
	mov	r3,a
	mov	a,r4
	rlc	a
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
;	printf_large.c:201: if (radix <= b4 )
	mov	a,r7
	cjne	a,_calculate_digit_radix_1_1,00112$
00112$:
	jc	00104$
;	printf_large.c:203: b4 -= radix;
	mov	a,r7
	clr	c
	subb	a,_calculate_digit_radix_1_1
	mov	r7,a
;	printf_large.c:204: ul |= 1;
	orl	ar3,#0x01
00104$:
;	printf_large.c:206: } while (--i);
	djnz	_calculate_digit_i_1_1,00103$
;	printf_large.c:207: value.ul = ul;
	mov	(_value + 0),r3
	mov	(_value + 1),r4
	mov	(_value + 2),r5
	mov	(_value + 3),r6
;	printf_large.c:208: value.byte[4] = b4;
	mov	(_value + 0x0004),r7
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_print_format'
;------------------------------------------------------------
;pvoid                     Allocated with name '__print_format_PARM_2'
;format                    Allocated with name '__print_format_PARM_3'
;ap                        Allocated with name '__print_format_PARM_4'
;pfn                       Allocated to registers 
;radix                     Allocated with name '__print_format_radix_1_1'
;width                     Allocated with name '__print_format_width_1_1'
;decimals                  Allocated to registers r5 
;length                    Allocated to registers r3 
;c                         Allocated to registers r2 
;memtype                   Allocated to registers r5 
;pstore                    Allocated with name '__print_format_pstore_4_22'
;sloc0                     Allocated with name '__print_format_sloc0_1_0'
;store                     Allocated with name '__print_format_store_4_22'
;------------------------------------------------------------
;	printf_large.c:414: _print_format (pfn_outputchar pfn, void* pvoid, const char *format, va_list ap)
;	-----------------------------------------
;	 function _print_format
;	-----------------------------------------
__print_format:
	mov	_output_char,dpl
	mov	(_output_char + 1),dph
;	printf_large.c:442: p = pvoid;
	mov	_p,__print_format_PARM_2
	mov	(_p + 1),(__print_format_PARM_2 + 1)
	mov	(_p + 2),(__print_format_PARM_2 + 2)
;	printf_large.c:446: charsOutputted = 0;
	clr	a
	mov	_charsOutputted,a
	mov	(_charsOutputted + 1),a
;	printf_large.c:454: while( c=*format++ )
00239$:
	mov	r2,__print_format_PARM_3
	mov	r3,(__print_format_PARM_3 + 1)
	mov	r4,(__print_format_PARM_3 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	mov	a,#0x01
	add	a,r2
	mov	__print_format_PARM_3,a
	clr	a
	addc	a,r3
	mov	(__print_format_PARM_3 + 1),a
	mov	(__print_format_PARM_3 + 2),r4
	mov	a,r5
	mov	r2,a
	jnz	00328$
	ljmp	00241$
00328$:
;	printf_large.c:456: if ( c=='%' )
	cjne	r2,#0x25,00329$
	sjmp	00330$
00329$:
	ljmp	00237$
00330$:
;	printf_large.c:458: left_justify    = 0;
	clr	__print_format_left_justify_1_1
;	printf_large.c:459: zero_padding    = 0;
	clr	__print_format_zero_padding_1_1
;	printf_large.c:460: prefix_sign     = 0;
	clr	__print_format_prefix_sign_1_1
;	printf_large.c:461: prefix_space    = 0;
	clr	__print_format_prefix_space_1_1
;	printf_large.c:462: signed_argument = 0;
	clr	__print_format_signed_argument_1_1
;	printf_large.c:463: char_argument   = 0;
	clr	__print_format_char_argument_1_1
;	printf_large.c:464: long_argument   = 0;
	clr	__print_format_long_argument_1_1
;	printf_large.c:465: float_argument  = 0;
	clr	__print_format_float_argument_1_1
;	printf_large.c:466: radix           = 0;
	mov	__print_format_radix_1_1,#0x00
;	printf_large.c:467: width           = 0;
	mov	__print_format_width_1_1,#0x00
;	printf_large.c:468: decimals        = -1;
	mov	r5,#0xFF
;	printf_large.c:470: get_conversion_spec:
	mov	r6,__print_format_PARM_3
	mov	r7,(__print_format_PARM_3 + 1)
	mov	r3,(__print_format_PARM_3 + 2)
00101$:
;	printf_large.c:472: c = *format++;
	mov	dpl,r6
	mov	dph,r7
	mov	b,r3
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	mov	r6,dpl
	mov	r7,dph
	mov	__print_format_PARM_3,r6
	mov	(__print_format_PARM_3 + 1),r7
	mov	(__print_format_PARM_3 + 2),r3
;	printf_large.c:474: if (c=='%') {
	cjne	r2,#0x25,00103$
;	printf_large.c:475: OUTPUT_CHAR(c, p);
	mov	dpl,r2
	lcall	__output_char
;	printf_large.c:476: continue;
	sjmp	00239$
00103$:
;	printf_large.c:479: if (isdigit(c)) {
	mov	ar4,r2
	cjne	r4,#0x30,00333$
00333$:
	jc	00110$
	mov	ar4,r2
	mov	a,#0x39
	cjne	a,ar4,00335$
00335$:
	jc	00110$
;	printf_large.c:480: if (decimals==-1) {
	cjne	r5,#0xFF,00107$
;	printf_large.c:481: width = 10*width + c - '0';
	mov	a,__print_format_width_1_1
	mov	b,#0x0A
	mul	ab
	add	a,r2
	add	a,#0xd0
;	printf_large.c:482: if (width == 0) {
	mov	__print_format_width_1_1,a
	jnz	00101$
;	printf_large.c:484: zero_padding = 1;
	setb	__print_format_zero_padding_1_1
	sjmp	00101$
00107$:
;	printf_large.c:487: decimals = 10*decimals + c - '0';
	mov	a,r5
	mov	b,#0x0A
	mul	ab
	add	a,r2
	add	a,#0xd0
	mov	r5,a
;	printf_large.c:489: goto get_conversion_spec;
	sjmp	00101$
00110$:
;	printf_large.c:492: if (c=='.') {
	cjne	r2,#0x2E,00115$
;	printf_large.c:493: if (decimals==-1) decimals=0;
	cjne	r5,#0xFF,00101$
	mov	r5,#0x00
;	printf_large.c:496: goto get_conversion_spec;
	sjmp	00101$
00115$:
;	printf_large.c:499: if (islower(c))
	mov	ar4,r2
	cjne	r4,#0x61,00344$
00344$:
	jc	00117$
	mov	ar4,r2
	mov	a,#0x7A
	cjne	a,ar4,00346$
00346$:
	jc	00117$
;	printf_large.c:501: c = toupper(c);
	anl	ar2,#0xDF
;	printf_large.c:502: lower_case = 1;
	setb	_lower_case
	sjmp	00118$
00117$:
;	printf_large.c:505: lower_case = 0;
	clr	_lower_case
00118$:
;	printf_large.c:507: switch( c )
	cjne	r2,#0x20,00348$
	sjmp	00122$
00348$:
	cjne	r2,#0x2B,00349$
	sjmp	00121$
00349$:
	cjne	r2,#0x2D,00350$
	sjmp	00120$
00350$:
	cjne	r2,#0x42,00351$
	sjmp	00123$
00351$:
	cjne	r2,#0x43,00352$
	sjmp	00125$
00352$:
	cjne	r2,#0x44,00353$
	ljmp	00162$
00353$:
	cjne	r2,#0x46,00354$
	ljmp	00166$
00354$:
	cjne	r2,#0x49,00355$
	ljmp	00162$
00355$:
	cjne	r2,#0x4C,00356$
	sjmp	00124$
00356$:
	cjne	r2,#0x4F,00357$
	ljmp	00163$
00357$:
	cjne	r2,#0x50,00358$
	ljmp	00148$
00358$:
	cjne	r2,#0x53,00359$
	sjmp	00129$
00359$:
	cjne	r2,#0x55,00360$
	ljmp	00164$
00360$:
	cjne	r2,#0x58,00361$
	ljmp	00165$
00361$:
	ljmp	00167$
;	printf_large.c:509: case '-':
00120$:
;	printf_large.c:510: left_justify = 1;
	setb	__print_format_left_justify_1_1
;	printf_large.c:511: goto get_conversion_spec;
	ljmp	00101$
;	printf_large.c:512: case '+':
00121$:
;	printf_large.c:513: prefix_sign = 1;
	setb	__print_format_prefix_sign_1_1
;	printf_large.c:514: goto get_conversion_spec;
	ljmp	00101$
;	printf_large.c:515: case ' ':
00122$:
;	printf_large.c:516: prefix_space = 1;
	setb	__print_format_prefix_space_1_1
;	printf_large.c:517: goto get_conversion_spec;
	ljmp	00101$
;	printf_large.c:518: case 'B':
00123$:
;	printf_large.c:519: char_argument = 1;
	setb	__print_format_char_argument_1_1
;	printf_large.c:520: goto get_conversion_spec;
	ljmp	00101$
;	printf_large.c:521: case 'L':
00124$:
;	printf_large.c:522: long_argument = 1;
	setb	__print_format_long_argument_1_1
;	printf_large.c:523: goto get_conversion_spec;
	ljmp	00101$
;	printf_large.c:525: case 'C':
00125$:
;	printf_large.c:526: if( char_argument )
	jnb	__print_format_char_argument_1_1,00127$
;	printf_large.c:527: c = va_arg(ap,char);
	mov	a,__print_format_PARM_4
	dec	a
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar2,@r0
	sjmp	00128$
00127$:
;	printf_large.c:529: c = va_arg(ap,int);
	mov	a,__print_format_PARM_4
	add	a,#0xfe
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	dec	r0
	mov	ar2,r3
00128$:
;	printf_large.c:530: OUTPUT_CHAR( c, p );
	mov	dpl,r2
	lcall	__output_char
;	printf_large.c:531: break;
	ljmp	00168$
;	printf_large.c:533: case 'S':
00129$:
;	printf_large.c:534: PTR = va_arg(ap,ptr_t);
	mov	a,__print_format_PARM_4
	add	a,#0xfd
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar6,@r0
	dec	r0
	dec	r0
	mov	(_value + 0),r3
	mov	(_value + 1),r4
	mov	(_value + 2),r6
;	printf_large.c:544: length = strlen(PTR);
	mov	dpl,r3
	mov	dph,r4
	mov	b,r6
	push	ar5
	lcall	_strlen
	mov	r3,dpl
	mov	r4,dph
	pop	ar5
;	printf_large.c:546: if ( decimals == -1 )
	cjne	r5,#0xFF,00131$
;	printf_large.c:548: decimals = length;
	mov	ar5,r3
00131$:
;	printf_large.c:550: if ( ( !left_justify ) && (length < width) )
	jb	__print_format_left_justify_1_1,00281$
	mov	a,r3
	cjne	a,__print_format_width_1_1,00366$
00366$:
	jnc	00281$
;	printf_large.c:552: width -= length;
	mov	a,__print_format_width_1_1
	clr	c
	subb	a,r3
	mov	__print_format_width_1_1,a
;	printf_large.c:553: while( width-- != 0 )
	mov	r4,__print_format_width_1_1
00132$:
	mov	ar6,r4
	dec	r4
	mov	__print_format_width_1_1,r4
	mov	a,r6
	jz	00321$
;	printf_large.c:555: OUTPUT_CHAR( ' ', p );
	mov	dpl,#0x20
	push	ar3
	push	ar4
	push	ar5
	lcall	__output_char
	pop	ar5
	pop	ar4
	pop	ar3
;	printf_large.c:559: while ( (c = *PTR)  && (decimals-- > 0))
	sjmp	00132$
00321$:
	mov	__print_format_width_1_1,r4
00281$:
	mov	ar4,r5
00139$:
	mov	dpl,_value
	mov	dph,(_value + 1)
	mov	b,(_value + 2)
	lcall	__gptrget
	mov	r5,a
	mov	r2,a
	jz	00141$
	mov	ar5,r4
	dec	r4
	clr	c
	clr	a
	xrl	a,#0x80
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jnc	00141$
;	printf_large.c:561: OUTPUT_CHAR( c, p );
	mov	dpl,r2
	push	ar3
	push	ar4
	lcall	__output_char
	pop	ar4
	pop	ar3
;	printf_large.c:562: PTR++;
	mov	r5,_value
	mov	r6,(_value + 1)
	mov	r7,(_value + 2)
	inc	r5
	cjne	r5,#0x00,00371$
	inc	r6
00371$:
	mov	(_value + 0),r5
	mov	(_value + 1),r6
	mov	(_value + 2),r7
	sjmp	00139$
00141$:
;	printf_large.c:565: if ( left_justify && (length < width))
	jb	__print_format_left_justify_1_1,00372$
	ljmp	00168$
00372$:
	mov	a,r3
	cjne	a,__print_format_width_1_1,00373$
00373$:
	jc	00374$
	ljmp	00168$
00374$:
;	printf_large.c:567: width -= length;
	mov	a,__print_format_width_1_1
	clr	c
	subb	a,r3
	mov	__print_format_width_1_1,a
;	printf_large.c:568: while( width-- != 0 )
	mov	r4,__print_format_width_1_1
00142$:
	mov	ar5,r4
	dec	r4
	mov	__print_format_width_1_1,r4
	mov	a,r5
	jnz	00375$
	ljmp	00323$
00375$:
;	printf_large.c:570: OUTPUT_CHAR( ' ', p );
	mov	dpl,#0x20
	push	ar4
	lcall	__output_char
	pop	ar4
;	printf_large.c:575: case 'P':
	sjmp	00142$
00148$:
;	printf_large.c:576: PTR = va_arg(ap,ptr_t);
	mov	a,__print_format_PARM_4
	add	a,#0xfd
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
	dec	r0
	dec	r0
	mov	(_value + 0),r5
	mov	(_value + 1),r6
	mov	(_value + 2),r7
;	printf_large.c:599: unsigned char memtype = value.byte[2];
	mov	r5,(_value + 0x0002)
;	printf_large.c:600: if (memtype >= 0x80)
	cjne	r5,#0x80,00376$
00376$:
	jc	00156$
;	printf_large.c:601: c = 'C';
	mov	r2,#0x43
	sjmp	00157$
00156$:
;	printf_large.c:602: else if (memtype >= 0x60)
	cjne	r5,#0x60,00378$
00378$:
	jc	00153$
;	printf_large.c:603: c = 'P';
	mov	r2,#0x50
	sjmp	00157$
00153$:
;	printf_large.c:604: else if (memtype >= 0x40)
	cjne	r5,#0x40,00380$
00380$:
	jc	00150$
;	printf_large.c:605: c = 'I';
	mov	r2,#0x49
	sjmp	00157$
00150$:
;	printf_large.c:607: c = 'X';
	mov	r2,#0x58
00157$:
;	printf_large.c:609: OUTPUT_CHAR(c, p);
	mov	dpl,r2
	push	ar2
	lcall	__output_char
;	printf_large.c:610: OUTPUT_CHAR(':', p);
	mov	dpl,#0x3A
	lcall	__output_char
;	printf_large.c:611: OUTPUT_CHAR('0', p);
	mov	dpl,#0x30
	lcall	__output_char
;	printf_large.c:612: OUTPUT_CHAR('x', p);
	mov	dpl,#0x78
	lcall	__output_char
	pop	ar2
;	printf_large.c:613: if ((c != 'I' /* idata */) &&
	cjne	r2,#0x49,00382$
	sjmp	00159$
00382$:
;	printf_large.c:614: (c != 'P' /* pdata */))
	cjne	r2,#0x50,00383$
	sjmp	00159$
00383$:
;	printf_large.c:616: OUTPUT_2DIGITS( value.byte[1] );
	mov	dpl,(_value + 0x0001)
	lcall	_output_2digits
00159$:
;	printf_large.c:618: OUTPUT_2DIGITS( value.byte[0] );
	mov	dpl,_value
	lcall	_output_2digits
;	printf_large.c:625: break;
;	printf_large.c:628: case 'I':
	sjmp	00168$
00162$:
;	printf_large.c:629: signed_argument = 1;
	setb	__print_format_signed_argument_1_1
;	printf_large.c:630: radix = 10;
	mov	__print_format_radix_1_1,#0x0A
;	printf_large.c:631: break;
;	printf_large.c:633: case 'O':
	sjmp	00168$
00163$:
;	printf_large.c:634: radix = 8;
	mov	__print_format_radix_1_1,#0x08
;	printf_large.c:635: break;
;	printf_large.c:637: case 'U':
	sjmp	00168$
00164$:
;	printf_large.c:638: radix = 10;
	mov	__print_format_radix_1_1,#0x0A
;	printf_large.c:639: break;
;	printf_large.c:641: case 'X':
	sjmp	00168$
00165$:
;	printf_large.c:642: radix = 16;
	mov	__print_format_radix_1_1,#0x10
;	printf_large.c:643: break;
;	printf_large.c:645: case 'F':
	sjmp	00168$
00166$:
;	printf_large.c:646: float_argument=1;
	setb	__print_format_float_argument_1_1
;	printf_large.c:647: break;
;	printf_large.c:649: default:
	sjmp	00168$
00167$:
;	printf_large.c:651: OUTPUT_CHAR( c, p );
	mov	dpl,r2
	lcall	__output_char
;	printf_large.c:828: return charsOutputted;
;	printf_large.c:653: }
	sjmp	00168$
00323$:
	mov	__print_format_width_1_1,r4
00168$:
;	printf_large.c:655: if (float_argument) {
	jnb	__print_format_float_argument_1_1,00234$
;	printf_large.c:656: value.f=va_arg(ap,float);
	mov	a,__print_format_PARM_4
	add	a,#0xfc
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
	dec	r0
	dec	r0
	dec	r0
	mov	(_value + 0),r4
	mov	(_value + 1),r5
	mov	(_value + 2),r6
	mov	(_value + 3),r7
;	printf_large.c:658: PTR="<NO FLOAT>";
	mov	(_value + 0),#__str_0
	mov	(_value + 1),#(__str_0 >> 8)
	mov	(_value + 2),#0x80
;	printf_large.c:659: while (c=*PTR++)
00169$:
	mov	__print_format_sloc0_1_0,_value
	mov	(__print_format_sloc0_1_0 + 1),(_value + 1)
	mov	(__print_format_sloc0_1_0 + 2),(_value + 2)
	mov	a,#0x01
	add	a,__print_format_sloc0_1_0
	mov	r7,a
	clr	a
	addc	a,(__print_format_sloc0_1_0 + 1)
	mov	r4,a
	mov	r5,(__print_format_sloc0_1_0 + 2)
	mov	(_value + 0),r7
	mov	(_value + 1),r4
	mov	(_value + 2),r5
	mov	dpl,__print_format_sloc0_1_0
	mov	dph,(__print_format_sloc0_1_0 + 1)
	mov	b,(__print_format_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r4,a
	mov	r2,a
	jnz	00385$
	ljmp	00239$
00385$:
;	printf_large.c:661: OUTPUT_CHAR (c, p);
	mov	dpl,r2
	lcall	__output_char
	sjmp	00169$
00234$:
;	printf_large.c:678: } else if (radix != 0)
	mov	a,__print_format_radix_1_1
	jnz	00386$
	ljmp	00239$
00386$:
;	printf_large.c:683: unsigned char MEM_SPACE_BUF_PP *pstore = &store[5];
	mov	__print_format_pstore_4_22,#(__print_format_store_4_22 + 0x0005)
;	printf_large.c:686: if (char_argument)
	jnb	__print_format_char_argument_1_1,00180$
;	printf_large.c:688: value.l = va_arg(ap,char);
	mov	a,__print_format_PARM_4
	dec	a
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	a,@r0
	mov	r5,a
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	r7,a
	mov	r4,a
	mov	(_value + 0),r5
	mov	(_value + 1),r6
	mov	(_value + 2),r7
	mov	(_value + 3),r4
;	printf_large.c:689: if (!signed_argument)
	jb	__print_format_signed_argument_1_1,00181$
;	printf_large.c:691: value.l &= 0xFF;
	mov	r4,_value
	mov	r5,#0x00
	mov	r6,#0x00
	mov	r7,#0x00
	mov	(_value + 0),r4
	mov	(_value + 1),r5
	mov	(_value + 2),r6
	mov	(_value + 3),r7
	sjmp	00181$
00180$:
;	printf_large.c:694: else if (long_argument)
	jnb	__print_format_long_argument_1_1,00177$
;	printf_large.c:696: value.l = va_arg(ap,long);
	mov	a,__print_format_PARM_4
	add	a,#0xfc
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	inc	r0
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
	dec	r0
	dec	r0
	dec	r0
	mov	(_value + 0),r4
	mov	(_value + 1),r5
	mov	(_value + 2),r6
	mov	(_value + 3),r7
	sjmp	00181$
00177$:
;	printf_large.c:700: value.l = va_arg(ap,int);
	mov	a,__print_format_PARM_4
	add	a,#0xfe
	mov	r0,a
	mov	__print_format_PARM_4,r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	dec	r0
	mov	a,r5
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	r7,a
	mov	(_value + 0),r4
	mov	(_value + 1),r5
	mov	(_value + 2),r6
	mov	(_value + 3),r7
;	printf_large.c:701: if (!signed_argument)
	jb	__print_format_signed_argument_1_1,00181$
;	printf_large.c:703: value.l &= 0xFFFF;
	mov	r4,_value
	mov	r5,(_value + 1)
	mov	r6,#0x00
	mov	r7,#0x00
	mov	(_value + 0),r4
	mov	(_value + 1),r5
	mov	(_value + 2),r6
	mov	(_value + 3),r7
00181$:
;	printf_large.c:707: if ( signed_argument )
	jnb	__print_format_signed_argument_1_1,00186$
;	printf_large.c:709: if (value.l < 0)
	mov	r4,_value
	mov	r5,(_value + 1)
	mov	r6,(_value + 2)
	mov	a,(_value + 3)
	mov	r7,a
	jnb	acc.7,00183$
;	printf_large.c:710: value.l = -value.l;
	clr	c
	clr	a
	subb	a,r4
	mov	r4,a
	clr	a
	subb	a,r5
	mov	r5,a
	clr	a
	subb	a,r6
	mov	r6,a
	clr	a
	subb	a,r7
	mov	r7,a
	mov	(_value + 0),r4
	mov	(_value + 1),r5
	mov	(_value + 2),r6
	mov	(_value + 3),r7
	sjmp	00186$
00183$:
;	printf_large.c:712: signed_argument = 0;
	clr	__print_format_signed_argument_1_1
00186$:
;	printf_large.c:716: lsd = 1;
	setb	__print_format_lsd_1_1
;	printf_large.c:718: do {
	mov	r0,__print_format_pstore_4_22
	mov	r4,#0x00
00190$:
;	printf_large.c:719: value.byte[4] = 0;
	mov	(_value + 0x0004),#0x00
;	printf_large.c:723: calculate_digit(radix);
	mov	dpl,__print_format_radix_1_1
	push	ar4
	push	ar0
	lcall	_calculate_digit
	pop	ar0
	pop	ar4
;	printf_large.c:725: if (!lsd)
	jb	__print_format_lsd_1_1,00188$
;	printf_large.c:727: *pstore = (value.byte[4] << 4) | (value.byte[4] >> 4) | *pstore;
	mov	a,(_value + 0x0004)
	swap	a
	mov	r5,a
	mov	a,@r0
	mov	r6,a
	orl	a,r5
	mov	@r0,a
;	printf_large.c:728: pstore--;
	dec	r0
	mov	__print_format_pstore_4_22,r0
	sjmp	00189$
00188$:
;	printf_large.c:732: *pstore = value.byte[4];
	mov	@r0,(_value + 0x0004)
00189$:
;	printf_large.c:734: length++;
	inc	r4
	mov	ar3,r4
;	printf_large.c:735: lsd = !lsd;
	cpl	__print_format_lsd_1_1
;	printf_large.c:736: } while( value.ul );
	mov	a,_value
	orl	a,(_value + 1)
	orl	a,(_value + 2)
	orl	a,(_value + 3)
	jnz	00190$
;	printf_large.c:738: if (width == 0)
	mov	__print_format_pstore_4_22,r0
	mov	ar3,r4
	mov	a,__print_format_width_1_1
	jnz	00194$
;	printf_large.c:743: width=1;
	mov	__print_format_width_1_1,#0x01
00194$:
;	printf_large.c:747: if (!zero_padding && !left_justify)
	jb	__print_format_zero_padding_1_1,00199$
	jb	__print_format_left_justify_1_1,00199$
;	printf_large.c:749: while ( width > (unsigned char) (length+1) )
	mov	a,r3
	inc	a
	mov	r4,a
	mov	r5,__print_format_width_1_1
00195$:
	mov	a,r4
	cjne	a,ar5,00398$
00398$:
	jnc	00325$
;	printf_large.c:751: OUTPUT_CHAR( ' ', p );
	mov	dpl,#0x20
	push	ar3
	push	ar4
	push	ar5
	lcall	__output_char
	pop	ar5
	pop	ar4
	pop	ar3
;	printf_large.c:752: width--;
	dec	r5
	sjmp	00195$
00325$:
	mov	__print_format_width_1_1,r5
00199$:
;	printf_large.c:756: if (signed_argument) // this now means the original value was negative
	jnb	__print_format_signed_argument_1_1,00209$
;	printf_large.c:758: OUTPUT_CHAR( '-', p );
	mov	dpl,#0x2D
	push	ar3
	lcall	__output_char
	pop	ar3
;	printf_large.c:760: width--;
	dec	__print_format_width_1_1
	sjmp	00210$
00209$:
;	printf_large.c:762: else if (length != 0)
	mov	a,r3
	jz	00210$
;	printf_large.c:765: if (prefix_sign)
	jnb	__print_format_prefix_sign_1_1,00204$
;	printf_large.c:767: OUTPUT_CHAR( '+', p );
	mov	dpl,#0x2B
	push	ar3
	lcall	__output_char
	pop	ar3
;	printf_large.c:769: width--;
	dec	__print_format_width_1_1
	sjmp	00210$
00204$:
;	printf_large.c:771: else if (prefix_space)
	jnb	__print_format_prefix_space_1_1,00210$
;	printf_large.c:773: OUTPUT_CHAR( ' ', p );
	mov	dpl,#0x20
	push	ar3
	lcall	__output_char
	pop	ar3
;	printf_large.c:775: width--;
	dec	__print_format_width_1_1
00210$:
;	printf_large.c:780: if (!left_justify)
	jb	__print_format_left_justify_1_1,00218$
;	printf_large.c:781: while ( width-- > length )
	mov	r4,__print_format_width_1_1
00211$:
	mov	ar5,r4
	dec	r4
	mov	__print_format_width_1_1,r4
	mov	a,r3
	cjne	a,ar5,00405$
00405$:
	jnc	00326$
;	printf_large.c:783: OUTPUT_CHAR( zero_padding ? '0' : ' ', p );
	jnb	__print_format_zero_padding_1_1,00244$
	mov	r5,#0x30
	sjmp	00245$
00244$:
	mov	r5,#0x20
00245$:
	mov	dpl,r5
	push	ar3
	push	ar4
	lcall	__output_char
	pop	ar4
	pop	ar3
	sjmp	00211$
00218$:
;	printf_large.c:788: if (width > length)
	mov	a,r3
	cjne	a,__print_format_width_1_1,00408$
00408$:
	jnc	00215$
;	printf_large.c:789: width -= length;
	mov	a,__print_format_width_1_1
	clr	c
	subb	a,r3
	mov	__print_format_width_1_1,a
	sjmp	00318$
00215$:
;	printf_large.c:791: width = 0;
	mov	__print_format_width_1_1,#0x00
;	printf_large.c:828: return charsOutputted;
;	printf_large.c:795: while( length-- )
	sjmp	00318$
00326$:
	mov	__print_format_width_1_1,r4
00318$:
	mov	r0,__print_format_pstore_4_22
00223$:
	mov	ar4,r3
	dec	r3
	mov	a,r4
	jz	00225$
;	printf_large.c:797: lsd = !lsd;
	cpl	__print_format_lsd_1_1
;	printf_large.c:798: if (!lsd)
	jb	__print_format_lsd_1_1,00221$
;	printf_large.c:800: pstore++;
	inc	r0
;	printf_large.c:801: value.byte[4] = *pstore >> 4;
	mov	a,@r0
	swap	a
	anl	a,#0x0f
	mov	r4,a
	mov	(_value + 0x0004),r4
	sjmp	00222$
00221$:
;	printf_large.c:805: value.byte[4] = *pstore & 0x0F;
	mov	ar4,@r0
	mov	a,#0x0F
	anl	a,r4
	mov	(_value + 0x0004),a
00222$:
;	printf_large.c:811: output_digit( value.byte[4] );
	mov	dpl,(_value + 0x0004)
	push	ar3
	push	ar0
	lcall	_output_digit
	pop	ar0
	pop	ar3
	sjmp	00223$
00225$:
;	printf_large.c:814: if (left_justify)
	jb	__print_format_left_justify_1_1,00412$
	ljmp	00239$
00412$:
;	printf_large.c:815: while (width-- > 0)
	mov	r3,__print_format_width_1_1
00226$:
	mov	ar4,r3
	dec	r3
	mov	a,r4
	jnz	00413$
	ljmp	00239$
00413$:
;	printf_large.c:817: OUTPUT_CHAR(' ', p);
	mov	dpl,#0x20
	push	ar3
	lcall	__output_char
	pop	ar3
	sjmp	00226$
00237$:
;	printf_large.c:824: OUTPUT_CHAR( c, p );
	mov	dpl,r2
	lcall	__output_char
	ljmp	00239$
00241$:
;	printf_large.c:828: return charsOutputted;
	mov	dpl,_charsOutputted
	mov	dph,(_charsOutputted + 1)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
__str_0:
	.ascii "<NO FLOAT>"
	.db 0x00
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
