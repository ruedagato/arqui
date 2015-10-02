;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module sprintf
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
	.globl _vsprintf_PARM_3
	.globl _vsprintf_PARM_2
	.globl _vsprintf
	.globl _sprintf
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
	.area OSEG    (OVR,DATA)
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
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_vsprintf_PARM_2:
	.ds 4
_vsprintf_PARM_3:
	.ds 4
_vsprintf_buf_1_1:
	.ds 4
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
;Allocation info for local variables in function 'put_char_to_string'
;------------------------------------------------------------
;p                         Allocated to stack - offset -8
;c                         Allocated to stack - offset 1
;buf                       Allocated to registers 
;------------------------------------------------------------
;	sprintf.c:34: put_char_to_string (char c, void* p) _REENTRANT
;	-----------------------------------------
;	 function put_char_to_string
;	-----------------------------------------
_put_char_to_string:
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
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
	mov	a,dpl
	movx	@dptr,a
	mov	dps,#0
;	sprintf.c:36: char **buf = (char **)p;
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
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
;	genAssign: resultIsFar = FALSE
	mov	dpl,r3
	mov	dph,r4
	mov	dpx,r5
	mov	b,r6
;	sprintf.c:37: *(*buf)++ = c;
	lcall	__gptrgetWord
	mov	r3,a
	mov	r4,_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	r5,a
	mov	r6,_ap
	lcall	__decdptr
	lcall	__decdptr
	lcall	__decdptr
	mov	a,#0x01
	add	a,r3
	mov	r7,a
	clr  a
	addc	a,r4
	mov	r0,a
	clr  a
	addc	a,r5
	mov	r1,a
	mov	ar2,r6
	mov	_ap, r7
	mov	a,r0
	lcall	__gptrputWord
	inc	dptr
	mov	_ap, r1
	mov	a,r2
	lcall	__gptrputWord
	mov	dpl,r3
	mov	dph,r4
	mov	dpx,r5
	mov	b,r6
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
	movx	a,@dptr
	dec	dps
	lcall	__gptrput
00101$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'vsprintf'
;------------------------------------------------------------
;format                    Allocated with name '_vsprintf_PARM_2'
;ap                        Allocated with name '_vsprintf_PARM_3'
;buf                       Allocated with name '_vsprintf_buf_1_1'
;i                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	sprintf.c:41: vsprintf (char *buf, const char *format, va_list ap)
;	-----------------------------------------
;	 function vsprintf
;	-----------------------------------------
_vsprintf:
	mov     dps, #1
	mov     dptr, #_vsprintf_buf_1_1
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
;	sprintf.c:44: i = _print_format (put_char_to_string, &buf, format, ap);
	mov	dptr,#_vsprintf_PARM_2
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
	mov	dptr,#_vsprintf_PARM_3
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
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_2
	mov	a,#_vsprintf_buf_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,#(_vsprintf_buf_1_1 >> 8)
	movx	@dptr,a
	inc	dptr
	mov	a,#(_vsprintf_buf_1_1 >> 16)
	movx	@dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_3
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
	mov dptr,#_put_char_to_string
	lcall	__print_format
	mov	r2,dpl
	mov	r3,dph
;	genAssign: resultIsFar = TRUE
	mov	dpl1,r2
	mov	dph1,r3
;	sprintf.c:45: *buf = 0;
	mov	dptr,#_vsprintf_buf_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r6
	mov	b,r7
	clr  a
	lcall	__gptrput
;	sprintf.c:46: return i;
	mov	dpl,dpl1
	mov	dph,dph1
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'sprintf'
;------------------------------------------------------------
;buf                       Allocated to stack - offset -8
;format                    Allocated to stack - offset -12
;arg                       Allocated to stack - offset 1
;i                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	sprintf.c:50: sprintf (char *buf, const char *format, ...)
;	-----------------------------------------
;	 function sprintf
;	-----------------------------------------
_sprintf:
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
;	sprintf.c:55: va_start (arg, format);
	mov	a,_bpx
	add	a,#0xF4
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
;	sprintf.c:56: i = _print_format (put_char_to_string, &buf, format, arg);
	mov	a,_bpx
	add	a,#0xF8
	mov	b,a
	mov	a,_bpx+1
	addc	a,#0xFF
	mov	r6,b
	mov	r7,a
	mov	r0,#0xFF
	mov	r1,#0x00
	mov	a,_bpx
	clr	c
	subb	a,#0x0C
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
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__print_format_PARM_2
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
	mov	dptr,#__print_format_PARM_3
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
	mov	dpx,#0xFF
	mov	dph,_bpx+1
	mov	dpl,_bpx
	inc	dptr
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#__print_format_PARM_4
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
	mov dptr,#_put_char_to_string
	lcall	__print_format
	mov	r2,dpl
	mov	r3,dph
;	genAssign: resultIsFar = TRUE
	mov	dpl1,r2
	mov	dph1,r3
;	sprintf.c:57: *buf = 0;
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
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r6
	mov	b,r7
	clr  a
	lcall	__gptrput
;	sprintf.c:60: return i;
	mov	dpl,dpl1
	mov	dph,dph1
00101$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
