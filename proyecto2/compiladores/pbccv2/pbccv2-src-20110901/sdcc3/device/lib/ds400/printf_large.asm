;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module printf_large
	.optsdcc -mds400 --model-flat24
	
;--------------------------------------------------------
; CPU specific extensions
;--------------------------------------------------------
.flat24 on		; 24 bit flat addressing
dpl1	=	0x84
dph1	=	0x85
dps	=	0x86
dpx	=	0x93
dpx1	=	0x95
esp	=	0x9B
ap	=	0x9C
_ap	=	0x9C
mcnt0	=	0xD1
mcnt1	=	0xD2
ma	=	0xD3
mb	=	0xD4
mc	=	0xD5
F1	=	0xD1	; user flag
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __print_format_PARM_4
	.globl __print_format_PARM_3
	.globl __print_format_PARM_2
	.globl _output_float_PARM_3
	.globl _output_float_PARM_2
	.globl _output_float_PARM_7
	.globl _output_float_PARM_6
	.globl _output_float_PARM_5
	.globl _output_float_PARM_4
	.globl __print_format
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_P4	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_DPL1	=	0x0084
_DPH1	=	0x0085
_DPS	=	0x0086
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_CKCON	=	0x008e
_P1	=	0x0090
_EXIF	=	0x0091
_P4CNT	=	0x0092
_DPX	=	0x0093
_DPX1	=	0x0095
_SCON0	=	0x0098
_SBUF0	=	0x0099
_ESP	=	0x009b
_AP	=	0x009c
_ACON	=	0x009d
_P2	=	0x00a0
_P5	=	0x00a1
_P5CNT	=	0x00a2
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_SCON1	=	0x00c0
_SBUF1	=	0x00c1
_PMR	=	0x00c4
_MCON	=	0x00c6
_TA	=	0x00c7
_T2CON	=	0x00c8
_T2MOD	=	0x00c9
_RCAP2L	=	0x00ca
_RTL2	=	0x00ca
_RCAP2H	=	0x00cb
_RTH2	=	0x00cb
_TL2	=	0x00cc
_TH2	=	0x00cd
_PSW	=	0x00d0
_MCNT0	=	0x00d1
_MCNT1	=	0x00d2
_MA	=	0x00d3
_MB	=	0x00d4
_MC	=	0x00d5
_WDCON	=	0x00d8
_ACC	=	0x00e0
_EIE	=	0x00e8
_MXAX	=	0x00ea
_B	=	0x00f0
_EIP	=	0x00f8
_TMR0	=	0x8c8a
_TMR1	=	0x8d8b
_TMR2	=	0xcdcc
_RCAP2	=	0xcbca
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_T2	=	0x0090
_T2EX	=	0x0091
_RXD1	=	0x0092
_TXD1	=	0x0093
_INT2	=	0x0094
_INT3	=	0x0095
_INT4	=	0x0096
_INT5	=	0x0097
_RI_0	=	0x0098
_TI_0	=	0x0099
_RB8_0	=	0x009a
_TB8_0	=	0x009b
_REN_0	=	0x009c
_SM2_0	=	0x009d
_SM1_0	=	0x009e
_SM0_0	=	0x009f
_FE_0	=	0x009f
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES0	=	0x00ac
_ET2	=	0x00ad
_ES1	=	0x00ae
_EA	=	0x00af
_RXD0	=	0x00b0
_TXD0	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS0	=	0x00bc
_PT2	=	0x00bd
_PS1	=	0x00be
_RI_1	=	0x00c0
_TI_1	=	0x00c1
_RB8_1	=	0x00c2
_TB8_1	=	0x00c3
_REN_1	=	0x00c4
_SM2_1	=	0x00c5
_SM1_1	=	0x00c6
_SM0_1	=	0x00c7
_FE_1	=	0x00c7
_CP_RL	=	0x00c8
_C_T	=	0x00c9
_TR2	=	0x00ca
_EXEN2	=	0x00cb
_TCLK	=	0x00cc
_RCLK	=	0x00cd
_EXF2	=	0x00ce
_TF2	=	0x00cf
_P	=	0x00d0
_F1	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
_RWT	=	0x00d8
_EWT	=	0x00d9
_WDRF	=	0x00da
_WDIF	=	0x00db
_PFI	=	0x00dc
_EPFI	=	0x00dd
_POR	=	0x00de
_SMOD_1	=	0x00df
_EX2	=	0x00e8
_EX3	=	0x00e9
_EX4	=	0x00ea
_EX5	=	0x00eb
_EWDI	=	0x00ec
_C1IE	=	0x00ed
_C0IE	=	0x00ee
_CANBIE	=	0x00ef
_PX2	=	0x00f8
_PX3	=	0x00f9
_PX4	=	0x00fa
_PX5	=	0x00fb
_PWDI	=	0x00fc
_C1IP	=	0x00fd
_C0IP	=	0x00fe
_CANBIP	=	0x00ff
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
	.area REG_BANK_3	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
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
_output_float_PARM_4:
	.ds 1
_output_float_PARM_5:
	.ds 1
_output_float_PARM_6:
	.ds 1
_output_float_PARM_7:
	.ds 1
_output_float_negative_1_1:
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
_output_char:
	.ds 3
_p:
	.ds 4
_value:
	.ds 5
_charsOutputted:
	.ds 2
_output_float_PARM_2:
	.ds 1
_output_float_PARM_3:
	.ds 1
_output_float_f_1_1:
	.ds 4
_output_float_fpBuffer_1_1:
	.ds 128
_output_float_integerPart_1_1:
	.ds 4
_output_float_rounding_1_1:
	.ds 4
_output_float_decimalPart_1_1:
	.ds 4
__print_format_PARM_2:
	.ds 4
__print_format_PARM_3:
	.ds 4
__print_format_PARM_4:
	.ds 4
__print_format_radix_1_1:
	.ds 1
__print_format_width_1_1:
	.ds 1
__print_format_length_1_1:
	.ds 1
__print_format_store_4_23:
	.ds 6
__print_format_pstore_4_23:
	.ds 3
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
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
	mov	dptr,#_p
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	a,#00103$
	push	acc
	mov	a,#(00103$ >> 8)
	push	acc
	mov	a,#(00103$ >> 16)
	push	acc
	mov	dptr,#_output_char
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dpl,r2
	ret
00103$:
;	stack adjustment for parms
	pop	acc
	pop	acc
	pop	acc
	pop	acc
;	printf_large.c:108: charsOutputted++;
	mov	dptr,#_charsOutputted
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'output_digit'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;n                         Allocated to registers r2 
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
	clr	c
	mov	a,#0x39
	subb	a,r2
	jnc  00104$
00109$:
;	printf_large.c:136: c += (unsigned char)('A' - '0' - 10);
	mov	a,#0x07
	add	a,r2
	mov	r2,a
;	printf_large.c:137: if (lower_case)
	jnb  _lower_case,00104$
00110$:
;	printf_large.c:138: c = tolower(c);
	orl	ar2,#0x20
00104$:
;	printf_large.c:140: _output_char( c );
	mov	dpl,r2
	lcall	__output_char
00105$:
	ret
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
	mov	r2,dpl
;	printf_large.c:159: output_digit( b>>4   );
	mov	a,r2
	swap	a
	anl	a,#0x0F
	mov	r3,a
	push	ar2
	mov	dpl,r3
	lcall	_output_digit
	pop	ar2
;	printf_large.c:160: output_digit( b&0x0F );
	anl	ar2,#0x0F
	mov	dpl,r2
	lcall	_output_digit
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_digit'
;------------------------------------------------------------
;radix                     Allocated to registers r2 
;ul                        Allocated to registers r3 r4 r5 r6 
;b4                        Allocated to registers r7 
;i                         Allocated to registers r0 
;------------------------------------------------------------
;	printf_large.c:189: calculate_digit (unsigned char radix)
;	-----------------------------------------
;	 function calculate_digit
;	-----------------------------------------
_calculate_digit:
	mov	r2,dpl
;	printf_large.c:191: register unsigned long ul = value.ul;
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
;	printf_large.c:192: register unsigned char b4 = value.byte[4];
	mov	dptr,#(_value + 0x000004)
	movx	a,@dptr
	mov	r7,a
;	printf_large.c:195: do
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x20
00103$:
;	printf_large.c:197: b4 = (b4 << 1);
	mov	a,r7
	add	a,acc
	mov	r7,a
;	printf_large.c:198: b4 |= (ul >> 31) & 0x01;
	mov	a,r6
	rl	a
	anl	a,#0x01
	mov  r1,a
	orl	ar7,a
;	printf_large.c:199: ul <<= 1;
	mov	b,#0x02
	sjmp	00113$
00112$:
	mov	a,r3
	add	a,acc
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
00113$:
	djnz	b,00112$
;	printf_large.c:201: if (radix <= b4 )
	clr	c
	mov	a,r7
	subb	a,r2
	jc   00104$
00114$:
;	printf_large.c:203: b4 -= radix;
	clr	c
	mov	a,r7
	subb	a,r2
	mov	r7,a
;	printf_large.c:204: ul |= 1;
	orl	ar3,#0x01
00104$:
;	printf_large.c:206: } while (--i);
	djnz  r0,00103$
00115$:
00116$:
;	printf_large.c:207: value.ul = ul;
	mov	dptr,#_value
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	printf_large.c:208: value.byte[4] = b4;
	mov	dptr,#(_value + 0x000004)
	mov	a,r7
	movx	@dptr,a
00106$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'output_float'
;------------------------------------------------------------
;reqWidth                  Allocated with name '_output_float_PARM_2'
;reqDecimals               Allocated with name '_output_float_PARM_3'
;f                         Allocated with name '_output_float_f_1_1'
;fpBuffer                  Allocated with name '_output_float_fpBuffer_1_1'
;integerPart               Allocated with name '_output_float_integerPart_1_1'
;rounding                  Allocated with name '_output_float_rounding_1_1'
;decimalPart               Allocated with name '_output_float_decimalPart_1_1'
;fpBI                      Allocated to registers r6 
;fpBD                      Allocated to registers 
;minWidth                  Allocated to registers r3 
;i                         Allocated to registers r2 
;exp                       Allocated to registers r7 
;sloc0                     Allocated with name '_output_float_sloc0_1_0'
;sloc1                     Allocated with name '_output_float_sloc1_1_0'
;sloc2                     Allocated with name '_output_float_sloc2_1_0'
;------------------------------------------------------------
;	printf_large.c:241: output_float (float f, unsigned char reqWidth,
;	-----------------------------------------
;	 function output_float
;	-----------------------------------------
_output_float:
	mov     dps, #1
	mov     dptr, #_output_float_f_1_1
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	inc	dptr
	mov	a,b
	movx	@dptr,a
	mov	dps,#0
;	printf_large.c:247: BOOL negative = 0;
;	genAssign: resultIsFar = FALSE
	clr	_output_float_negative_1_1
;	printf_large.c:251: char fpBI=0, fpBD;
;	genAssign: resultIsFar = TRUE
	mov	r6,#0x00
;	printf_large.c:253: signed char exp = -128;
;	genAssign: resultIsFar = TRUE
	mov	r7,#0x80
;	printf_large.c:256: if (f<0) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fslt_PARM_2
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	push	ar7
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fslt
	pop	ar7
	mov	a,dpl
	jz  00102$
00257$:
;	printf_large.c:257: negative=1;
;	genAssign: resultIsFar = FALSE
	setb	_output_float_negative_1_1
;	printf_large.c:258: f=-f;
	mov	dptr,#_output_float_f_1_1
	mov	dps, #1
	mov	dptr, #_output_float_f_1_1
	dec	dps
	movx	a,@dptr
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	acc.7
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
00102$:
;	printf_large.c:261: if (f>0x00ffffff) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsgt_PARM_2
	mov  a,#0xFF
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x7F
	movx	@dptr,a
	inc	dptr
	mov	a,#0x4B
	movx	@dptr,a
	push	ar7
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsgt
	pop	ar7
	mov	a,dpl
	jnz	00258$
	ljmp	00109$
00258$:
;	printf_large.c:264: for (exp = 0; f >= 10.0; exp++) f /=10.0;
;	genAssign: resultIsFar = TRUE
	mov	r7,#0x00
;	genAssign: resultIsFar = FALSE
	mov	r6,#0x00
00176$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fslt_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x20
	movx	@dptr,a
	inc	dptr
	mov	a,#0x41
	movx	@dptr,a
	push	ar6
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fslt
	pop	ar6
	mov	a,dpl
	jnz  00205$
00259$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x20
	movx	@dptr,a
	inc	dptr
	mov	a,#0x41
	movx	@dptr,a
	push	ar6
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_f_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	r6
;	genAssign: resultIsFar = TRUE
	mov	ar7,r6
	ljmp	00176$
00205$:
;	genAssign: resultIsFar = FALSE
00180$:
;	printf_large.c:265: for (       ; f < 1.0;   exp--) f *=10.0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fslt_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x80
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	push	ar6
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fslt
	pop	ar6
	mov	a,dpl
	jz  00248$
00260$:
	mov	dptr,#_output_float_f_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsmul_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar6
	mov  dptr,#0x0000
	mov	dpx,#0x20
	mov	b,#0x41
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_f_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	dec	r6
;	genAssign: resultIsFar = TRUE
	mov	ar7,r6
	ljmp	00180$
00248$:
;	genAssign: resultIsFar = TRUE
	mov	ar7,r6
;	printf_large.c:267: if (negative) {
	jnb  _output_float_negative_1_1,00106$
00261$:
;	printf_large.c:268: OUTPUT_CHAR ('-', p);
	push	ar7
	mov	dpl,#0x2D
	lcall	__output_char
	pop	ar7
	sjmp 00107$
00106$:
;	printf_large.c:270: if (sign) {
	jnb  _output_float_PARM_6,00107$
00262$:
;	printf_large.c:271: OUTPUT_CHAR ('+', p);
	push	ar7
	mov	dpl,#0x2B
	lcall	__output_char
	pop	ar7
00107$:
;	printf_large.c:274: reqWidth = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_2
	clr  a
	movx	@dptr,a
;	printf_large.c:275: left = 0;
;	genAssign: resultIsFar = FALSE
	clr	_output_float_PARM_4
;	printf_large.c:276: zero = 0;
;	genAssign: resultIsFar = FALSE
	clr	_output_float_PARM_5
;	printf_large.c:277: sign = 0;
;	genAssign: resultIsFar = FALSE
	clr	_output_float_PARM_6
;	printf_large.c:278: space = 0;
;	genAssign: resultIsFar = FALSE
	clr	_output_float_PARM_7
00109$:
;	printf_large.c:282: if (reqDecimals==-1)
	mov	dptr,#_output_float_PARM_3
	movx	a,@dptr
	cjne a,#0xFF,00111$
00264$:
;	printf_large.c:283: reqDecimals=DEFAULT_FLOAT_PRECISION;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_3
	mov	a,#0x06
	movx	@dptr,a
00111$:
;	printf_large.c:286: rounding = 0.5;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_rounding_1_1
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
;	printf_large.c:287: for (i=reqDecimals; i>0; i--) {
	mov	dptr,#_output_float_PARM_3
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	r0,a
;	genAssign: resultIsFar = FALSE
00184$:
	mov	a,r0
	jz  00194$
00265$:
;	genAssign: resultIsFar = FALSE
	mov	r1,#0x01
	sjmp 00195$
00194$:
;	genAssign: resultIsFar = FALSE
	mov	r1,#0x00
00195$:
	mov	a,r1
	jz  00187$
00266$:
;	printf_large.c:288: rounding /= 10.0;
	push	ar7
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x20
	movx	@dptr,a
	inc	dptr
	mov	a,#0x41
	movx	@dptr,a
	push	ar0
	inc	dps
	mov	dptr,#_output_float_rounding_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsdiv
	mov	r1,dpl
	mov	r7,dph
	mov	r2,dpx
	mov	r3,b
	pop	ar0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_rounding_1_1
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	printf_large.c:287: for (i=reqDecimals; i>0; i--) {
	dec	r0
	pop	ar7
	sjmp 00184$
00187$:
;	printf_large.c:290: f += rounding;
	push	ar7
	mov	dptr,#_output_float_rounding_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsadd_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar7
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar7
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_f_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	printf_large.c:293: integerPart = f;
	push	ar7
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fs2ulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar7
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_integerPart_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	printf_large.c:294: decimalPart = f - integerPart;
	inc	dps
	mov	dptr,#_output_float_integerPart_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___ulong2fs
	mov	r0,dpl
	mov	r1,dph
	mov	r7,dpx
	mov	r2,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fssub_PARM_2
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	push	ar7
	inc	dps
	mov	dptr,#_output_float_f_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar7
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_decimalPart_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	printf_large.c:408: return;
	pop	ar7
;	printf_large.c:297: while (integerPart) {
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
00112$:
	mov	dptr,#_output_float_integerPart_1_1
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jnz	00267$
	ljmp	00250$
00267$:
;	printf_large.c:298: fpBuffer[fpBI++]='0' + integerPart%10;
;	genAssign: resultIsFar = FALSE
	mov	ar3,r2
	inc	r2
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	a,r3
	add	a,#_output_float_fpBuffer_1_1
	mov	r3,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 8)
	mov	r4,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 16)
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modulong_PARM_2
	mov	a,#0x0A
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar7
	inc	dps
	mov	dptr,#_output_float_integerPart_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	__modulong
	pop	ar7
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	r0,dpl
	mov	a,#0x30
	add	a,r0
	mov  r0,a
	mov  dpl,r3
	mov  dph,r4
	mov  dpx,r5
	movx	@dptr,a
;	printf_large.c:299: integerPart /= 10;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_PARM_2
	mov	a,#0x0A
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	push	ar2
	push	ar7
	inc	dps
	mov	dptr,#_output_float_integerPart_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	__divulong
	mov	r3,dpl
	mov	r4,dph
	mov	r5,dpx
	mov	r0,b
	pop	ar7
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_integerPart_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	ljmp	00112$
00250$:
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
;	printf_large.c:301: if (!fpBI) {
	mov	a,r2
	jnz  00116$
00268$:
;	printf_large.c:303: fpBuffer[fpBI++]='0';
	mov	a,#0x01
	add	a,r2
	mov	r6,a
	mov	a,r2
	add	a,#_output_float_fpBuffer_1_1
	mov	dpl,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 16)
	mov	dpx,a
	mov	a,#0x30
	movx	@dptr,a
00116$:
;	printf_large.c:309: for (i=reqDecimals; i>0; i--) {
	mov	dptr,#_output_float_PARM_3
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	r2,a
;	genAssign: resultIsFar = FALSE
	mov	ar3,r6
;	genAssign: resultIsFar = FALSE
00188$:
	mov	a,r2
	jz  00196$
00269$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x01
	sjmp 00197$
00196$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x00
00197$:
	mov	a,r4
	jnz	00270$
	ljmp	00251$
00270$:
;	printf_large.c:310: decimalPart *= 10.0;
	mov	dptr,#_output_float_decimalPart_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsmul_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	mov  dptr,#0x0000
	mov	dpx,#0x20
	mov	b,#0x41
	lcall	___fsmul
	mov	r4,dpl
	mov	r5,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_decimalPart_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	printf_large.c:312: integerPart = decimalPart;
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	inc	dps
	mov	dptr,#_output_float_decimalPart_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fs2ulong
	mov	r4,dpl
	mov	r5,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_integerPart_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	printf_large.c:313: fpBuffer[fpBD++] = '0' + integerPart;
;	genAssign: resultIsFar = FALSE
	mov	ar4,r3
	inc	r3
	mov	a,r4
	add	a,#_output_float_fpBuffer_1_1
	mov	dpl1,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 16)
	mov	dpx1,a
	mov	dptr,#_output_float_integerPart_1_1
	movx	a,@dptr
	add  a,#0x30
	mov  r1,a
	inc	dps
	movx	@dptr,a
	mov	dps,#0
;	printf_large.c:314: decimalPart -= integerPart;
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	inc	dps
	mov	dptr,#_output_float_integerPart_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___ulong2fs
	mov	r4,dpl
	mov	r5,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fssub_PARM_2
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	inc	dps
	mov	dptr,#_output_float_decimalPart_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	inc	dptr
	movx	a,@dptr
	mov	dpx,a
	inc	dptr
	movx	a,@dptr
	mov	b,a
	mov	dps,#0
	lcall	___fssub
	mov	r4,dpl
	mov	r5,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_decimalPart_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	printf_large.c:309: for (i=reqDecimals; i>0; i--) {
	dec	r2
	ljmp	00188$
00251$:
;	genAssign: resultIsFar = TRUE
;	printf_large.c:317: minWidth=fpBI; // we need at least these
;	genAssign: resultIsFar = TRUE
	mov	ar3,r6
;	printf_large.c:318: minWidth+=reqDecimals?reqDecimals+1:0; // maybe these
	mov	dptr,#_output_float_PARM_3
	movx	a,@dptr
	jz  00198$
00271$:
	mov	dptr,#_output_float_PARM_3
	movx	a,@dptr
	add	a,#0x01
	mov	r4,a
	sjmp 00199$
00198$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x00
00199$:
	mov	a,r4
	add	a,r3
	mov	r3,a
;	printf_large.c:319: if (negative || sign || space)
	jb   _output_float_negative_1_1,00117$
00272$:
	jb   _output_float_PARM_6,00117$
00273$:
	jnb  _output_float_PARM_7,00118$
00274$:
00117$:
;	printf_large.c:320: minWidth++; // and maybe even this :)
	inc	r3
00118$:
;	printf_large.c:322: if (!left && reqWidth>i) {
	jnb	_output_float_PARM_4,00275$
	ljmp	00155$
00275$:
	mov	dptr,#_output_float_PARM_2
	clr	c
	mov	a,r2
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jc	00276$
	ljmp	00155$
00276$:
;	printf_large.c:323: if (zero) {
	jnb  _output_float_PARM_5,00230$
00277$:
;	printf_large.c:324: if (negative)
	jnb  _output_float_negative_1_1,00127$
00278$:
;	printf_large.c:326: OUTPUT_CHAR('-', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2D
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	sjmp 00228$
00127$:
;	printf_large.c:328: else if (sign)
	jnb  _output_float_PARM_6,00124$
00279$:
;	printf_large.c:330: OUTPUT_CHAR('+', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2B
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	sjmp 00228$
00124$:
;	printf_large.c:332: else if (space)
	jnb  _output_float_PARM_7,00228$
00280$:
;	printf_large.c:334: OUTPUT_CHAR(' ', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
;	printf_large.c:336: while (reqWidth-->minWidth)
00228$:
	mov	dptr,#_output_float_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
00129$:
;	genAssign: resultIsFar = FALSE
	mov	ar5,r4
	dec	r4
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_2
	mov	a,r4
	movx	@dptr,a
	clr	c
	mov	a,r3
	subb	a,r5
	jc	00281$
	ljmp	00252$
00281$:
;	printf_large.c:338: OUTPUT_CHAR('0', p);
	push	ar3
	push	ar4
	push	ar6
	push	ar7
	mov	dpl,#0x30
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar4
	pop	ar3
;	printf_large.c:341: while (reqWidth-->minWidth)
	sjmp 00129$
00230$:
	mov	dptr,#_output_float_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r5,a
00132$:
;	genAssign: resultIsFar = FALSE
	mov	ar0,r5
	dec	r5
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_2
	mov	a,r5
	movx	@dptr,a
	clr	c
	mov	a,r3
	subb	a,r0
	jnc  00253$
00282$:
;	printf_large.c:343: OUTPUT_CHAR(' ', p);
	push	ar3
	push	ar5
	push	ar6
	push	ar7
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar3
	sjmp 00132$
00253$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_2
	mov	a,r5
	movx	@dptr,a
;	printf_large.c:345: if (negative)
	jnb  _output_float_negative_1_1,00141$
00283$:
;	printf_large.c:347: OUTPUT_CHAR('-', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2D
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	ljmp	00156$
00141$:
;	printf_large.c:349: else if (sign)
	jnb  _output_float_PARM_6,00138$
00284$:
;	printf_large.c:351: OUTPUT_CHAR('+', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2B
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	sjmp 00156$
00138$:
;	printf_large.c:353: else if (space)
	jnb  _output_float_PARM_7,00156$
00285$:
;	printf_large.c:355: OUTPUT_CHAR(' ', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	sjmp 00156$
00155$:
;	printf_large.c:359: if (negative)
	jnb  _output_float_negative_1_1,00152$
00286$:
;	printf_large.c:361: OUTPUT_CHAR('-', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2D
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	sjmp 00156$
00152$:
;	printf_large.c:363: else if (sign)
	jnb  _output_float_PARM_6,00149$
00287$:
;	printf_large.c:365: OUTPUT_CHAR('+', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2B
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	sjmp 00156$
00149$:
;	printf_large.c:367: else if (space)
	jnb  _output_float_PARM_7,00156$
00288$:
;	printf_large.c:369: OUTPUT_CHAR(' ', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
;	printf_large.c:408: return;
;	printf_large.c:369: OUTPUT_CHAR(' ', p);
	sjmp 00156$
00252$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_2
	mov	a,r4
	movx	@dptr,a
00156$:
;	printf_large.c:374: i=fpBI-1;
	mov	a,r6
	dec	a
;	genAssign: resultIsFar = TRUE
	mov	r2,a
;	printf_large.c:375: do {
;	genAssign: resultIsFar = FALSE
00158$:
;	printf_large.c:376: OUTPUT_CHAR (fpBuffer[i], p);
	mov	a,r2
	add	a,#_output_float_fpBuffer_1_1
	mov	dpl,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	r4,a
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,r4
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
	pop	ar2
;	printf_large.c:377: } while (i--);
;	genAssign: resultIsFar = FALSE
	mov	ar4,r2
	dec	r2
	mov	a,r4
	jnz  00158$
00289$:
;	printf_large.c:380: if (reqDecimals) {
	mov	dptr,#_output_float_PARM_3
	movx	a,@dptr
	jz  00165$
00290$:
;	printf_large.c:381: OUTPUT_CHAR ('.', p);
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,#0x2E
	lcall	__output_char
	pop	ar7
	pop	ar6
	pop	ar3
;	printf_large.c:383: while (reqDecimals--)
;	genAssign: resultIsFar = FALSE
	mov	ar2,r6
	mov	dptr,#_output_float_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
00161$:
;	genAssign: resultIsFar = FALSE
	mov	ar5,r4
	dec	r4
	mov	a,r5
	jz  00165$
00291$:
;	printf_large.c:385: OUTPUT_CHAR (fpBuffer[i++], p);
;	genAssign: resultIsFar = FALSE
	mov	ar5,r2
	inc	r2
	mov	a,r5
	add	a,#_output_float_fpBuffer_1_1
	mov	dpl,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_output_float_fpBuffer_1_1 >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar7
	mov	dpl,r5
	lcall	__output_char
	pop	ar7
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp 00161$
00165$:
;	printf_large.c:389: if (left && reqWidth>minWidth) {
	jnb  _output_float_PARM_4,00170$
00292$:
	mov	dptr,#_output_float_PARM_2
	clr	c
	mov	a,r3
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jnc  00170$
00293$:
;	printf_large.c:390: while (reqWidth-->minWidth)
	mov	dptr,#_output_float_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
00166$:
;	genAssign: resultIsFar = FALSE
	mov	ar4,r2
	dec	r2
	clr	c
	mov	a,r3
	subb	a,r4
	jnc  00170$
00294$:
;	printf_large.c:392: OUTPUT_CHAR(' ', p);
	push	ar2
	push	ar3
	push	ar7
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar7
	pop	ar3
	pop	ar2
	sjmp 00166$
00170$:
;	printf_large.c:396: if (exp != -128) {
	mov	a,r7
	cjne	a,#0x80,00295$
	sjmp 00175$
00295$:
;	printf_large.c:397: OUTPUT_CHAR ('e', p);
	push	ar7
	mov	dpl,#0x65
	lcall	__output_char
	pop	ar7
;	printf_large.c:398: if (exp<0) {
	mov	a,r7
	jnb  acc.7,00173$
00296$:
;	printf_large.c:399: OUTPUT_CHAR ('-', p);
	push	ar7
	mov	dpl,#0x2D
	lcall	__output_char
	pop	ar7
;	printf_large.c:400: exp = -exp;
	clr	c
	clr	a
	subb	a,r7
	mov	r7,a
00173$:
;	printf_large.c:402: OUTPUT_CHAR ('0'+exp/10, p);
	clr	F0
	mov	b,#0x0a
	mov	a,r7
	jnb	acc.7,00297$
	cpl	F0
	cpl	a
	inc	a
00297$:
	nop	; workaround for DS80C390 div bug.
	div	ab
	jnb	F0,00298$
	cpl	a
	inc	a
00298$:
	add  a,#0x30
	mov  r2,a
	push	ar7
	mov	dpl,r2
	lcall	__output_char
	pop	ar7
;	printf_large.c:403: OUTPUT_CHAR ('0'+exp%10, p);
	mov	b,#0x0a
	mov	a,r7
	clr	F0
	jnb	acc.7,00299$
	setb	F0
	cpl	a
	inc	a
00299$:
	nop	; workaround for DS80C390 div bug.
	div	ab
	mov	a,b
	jnb	F0,00300$
	cpl	a
	inc	a
00300$:
	add  a,#0x30
	mov  r7,a
	mov	dpl,r7
	lcall	__output_char
00175$:
;	printf_large.c:408: return;
00192$:
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
;length                    Allocated with name '__print_format_length_1_1'
;c                         Allocated to registers r2 
;memtype                   Allocated to registers r2 
;store                     Allocated with name '__print_format_store_4_23'
;pstore                    Allocated with name '__print_format_pstore_4_23'
;sloc0                     Allocated with name '__print_format_sloc0_1_0'
;------------------------------------------------------------
;	printf_large.c:414: _print_format (pfn_outputchar pfn, void* pvoid, const char *format, va_list ap)
;	-----------------------------------------
;	 function _print_format
;	-----------------------------------------
__print_format:
	mov     dps, #1
	mov     dptr, #_output_char
	mov	a,dpl
	movx	@dptr,a
	inc	dptr
	mov	a,dph
	movx	@dptr,a
	inc	dptr
	mov	a,dpx
	movx	@dptr,a
	mov	dps,#0
;	printf_large.c:442: p = pvoid;
	mov	dptr,#__print_format_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_p
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	printf_large.c:446: charsOutputted = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_charsOutputted
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	printf_large.c:449: if (format==0) {
	mov	dptr,#__print_format_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jnz  00249$
00325$:
;	printf_large.c:450: format=NULL_STRING;
	mov	dptr,#__print_format_PARM_3
	mov	a,#__str_0
	movx	@dptr,a
	inc	dptr
	mov	a,#(__str_0 >> 8)
	movx	@dptr,a
	inc	dptr
	mov	a,#(__str_0 >> 16)
	movx	@dptr,a
	inc	dptr
	mov	a,#0x80
	movx	@dptr,a
;	printf_large.c:454: while( c=*format++ )
00249$:
00238$:
	mov	dptr,#__print_format_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	mov	dptr,#__print_format_PARM_3
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr  a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r4
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	ar2,r6
	mov	a,r6
	jnz	00326$
	ljmp	00240$
00326$:
;	printf_large.c:456: if ( c=='%' )
	mov	a,r2
	cjne	a,#0x25,00327$
	sjmp	00328$
00327$:
	ljmp	00236$
00328$:
;	printf_large.c:458: left_justify    = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_left_justify_1_1
;	printf_large.c:459: zero_padding    = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_zero_padding_1_1
;	printf_large.c:460: prefix_sign     = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_prefix_sign_1_1
;	printf_large.c:461: prefix_space    = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_prefix_space_1_1
;	printf_large.c:462: signed_argument = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_signed_argument_1_1
;	printf_large.c:463: char_argument   = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_char_argument_1_1
;	printf_large.c:464: long_argument   = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_long_argument_1_1
;	printf_large.c:465: float_argument  = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_float_argument_1_1
;	printf_large.c:466: radix           = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_radix_1_1
;	printf_large.c:467: width           = 0;
;	genAssign: resultIsFar = TRUE
	clr   a
	movx  @dptr,a
	mov   dptr,#__print_format_width_1_1
	movx  @dptr,a
;	printf_large.c:468: decimals        = -1;
;	genAssign: resultIsFar = TRUE
	mov	r5,#0xFF
;	printf_large.c:470: get_conversion_spec:
	mov	dptr,#__print_format_PARM_3
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
00103$:
;	printf_large.c:472: c = *format++;
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_3
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	ar2,r3
;	printf_large.c:474: if (c=='%') {
	mov	a,r2
	cjne a,#0x25,00105$
00330$:
;	printf_large.c:475: OUTPUT_CHAR(c, p);
	mov	dpl,r2
	lcall	__output_char
;	printf_large.c:476: continue;
	ljmp	00238$
00105$:
;	printf_large.c:479: if (isdigit(c)) {
;	genAssign: resultIsFar = FALSE
	mov	ar3,r2
	cjne	r3,#0x30,00331$
00331$:
	jc   00112$
00332$:
;	genAssign: resultIsFar = FALSE
	mov	ar3,r2
	clr	c
	mov	a,#0x39
	subb	a,r3
	jc   00112$
00333$:
;	printf_large.c:480: if (decimals==-1) {
	mov	a,r5
	cjne a,#0xFF,00109$
00335$:
;	printf_large.c:481: width = 10*width + c - '0';
	mov	dptr,#__print_format_width_1_1
	mov	b,#0x0A
	movx	a,@dptr
	mul	ab
	add	a,r2
	mov  r3,a
	add	a,#0xD0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	movx	@dptr,a
;	printf_large.c:482: if (width == 0) {
	mov	dptr,#__print_format_width_1_1
	movx	a,@dptr
	jnz  00103$
00336$:
;	printf_large.c:484: zero_padding = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_zero_padding_1_1
	sjmp 00103$
00109$:
;	printf_large.c:487: decimals = 10*decimals + c - '0';
	clr	F0
	mov	b,#0x0A
	mov	a,r5
	jnb	acc.7,00337$
	cpl	F0
	cpl	a
	inc	a
00337$:
	mul	ab
	jnb	F0,00338$
	cpl	a
	inc	a
00338$:
	add	a,r2
	mov  r3,a
	add	a,#0xD0
;	genAssign: resultIsFar = TRUE
	mov	r5,a
;	printf_large.c:489: goto get_conversion_spec;
	ljmp	00103$
00112$:
;	printf_large.c:492: if (c=='.') {
	mov	a,r2
	cjne a,#0x2E,00117$
00340$:
;	printf_large.c:493: if (decimals==-1) decimals=0;
	mov	a,r5
	cjne	a,#0xFF,00341$
	sjmp	00342$
00341$:
	ljmp	00103$
00342$:
;	genAssign: resultIsFar = TRUE
	mov	r5,#0x00
;	printf_large.c:496: goto get_conversion_spec;
	ljmp	00103$
00117$:
;	printf_large.c:499: if (islower(c))
;	genAssign: resultIsFar = FALSE
	mov	ar3,r2
	cjne	r3,#0x61,00343$
00343$:
	jc   00119$
00344$:
;	genAssign: resultIsFar = FALSE
	mov	ar3,r2
	clr	c
	mov	a,#0x7A
	subb	a,r3
	jc   00119$
00345$:
;	printf_large.c:501: c = toupper(c);
	anl	ar2,#0xDF
;	printf_large.c:502: lower_case = 1;
;	genAssign: resultIsFar = FALSE
	setb	_lower_case
	sjmp 00120$
00119$:
;	printf_large.c:505: lower_case = 0;
;	genAssign: resultIsFar = FALSE
	clr	_lower_case
00120$:
;	printf_large.c:507: switch( c )
	mov	a,r2
	cjne	a,#0x20,00346$
	sjmp 00124$
00346$:
	mov	a,r2
	cjne	a,#0x2B,00347$
	sjmp 00123$
00347$:
	mov	a,r2
	cjne	a,#0x2D,00348$
	sjmp 00122$
00348$:
	mov	a,r2
	cjne	a,#0x42,00349$
	sjmp 00125$
00349$:
	mov	a,r2
	cjne	a,#0x43,00350$
	sjmp 00127$
00350$:
	mov	a,r2
	cjne	a,#0x44,00351$
	ljmp	00164$
00351$:
	mov	a,r2
	cjne	a,#0x46,00352$
	ljmp	00168$
00352$:
	mov	a,r2
	cjne	a,#0x49,00353$
	ljmp	00164$
00353$:
	mov	a,r2
	cjne	a,#0x4C,00354$
	sjmp 00126$
00354$:
	mov	a,r2
	cjne	a,#0x4F,00355$
	ljmp	00165$
00355$:
	mov	a,r2
	cjne	a,#0x50,00356$
	ljmp	00153$
00356$:
	mov	a,r2
	cjne	a,#0x53,00357$
	ljmp	00131$
00357$:
	mov	a,r2
	cjne	a,#0x55,00358$
	ljmp	00166$
00358$:
	mov	a,r2
	cjne	a,#0x58,00359$
	ljmp	00167$
00359$:
	ljmp	00169$
;	printf_large.c:509: case '-':
00122$:
;	printf_large.c:510: left_justify = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_left_justify_1_1
;	printf_large.c:511: goto get_conversion_spec;
	ljmp	00103$
;	printf_large.c:512: case '+':
00123$:
;	printf_large.c:513: prefix_sign = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_prefix_sign_1_1
;	printf_large.c:514: goto get_conversion_spec;
	ljmp	00103$
;	printf_large.c:515: case ' ':
00124$:
;	printf_large.c:516: prefix_space = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_prefix_space_1_1
;	printf_large.c:517: goto get_conversion_spec;
	ljmp	00103$
;	printf_large.c:518: case 'B':
00125$:
;	printf_large.c:519: char_argument = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_char_argument_1_1
;	printf_large.c:520: goto get_conversion_spec;
	ljmp	00103$
;	printf_large.c:521: case 'L':
00126$:
;	printf_large.c:522: long_argument = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_long_argument_1_1
;	printf_large.c:523: goto get_conversion_spec;
	ljmp	00103$
;	printf_large.c:525: case 'C':
00127$:
;	printf_large.c:526: if( char_argument )
	jnb  __print_format_char_argument_1_1,00129$
00360$:
;	printf_large.c:527: c = va_arg(ap,char);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	dec	r6
	cjne	r6,#0xFF,00361$
	dec	r7
	cjne	r7,#0xFF,00361$
	dec	r0
00361$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r6,a
;	genAssign: resultIsFar = TRUE
	mov	ar2,r6
	sjmp 00130$
00129$:
;	printf_large.c:529: c = va_arg(ap,int);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	a,r6
	add	a,#0xFE
	mov	r6,a
	mov	a,r7
	addc	a,#0xFF
	mov	r7,a
	mov	a,r0
	addc	a,#0xFF
	mov	r0,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrgetWord
	mov	r6,a
	mov	r7,_ap
	mov	ar2,r6
00130$:
;	printf_large.c:530: OUTPUT_CHAR( c, p );
	push	ar5
	mov	dpl,r2
	lcall	__output_char
	pop	ar5
;	printf_large.c:531: break;
	ljmp	00170$
;	printf_large.c:533: case 'S':
00131$:
;	printf_large.c:534: PTR = va_arg(ap,ptr_t);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	a,r6
	add	a,#0xFC
	mov	r6,a
	mov	a,r7
	addc	a,#0xFF
	mov	r7,a
	mov	a,r0
	addc	a,#0xFF
	mov	r0,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrgetWord
	mov	r6,a
	mov	r7,_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	r0,a
	mov	r1,_ap
	mov	dptr,#_value
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	printf_large.c:537: if (PTR==0) {
	mov	a,r6
	orl	a,r7
	orl	a,r0
	jnz  00133$
00362$:
;	printf_large.c:538: PTR=NULL_STRING;
	mov	dptr,#_value
	mov	a,#__str_0
	movx	@dptr,a
	inc	dptr
	mov	a,#(__str_0 >> 8)
	movx	@dptr,a
	inc	dptr
	mov	a,#(__str_0 >> 16)
	movx	@dptr,a
	inc	dptr
	mov	a,#0x80
	movx	@dptr,a
;	printf_large.c:539: length=NULL_STRING_LENGTH;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_length_1_1
	mov	a,#0x06
	movx	@dptr,a
	sjmp 00134$
00133$:
;	printf_large.c:541: length = strlen(PTR);
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	mov	r3,a
	push	ar5
	mov	dpl,r7
	mov	dph,r0
	mov	dpx,r1
	mov	b,r3
	lcall	_strlen
	mov	r3,dpl
	mov	r7,dph
	pop	ar5
	mov	dptr,#__print_format_length_1_1
	mov	a,r3
	movx	@dptr,a
;	printf_large.c:828: return charsOutputted;
;	printf_large.c:541: length = strlen(PTR);
00134$:
;	printf_large.c:546: if ( decimals == -1 )
	mov	a,r5
	cjne a,#0xFF,00136$
00364$:
;	printf_large.c:548: decimals = length;
	mov	dptr,#__print_format_length_1_1
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	r5,a
00136$:
;	printf_large.c:550: if ( ( !left_justify ) && (length < width) )
	jb   __print_format_left_justify_1_1,00282$
00365$:
	mov	dptr,#__print_format_width_1_1
	mov	dps, #1
	mov	dptr, #__print_format_length_1_1
	dec	dps
	clr	c
	mov	dps,#1
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jnc  00282$
00366$:
;	printf_large.c:552: width -= length;
	mov	dptr,#__print_format_length_1_1
	mov	dps, #1
	mov	dptr, #__print_format_width_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	b,a
	inc	dps
	movx	a,@dptr
	subb	a,b
	movx	@dptr,a
	mov	dps,#0
;	printf_large.c:553: while( width-- != 0 )
	mov	dptr,#__print_format_width_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r7,a
00137$:
;	genAssign: resultIsFar = FALSE
	mov	ar0,r7
	dec	r7
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r7
	movx	@dptr,a
	mov	a,r0
	jz  00318$
00367$:
;	printf_large.c:555: OUTPUT_CHAR( ' ', p );
	push	ar5
	push	ar7
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar7
	pop	ar5
;	printf_large.c:559: while ( (c = *PTR)  && (decimals-- > 0))
	sjmp 00137$
00318$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r7
	movx	@dptr,a
00282$:
;	genAssign: resultIsFar = FALSE
	mov	ar7,r5
00144$:
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	mov	r6,a
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r3
	mov	b,r6
	lcall	__gptrget
;	genAssign: resultIsFar = TRUE
	mov  r0,a
	mov  ar2,r0 
	jz  00319$
00368$:
;	genAssign: resultIsFar = FALSE
	mov	ar6,r7
	dec	r7
;	genAssign: resultIsFar = TRUE
	mov	ar5,r7
	clr	c
	mov  a,#(0x00 ^ 0x80)
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
	jnc  00319$
00369$:
;	printf_large.c:561: OUTPUT_CHAR( c, p );
	push	ar7
	mov	dpl,r2
	lcall	__output_char
	pop	ar7
;	printf_large.c:562: PTR++;
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	mov	r3,a
	inc	r6
	cjne	r6,#0,00370$
	inc	r0
	cjne	r0,#0,00370$
	inc	r1
00370$:
	mov	dptr,#_value
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	sjmp 00144$
00319$:
;	genAssign: resultIsFar = TRUE
	mov	ar5,r7
;	printf_large.c:565: if ( left_justify && (length < width))
	jb	__print_format_left_justify_1_1,00371$
	ljmp	00170$
00371$:
	mov	dptr,#__print_format_width_1_1
	mov	dps, #1
	mov	dptr, #__print_format_length_1_1
	dec	dps
	clr	c
	mov	dps,#1
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jc	00372$
	ljmp	00170$
00372$:
;	printf_large.c:567: width -= length;
	mov	dptr,#__print_format_length_1_1
	mov	dps, #1
	mov	dptr, #__print_format_width_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	b,a
	inc	dps
	movx	a,@dptr
	subb	a,b
	movx	@dptr,a
	mov	dps,#0
;	printf_large.c:568: while( width-- != 0 )
	mov	dptr,#__print_format_width_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
00147$:
;	genAssign: resultIsFar = FALSE
	mov	ar7,r6
	dec	r6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r6
	movx	@dptr,a
	mov	a,r7
	jnz	00373$
	ljmp	00320$
00373$:
;	printf_large.c:570: OUTPUT_CHAR( ' ', p );
	push	ar5
	push	ar6
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar6
	pop	ar5
;	printf_large.c:575: case 'P':
	sjmp 00147$
00153$:
;	printf_large.c:576: PTR = va_arg(ap,ptr_t);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	a,r7
	add	a,#0xFC
	mov	r7,a
	mov	a,r0
	addc	a,#0xFF
	mov	r0,a
	mov	a,r1
	addc	a,#0xFF
	mov	r1,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	mov	dpl,r7
	mov	dph,r0
	mov	dpx,r1
	mov	b,r3
	lcall	__gptrgetWord
	mov	r7,a
	mov	r0,_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	r1,a
	mov	r3,_ap
	mov	dptr,#_value
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	printf_large.c:580: unsigned char memtype = value.byte[3];
	mov	dptr,#(_value + 0x000003)
	movx	a,@dptr
	mov	r3,a
;	genAssign: resultIsFar = FALSE
	mov	ar2,r3
;	printf_large.c:581: if (memtype >= 0x80)
	cjne	r2,#0x80,00374$
00374$:
	jc   00161$
00375$:
;	printf_large.c:582: c = 'C';
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x43
	sjmp 00162$
00161$:
;	printf_large.c:583: else if (memtype >= 0x60)
	cjne	r2,#0x60,00376$
00376$:
	jc   00158$
00377$:
;	printf_large.c:584: c = 'P';
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x50
	sjmp 00162$
00158$:
;	printf_large.c:585: else if (memtype >= 0x40)
	cjne	r2,#0x40,00378$
00378$:
	jc   00155$
00379$:
;	printf_large.c:586: c = 'I';
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x49
	sjmp 00162$
00155$:
;	printf_large.c:588: c = 'X';
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x58
00162$:
;	printf_large.c:590: OUTPUT_CHAR(c, p);
	push	ar5
	mov	dpl,r2
	lcall	__output_char
	pop	ar5
;	printf_large.c:591: OUTPUT_CHAR(':', p);
	push	ar5
	mov	dpl,#0x3A
	lcall	__output_char
	pop	ar5
;	printf_large.c:592: OUTPUT_CHAR('0', p);
	push	ar5
	mov	dpl,#0x30
	lcall	__output_char
	pop	ar5
;	printf_large.c:593: OUTPUT_CHAR('x', p);
	push	ar5
	mov	dpl,#0x78
	lcall	__output_char
	pop	ar5
;	printf_large.c:594: OUTPUT_2DIGITS( value.byte[2] );
	mov	dptr,#(_value + 0x000002)
	movx	a,@dptr
	mov	r7,a
	push	ar5
	mov	dpl,r7
	lcall	_output_2digits
	pop	ar5
;	printf_large.c:595: OUTPUT_2DIGITS( value.byte[1] );
	mov	dptr,#(_value + 0x000001)
	movx	a,@dptr
	mov	r7,a
	push	ar5
	mov	dpl,r7
	lcall	_output_2digits
	pop	ar5
;	printf_large.c:596: OUTPUT_2DIGITS( value.byte[0] );
	mov	dptr,#_value
	movx	a,@dptr
	mov	r7,a
	push	ar5
	mov	dpl,r7
	lcall	_output_2digits
	pop	ar5
;	printf_large.c:625: break;
;	printf_large.c:628: case 'I':
	sjmp 00170$
00164$:
;	printf_large.c:629: signed_argument = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_signed_argument_1_1
;	printf_large.c:630: radix = 10;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_radix_1_1
	mov	a,#0x0A
	movx	@dptr,a
;	printf_large.c:631: break;
;	printf_large.c:633: case 'O':
	sjmp 00170$
00165$:
;	printf_large.c:634: radix = 8;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_radix_1_1
	mov	a,#0x08
	movx	@dptr,a
;	printf_large.c:635: break;
;	printf_large.c:637: case 'U':
	sjmp 00170$
00166$:
;	printf_large.c:638: radix = 10;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_radix_1_1
	mov	a,#0x0A
	movx	@dptr,a
;	printf_large.c:639: break;
;	printf_large.c:641: case 'X':
	sjmp 00170$
00167$:
;	printf_large.c:642: radix = 16;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_radix_1_1
	mov	a,#0x10
	movx	@dptr,a
;	printf_large.c:643: break;
;	printf_large.c:645: case 'F':
	sjmp 00170$
00168$:
;	printf_large.c:646: float_argument=1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_float_argument_1_1
;	printf_large.c:647: break;
;	printf_large.c:649: default:
	sjmp 00170$
00169$:
;	printf_large.c:651: OUTPUT_CHAR( c, p );
	push	ar5
	mov	dpl,r2
	lcall	__output_char
	pop	ar5
;	printf_large.c:828: return charsOutputted;
;	printf_large.c:653: }
	sjmp 00170$
00320$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r6
	movx	@dptr,a
00170$:
;	printf_large.c:655: if (float_argument) {
	jb	__print_format_float_argument_1_1,00380$
	ljmp	00233$
00380$:
;	printf_large.c:656: value.f=va_arg(ap,float);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	a,r6
	add	a,#0xFC
	mov	r6,a
	mov	a,r7
	addc	a,#0xFF
	mov	r7,a
	mov	a,r0
	addc	a,#0xFF
	mov	r0,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrgetWord
	mov	r6,a
	mov	r7,_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	r0,a
	mov	r1,_ap
	mov	dptr,#_value
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	printf_large.c:674: OUTPUT_FLOAT(value.f, width, decimals, left_justify,
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	inc	dptr
	movx	a,@dptr
	mov	dptr,#__print_format_width_1_1
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	dptr,#_output_float_PARM_2
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_output_float_PARM_3
	mov	a,r5
	movx	@dptr,a
;	genAssign: resultIsFar = FALSE
	mov	c,__print_format_left_justify_1_1
	mov	_output_float_PARM_4,c
;	genAssign: resultIsFar = FALSE
	mov	c,__print_format_zero_padding_1_1
	mov	_output_float_PARM_5,c
;	genAssign: resultIsFar = FALSE
	mov	c,__print_format_prefix_sign_1_1
	mov	_output_float_PARM_6,c
;	genAssign: resultIsFar = FALSE
	mov	c,__print_format_prefix_space_1_1
	mov	_output_float_PARM_7,c
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	_output_float
	ljmp	00238$
00233$:
;	printf_large.c:678: } else if (radix != 0)
	mov	dptr,#__print_format_radix_1_1
	movx	a,@dptr
	jnz	00381$
	ljmp	00238$
00381$:
;	printf_large.c:683: unsigned char MEM_SPACE_BUF_PP *pstore = &store[5];
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_pstore_4_23
	mov	a,#(__print_format_store_4_23 + 0x000005)
	movx	@dptr,a
	inc	dptr
	mov	a,#((__print_format_store_4_23 + 0x000005) >> 8)
	movx	@dptr,a
	inc	dptr
	mov	a,#((__print_format_store_4_23 + 0x000005) >> 16)
	movx	@dptr,a
;	printf_large.c:686: if (char_argument)
	jnb  __print_format_char_argument_1_1,00179$
00382$:
;	printf_large.c:688: value.l = va_arg(ap,char);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	dec	r0
	cjne	r0,#0xFF,00383$
	dec	r1
	cjne	r1,#0xFF,00383$
	dec	r5
00383$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrget
	mov  r0,a
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	r6,a
	mov	r7,a
	mov	dptr,#_value
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	printf_large.c:689: if (!signed_argument)
	jnb	__print_format_signed_argument_1_1,00384$
	ljmp	00180$
00384$:
;	printf_large.c:691: value.l &= 0xFF;
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	mov	r1,#0
	mov	r5,#0
	mov	r6,#0
	mov	dptr,#_value
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	ljmp	00180$
00179$:
;	printf_large.c:694: else if (long_argument)
	jnb  __print_format_long_argument_1_1,00176$
00385$:
;	printf_large.c:696: value.l = va_arg(ap,long);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	a,r0
	add	a,#0xFC
	mov	r0,a
	mov	a,r1
	addc	a,#0xFF
	mov	r1,a
	mov	a,r5
	addc	a,#0xFF
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrgetWord
	mov	r0,a
	mov	r1,_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	r5,a
	mov	r6,_ap
	mov	dptr,#_value
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	sjmp 00180$
00176$:
;	printf_large.c:700: value.l = va_arg(ap,int);
	mov	dptr,#__print_format_PARM_4
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	a,r0
	add	a,#0xFE
	mov	r0,a
	mov	a,r1
	addc	a,#0xFF
	mov	r1,a
	mov	a,r5
	addc	a,#0xFF
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_4
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrgetWord
	mov	r0,a
	mov	r1,_ap
	mov	a,r1
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	r6,a
	mov	dptr,#_value
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	printf_large.c:701: if (!signed_argument)
	jb   __print_format_signed_argument_1_1,00180$
00386$:
;	printf_large.c:703: value.l &= 0xFFFF;
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	mov	r5,#0
	mov	r6,#0
	mov	dptr,#_value
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	printf_large.c:828: return charsOutputted;
;	printf_large.c:703: value.l &= 0xFFFF;
00180$:
;	printf_large.c:707: if ( signed_argument )
	jnb  __print_format_signed_argument_1_1,00185$
00387$:
;	printf_large.c:709: if (value.l < 0)
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov  r6,a
	jnb  acc.7,00182$
00388$:
;	printf_large.c:710: value.l = -value.l;
	clr	c
	clr	a
	subb	a,r0
	mov	r0,a
	clr	a
	subb	a,r1
	mov	r1,a
	clr	a
	subb	a,r5
	mov	r5,a
	clr	a
	subb	a,r6
	mov	r6,a
	mov	dptr,#_value
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	sjmp 00185$
00182$:
;	printf_large.c:712: signed_argument = 0;
;	genAssign: resultIsFar = FALSE
	clr	__print_format_signed_argument_1_1
00185$:
;	printf_large.c:716: lsd = 1;
;	genAssign: resultIsFar = FALSE
	setb	__print_format_lsd_1_1
;	printf_large.c:718: do {
	mov	dptr,#__print_format_pstore_4_23
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
00189$:
;	printf_large.c:719: value.byte[4] = 0;
	mov	dptr,#(_value + 0x000004)
	clr  a
	movx	@dptr,a
;	printf_large.c:723: calculate_digit(radix);
	push	ar2
	push	ar5
	push	ar6
	push	ar7
	mov	dptr,#__print_format_radix_1_1
	movx	a,@dptr
	mov	dpl,a
	lcall	_calculate_digit
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar2
;	printf_large.c:725: if (!lsd)
	jb   __print_format_lsd_1_1,00187$
00389$:
;	printf_large.c:727: *pstore = (value.byte[4] << 4) | (value.byte[4] >> 4) | *pstore;
	mov	dptr,#(_value + 0x000004)
	movx	a,@dptr
	mov  r1,a
	swap	a
	mov	r1,a
	mov	dpl,r5
	mov	dph,r6
	mov	dpx,r7
	movx	a,@dptr
	mov  r3,a
	orl	ar1,a
	mov	dpl,r5
	mov	dph,r6
	mov	dpx,r7
	mov	a,r1
	movx	@dptr,a
;	printf_large.c:728: pstore--;
	dec	r5
	cjne	r5,#0xFF,00390$
	dec	r6
	cjne	r6,#0xFF,00390$
	dec	r7
00390$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_pstore_4_23
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	sjmp 00188$
00187$:
;	printf_large.c:732: *pstore = value.byte[4];
	mov	dptr,#(_value + 0x000004)
	movx	a,@dptr
	mov  r1,a
	mov  dpl,r5
	mov  dph,r6
	mov  dpx,r7
	movx	@dptr,a
00188$:
;	printf_large.c:734: length++;
	inc	r2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_length_1_1
	mov	a,r2
	movx	@dptr,a
;	printf_large.c:735: lsd = !lsd;
	cpl	__print_format_lsd_1_1
;	printf_large.c:736: } while( value.ul );
	mov	dptr,#_value
	movx	a,@dptr
	inc	dptr
	mov	r1,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	mov	r0,a
	mov	a,r1
	orl	a,r4
	orl	a,r3
	orl	a,r0
	jz	00391$
	ljmp	00189$
00391$:
;	printf_large.c:738: if (width == 0)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_pstore_4_23
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_length_1_1
	mov	a,r2
	movx	@dptr,a
	mov	dptr,#__print_format_width_1_1
	movx	a,@dptr
	jnz  00193$
00392$:
;	printf_large.c:743: width=1;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,#0x01
	movx	@dptr,a
00193$:
;	printf_large.c:747: if (!zero_padding && !left_justify)
	jb   __print_format_zero_padding_1_1,00198$
00393$:
	jb   __print_format_left_justify_1_1,00198$
00394$:
;	printf_large.c:749: while ( width > (unsigned char) (length+1) )
	mov	dptr,#__print_format_length_1_1
	movx	a,@dptr
	add	a,#0x01
	mov	r3,a
	mov	dptr,#__print_format_width_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
00194$:
	clr	c
	mov	a,r3
	subb	a,r4
	jnc  00322$
00395$:
;	printf_large.c:751: OUTPUT_CHAR( ' ', p );
	push	ar3
	push	ar4
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar4
	pop	ar3
;	printf_large.c:752: width--;
	dec	r4
	sjmp 00194$
00322$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r4
	movx	@dptr,a
00198$:
;	printf_large.c:756: if (signed_argument) // this now means the original value was negative
	jnb  __print_format_signed_argument_1_1,00208$
00396$:
;	printf_large.c:758: OUTPUT_CHAR( '-', p );
	mov	dpl,#0x2D
	lcall	__output_char
;	printf_large.c:760: width--;
	mov	dptr,#__print_format_width_1_1
	movx	a,@dptr
	dec	a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	movx	@dptr,a
	sjmp 00209$
00208$:
;	printf_large.c:762: else if (length != 0)
	mov	dptr,#__print_format_length_1_1
	movx	a,@dptr
	jz  00209$
00397$:
;	printf_large.c:765: if (prefix_sign)
	jnb  __print_format_prefix_sign_1_1,00203$
00398$:
;	printf_large.c:767: OUTPUT_CHAR( '+', p );
	mov	dpl,#0x2B
	lcall	__output_char
;	printf_large.c:769: width--;
	mov	dptr,#__print_format_width_1_1
	movx	a,@dptr
	dec	a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	movx	@dptr,a
	sjmp 00209$
00203$:
;	printf_large.c:771: else if (prefix_space)
	jnb  __print_format_prefix_space_1_1,00209$
00399$:
;	printf_large.c:773: OUTPUT_CHAR( ' ', p );
	mov	dpl,#0x20
	lcall	__output_char
;	printf_large.c:775: width--;
	mov	dptr,#__print_format_width_1_1
	movx	a,@dptr
	dec	a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	movx	@dptr,a
00209$:
;	printf_large.c:780: if (!left_justify)
	jb   __print_format_left_justify_1_1,00217$
00400$:
;	printf_large.c:781: while ( width-- > length )
	mov	dptr,#__print_format_width_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
00210$:
;	genAssign: resultIsFar = FALSE
	mov	ar4,r3
	dec	r3
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r3
	movx	@dptr,a
	mov	dptr,#__print_format_length_1_1
	clr	c
	movx	a,@dptr
	subb	a,r4
	jnc  00323$
00401$:
;	printf_large.c:783: OUTPUT_CHAR( zero_padding ? '0' : ' ', p );
	jnb  __print_format_zero_padding_1_1,00243$
00402$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x30
	sjmp 00244$
00243$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x20
00244$:
	push	ar3
	mov	dpl,r4
	lcall	__output_char
	pop	ar3
	sjmp 00210$
00217$:
;	printf_large.c:788: if (width > length)
	mov	dptr,#__print_format_length_1_1
	mov	dps, #1
	mov	dptr, #__print_format_width_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	dps,#1
	xch	a, b
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	subb	a,b
	jnc  00214$
00403$:
;	printf_large.c:789: width -= length;
	mov	dptr,#__print_format_length_1_1
	mov	dps, #1
	mov	dptr, #__print_format_width_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	b,a
	inc	dps
	movx	a,@dptr
	subb	a,b
	movx	@dptr,a
	mov	dps,#0
	sjmp 00315$
00214$:
;	printf_large.c:791: width = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	clr  a
	movx	@dptr,a
;	printf_large.c:828: return charsOutputted;
;	printf_large.c:795: while( length-- )
	sjmp 00315$
00323$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_width_1_1
	mov	a,r3
	movx	@dptr,a
00315$:
	mov	dptr,#__print_format_pstore_4_23
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dptr,#__print_format_length_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
00222$:
;	genAssign: resultIsFar = FALSE
	mov	ar7,r6
	dec	r6
	mov	a,r7
	jz  00224$
00404$:
;	printf_large.c:797: lsd = !lsd;
	cpl	__print_format_lsd_1_1
;	printf_large.c:798: if (!lsd)
	jb   __print_format_lsd_1_1,00220$
00405$:
;	printf_large.c:800: pstore++;
	inc	r3
	cjne	r3,#0,00406$
	inc	r4
	cjne	r4,#0,00406$
	inc	r5
00406$:
;	printf_large.c:801: value.byte[4] = *pstore >> 4;
	mov	dpl,r3
	mov	dph,r4
	mov	dpx,r5
	movx	a,@dptr
	mov  r7,a
	swap	a
	anl	a,#0x0F
	mov  r7,a
	mov  dptr,#(_value + 0x000004)
	movx @dptr,a
	sjmp 00221$
00220$:
;	printf_large.c:805: value.byte[4] = *pstore & 0x0F;
	mov	dpl,r3
	mov	dph,r4
	mov	dpx,r5
	movx	a,@dptr
	mov	r7,a
	anl	ar7,#0x0F
	mov	dptr,#(_value + 0x000004)
	mov	a,r7
	movx	@dptr,a
00221$:
;	printf_large.c:811: output_digit( value.byte[4] );
	mov	dptr,#(_value + 0x000004)
	movx	a,@dptr
	mov	r7,a
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	mov	dpl,r7
	lcall	_output_digit
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	sjmp 00222$
00224$:
;	printf_large.c:814: if (left_justify)
	jb	__print_format_left_justify_1_1,00407$
	ljmp	00238$
00407$:
;	printf_large.c:815: while (width-- > 0)
	mov	dptr,#__print_format_width_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
00225$:
;	genAssign: resultIsFar = FALSE
	mov	ar4,r3
	dec	r3
	mov	a,r4
	jnz	00408$
	ljmp	00238$
00408$:
;	printf_large.c:817: OUTPUT_CHAR(' ', p);
	push	ar3
	mov	dpl,#0x20
	lcall	__output_char
	pop	ar3
	sjmp 00225$
00236$:
;	printf_large.c:824: OUTPUT_CHAR( c, p );
	mov	dpl,r2
	lcall	__output_char
	ljmp	00238$
00240$:
;	printf_large.c:828: return charsOutputted;
	mov     dps, #1
	mov     dptr, #_charsOutputted
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	mov	dps,#0
00241$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
__str_0:
	.ascii "<NULL>"
	.db 0x00
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
