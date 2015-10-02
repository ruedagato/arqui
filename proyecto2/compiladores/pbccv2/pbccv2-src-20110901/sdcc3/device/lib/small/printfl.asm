;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:24 2015
;--------------------------------------------------------
	.module printfl
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _CY
	.globl _AC
	.globl _F0
	.globl _RS1
	.globl _RS0
	.globl _OV
	.globl _F1
	.globl _P
	.globl _PS
	.globl _PT1
	.globl _PX1
	.globl _PT0
	.globl _PX0
	.globl _RD
	.globl _WR
	.globl _T1
	.globl _T0
	.globl _INT1
	.globl _INT0
	.globl _TXD
	.globl _RXD
	.globl _P3_7
	.globl _P3_6
	.globl _P3_5
	.globl _P3_4
	.globl _P3_3
	.globl _P3_2
	.globl _P3_1
	.globl _P3_0
	.globl _EA
	.globl _ES
	.globl _ET1
	.globl _EX1
	.globl _ET0
	.globl _EX0
	.globl _P2_7
	.globl _P2_6
	.globl _P2_5
	.globl _P2_4
	.globl _P2_3
	.globl _P2_2
	.globl _P2_1
	.globl _P2_0
	.globl _SM0
	.globl _SM1
	.globl _SM2
	.globl _REN
	.globl _TB8
	.globl _RB8
	.globl _TI
	.globl _RI
	.globl _P1_7
	.globl _P1_6
	.globl _P1_5
	.globl _P1_4
	.globl _P1_3
	.globl _P1_2
	.globl _P1_1
	.globl _P1_0
	.globl _TF1
	.globl _TR1
	.globl _TF0
	.globl _TR0
	.globl _IE1
	.globl _IT1
	.globl _IE0
	.globl _IT0
	.globl _P0_7
	.globl _P0_6
	.globl _P0_5
	.globl _P0_4
	.globl _P0_3
	.globl _P0_2
	.globl _P0_1
	.globl _P0_0
	.globl _B
	.globl _ACC
	.globl _PSW
	.globl _IP
	.globl _P3
	.globl _IE
	.globl _P2
	.globl _SBUF
	.globl _SCON
	.globl _P1
	.globl _TH1
	.globl _TH0
	.globl _TL1
	.globl _TL0
	.globl _TMOD
	.globl _TCON
	.globl _PCON
	.globl _DPH
	.globl _DPL
	.globl _SP
	.globl _P0
	.globl _printf_small
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_PSW	=	0x00d0
_ACC	=	0x00e0
_B	=	0x00f0
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES	=	0x00ac
_EA	=	0x00af
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
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
_PS	=	0x00bc
_P	=	0x00d0
_F1	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_radix:
	.ds 1
_str:
	.ds 3
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
;	printfl.c:54: static __bit  long_flag = 0;
	clr	_long_flag
;	printfl.c:55: static __bit  string_flag =0;
	clr	_string_flag
;	printfl.c:56: static __bit  char_flag = 0;
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
;fmt                       Allocated to stack - offset -5
;ap                        Allocated to registers r2 
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
	push	_bp
	mov	_bp,sp
;	printfl.c:129: va_start(ap,fmt);
	mov	a,_bp
	add	a,#0xfb
	mov	r2,a
00130$:
;	printfl.c:131: for (; *fmt ; fmt++ ) {
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	jnz	00155$
	ljmp	00134$
00155$:
;	printfl.c:132: if (*fmt == '%') {
	cjne	r6,#0x25,00156$
	sjmp	00157$
00156$:
	ljmp	00128$
00157$:
;	printfl.c:133: long_flag = string_flag = char_flag = 0;
	clr	_char_flag
	clr	_string_flag
	clr	_long_flag
;	printfl.c:134: fmt++ ;
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,#0x01
	add	a,r3
	mov	@r0,a
	clr	a
	addc	a,r4
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,ar5
;	printfl.c:135: switch (*fmt) {
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	mov	r7,a
	cjne	r7,#0x68,00158$
	sjmp	00102$
00158$:
	cjne	r7,#0x6C,00103$
;	printfl.c:137: long_flag = 1;
	setb	_long_flag
;	printfl.c:138: fmt++;
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,#0x01
	add	a,r3
	mov	@r0,a
	clr	a
	addc	a,r4
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,ar5
;	printfl.c:139: break;
;	printfl.c:140: case 'h':
	sjmp	00103$
00102$:
;	printfl.c:141: char_flag = 1;
	setb	_char_flag
;	printfl.c:142: fmt++;
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	a,#0x01
	add	a,r3
	mov	@r0,a
	clr	a
	addc	a,r4
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,ar5
;	printfl.c:143: }
00103$:
;	printfl.c:145: switch (*fmt) {
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	mov	r3,a
	cjne	r3,#0x63,00161$
	sjmp	00107$
00161$:
	cjne	r3,#0x64,00162$
	sjmp	00105$
00162$:
	cjne	r3,#0x6F,00163$
	sjmp	00108$
00163$:
	cjne	r3,#0x73,00164$
	sjmp	00104$
00164$:
;	printfl.c:146: case 's':
	cjne	r3,#0x78,00109$
	sjmp	00106$
00104$:
;	printfl.c:147: string_flag = 1;
	setb	_string_flag
;	printfl.c:148: break;
;	printfl.c:149: case 'd':
	sjmp	00109$
00105$:
;	printfl.c:150: radix = 10;
	mov	_radix,#0x0A
;	printfl.c:151: break;
;	printfl.c:152: case 'x':
	sjmp	00109$
00106$:
;	printfl.c:153: radix = 16;
	mov	_radix,#0x10
;	printfl.c:154: break;
;	printfl.c:155: case 'c':
	sjmp	00109$
00107$:
;	printfl.c:156: radix = 0;
	mov	_radix,#0x00
;	printfl.c:157: break;
;	printfl.c:158: case 'o':
	sjmp	00109$
00108$:
;	printfl.c:159: radix = 8;
	mov	_radix,#0x08
;	printfl.c:161: }
00109$:
;	printfl.c:163: if (string_flag) {
	jnb	_string_flag,00114$
;	printfl.c:164: str = va_arg(ap, char *);
	mov	a,r2
	add	a,#0xfd
	mov	r0,a
	mov	r2,a
	mov	_str,@r0
	inc	r0
	mov	(_str + 1),@r0
	inc	r0
	mov	(_str + 2),@r0
	dec	r0
	dec	r0
;	printfl.c:165: while (*str) putchar(*str++);
00110$:
	mov	r3,_str
	mov	r4,(_str + 1)
	mov	r5,(_str + 2)
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	jnz	00167$
	ljmp	00132$
00167$:
	mov	r3,_str
	mov	r4,(_str + 1)
	mov	r5,(_str + 2)
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	lcall	__gptrget
	mov	r3,a
	inc	_str
	clr	a
	cjne	a,_str,00168$
	inc	(_str + 1)
00168$:
	mov	dpl,r3
	push	ar2
	lcall	_putchar
	pop	ar2
;	printfl.c:166: continue ;
	sjmp	00110$
00114$:
;	printfl.c:169: if (long_flag)
	jnb	_long_flag,00119$
;	printfl.c:170: val = va_arg(ap,long);
	mov	a,r2
	add	a,#0xfc
	mov	r0,a
	mov	r2,a
	mov	_val,@r0
	inc	r0
	mov	(_val + 1),@r0
	inc	r0
	mov	(_val + 2),@r0
	inc	r0
	mov	(_val + 3),@r0
	dec	r0
	dec	r0
	dec	r0
	sjmp	00120$
00119$:
;	printfl.c:172: if (char_flag)
	jnb	_char_flag,00116$
;	printfl.c:173: val = va_arg(ap,char);
	mov	a,r2
	dec	a
	mov	r0,a
	mov	r2,a
	mov	a,@r0
	mov	r3,a
	mov	_val,a
	rlc	a
	subb	a,acc
	mov	(_val + 1),a
	mov	(_val + 2),a
	mov	(_val + 3),a
	sjmp	00120$
00116$:
;	printfl.c:175: val = va_arg(ap,int);
	mov	a,r2
	add	a,#0xfe
	mov	r0,a
	mov	r2,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	dec	r0
	mov	_val,r3
	mov	a,r4
	mov	(_val + 1),a
	rlc	a
	subb	a,acc
	mov	(_val + 2),a
	mov	(_val + 3),a
00120$:
;	printfl.c:180: if (radix)
	mov	a,_radix
	jz	00125$
;	printfl.c:185: _ltoa (val, buffer, radix);
	mov	__ltoa_PARM_2,#_printf_small_buffer_4_8
	mov	(__ltoa_PARM_2 + 1),#0x00
	mov	(__ltoa_PARM_2 + 2),#0x40
	mov	__ltoa_PARM_3,_radix
	mov	dpl,_val
	mov	dph,(_val + 1)
	mov	b,(_val + 2)
	mov	a,(_val + 3)
	push	ar2
	lcall	__ltoa
	pop	ar2
;	printfl.c:186: stri = buffer;
;	printfl.c:187: while (*stri)
	mov	r0,#_printf_small_buffer_4_8
00121$:
	mov	a,@r0
	mov	r3,a
	jz	00132$
;	printfl.c:189: putchar (*stri);
	mov	dpl,r3
	push	ar2
	push	ar0
	lcall	_putchar
	pop	ar0
	pop	ar2
;	printfl.c:190: stri++;
	inc	r0
	sjmp	00121$
00125$:
;	printfl.c:195: putchar((char)val);
	mov	dpl,_val
	push	ar2
	lcall	_putchar
	pop	ar2
	sjmp	00132$
00128$:
;	printfl.c:198: putchar(*fmt);
	mov	dpl,r6
	push	ar2
	lcall	_putchar
	pop	ar2
00132$:
;	printfl.c:131: for (; *fmt ; fmt++ ) {
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	inc	@r0
	cjne	@r0,#0x00,00173$
	inc	r0
	inc	@r0
00173$:
	ljmp	00130$
00134$:
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
