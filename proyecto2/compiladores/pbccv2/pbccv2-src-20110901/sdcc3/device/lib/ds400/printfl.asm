;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module printfl
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
	.globl _printf_small
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
_radix:
	.ds 1
_str:
	.ds 4
_val:
	.ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
_printf_small_buffer_4_8:
	.ds 12
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
_long_flag:
	.ds 1
_string_flag:
	.ds 1
_char_flag:
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
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;	printfl.c:54: static __bit  long_flag = 0;
;	genAssign: resultIsFar = FALSE
	clr	_long_flag
;	printfl.c:55: static __bit  string_flag =0;
;	genAssign: resultIsFar = FALSE
	clr	_string_flag
;	printfl.c:56: static __bit  char_flag = 0;
;	genAssign: resultIsFar = FALSE
	clr	_char_flag
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
;Allocation info for local variables in function 'printf_small'
;------------------------------------------------------------
;fmt                       Allocated to stack - offset -8
;ap                        Allocated to stack - offset 1
;stri                      Allocated to registers 
;buffer                    Allocated with name '_printf_small_buffer_4_8'
;------------------------------------------------------------
;	printfl.c:125: void printf_small (char * fmt, ... ) __reentrant
;	-----------------------------------------
;	 function printf_small
;	-----------------------------------------
_printf_small:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bpx
	push	_bpx+1
	mov	_bpx,sp
	mov	_bpx+1,esp
	anl	_bpx+1,#3
	orl	_bpx+1,#0xDC
	push	acc
	push	acc
	push	acc
	push	acc
;	printfl.c:129: va_start(ap,fmt);
	mov	a,_bpx
	add	a,#0xF8
	mov	b,a
	mov	a,_bpx+1
	addc	a,#0xFF
	mov	r2,b
	mov	r3,a
	mov	r4,#0xFF
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
00130$:
;	printfl.c:131: for (; *fmt ; fmt++ ) {
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r2
	mov	b,r3
	lcall	__gptrget
	mov  r4,a
	jnz	00155$
	ljmp	00134$
00155$:
;	printfl.c:132: if (*fmt == '%') {
	mov	a,r4
	cjne	a,#0x25,00156$
	sjmp	00157$
00156$:
	ljmp	00128$
00157$:
;	printfl.c:133: long_flag = string_flag = char_flag = 0;
;	genAssign: resultIsFar = FALSE
	clr	_char_flag
;	genAssign: resultIsFar = FALSE
	clr	_string_flag
;	genAssign: resultIsFar = FALSE
	clr	_long_flag
;	printfl.c:134: fmt++ ;
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
	mov	a,#0x01
	add	a,r6
	movx	@dptr,a
	clr  a
	addc	a,r7
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r2
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	printfl.c:135: switch (*fmt) {
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrget
	mov  r7,a
	cjne	a,#0x68,00158$
	sjmp 00102$
00158$:
	mov	a,r7
	cjne a,#0x6C,00103$
00160$:
;	printfl.c:137: long_flag = 1;
;	genAssign: resultIsFar = FALSE
	setb	_long_flag
;	printfl.c:138: fmt++;
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr  a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r5
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	printfl.c:139: break;
;	printfl.c:140: case 'h':
	sjmp 00103$
00102$:
;	printfl.c:141: char_flag = 1;
;	genAssign: resultIsFar = FALSE
	setb	_char_flag
;	printfl.c:142: fmt++;
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr  a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r5
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	printfl.c:143: }
00103$:
;	printfl.c:145: switch (*fmt) {
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrget
	mov  r2,a
	cjne	a,#0x63,00161$
	sjmp 00107$
00161$:
	mov	a,r2
	cjne	a,#0x64,00162$
	sjmp 00105$
00162$:
	mov	a,r2
	cjne	a,#0x6F,00163$
	sjmp 00108$
00163$:
	mov	a,r2
	cjne	a,#0x73,00164$
	sjmp 00104$
00164$:
	mov	a,r2
;	printfl.c:146: case 's':
	cjne a,#0x78,00109$
	sjmp 00106$
00104$:
;	printfl.c:147: string_flag = 1;
;	genAssign: resultIsFar = FALSE
	setb	_string_flag
;	printfl.c:148: break;
;	printfl.c:149: case 'd':
	sjmp 00109$
00105$:
;	printfl.c:150: radix = 10;
;	genAssign: resultIsFar = FALSE
	mov	_radix,#0x0A
;	printfl.c:151: break;
;	printfl.c:152: case 'x':
	sjmp 00109$
00106$:
;	printfl.c:153: radix = 16;
;	genAssign: resultIsFar = FALSE
	mov	_radix,#0x10
;	printfl.c:154: break;
;	printfl.c:155: case 'c':
	sjmp 00109$
00107$:
;	printfl.c:156: radix = 0;
;	genAssign: resultIsFar = FALSE
	mov	_radix,#0x00
;	printfl.c:157: break;
;	printfl.c:158: case 'o':
	sjmp 00109$
00108$:
;	printfl.c:159: radix = 8;
;	genAssign: resultIsFar = FALSE
	mov	_radix,#0x08
;	printfl.c:161: }
00109$:
;	printfl.c:163: if (string_flag) {
	jb	_string_flag,00166$
	ljmp	00114$
00166$:
;	printfl.c:164: str = va_arg(ap, char *);
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	movx	a,@dptr
	add	a,#0xFC
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
;	genAssign: resultIsFar = TRUE
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrgetWord
	mov	_str,a
	mov	(_str + 1),_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	(_str + 2),a
	mov	(_str + 3),_ap
;	printfl.c:165: while (*str) putchar(*str++);
00110$:
;	genAssign: resultIsFar = FALSE
	mov	dpl,_str
	mov	dph,(_str + 1)
	mov	dpx,(_str + 2)
	mov	b,(_str + 3)
	lcall	__gptrget
	mov  r2,a
	jnz	00167$
	ljmp	00132$
00167$:
;	genAssign: resultIsFar = FALSE
	mov	dpl,_str
	mov	dph,(_str + 1)
	mov	dpx,(_str + 2)
	mov	b,(_str + 3)
	lcall	__gptrget
	mov	r2,a
	mov	a,#0x01
	add	a,_str
	mov	_str,a
	clr  a
	addc	a,(_str + 1)
	mov	(_str + 1),a
	clr  a
	addc	a,(_str + 2)
	mov	(_str + 2),a
	mov	dpl,r2
	lcall	_putchar
;	printfl.c:166: continue ;
	sjmp 00110$
00114$:
;	printfl.c:169: if (long_flag)
	jnb  _long_flag,00119$
00168$:
;	printfl.c:170: val = va_arg(ap,long);
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	movx	a,@dptr
	add	a,#0xFC
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
;	genAssign: resultIsFar = TRUE
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrgetWord
	mov	_val,a
	mov	(_val + 1),_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	(_val + 2),a
	mov	(_val + 3),_ap
	ljmp	00120$
00119$:
;	printfl.c:172: if (char_flag)
	jnb  _char_flag,00116$
00169$:
;	printfl.c:173: val = va_arg(ap,char);
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	movx	a,@dptr
	add	a,#0xFF
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
;	genAssign: resultIsFar = TRUE
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrget
	mov  r2,a
	mov  _val,r2 
	rlc	a
	subb	a,acc
	mov	(_val + 1),a
	mov	(_val + 2),a
	mov	(_val + 3),a
	sjmp 00120$
00116$:
;	printfl.c:175: val = va_arg(ap,int);
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	movx	a,@dptr
	add	a,#0xFE
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
;	genAssign: resultIsFar = TRUE
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r5
	mov	b,r6
	lcall	__gptrgetWord
	mov	r2,a
	mov	r3,_ap
	mov	_val,r2
	mov	(_val + 1),r3
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	(_val + 2),a
	mov	(_val + 3),a
00120$:
;	printfl.c:180: if (radix)
	mov	a,_radix
	jz  00125$
00170$:
;	printfl.c:185: _ltoa (val, buffer, radix);
	mov	dptr,#__ltoa_PARM_2
	mov	a,#_printf_small_buffer_4_8
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	inc	dptr
	mov	a,#0x40
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__ltoa_PARM_3
	mov	a,_radix
	movx	@dptr,a
	mov	dpl,_val
	mov	dph,(_val + 1)
	mov	dpx,(_val + 2)
	mov	b,(_val + 3)
	lcall	__ltoa
;	printfl.c:186: stri = buffer;
;	printfl.c:187: while (*stri)
;	genAssign: resultIsFar = FALSE
	mov	r0,#_printf_small_buffer_4_8
00121$:
	mov	ar2,@r0
	mov	a,r2
	jz  00132$
00171$:
;	printfl.c:189: putchar (*stri);
	push	ar0
	mov	dpl,r2
	lcall	_putchar
	pop	ar0
;	printfl.c:190: stri++;
	inc	r0
	sjmp 00121$
00125$:
;	printfl.c:195: putchar((char)val);
	mov	r2,_val
	mov	dpl,r2
	lcall	_putchar
	sjmp 00132$
00128$:
;	printfl.c:198: putchar(*fmt);
	mov	dpl,r4
	lcall	_putchar
00132$:
;	printfl.c:131: for (; *fmt ; fmt++ ) {
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0xFF
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	ljmp	00130$
00134$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
