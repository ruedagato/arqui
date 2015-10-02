;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module printf_large
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
	.globl __print_format_PARM_4
	.globl __print_format_PARM_3
	.globl __print_format_PARM_2
	.globl __print_format
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_output_digit_c_1_1:
	.ds 1
__print_format_sloc0_1_0:
	.ds 2
__print_format_sloc1_1_0:
	.ds 1
__print_format_sloc2_1_0:
	.ds 4
__print_format_sloc3_1_0:
	.ds 4
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_calculate_digit_ul_1_1::
	.ds 4
_calculate_digit_b4_1_1::
	.ds 1
_calculate_digit_i_1_1::
	.ds 1
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
_lower_case:
	.ds 1
_output_char:
	.ds 2
_p:
	.ds 2
_value:
	.ds 5
_charsOutputted:
	.ds 2
__output_char_c_1_1:
	.ds 1
_output_2digits_b_1_1:
	.ds 1
_calculate_digit_radix_1_1:
	.ds 1
__print_format_PARM_2:
	.ds 2
__print_format_PARM_3:
	.ds 2
__print_format_PARM_4:
	.ds 2
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
__print_format_radix_1_1:
	.ds 1
__print_format_width_1_1:
	.ds 1
__print_format_decimals_1_1:
	.ds 1
__print_format_length_1_1:
	.ds 1
__print_format_c_1_1:
	.ds 1
__print_format_store_4_20:
	.ds 6
__print_format_pstore_4_20:
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
;Allocation info for local variables in function '_output_char'
;------------------------------------------------------------
;c                         Allocated with name '__output_char_c_1_1'
;------------------------------------------------------------
;../printf_large.c:105: _output_char (unsigned char c)
;	-----------------------------------------
;	 function _output_char
;	-----------------------------------------
__output_char:
	sta	__output_char_c_1_1
;../printf_large.c:107: output_char( c, p );
	lda	(_p + 1)
	psha
	lda	_p
	psha
	bsr	00104$
	bra	00103$
00104$:
	lda	(_output_char + 1)
	psha
	lda	_output_char
	psha
	lda	__output_char_c_1_1
	rts
00103$:
	ais	#2
;../printf_large.c:108: charsOutputted++;
	lda	(_charsOutputted + 1)
	inca
	sta	(_charsOutputted + 1)
	bne	00105$
	lda	_charsOutputted
	inca
	sta	_charsOutputted
00105$:
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'output_digit'
;------------------------------------------------------------
;c                         Allocated with name '_output_digit_c_1_1'
;n                         Allocated to registers 
;------------------------------------------------------------
;../printf_large.c:130: output_digit (unsigned char n)
;	-----------------------------------------
;	 function output_digit
;	-----------------------------------------
_output_digit:
;../printf_large.c:132: register unsigned char c = n + (unsigned char)'0';
	add	#0x30
	sta	*_output_digit_c_1_1
;../printf_large.c:134: if (c > (unsigned char)'9')
	lda	*_output_digit_c_1_1
	cmp	#0x39
	bls	00104$
00109$:
;../printf_large.c:136: c += (unsigned char)('A' - '0' - 10);
	lda	*_output_digit_c_1_1
	add	#0x07
	sta	*_output_digit_c_1_1
;../printf_large.c:137: if (lower_case)
	lda	_lower_case
	beq	00104$
00110$:
;../printf_large.c:138: c = tolower(c);
	bset	#5,*_output_digit_c_1_1
00104$:
;../printf_large.c:140: _output_char( c );
	lda	*_output_digit_c_1_1
	jsr	__output_char
00105$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'output_2digits'
;------------------------------------------------------------
;b                         Allocated with name '_output_2digits_b_1_1'
;------------------------------------------------------------
;../printf_large.c:157: output_2digits (unsigned char b)
;	-----------------------------------------
;	 function output_2digits
;	-----------------------------------------
_output_2digits:
	sta	_output_2digits_b_1_1
;../printf_large.c:159: output_digit( b>>4   );
	lda	_output_2digits_b_1_1
	nsa	
	and	#0x0f
	jsr	_output_digit
;../printf_large.c:160: output_digit( b&0x0F );
	lda	_output_2digits_b_1_1
	and	#0x0F
	jsr	_output_digit
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_digit'
;------------------------------------------------------------
;radix                     Allocated with name '_calculate_digit_radix_1_1'
;ul                        Allocated with name '_calculate_digit_ul_1_1'
;b4                        Allocated with name '_calculate_digit_b4_1_1'
;i                         Allocated with name '_calculate_digit_i_1_1'
;------------------------------------------------------------
;../printf_large.c:189: calculate_digit (unsigned char radix)
;	-----------------------------------------
;	 function calculate_digit
;	-----------------------------------------
_calculate_digit:
	sta	_calculate_digit_radix_1_1
;../printf_large.c:191: register unsigned long ul = value.ul;
	lda	_value
	sta	*_calculate_digit_ul_1_1
	lda	(_value + 1)
	sta	*(_calculate_digit_ul_1_1 + 1)
	lda	(_value + 2)
	sta	*(_calculate_digit_ul_1_1 + 2)
	lda	(_value + 3)
	sta	*(_calculate_digit_ul_1_1 + 3)
;../printf_large.c:192: register unsigned char b4 = value.byte[4];
	lda	(_value + 0x0004)
	sta	*_calculate_digit_b4_1_1
;../printf_large.c:195: do
	mov	#0x20,*_calculate_digit_i_1_1
00103$:
;../printf_large.c:197: b4 = (b4 << 1);
	lda	*_calculate_digit_b4_1_1
	lsla	
	sta	*_calculate_digit_b4_1_1
;../printf_large.c:198: b4 |= (ul >> 31) & 0x01;
	lda	*_calculate_digit_ul_1_1
	rola
	clra
	rola
	ora	*_calculate_digit_b4_1_1
	sta	*_calculate_digit_b4_1_1
;../printf_large.c:199: ul <<= 1;
	lda	*(_calculate_digit_ul_1_1 + 3)
	ldx	*(_calculate_digit_ul_1_1 + 2)
	lsla
	rolx
	sta	*(_calculate_digit_ul_1_1 + 3)
	stx	*(_calculate_digit_ul_1_1 + 2)
	lda	*(_calculate_digit_ul_1_1 + 1)
	ldx	*_calculate_digit_ul_1_1
	rola
	rolx
	sta	*(_calculate_digit_ul_1_1 + 1)
	stx	*_calculate_digit_ul_1_1
;../printf_large.c:201: if (radix <= b4 )
	lda	_calculate_digit_radix_1_1
	cmp	*_calculate_digit_b4_1_1
	bhi	00104$
00112$:
;../printf_large.c:203: b4 -= radix;
	lda	*_calculate_digit_b4_1_1
	sub	_calculate_digit_radix_1_1
	sta	*_calculate_digit_b4_1_1
;../printf_large.c:204: ul |= 1;
	bset	#0,*(_calculate_digit_ul_1_1 + 3)
00104$:
;../printf_large.c:206: } while (--i);
	dbnz	*_calculate_digit_i_1_1,00113$
	bra	00114$
00113$:
	bra	00103$
00114$:
;../printf_large.c:207: value.ul = ul;
	lda	*_calculate_digit_ul_1_1
	sta	_value
	lda	*(_calculate_digit_ul_1_1 + 1)
	sta	(_value + 1)
	lda	*(_calculate_digit_ul_1_1 + 2)
	sta	(_value + 2)
	lda	*(_calculate_digit_ul_1_1 + 3)
	sta	(_value + 3)
;../printf_large.c:208: value.byte[4] = b4;
	lda	*_calculate_digit_b4_1_1
	sta	(_value + 0x0004)
00106$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function '_print_format'
;------------------------------------------------------------
;sloc0                     Allocated with name '__print_format_sloc0_1_0'
;sloc1                     Allocated with name '__print_format_sloc1_1_0'
;sloc2                     Allocated with name '__print_format_sloc2_1_0'
;sloc3                     Allocated with name '__print_format_sloc3_1_0'
;pvoid                     Allocated with name '__print_format_PARM_2'
;format                    Allocated with name '__print_format_PARM_3'
;ap                        Allocated with name '__print_format_PARM_4'
;pfn                       Allocated to registers 
;left_justify              Allocated with name '__print_format_left_justify_1_1'
;zero_padding              Allocated with name '__print_format_zero_padding_1_1'
;prefix_sign               Allocated with name '__print_format_prefix_sign_1_1'
;prefix_space              Allocated with name '__print_format_prefix_space_1_1'
;signed_argument           Allocated with name '__print_format_signed_argument_1_1'
;char_argument             Allocated with name '__print_format_char_argument_1_1'
;long_argument             Allocated with name '__print_format_long_argument_1_1'
;float_argument            Allocated with name '__print_format_float_argument_1_1'
;lsd                       Allocated with name '__print_format_lsd_1_1'
;radix                     Allocated with name '__print_format_radix_1_1'
;width                     Allocated with name '__print_format_width_1_1'
;decimals                  Allocated with name '__print_format_decimals_1_1'
;length                    Allocated with name '__print_format_length_1_1'
;c                         Allocated with name '__print_format_c_1_1'
;store                     Allocated with name '__print_format_store_4_20'
;pstore                    Allocated with name '__print_format_pstore_4_20'
;------------------------------------------------------------
;../printf_large.c:414: _print_format (pfn_outputchar pfn, void* pvoid, const char *format, va_list ap)
;	-----------------------------------------
;	 function _print_format
;	-----------------------------------------
__print_format:
	sta	(_output_char + 1)
	stx	_output_char
;../printf_large.c:442: p = pvoid;
	lda	__print_format_PARM_2
	sta	_p
	lda	(__print_format_PARM_2 + 1)
	sta	(_p + 1)
;../printf_large.c:446: charsOutputted = 0;
	clra
	sta	_charsOutputted
	sta	(_charsOutputted + 1)
;../printf_large.c:454: while( c=*format++ )
00227$:
	lda	__print_format_PARM_3
	sta	*__print_format_sloc0_1_0
	lda	(__print_format_PARM_3 + 1)
	sta	*(__print_format_sloc0_1_0 + 1)
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	sta	*__print_format_sloc1_1_0
	lda	*(__print_format_sloc0_1_0 + 1)
	add	#0x01
	sta	(__print_format_PARM_3 + 1)
	lda	*__print_format_sloc0_1_0
	adc	#0x00
	sta	__print_format_PARM_3
	lda	*__print_format_sloc1_1_0
	sta	__print_format_c_1_1
	tst	*__print_format_sloc1_1_0
	bne	00311$
	jmp	00229$
00311$:
;../printf_large.c:456: if ( c=='%' )
	lda	__print_format_c_1_1
	cmp	#0x25
	beq	00312$
	jmp	00225$
00312$:
;../printf_large.c:458: left_justify    = 0;
;../printf_large.c:459: zero_padding    = 0;
;../printf_large.c:460: prefix_sign     = 0;
;../printf_large.c:461: prefix_space    = 0;
	clra
	sta	__print_format_left_justify_1_1
	sta	__print_format_zero_padding_1_1
	sta	__print_format_prefix_sign_1_1
	sta	__print_format_prefix_space_1_1
;../printf_large.c:462: signed_argument = 0;
;../printf_large.c:463: char_argument   = 0;
;../printf_large.c:464: long_argument   = 0;
;../printf_large.c:465: float_argument  = 0;
	clra
	sta	__print_format_signed_argument_1_1
	sta	__print_format_char_argument_1_1
	sta	__print_format_long_argument_1_1
	sta	__print_format_float_argument_1_1
;../printf_large.c:466: radix           = 0;
;../printf_large.c:467: width           = 0;
	clra
	sta	__print_format_radix_1_1
	sta	__print_format_width_1_1
;../printf_large.c:468: decimals        = -1;
	lda	#0xFF
	sta	__print_format_decimals_1_1
;../printf_large.c:470: get_conversion_spec:
	lda	__print_format_PARM_3
	sta	*__print_format_sloc0_1_0
	lda	(__print_format_PARM_3 + 1)
	sta	*(__print_format_sloc0_1_0 + 1)
00101$:
;../printf_large.c:472: c = *format++;
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	aix	#1
	sta	__print_format_c_1_1
	sthx	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_PARM_3
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(__print_format_PARM_3 + 1)
;../printf_large.c:474: if (c=='%') {
	lda	__print_format_c_1_1
	cmp	#0x25
	bne	00103$
00313$:
;../printf_large.c:475: OUTPUT_CHAR(c, p);
	lda	__print_format_c_1_1
	jsr	__output_char
;../printf_large.c:476: continue;
	jmp	00227$
00103$:
;../printf_large.c:479: if (isdigit(c)) {
	lda	__print_format_c_1_1
	cmp	#0x30
	bcs	00110$
00314$:
	lda	__print_format_c_1_1
	cmp	#0x39
	bhi	00110$
00315$:
;../printf_large.c:480: if (decimals==-1) {
	lda	__print_format_decimals_1_1
	cmp	#0xFF
	bne	00107$
00316$:
;../printf_large.c:481: width = 10*width + c - '0';
	lda	__print_format_width_1_1
	ldx	#0x0A
	mul
	add	__print_format_c_1_1
	sub	#0x30
	sta	__print_format_width_1_1
;../printf_large.c:482: if (width == 0) {
	lda	__print_format_width_1_1
	bne	00101$
00317$:
;../printf_large.c:484: zero_padding = 1;
	lda	#0x01
	sta	__print_format_zero_padding_1_1
	bra	00101$
00107$:
;../printf_large.c:487: decimals = 10*decimals + c - '0';
	lda	__print_format_decimals_1_1
	ldx	#0x0A
	mul
	add	__print_format_c_1_1
	sub	#0x30
	sta	__print_format_decimals_1_1
;../printf_large.c:489: goto get_conversion_spec;
	bra	00101$
00110$:
;../printf_large.c:492: if (c=='.') {
	lda	__print_format_c_1_1
	cmp	#0x2E
	bne	00115$
00318$:
;../printf_large.c:493: if (decimals==-1) decimals=0;
	lda	__print_format_decimals_1_1
	cmp	#0xFF
	beq	00319$
	jmp	00101$
00319$:
	clra
	sta	__print_format_decimals_1_1
;../printf_large.c:496: goto get_conversion_spec;
	jmp	00101$
00115$:
;../printf_large.c:499: if (islower(c))
	lda	__print_format_c_1_1
	cmp	#0x61
	bcs	00117$
00320$:
	lda	__print_format_c_1_1
	cmp	#0x7A
	bhi	00117$
00321$:
;../printf_large.c:501: c = toupper(c);
	lda	__print_format_c_1_1
	and	#0xDF
	sta	__print_format_c_1_1
;../printf_large.c:502: lower_case = 1;
	lda	#0x01
	sta	_lower_case
	bra	00118$
00117$:
;../printf_large.c:505: lower_case = 0;
	clra
	sta	_lower_case
00118$:
;../printf_large.c:507: switch( c )
	lda	__print_format_c_1_1
	cmp	#0x20
	bne	00322$
	jmp	00122$
00322$:
	lda	__print_format_c_1_1
	cmp	#0x2B
	bne	00323$
	jmp	00121$
00323$:
	lda	__print_format_c_1_1
	cmp	#0x2D
	bne	00324$
	jmp	00120$
00324$:
	lda	__print_format_c_1_1
	cmp	#0x42
	bne	00325$
	jmp	00123$
00325$:
	lda	__print_format_c_1_1
	cmp	#0x43
	bne	00326$
	jmp	00125$
00326$:
	lda	__print_format_c_1_1
	cmp	#0x44
	bne	00327$
	jmp	00150$
00327$:
	lda	__print_format_c_1_1
	cmp	#0x46
	bne	00328$
	jmp	00154$
00328$:
	lda	__print_format_c_1_1
	cmp	#0x49
	bne	00329$
	jmp	00150$
00329$:
	lda	__print_format_c_1_1
	cmp	#0x4C
	beq	00124$
00330$:
	lda	__print_format_c_1_1
	cmp	#0x4F
	bne	00331$
	jmp	00151$
00331$:
	lda	__print_format_c_1_1
	cmp	#0x50
	bne	00332$
	jmp	00148$
00332$:
	lda	__print_format_c_1_1
	cmp	#0x53
	bne	00333$
	jmp	00129$
00333$:
	lda	__print_format_c_1_1
	cmp	#0x55
	bne	00334$
	jmp	00152$
00334$:
	lda	__print_format_c_1_1
	cmp	#0x58
	bne	00335$
	jmp	00153$
00335$:
	jmp	00155$
;../printf_large.c:509: case '-':
00120$:
;../printf_large.c:510: left_justify = 1;
	lda	#0x01
	sta	__print_format_left_justify_1_1
;../printf_large.c:511: goto get_conversion_spec;
	jmp	00101$
;../printf_large.c:512: case '+':
00121$:
;../printf_large.c:513: prefix_sign = 1;
	lda	#0x01
	sta	__print_format_prefix_sign_1_1
;../printf_large.c:514: goto get_conversion_spec;
	jmp	00101$
;../printf_large.c:515: case ' ':
00122$:
;../printf_large.c:516: prefix_space = 1;
	lda	#0x01
	sta	__print_format_prefix_space_1_1
;../printf_large.c:517: goto get_conversion_spec;
	jmp	00101$
;../printf_large.c:518: case 'B':
00123$:
;../printf_large.c:519: char_argument = 1;
	lda	#0x01
	sta	__print_format_char_argument_1_1
;../printf_large.c:520: goto get_conversion_spec;
	jmp	00101$
;../printf_large.c:521: case 'L':
00124$:
;../printf_large.c:522: long_argument = 1;
	lda	#0x01
	sta	__print_format_long_argument_1_1
;../printf_large.c:523: goto get_conversion_spec;
	jmp	00101$
;../printf_large.c:525: case 'C':
00125$:
;../printf_large.c:526: if( char_argument )
	lda	__print_format_char_argument_1_1
	beq	00127$
00336$:
;../printf_large.c:527: c = va_arg(ap,char);
	lda	(__print_format_PARM_4 + 1)
	add	#0x01
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc0_1_0 + 1)
	sub	#0x01
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sbc	#0x00
	sta	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	sta	__print_format_c_1_1
	bra	00128$
00127$:
;../printf_large.c:529: c = va_arg(ap,int);
	lda	(__print_format_PARM_4 + 1)
	add	#0x02
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc0_1_0 + 1)
	sub	#0x02
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sbc	#0x00
	sta	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	aix	#1
	sta	*__print_format_sloc0_1_0
	lda	,x
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	__print_format_c_1_1
00128$:
;../printf_large.c:530: OUTPUT_CHAR( c, p );
	lda	__print_format_c_1_1
	jsr	__output_char
;../printf_large.c:531: break;
	jmp	00156$
;../printf_large.c:533: case 'S':
00129$:
;../printf_large.c:534: PTR = va_arg(ap,ptr_t);
	lda	(__print_format_PARM_4 + 1)
	add	#0x02
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc0_1_0 + 1)
	sub	#0x02
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sbc	#0x00
	sta	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	aix	#1
	sta	*__print_format_sloc0_1_0
	lda	,x
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sta	_value
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(_value + 1)
;../printf_large.c:544: length = strlen(PTR);
	lda	_value
	sta	*__print_format_sloc0_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc0_1_0 + 1)
	ldx	*__print_format_sloc0_1_0
	lda	*(__print_format_sloc0_1_0 + 1)
	jsr	_strlen
	sta	*(__print_format_sloc0_1_0 + 1)
	stx	*__print_format_sloc0_1_0
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	__print_format_length_1_1
;../printf_large.c:546: if ( decimals == -1 )
	lda	__print_format_decimals_1_1
	cmp	#0xFF
	bne	00131$
00337$:
;../printf_large.c:548: decimals = length;
	lda	__print_format_length_1_1
	sta	__print_format_decimals_1_1
00131$:
;../printf_large.c:550: if ( ( !left_justify ) && (length < width) )
	lda	__print_format_left_justify_1_1
	bne	00269$
00338$:
	lda	__print_format_length_1_1
	cmp	__print_format_width_1_1
	bcc	00269$
00339$:
;../printf_large.c:552: width -= length;
	lda	__print_format_width_1_1
	sub	__print_format_length_1_1
	sta	__print_format_width_1_1
;../printf_large.c:553: while( width-- != 0 )
	lda	__print_format_width_1_1
	sta	*__print_format_sloc1_1_0
00132$:
	mov	*__print_format_sloc1_1_0,*__print_format_sloc0_1_0
	dec	*__print_format_sloc1_1_0
	lda	*__print_format_sloc1_1_0
	sta	__print_format_width_1_1
	tst	*__print_format_sloc0_1_0
	beq	00304$
00340$:
;../printf_large.c:555: OUTPUT_CHAR( ' ', p );
	lda	#0x20
	jsr	__output_char
	bra	00132$
;../printf_large.c:559: while ( (c = *PTR)  && (decimals-- > 0))
00304$:
	lda	*__print_format_sloc1_1_0
	sta	__print_format_width_1_1
00269$:
	lda	__print_format_decimals_1_1
	sta	*__print_format_sloc1_1_0
00139$:
	lda	_value
	sta	*__print_format_sloc0_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc0_1_0 + 1)
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	sta	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_c_1_1
	tst	*__print_format_sloc0_1_0
	beq	00141$
00341$:
	mov	*__print_format_sloc1_1_0,*__print_format_sloc0_1_0
	dec	*__print_format_sloc1_1_0
	lda	*__print_format_sloc0_1_0
	cmp	#0x00
	ble	00141$
00342$:
;../printf_large.c:561: OUTPUT_CHAR( c, p );
	lda	__print_format_c_1_1
	jsr	__output_char
;../printf_large.c:562: PTR++;
	lda	_value
	sta	*__print_format_sloc0_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc0_1_0 + 1)
	ldhx	*__print_format_sloc0_1_0
	aix	#1
	sthx	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	_value
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(_value + 1)
	bra	00139$
00141$:
;../printf_large.c:565: if ( left_justify && (length < width))
	lda	__print_format_left_justify_1_1
	bne	00343$
	jmp	00156$
00343$:
	lda	__print_format_length_1_1
	cmp	__print_format_width_1_1
	bcs	00344$
	jmp	00156$
00344$:
;../printf_large.c:567: width -= length;
	lda	__print_format_width_1_1
	sub	__print_format_length_1_1
	sta	__print_format_width_1_1
;../printf_large.c:568: while( width-- != 0 )
	lda	__print_format_width_1_1
	sta	*__print_format_sloc1_1_0
00142$:
	mov	*__print_format_sloc1_1_0,*__print_format_sloc0_1_0
	dec	*__print_format_sloc1_1_0
	lda	*__print_format_sloc1_1_0
	sta	__print_format_width_1_1
	tst	*__print_format_sloc0_1_0
	bne	00345$
	jmp	00306$
00345$:
;../printf_large.c:570: OUTPUT_CHAR( ' ', p );
	lda	#0x20
	jsr	__output_char
	bra	00142$
;../printf_large.c:575: case 'P':
00148$:
;../printf_large.c:576: PTR = va_arg(ap,ptr_t);
	lda	(__print_format_PARM_4 + 1)
	add	#0x02
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc0_1_0 + 1)
	sub	#0x02
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sbc	#0x00
	sta	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	aix	#1
	sta	*__print_format_sloc0_1_0
	lda	,x
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sta	_value
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(_value + 1)
;../printf_large.c:620: OUTPUT_CHAR('0', p);
	lda	#0x30
	jsr	__output_char
;../printf_large.c:621: OUTPUT_CHAR('x', p);
	lda	#0x78
	jsr	__output_char
;../printf_large.c:622: OUTPUT_2DIGITS( value.byte[1] );
	lda	(_value + 0x0001)
	jsr	_output_2digits
;../printf_large.c:623: OUTPUT_2DIGITS( value.byte[0] );
	lda	_value
	jsr	_output_2digits
;../printf_large.c:625: break;
	bra	00156$
;../printf_large.c:628: case 'I':
00150$:
;../printf_large.c:629: signed_argument = 1;
	lda	#0x01
	sta	__print_format_signed_argument_1_1
;../printf_large.c:630: radix = 10;
	lda	#0x0A
	sta	__print_format_radix_1_1
;../printf_large.c:631: break;
	bra	00156$
;../printf_large.c:633: case 'O':
00151$:
;../printf_large.c:634: radix = 8;
	lda	#0x08
	sta	__print_format_radix_1_1
;../printf_large.c:635: break;
	bra	00156$
;../printf_large.c:637: case 'U':
00152$:
;../printf_large.c:638: radix = 10;
	lda	#0x0A
	sta	__print_format_radix_1_1
;../printf_large.c:639: break;
	bra	00156$
;../printf_large.c:641: case 'X':
00153$:
;../printf_large.c:642: radix = 16;
	lda	#0x10
	sta	__print_format_radix_1_1
;../printf_large.c:643: break;
	bra	00156$
;../printf_large.c:645: case 'F':
00154$:
;../printf_large.c:646: float_argument=1;
	lda	#0x01
	sta	__print_format_float_argument_1_1
;../printf_large.c:647: break;
	bra	00156$
;../printf_large.c:649: default:
00155$:
;../printf_large.c:651: OUTPUT_CHAR( c, p );
	lda	__print_format_c_1_1
	jsr	__output_char
;../printf_large.c:828: return charsOutputted;
	bra	00156$
;../printf_large.c:653: }
00306$:
	lda	*__print_format_sloc1_1_0
	sta	__print_format_width_1_1
00156$:
;../printf_large.c:655: if (float_argument) {
	lda	__print_format_float_argument_1_1
	bne	00346$
	jmp	00222$
00346$:
;../printf_large.c:656: value.f=va_arg(ap,float);
	lda	(__print_format_PARM_4 + 1)
	add	#0x04
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc0_1_0 + 1)
	sub	#0x04
	sta	*(__print_format_sloc0_1_0 + 1)
	lda	*__print_format_sloc0_1_0
	sbc	#0x00
	sta	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc0_1_0
	lda	,x
	aix	#1
	sta	*__print_format_sloc2_1_0
	lda	,x
	aix	#1
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	,x
	aix	#1
	sta	*(__print_format_sloc2_1_0 + 2)
	lda	,x
	sta	*(__print_format_sloc2_1_0 + 3)
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
;../printf_large.c:658: PTR="<NO FLOAT>";
	lda	#>__str_0
	sta	_value
	lda	#__str_0
	sta	(_value + 1)
;../printf_large.c:659: while (c=*PTR++)
00157$:
	lda	_value
	sta	*__print_format_sloc2_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	ldhx	*__print_format_sloc2_1_0
	aix	#1
	sthx	*__print_format_sloc0_1_0
	lda	*__print_format_sloc0_1_0
	sta	_value
	lda	*(__print_format_sloc0_1_0 + 1)
	sta	(_value + 1)
	ldhx	*__print_format_sloc2_1_0
	lda	,x
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	__print_format_c_1_1
	tst	*__print_format_sloc2_1_0
	bne	00347$
	jmp	00227$
00347$:
;../printf_large.c:661: OUTPUT_CHAR (c, p);
	lda	__print_format_c_1_1
	jsr	__output_char
	bra	00157$
00222$:
;../printf_large.c:678: } else if (radix != 0)
	lda	__print_format_radix_1_1
	bne	00348$
	jmp	00227$
00348$:
;../printf_large.c:683: unsigned char MEM_SPACE_BUF_PP *pstore = &store[5];
	lda	#>(__print_format_store_4_20 + 0x0005)
	sta	__print_format_pstore_4_20
	lda	#(__print_format_store_4_20 + 0x0005)
	sta	(__print_format_pstore_4_20 + 1)
;../printf_large.c:686: if (char_argument)
	lda	__print_format_char_argument_1_1
	bne	00349$
	jmp	00168$
00349$:
;../printf_large.c:688: value.l = va_arg(ap,char);
	lda	(__print_format_PARM_4 + 1)
	add	#0x01
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc2_1_0 + 1)
	sub	#0x01
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	*__print_format_sloc2_1_0
	sbc	#0x00
	sta	*__print_format_sloc2_1_0
	ldhx	*__print_format_sloc2_1_0
	lda	,x
	sta	*(__print_format_sloc2_1_0 + 3)
	rola	
	clra	
	sbc	#0x00
	sta	*(__print_format_sloc2_1_0 + 2)
	sta	*(__print_format_sloc2_1_0 + 1)
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
;../printf_large.c:689: if (!signed_argument)
	lda	__print_format_signed_argument_1_1
	beq	00350$
	jmp	00169$
00350$:
;../printf_large.c:691: value.l &= 0xFF;
	lda	_value
	sta	*__print_format_sloc2_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	(_value + 2)
	sta	*(__print_format_sloc2_1_0 + 2)
	lda	(_value + 3)
	sta	*(__print_format_sloc2_1_0 + 3)
	clr	*(__print_format_sloc2_1_0 + 2)
	clr	*(__print_format_sloc2_1_0 + 1)
	clr	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
	jmp	00169$
00168$:
;../printf_large.c:694: else if (long_argument)
	lda	__print_format_long_argument_1_1
	beq	00165$
00351$:
;../printf_large.c:696: value.l = va_arg(ap,long);
	lda	(__print_format_PARM_4 + 1)
	add	#0x04
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc2_1_0 + 1)
	sub	#0x04
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	*__print_format_sloc2_1_0
	sbc	#0x00
	sta	*__print_format_sloc2_1_0
	ldhx	*__print_format_sloc2_1_0
	lda	,x
	aix	#1
	sta	*__print_format_sloc2_1_0
	lda	,x
	aix	#1
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	,x
	aix	#1
	sta	*(__print_format_sloc2_1_0 + 2)
	lda	,x
	sta	*(__print_format_sloc2_1_0 + 3)
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
	jmp	00169$
00165$:
;../printf_large.c:700: value.l = va_arg(ap,int);
	lda	(__print_format_PARM_4 + 1)
	add	#0x02
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	__print_format_PARM_4
	adc	#0x00
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	__print_format_PARM_4
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(__print_format_PARM_4 + 1)
	lda	*(__print_format_sloc2_1_0 + 1)
	sub	#0x02
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	*__print_format_sloc2_1_0
	sbc	#0x00
	sta	*__print_format_sloc2_1_0
	ldhx	*__print_format_sloc2_1_0
	lda	,x
	aix	#1
	sta	*__print_format_sloc2_1_0
	lda	,x
	sta	*(__print_format_sloc2_1_0 + 1)
	mov	*(__print_format_sloc2_1_0 + 1),*(__print_format_sloc2_1_0 + 3)
	mov	*__print_format_sloc2_1_0,*(__print_format_sloc2_1_0 + 2)
	lda	*__print_format_sloc2_1_0
	rola	
	clra	
	sbc	#0x00
	sta	*(__print_format_sloc2_1_0 + 1)
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
;../printf_large.c:701: if (!signed_argument)
	lda	__print_format_signed_argument_1_1
	bne	00169$
00352$:
;../printf_large.c:703: value.l &= 0xFFFF;
	lda	_value
	sta	*__print_format_sloc2_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	(_value + 2)
	sta	*(__print_format_sloc2_1_0 + 2)
	lda	(_value + 3)
	sta	*(__print_format_sloc2_1_0 + 3)
	clr	*(__print_format_sloc2_1_0 + 1)
	clr	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
00169$:
;../printf_large.c:707: if ( signed_argument )
	lda	__print_format_signed_argument_1_1
	bne	00353$
	jmp	00174$
00353$:
;../printf_large.c:709: if (value.l < 0)
	lda	_value
	sta	*__print_format_sloc2_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	(_value + 2)
	sta	*(__print_format_sloc2_1_0 + 2)
	lda	(_value + 3)
	sta	*(__print_format_sloc2_1_0 + 3)
	lda	*__print_format_sloc2_1_0
	sub	#0x00
	bge	00171$
00354$:
;../printf_large.c:710: value.l = -value.l;
	lda	_value
	sta	*__print_format_sloc2_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	(_value + 2)
	sta	*(__print_format_sloc2_1_0 + 2)
	lda	(_value + 3)
	sta	*(__print_format_sloc2_1_0 + 3)
	clra
	sub	*(__print_format_sloc2_1_0 + 3)
	sta	*(__print_format_sloc2_1_0 + 3)
	clra
	sbc	*(__print_format_sloc2_1_0 + 2)
	sta	*(__print_format_sloc2_1_0 + 2)
	clra
	sbc	*(__print_format_sloc2_1_0 + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	clra
	sbc	*__print_format_sloc2_1_0
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	_value
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(_value + 1)
	lda	*(__print_format_sloc2_1_0 + 2)
	sta	(_value + 2)
	lda	*(__print_format_sloc2_1_0 + 3)
	sta	(_value + 3)
	bra	00174$
00171$:
;../printf_large.c:712: signed_argument = 0;
	clra
	sta	__print_format_signed_argument_1_1
00174$:
;../printf_large.c:716: lsd = 1;
	lda	#0x01
	sta	__print_format_lsd_1_1
;../printf_large.c:718: do {
	lda	__print_format_pstore_4_20
	sta	*__print_format_sloc2_1_0
	lda	(__print_format_pstore_4_20 + 1)
	sta	*(__print_format_sloc2_1_0 + 1)
	clr	*__print_format_sloc1_1_0
00178$:
;../printf_large.c:719: value.byte[4] = 0;
	clra
	sta	(_value + 0x0004)
;../printf_large.c:723: calculate_digit(radix);
	lda	__print_format_radix_1_1
	jsr	_calculate_digit
;../printf_large.c:725: if (!lsd)
	lda	__print_format_lsd_1_1
	bne	00176$
00355$:
;../printf_large.c:727: *pstore = (value.byte[4] << 4) | (value.byte[4] >> 4) | *pstore;
	lda	(_value + 0x0004)
	nsa
	sta	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc2_1_0
	lda	,x
	ora	*__print_format_sloc0_1_0
	ldhx	*__print_format_sloc2_1_0
	sta	,x
;../printf_large.c:728: pstore--;
	lda	*(__print_format_sloc2_1_0 + 1)
	sub	#0x01
	sta	*(__print_format_sloc2_1_0 + 1)
	lda	*__print_format_sloc2_1_0
	sbc	#0x00
	sta	*__print_format_sloc2_1_0
	lda	*__print_format_sloc2_1_0
	sta	__print_format_pstore_4_20
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(__print_format_pstore_4_20 + 1)
	bra	00177$
00176$:
;../printf_large.c:732: *pstore = value.byte[4];
	lda	(_value + 0x0004)
	ldhx	*__print_format_sloc2_1_0
	sta	,x
00177$:
;../printf_large.c:734: length++;
	inc	*__print_format_sloc1_1_0
	lda	*__print_format_sloc1_1_0
	sta	__print_format_length_1_1
;../printf_large.c:735: lsd = !lsd;
	lda	__print_format_lsd_1_1
	beq	00356$
	lda	#0x01
00356$:
	eor	#0x01
	sta	__print_format_lsd_1_1
;../printf_large.c:736: } while( value.ul );
	lda	_value
	sta	*__print_format_sloc3_1_0
	lda	(_value + 1)
	sta	*(__print_format_sloc3_1_0 + 1)
	lda	(_value + 2)
	sta	*(__print_format_sloc3_1_0 + 2)
	lda	(_value + 3)
	sta	*(__print_format_sloc3_1_0 + 3)
	lda	*(__print_format_sloc3_1_0 + 3)
	ora	*(__print_format_sloc3_1_0 + 2)
	ora	*(__print_format_sloc3_1_0 + 1)
	ora	*__print_format_sloc3_1_0
	beq	00357$
	jmp	00178$
00357$:
;../printf_large.c:738: if (width == 0)
	lda	*__print_format_sloc2_1_0
	sta	__print_format_pstore_4_20
	lda	*(__print_format_sloc2_1_0 + 1)
	sta	(__print_format_pstore_4_20 + 1)
	lda	*__print_format_sloc1_1_0
	sta	__print_format_length_1_1
	lda	__print_format_width_1_1
	bne	00182$
00358$:
;../printf_large.c:743: width=1;
	lda	#0x01
	sta	__print_format_width_1_1
00182$:
;../printf_large.c:747: if (!zero_padding && !left_justify)
	lda	__print_format_zero_padding_1_1
	bne	00187$
00359$:
	lda	__print_format_left_justify_1_1
	bne	00187$
00360$:
;../printf_large.c:749: while ( width > (unsigned char) (length+1) )
	lda	__print_format_length_1_1
	add	#0x01
	sta	*__print_format_sloc3_1_0
	lda	__print_format_width_1_1
	sta	*__print_format_sloc2_1_0
00183$:
	lda	*__print_format_sloc2_1_0
	cmp	*__print_format_sloc3_1_0
	bls	00308$
00361$:
;../printf_large.c:751: OUTPUT_CHAR( ' ', p );
	lda	#0x20
	jsr	__output_char
;../printf_large.c:752: width--;
	dec	*__print_format_sloc2_1_0
	bra	00183$
00308$:
	lda	*__print_format_sloc2_1_0
	sta	__print_format_width_1_1
00187$:
;../printf_large.c:756: if (signed_argument) // this now means the original value was negative
	lda	__print_format_signed_argument_1_1
	beq	00197$
00362$:
;../printf_large.c:758: OUTPUT_CHAR( '-', p );
	lda	#0x2D
	jsr	__output_char
;../printf_large.c:760: width--;
	lda	__print_format_width_1_1
	deca
	sta	__print_format_width_1_1
	bra	00198$
00197$:
;../printf_large.c:762: else if (length != 0)
	lda	__print_format_length_1_1
	beq	00198$
00363$:
;../printf_large.c:765: if (prefix_sign)
	lda	__print_format_prefix_sign_1_1
	beq	00192$
00364$:
;../printf_large.c:767: OUTPUT_CHAR( '+', p );
	lda	#0x2B
	jsr	__output_char
;../printf_large.c:769: width--;
	lda	__print_format_width_1_1
	deca
	sta	__print_format_width_1_1
	bra	00198$
00192$:
;../printf_large.c:771: else if (prefix_space)
	lda	__print_format_prefix_space_1_1
	beq	00198$
00365$:
;../printf_large.c:773: OUTPUT_CHAR( ' ', p );
	lda	#0x20
	jsr	__output_char
;../printf_large.c:775: width--;
	lda	__print_format_width_1_1
	deca
	sta	__print_format_width_1_1
00198$:
;../printf_large.c:780: if (!left_justify)
	lda	__print_format_left_justify_1_1
	bne	00206$
00366$:
;../printf_large.c:781: while ( width-- > length )
	lda	__print_format_width_1_1
	sta	*__print_format_sloc3_1_0
00199$:
	mov	*__print_format_sloc3_1_0,*__print_format_sloc2_1_0
	dec	*__print_format_sloc3_1_0
	lda	*__print_format_sloc3_1_0
	sta	__print_format_width_1_1
	lda	*__print_format_sloc2_1_0
	cmp	__print_format_length_1_1
	bls	00309$
00367$:
;../printf_large.c:783: OUTPUT_CHAR( zero_padding ? '0' : ' ', p );
	lda	__print_format_zero_padding_1_1
	beq	00232$
00368$:
	mov	#0x30,*__print_format_sloc2_1_0
	bra	00233$
00232$:
	mov	#0x20,*__print_format_sloc2_1_0
00233$:
	lda	*__print_format_sloc2_1_0
	jsr	__output_char
	bra	00199$
00206$:
;../printf_large.c:788: if (width > length)
	lda	__print_format_width_1_1
	cmp	__print_format_length_1_1
	bls	00203$
00369$:
;../printf_large.c:789: width -= length;
	lda	__print_format_width_1_1
	sub	__print_format_length_1_1
	sta	__print_format_width_1_1
	bra	00301$
00203$:
;../printf_large.c:791: width = 0;
	clra
	sta	__print_format_width_1_1
;../printf_large.c:828: return charsOutputted;
	bra	00301$
;../printf_large.c:795: while( length-- )
00309$:
	lda	*__print_format_sloc3_1_0
	sta	__print_format_width_1_1
00301$:
	lda	__print_format_pstore_4_20
	sta	*__print_format_sloc3_1_0
	lda	(__print_format_pstore_4_20 + 1)
	sta	*(__print_format_sloc3_1_0 + 1)
	lda	__print_format_length_1_1
	sta	*__print_format_sloc2_1_0
00211$:
	mov	*__print_format_sloc2_1_0,*__print_format_sloc1_1_0
	dec	*__print_format_sloc2_1_0
	tst	*__print_format_sloc1_1_0
	beq	00213$
00370$:
;../printf_large.c:797: lsd = !lsd;
	lda	__print_format_lsd_1_1
	beq	00371$
	lda	#0x01
00371$:
	eor	#0x01
	sta	__print_format_lsd_1_1
;../printf_large.c:798: if (!lsd)
	lda	__print_format_lsd_1_1
	bne	00209$
00372$:
;../printf_large.c:800: pstore++;
	ldhx	*__print_format_sloc3_1_0
	aix	#1
	sthx	*__print_format_sloc3_1_0
;../printf_large.c:801: value.byte[4] = *pstore >> 4;
	ldhx	*__print_format_sloc3_1_0
	lda	,x
	nsa	
	and	#0x0f
	sta	(_value + 0x0004)
	bra	00210$
00209$:
;../printf_large.c:805: value.byte[4] = *pstore & 0x0F;
	ldhx	*__print_format_sloc3_1_0
	lda	,x
	and	#0x0F
	sta	(_value + 0x0004)
00210$:
;../printf_large.c:811: output_digit( value.byte[4] );
	lda	(_value + 0x0004)
	jsr	_output_digit
	bra	00211$
00213$:
;../printf_large.c:814: if (left_justify)
	lda	__print_format_left_justify_1_1
	bne	00373$
	jmp	00227$
00373$:
;../printf_large.c:815: while (width-- > 0)
	lda	__print_format_width_1_1
	sta	*__print_format_sloc3_1_0
00214$:
	mov	*__print_format_sloc3_1_0,*__print_format_sloc2_1_0
	dec	*__print_format_sloc3_1_0
	tst	*__print_format_sloc2_1_0
	bne	00374$
	jmp	00227$
00374$:
;../printf_large.c:817: OUTPUT_CHAR(' ', p);
	lda	#0x20
	jsr	__output_char
	bra	00214$
00225$:
;../printf_large.c:824: OUTPUT_CHAR( c, p );
	lda	__print_format_c_1_1
	jsr	__output_char
	jmp	00227$
00229$:
;../printf_large.c:828: return charsOutputted;
	ldx	_charsOutputted
	lda	(_charsOutputted + 1)
00230$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
__str_0:
	.ascii "<NO FLOAT>"
	.db 0x00
	.area XINIT
	.area CABS    (ABS,CODE)
