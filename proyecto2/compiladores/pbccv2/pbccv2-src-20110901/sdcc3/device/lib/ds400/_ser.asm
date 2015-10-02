;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module _ser
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
	.globl _ser_rxBuffer
	.globl _ser_txBuffer
	.globl _ser_rxIndexOut
	.globl _ser_rxIndexIn
	.globl _ser_txIndexOut
	.globl _ser_txIndexIn
	.globl _ser_init
	.globl _ser_interrupt_handler
	.globl _ser_putc
	.globl _ser_getc
	.globl _ser_printString
	.globl _ser_charAvail
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
_ser_txBusy:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_ser_txIndexIn::
	.ds 1
_ser_txIndexOut::
	.ds 1
_ser_rxIndexIn::
	.ds 1
_ser_rxIndexOut::
	.ds 1
_ser_txBuffer::
	.ds 256
_ser_rxBuffer::
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
;Allocation info for local variables in function 'ser_init'
;------------------------------------------------------------
;------------------------------------------------------------
;	_ser.c:76: ser_init(void)
;	-----------------------------------------
;	 function ser_init
;	-----------------------------------------
_ser_init:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_ser.c:78: ES = 0;
;	genAssign: resultIsFar = FALSE
	clr	_ES
;	_ser.c:80: ser_txBusy     = 0;
;	genAssign: resultIsFar = FALSE
	clr	_ser_txBusy
;	_ser.c:82: ser_txIndexIn  = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_ser_txIndexIn
;	_ser.c:83: ser_txIndexOut = 0;
;	genAssign: resultIsFar = TRUE
;	_ser.c:84: ser_rxIndexIn  = 0;
;	genAssign: resultIsFar = TRUE
;	_ser.c:85: ser_rxIndexOut = 0;
;	genAssign: resultIsFar = TRUE
	clr   a
	movx  @dptr,a
	mov   dptr,#_ser_txIndexOut
	movx  @dptr,a
	mov   dptr,#_ser_rxIndexIn
	movx  @dptr,a
	mov   dptr,#_ser_rxIndexOut
	movx  @dptr,a
;	_ser.c:87: T2CON = 0x30;
;	genAssign: resultIsFar = FALSE
	mov	_T2CON,#0x30
;	_ser.c:90: RCAP2H = 0xFF;
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2H,#0xFF
;	_ser.c:91: RCAP2L = 0xDD;
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2L,#0xDD
;	_ser.c:94: T2CON = 0x34;
;	genAssign: resultIsFar = FALSE
	mov	_T2CON,#0x34
;	_ser.c:96: SCON = 0x50;
;	genAssign: resultIsFar = FALSE
	mov	_SCON,#0x50
;	_ser.c:98: if (TI) {
;	_ser.c:99: TI = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI,00109$
	sjmp    00102$
00109$:
00102$:
;	_ser.c:101: if (RI) {
;	_ser.c:102: RI = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _RI,00110$
	sjmp    00104$
00110$:
00104$:
;	_ser.c:105: ES=1;  
;	genAssign: resultIsFar = FALSE
	setb	_ES
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ser_interrupt_handler'
;------------------------------------------------------------
;------------------------------------------------------------
;	_ser.c:109: ser_interrupt_handler(void) __interrupt 4 __using 1
;	-----------------------------------------
;	 function ser_interrupt_handler
;	-----------------------------------------
_ser_interrupt_handler:
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
;	_ser.c:111: ES=0;
;	genAssign: resultIsFar = FALSE
	clr	_ES
;	_ser.c:113: if (RI) {
;	_ser.c:114: RI = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _RI,00113$
	sjmp    00102$
00113$:
;	_ser.c:115: ser_rxBuffer[ser_rxIndexIn++] = SBUF;
	mov	dptr,#_ser_rxIndexIn
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#_ser_rxIndexIn
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	mov	a,r2
	add	a,#_ser_rxBuffer
	mov	dpl,a
	clr	a
	addc	a,#(_ser_rxBuffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_ser_rxBuffer >> 16)
	mov	dpx,a
	mov	a,_SBUF
	movx	@dptr,a
00102$:
;	_ser.c:118: if (TI) {
;	_ser.c:119: TI = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI,00114$
	sjmp    00107$
00114$:
;	_ser.c:120: if (ser_txIndexIn == ser_txIndexOut) {
	mov	dptr,#_ser_txIndexOut
	mov     dps, #1
	mov     dptr, #_ser_txIndexIn
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne a,b,00104$
00116$:
;	_ser.c:121: ser_txBusy = 0;
;	genAssign: resultIsFar = FALSE
	clr	_ser_txBusy
	sjmp 00107$
00104$:
;	_ser.c:124: SBUF = ser_txBuffer[ser_txIndexOut++];
	mov	dptr,#_ser_txIndexOut
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#_ser_txIndexOut
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	mov	a,r2
	add	a,#_ser_txBuffer
	mov	dpl,a
	clr	a
	addc	a,#(_ser_txBuffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_ser_txBuffer >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	_SBUF,a
00107$:
;	_ser.c:128: ES=1;
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
;Allocation info for local variables in function 'ser_putc'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	_ser.c:132: ser_putc(unsigned char c)
;	-----------------------------------------
;	 function ser_putc
;	-----------------------------------------
_ser_putc:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	r2,dpl
;	_ser.c:134: ES=0;
;	genAssign: resultIsFar = FALSE
	clr	_ES
;	_ser.c:136: if (ser_txBusy) {
	jnb  _ser_txBusy,00102$
00107$:
;	_ser.c:137: ser_txBuffer[ser_txIndexIn++] = c;
	mov	dptr,#_ser_txIndexIn
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
	mov	dptr,#_ser_txIndexIn
	mov	a,#0x01
	add	a,r3
	movx	@dptr,a
	mov	a,r3
	add	a,#_ser_txBuffer
	mov	dpl,a
	clr	a
	addc	a,#(_ser_txBuffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_ser_txBuffer >> 16)
	mov	dpx,a
	mov	a,r2
	movx	@dptr,a
	sjmp 00103$
00102$:
;	_ser.c:140: ser_txBusy = 1;
;	genAssign: resultIsFar = FALSE
	setb	_ser_txBusy
;	_ser.c:141: SBUF = c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF,r2
00103$:
;	_ser.c:144: ES=1;
;	genAssign: resultIsFar = FALSE
	setb	_ES
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ser_getc'
;------------------------------------------------------------
;tmp                       Allocated to registers r2 
;------------------------------------------------------------
;	_ser.c:148: ser_getc(void)
;	-----------------------------------------
;	 function ser_getc
;	-----------------------------------------
_ser_getc:
;	_ser.c:153: if (ser_rxIndexIn != ser_rxIndexOut) {
	mov	dptr,#_ser_rxIndexOut
	mov     dps, #1
	mov     dptr, #_ser_rxIndexIn
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne	a,b,00107$
	sjmp 00102$
00107$:
;	_ser.c:154: tmp = ser_rxBuffer[ser_rxIndexOut++];
	mov	dptr,#_ser_rxIndexOut
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	mov	dptr,#_ser_rxIndexOut
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	mov	a,r2
	add	a,#_ser_rxBuffer
	mov	dpl,a
	clr	a
	addc	a,#(_ser_rxBuffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_ser_rxBuffer >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	r2,a
;	genAssign: resultIsFar = TRUE
	sjmp 00103$
00102$:
;	_ser.c:157: tmp = 0;
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
00103$:
;	_ser.c:161: return(tmp);
	mov	dpl,r2
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ser_printString'
;------------------------------------------------------------
;String                    Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	_ser.c:165: ser_printString(char *String)
;	-----------------------------------------
;	 function ser_printString
;	-----------------------------------------
_ser_printString:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	_ser.c:167: while (*String) {
;	genAssign: resultIsFar = FALSE
00101$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r6,a
	jz  00104$
00109$:
;	_ser.c:168: ser_putc(*String++);
	inc	r2
	cjne	r2,#0,00110$
	inc	r3
	cjne	r3,#0,00110$
	inc	r4
00110$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	lcall	_ser_putc
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp 00101$
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ser_charAvail'
;------------------------------------------------------------
;ret                       Allocated to registers r2 
;------------------------------------------------------------
;	_ser.c:173: ser_charAvail(void)
;	-----------------------------------------
;	 function ser_charAvail
;	-----------------------------------------
_ser_charAvail:
;	_ser.c:175: char ret = 0;
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
;	_ser.c:177: if (ser_rxIndexIn != ser_rxIndexOut) {
	mov	dptr,#_ser_rxIndexOut
	mov     dps, #1
	mov     dptr, #_ser_rxIndexIn
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne	a,b,00106$
	sjmp 00102$
00106$:
;	_ser.c:178: ret = 1;
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x01
00102$:
;	_ser.c:181: return(ret);
	mov	dpl,r2
00103$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
