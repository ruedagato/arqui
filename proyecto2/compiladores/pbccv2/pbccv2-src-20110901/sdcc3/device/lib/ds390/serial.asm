;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module serial
	.optsdcc -mds390 --model-flat24
	
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
	.globl _serial_getc
	.globl _serial_putc
	.globl _serial_interrupt_handler
	.globl _serial_init
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
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
_T2CON	=	0x00c8
_RCAP2L	=	0x00ca
_RCAP2H	=	0x00cb
_TL2	=	0x00cc
_TH2	=	0x00cd
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
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
_ET2	=	0x00ad
_PT2	=	0x00bd
_T2CON_0	=	0x00c8
_T2CON_1	=	0x00c9
_T2CON_2	=	0x00ca
_T2CON_3	=	0x00cb
_T2CON_4	=	0x00cc
_T2CON_5	=	0x00cd
_T2CON_6	=	0x00ce
_T2CON_7	=	0x00cf
_CP_RL2	=	0x00c8
_C_T2	=	0x00c9
_TR2	=	0x00ca
_EXEN2	=	0x00cb
_TCLK	=	0x00cc
_RCLK	=	0x00cd
_EXF2	=	0x00ce
_TF2	=	0x00cf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
	.area REG_BANK_1	(REL,OVR,DATA)
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
_work_flag_byte_arrived:
	.ds 1
_work_flag_buffer_transfered:
	.ds 1
_tx_serial_buffer_empty:
	.ds 1
_rx_serial_buffer_empty:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_stx_index_in:
	.ds 1
_srx_index_in:
	.ds 1
_stx_index_out:
	.ds 1
_srx_index_out:
	.ds 1
_stx_buffer:
	.ds 256
_srx_buffer:
	.ds 256
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
;Allocation info for local variables in function 'serial_init'
;------------------------------------------------------------
;------------------------------------------------------------
;	serial.c:45: void serial_init(void)
;	-----------------------------------------
;	 function serial_init
;	-----------------------------------------
_serial_init:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	serial.c:47: SCON = 0x50;
;	genAssign: resultIsFar = FALSE
	mov	_SCON,#0x50
;	serial.c:48: T2CON = 0x34;
;	genAssign: resultIsFar = FALSE
	mov	_T2CON,#0x34
;	serial.c:49: PS = 1;
;	genAssign: resultIsFar = FALSE
	setb	_PS
;	serial.c:50: T2CON = 0x34;
;	genAssign: resultIsFar = FALSE
	mov	_T2CON,#0x34
;	serial.c:51: RCAP2H = 0xFF;
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2H,#0xFF
;	serial.c:52: RCAP2L = 0xDA;
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2L,#0xDA
;	serial.c:54: RI = 0;
;	genAssign: resultIsFar = FALSE
	clr	_RI
;	serial.c:55: TI = 0;
;	genAssign: resultIsFar = FALSE
	clr	_TI
;	serial.c:57: stx_index_in = srx_index_in = stx_index_out = srx_index_out = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_srx_index_out
;	genAssign: resultIsFar = TRUE
;	genAssign: resultIsFar = TRUE
;	genAssign: resultIsFar = TRUE
	clr   a
	movx  @dptr,a
	mov   dptr,#_stx_index_out
	movx  @dptr,a
	mov   dptr,#_srx_index_in
	movx  @dptr,a
	mov   dptr,#_stx_index_in
	movx  @dptr,a
;	serial.c:58: rx_serial_buffer_empty = tx_serial_buffer_empty = 1;
;	genAssign: resultIsFar = FALSE
	setb	_tx_serial_buffer_empty
;	genAssign: resultIsFar = FALSE
	setb	_rx_serial_buffer_empty
;	serial.c:59: work_flag_buffer_transfered = 0;
;	genAssign: resultIsFar = FALSE
	clr	_work_flag_buffer_transfered
;	serial.c:60: work_flag_byte_arrived = 0;
;	genAssign: resultIsFar = FALSE
	clr	_work_flag_byte_arrived
;	serial.c:61: ES=1;
;	genAssign: resultIsFar = FALSE
	setb	_ES
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'serial_interrupt_handler'
;------------------------------------------------------------
;------------------------------------------------------------
;	serial.c:64: void serial_interrupt_handler(void) __interrupt 4 __using 1
;	-----------------------------------------
;	 function serial_interrupt_handler
;	-----------------------------------------
_serial_interrupt_handler:
	ar2 = 0x0A
	ar3 = 0x0B
	ar4 = 0x0C
	ar5 = 0x0D
	ar6 = 0x0E
	ar7 = 0x0F
	ar0 = 0x08
	ar1 = 0x09
	push	acc
	push	b
	push	dpl
	push	dph
	push	dpx
	push	dps
	mov	dps,#0
	push	psw
	mov	psw,#0x08
;	serial.c:66: ES=0;
;	genAssign: resultIsFar = FALSE
	clr	_ES
;	serial.c:67: if ( RI )
;	serial.c:69: RI = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _RI,00113$
	sjmp    00102$
00113$:
;	serial.c:70: srx_buffer[srx_index_in++]=SBUF;
	mov	dptr,#_srx_index_in
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#_srx_index_in
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	mov	a,r2
	add	a,#_srx_buffer
	mov	dpl,a
	clr	a
	addc	a,#(_srx_buffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_srx_buffer >> 16)
	mov	dpx,a
	mov	a,_SBUF
	movx	@dptr,a
;	serial.c:71: work_flag_byte_arrived = 1;
;	genAssign: resultIsFar = FALSE
	setb	_work_flag_byte_arrived
;	serial.c:72: rx_serial_buffer_empty = 0;
;	genAssign: resultIsFar = FALSE
	clr	_rx_serial_buffer_empty
00102$:
;	serial.c:74: if ( TI )
;	serial.c:76: TI = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI,00114$
	sjmp    00107$
00114$:
;	serial.c:77: if (stx_index_out == stx_index_in )
	mov	dptr,#_stx_index_in
	mov     dps, #1
	mov     dptr, #_stx_index_out
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne a,b,00104$
00116$:
;	serial.c:79: tx_serial_buffer_empty = 1;
;	genAssign: resultIsFar = FALSE
	setb	_tx_serial_buffer_empty
;	serial.c:80: work_flag_buffer_transfered = 1;
;	genAssign: resultIsFar = FALSE
	setb	_work_flag_buffer_transfered
	sjmp 00107$
00104$:
;	serial.c:82: else SBUF = stx_buffer[stx_index_out++];
	mov	dptr,#_stx_index_out
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#_stx_index_out
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	mov	a,r2
	add	a,#_stx_buffer
	mov	dpl,a
	clr	a
	addc	a,#(_stx_buffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_stx_buffer >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	_SBUF,a
00107$:
;	serial.c:84: ES=1;
;	genAssign: resultIsFar = FALSE
	setb	_ES
00108$:
	pop	psw
	pop	dps
	pop	dpx
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti
;	eliminated unneeded push/pop dpl1
;	eliminated unneeded push/pop dph1
;	eliminated unneeded push/pop dpx1
;	eliminated unneeded push/pop ap
;------------------------------------------------------------
;Allocation info for local variables in function 'serial_putc'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	serial.c:89: void serial_putc(unsigned char c)
;	-----------------------------------------
;	 function serial_putc
;	-----------------------------------------
_serial_putc:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
;	serial.c:91: stx_buffer[stx_index_in++]=c;
	mov	dptr,#_stx_index_in
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_stx_index_in
	mov	a,#0x01
	add	a,r3
	movx	@dptr,a
	mov	a,r3
	add	a,#_stx_buffer
	mov	dpl,a
	clr	a
	addc	a,#(_stx_buffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_stx_buffer >> 16)
	mov	dpx,a
	mov	a,r2
	movx	@dptr,a
;	serial.c:92: ES=0;
;	genAssign: resultIsFar = FALSE
	clr	_ES
;	serial.c:93: if ( tx_serial_buffer_empty )
;	serial.c:95: tx_serial_buffer_empty = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _tx_serial_buffer_empty,00106$
	sjmp    00102$
00106$:
;	serial.c:96: TI=1;
;	genAssign: resultIsFar = FALSE
	setb	_TI
00102$:
;	serial.c:98: ES=1;
;	genAssign: resultIsFar = FALSE
	setb	_ES
00103$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'serial_getc'
;------------------------------------------------------------
;tmp                       Allocated to registers r2 
;------------------------------------------------------------
;	serial.c:101: unsigned char serial_getc(void)
;	-----------------------------------------
;	 function serial_getc
;	-----------------------------------------
_serial_getc:
;	serial.c:103: unsigned char tmp = srx_buffer[srx_index_out++];
	mov	dptr,#_srx_index_out
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#_srx_index_out
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	mov	a,r2
	add	a,#_srx_buffer
	mov	dpl,a
	clr	a
	addc	a,#(_srx_buffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_srx_buffer >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	r2,a
;	genAssign: resultIsFar = TRUE
;	serial.c:104: ES=0;
;	genAssign: resultIsFar = FALSE
	clr	_ES
;	serial.c:105: if ( srx_index_out == srx_index_in) rx_serial_buffer_empty = 1;
	mov	dptr,#_srx_index_in
	mov     dps, #1
	mov     dptr, #_srx_index_out
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne a,b,00102$
00107$:
;	genAssign: resultIsFar = FALSE
	setb	_rx_serial_buffer_empty
00102$:
;	serial.c:106: ES=1;
;	genAssign: resultIsFar = FALSE
	setb	_ES
;	serial.c:107: return tmp;
	mov	dpl,r2
00103$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
