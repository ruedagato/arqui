;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:20 2015
;--------------------------------------------------------
	.module tinibios
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
	.globl _ClockInit
	.globl _installInterrupt_PARM_2
	.globl _romInit_PARM_2
	.globl _Serial0Init_PARM_2
	.globl __sdcc_external_startup
	.globl _Serial0Init
	.globl _Serial0SwitchToBuffered
	.globl _Serial0IrqHandler
	.globl _Serial0CharArrived
	.globl _Serial0PutChar
	.globl _Serial0GetChar
	.globl _Serial0SendBreak
	.globl _Serial0Flush
	.globl _ClockTicks
	.globl _ClockMilliSecondsDelay
	.globl _romInit
	.globl _installInterrupt
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
_serial0Buffered:
	.ds 1
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
_receive0Buffer:
	.ds 1024
_Serial0Init_PARM_2:
	.ds 1
_romInit_PARM_2:
	.ds 1
_installInterrupt_PARM_2:
	.ds 1
_installInterrupt_isr_1_1:
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
_receive0BufferHead:
	.ds 2
_receive0BufferTail:
	.ds 2
_transmit0IsBusy:
	.ds 1
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
;Allocation info for local variables in function '_sdcc_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:36: unsigned char _sdcc_external_startup(void)
;	-----------------------------------------
;	 function _sdcc_external_startup
;	-----------------------------------------
__sdcc_external_startup:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	tinibios.c:38: IE = 0; // Disable all interrupts.
;	genAssign: resultIsFar = FALSE
	mov	_IE,#0x00
;	tinibios.c:40: PSW = 0;
;	genAssign: resultIsFar = FALSE
	mov	_PSW,#0x00
;	tinibios.c:56: __endasm;    
	
  ; save the 24-bit return address
	  pop ar2; msb
	  pop ar1
	  pop ar0; lsb
	
	
	  mov _ESP,#0x00; reinitialize the stack
	  mov _SP,#0x00
	
  ; restore the 24-bit return address
	  push ar0; lsb
	  push ar1
	  push ar2; msb
	  
;	tinibios.c:61: Serial0Init(1, 0); // baud argument ignored.
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_Serial0Init_PARM_2
	clr  a
	movx	@dptr,a
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_Serial0Init
;	tinibios.c:63: IE = 0x80; // Enable interrupts.
;	genAssign: resultIsFar = FALSE
	mov	_IE,#0x80
;	tinibios.c:65: return 0;
	mov	dpl,#0x00
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0Init'
;------------------------------------------------------------
;buffered                  Allocated with name '_Serial0Init_PARM_2'
;baud                      Allocated to registers 
;------------------------------------------------------------
;	tinibios.c:93: void Serial0Init (unsigned long baud, unsigned char buffered)
;	-----------------------------------------
;	 function Serial0Init
;	-----------------------------------------
_Serial0Init:
;	tinibios.c:95: ES0 = 0; // disable serial channel 0 interrupt
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:101: SCON0 = 0x5A; // 10 bit serial 0, use timer baud rate, enable recieving
;	genAssign: resultIsFar = FALSE
	mov	_SCON0,#0x5A
;	tinibios.c:102: RCAP2H = (TIMER_RELOAD >> 8) & 0xff;
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2H,#0xFF
;	tinibios.c:103: RCAP2L = TIMER_RELOAD & 0xff;
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2L,#0xFC
;	tinibios.c:104: T2CON = 0x30; // Enable timer 2 for serial port
;	genAssign: resultIsFar = FALSE
	mov	_T2CON,#0x30
;	tinibios.c:105: TR2 = 1; // Set timer 2 to run
;	genAssign: resultIsFar = FALSE
	setb	_TR2
;	tinibios.c:110: serial0Buffered=buffered;
	mov	dptr,#_Serial0Init_PARM_2
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
;	genAssign: resultIsFar = FALSE
;	tinibios.c:112: if (buffered) {
	mov  r2,a
	mov  _serial0Buffered,r2 
	jz  00102$
00107$:
;	tinibios.c:113: installInterrupt(Serial0IrqHandler, 0x23);
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_installInterrupt_PARM_2
	mov	a,#0x23
	movx	@dptr,a
	mov dptr,#_Serial0IrqHandler
	lcall	_installInterrupt
;	tinibios.c:114: RI_0=TI_0=0; // clear "pending" interrupts
;	genAssign: resultIsFar = FALSE
	clr	_TI_0
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:115: ES0 = 1; // enable serial channel 0 interrupt
;	genAssign: resultIsFar = FALSE
	setb	_ES0
	sjmp 00104$
00102$:
;	tinibios.c:117: RI_0=0; // receive buffer empty
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:118: TI_0=1; // transmit buffer empty
;	genAssign: resultIsFar = FALSE
	setb	_TI_0
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0SwitchToBuffered'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:122: void Serial0SwitchToBuffered(void)
;	-----------------------------------------
;	 function Serial0SwitchToBuffered
;	-----------------------------------------
_Serial0SwitchToBuffered:
;	tinibios.c:124: IE &= ~0x80;
	anl	_IE,#0x7F
;	tinibios.c:126: serial0Buffered = 1;
;	genAssign: resultIsFar = FALSE
	mov	_serial0Buffered,#0x01
;	tinibios.c:127: installInterrupt(Serial0IrqHandler, 0x23);
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_installInterrupt_PARM_2
	mov	a,#0x23
	movx	@dptr,a
	mov dptr,#_Serial0IrqHandler
	lcall	_installInterrupt
;	tinibios.c:128: RI_0=TI_0=0; // clear "pending" interrupts
;	genAssign: resultIsFar = FALSE
	clr	_TI_0
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:129: ES0 = 1; // enable serial channel 0 interrupt
;	genAssign: resultIsFar = FALSE
	setb	_ES0
;	tinibios.c:131: IE |= 0x80;
	orl	_IE,#0x80
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0IrqHandler'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:134: void Serial0IrqHandler (void) __interrupt 4
;	-----------------------------------------
;	 function Serial0IrqHandler
;	-----------------------------------------
_Serial0IrqHandler:
	push	acc
	push	b
	push	dpl
	push	dph
	push	dpx
	push	dps
	mov	dps,#0
	push	dpl1
	push	dph1
	push	dpx1
	push	ar2
	push	ar3
	push	psw
	mov	psw,#0x00
;	tinibios.c:136: if (RI_0) {
	jnb  _RI_0,00104$
00112$:
;	tinibios.c:137: receive0Buffer[receive0BufferHead]=SBUF0;
	mov	dptr,#_receive0BufferHead
	movx	a,@dptr
	add	a,#_receive0Buffer
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#(_receive0Buffer >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_receive0Buffer >> 16)
	mov	dpx1,a
	mov	a,_SBUF0
	inc	dps
	movx	@dptr,a
	mov	dps,#0
;	tinibios.c:138: receive0BufferHead=(receive0BufferHead+1)&(S0RBS-1);
	mov	dptr,#_receive0BufferHead
	movx	a,@dptr
	add	a,#0x01
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	mov	dptr,#_receive0BufferHead
	mov	a,r2
	movx	@dptr,a
	mov	a,#0x03
	anl	a,r3
	inc	dptr
	movx	@dptr,a
;	tinibios.c:139: if (receive0BufferHead==receive0BufferTail) {
	mov	dptr,#_receive0BufferTail
	mov     dps, #1
	mov     dptr, #_receive0BufferHead
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne	a,b,00113$
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00113$
	sjmp	00114$
00113$:
	sjmp 00102$
00114$:
;	tinibios.c:141: receive0BufferTail=(receive0BufferTail+1)&(S0RBS-1);
	mov	dptr,#_receive0BufferTail
	movx	a,@dptr
	add	a,#0x01
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	mov	dptr,#_receive0BufferTail
	mov	a,r2
	movx	@dptr,a
	mov	a,#0x03
	anl	a,r3
	inc	dptr
	movx	@dptr,a
00102$:
;	tinibios.c:143: RI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
00104$:
;	tinibios.c:145: if (TI_0) {
;	tinibios.c:146: TI_0=0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI_0,00115$
	sjmp    00107$
00115$:
;	tinibios.c:147: transmit0IsBusy=0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_transmit0IsBusy
	clr  a
	movx	@dptr,a
00107$:
	pop	psw
	pop	ar3
	pop	ar2
	pop	dpx1
	pop	dph1
	pop	dpl1
	pop	dps
	pop	dpx
	pop	dph
	pop	dpl
	pop	b
	pop	acc
	reti
;	eliminated unneeded push/pop ar4
;	eliminated unneeded push/pop ap
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0CharArrived'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:151: char Serial0CharArrived(void)
;	-----------------------------------------
;	 function Serial0CharArrived
;	-----------------------------------------
_Serial0CharArrived:
;	tinibios.c:153: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00106$
00113$:
;	tinibios.c:154: if (receive0BufferHead!=receive0BufferTail)
	mov	dptr,#_receive0BufferTail
	mov     dps, #1
	mov     dptr, #_receive0BufferHead
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne	a,b,00114$
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00114$
	sjmp 00107$
00114$:
;	tinibios.c:155: return receive0Buffer[receive0BufferTail];
	mov	dptr,#_receive0BufferTail
	movx	a,@dptr
	add	a,#_receive0Buffer
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#(_receive0Buffer >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_receive0Buffer >> 16)
	mov	dpx1,a
	inc	dps
	movx	a,@dptr
	mov	r2,a
	mov	dps,#0
	mov	dpl,r2
	sjmp 00108$
00106$:
;	tinibios.c:157: if (RI_0)
	jnb  _RI_0,00107$
00115$:
;	tinibios.c:158: return SBUF0;
;	genAssign: resultIsFar = FALSE
	mov	r2,_SBUF0
	mov	dpl,r2
;	tinibios.c:160: return 0;
	ret
00107$:
	mov     dpl,#0x00
00108$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0PutChar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	tinibios.c:163: void Serial0PutChar (char c)
;	-----------------------------------------
;	 function Serial0PutChar
;	-----------------------------------------
_Serial0PutChar:
	mov	r2,dpl
;	tinibios.c:165: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00104$
00116$:
;	tinibios.c:166: while (transmit0IsBusy)
00101$:
	mov	dptr,#_transmit0IsBusy
	movx	a,@dptr
	jnz  00101$
00117$:
;	tinibios.c:168: transmit0IsBusy=1;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_transmit0IsBusy
	mov	a,#0x01
	movx	@dptr,a
;	tinibios.c:169: SBUF0=c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF0,r2
;	tinibios.c:171: while (!TI_0)
	sjmp 00110$
00104$:
;	tinibios.c:173: TI_0 = 0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI_0,00118$
	sjmp    00104$
00118$:
;	tinibios.c:174: SBUF0=c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF0,r2
00110$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0GetChar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	tinibios.c:178: char Serial0GetChar (void)
;	-----------------------------------------
;	 function Serial0GetChar
;	-----------------------------------------
_Serial0GetChar:
;	tinibios.c:181: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00104$
00116$:
;	tinibios.c:182: while (receive0BufferHead==receive0BufferTail)
00101$:
	mov	dptr,#_receive0BufferTail
	mov     dps, #1
	mov     dptr, #_receive0BufferHead
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	movx	a,@dptr
	cjne	a,b,00117$
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	mov	b,a
	inc	dptr
	movx	a,@dptr
	cjne	a,b,00117$
	sjmp 00101$
00117$:
;	tinibios.c:184: c=receive0Buffer[receive0BufferTail];
	mov	dptr,#_receive0BufferTail
	movx	a,@dptr
	add	a,#_receive0Buffer
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#(_receive0Buffer >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_receive0Buffer >> 16)
	mov	dpx1,a
	inc	dps
	movx	a,@dptr
	mov	r2,a
	mov	dps,#0
;	genAssign: resultIsFar = TRUE
;	tinibios.c:185: ES0=0; // disable serial interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:186: receive0BufferTail=(receive0BufferTail+1)&(S0RBS-1);
	mov	dptr,#_receive0BufferTail
	movx	a,@dptr
	add	a,#0x01
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	mov	dptr,#_receive0BufferTail
	mov	a,r3
	movx	@dptr,a
	mov	a,#0x03
	anl	a,r4
	inc	dptr
	movx	@dptr,a
;	tinibios.c:187: ES0=1; // enable serial interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ES0
;	tinibios.c:189: while (!RI_0)
	sjmp 00109$
00104$:
	jnb  _RI_0,00104$
00118$:
;	tinibios.c:191: c=SBUF0;
;	genAssign: resultIsFar = TRUE
	mov	r2,_SBUF0
;	tinibios.c:192: RI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
00109$:
;	tinibios.c:194: return c;
	mov	dpl,r2
00110$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0SendBreak'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:197: void Serial0SendBreak()
;	-----------------------------------------
;	 function Serial0SendBreak
;	-----------------------------------------
_Serial0SendBreak:
;	tinibios.c:199: P3 &= ~0x02;
	anl	_P3,#0xFD
;	tinibios.c:200: ClockMilliSecondsDelay(2);
	mov	dptr,#0x000002
	mov	b,#0x00
	lcall	_ClockMilliSecondsDelay
;	tinibios.c:201: P3 |= 0x02;
	orl	_P3,#0x02
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0Flush'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:204: void Serial0Flush()
;	-----------------------------------------
;	 function Serial0Flush
;	-----------------------------------------
_Serial0Flush:
;	tinibios.c:206: ES0=0; // disable interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:207: receive0BufferHead=receive0BufferTail=0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_receive0BufferTail
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_receive0BufferHead
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	tinibios.c:208: RI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:209: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00102$
00107$:
;	tinibios.c:210: TI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_TI_0
;	tinibios.c:211: ES0=1; // enable interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ES0
	sjmp 00104$
00102$:
;	tinibios.c:213: TI_0=1;
;	genAssign: resultIsFar = FALSE
	setb	_TI_0
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockInit'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:223: void ClockInit()
;	-----------------------------------------
;	 function ClockInit
;	-----------------------------------------
_ClockInit:
;	tinibios.c:226: }
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockTicks'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:229: unsigned long ClockTicks(void)
;	-----------------------------------------
;	 function ClockTicks
;	-----------------------------------------
_ClockTicks:
;	tinibios.c:231: return task_gettimemillis_long();
	lcall	_task_gettimemillis_long
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockMilliSecondsDelay'
;------------------------------------------------------------
;delay                     Allocated to registers r2 r3 r4 r5 
;ms                        Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:234: void ClockMilliSecondsDelay(unsigned long delay)
;	-----------------------------------------
;	 function ClockMilliSecondsDelay
;	-----------------------------------------
_ClockMilliSecondsDelay:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	tinibios.c:236: unsigned long ms = task_gettimemillis_long() + delay;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_task_gettimemillis_long
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r2
	add	a,r6
	mov	r2,a
	mov	a,r3
	addc	a,r7
	mov	r3,a
	mov	a,r4
	addc	a,r0
	mov	r4,a
	mov	a,r5
	addc	a,r1
	mov	r5,a
;	tinibios.c:238: while (ms > task_gettimemillis_long())
00101$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_task_gettimemillis_long
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	clr	c
	mov	a,r6
	subb	a,r2
	mov	a,r7
	subb	a,r3
	mov	a,r0
	subb	a,r4
	mov	a,r1
	subb	a,r5
	jc   00101$
00107$:
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function '_xisegStart'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:246: static void __xdata *_xisegStart(void) __naked
;	-----------------------------------------
;	 function _xisegStart
;	-----------------------------------------
__xisegStart:
;	naked function: no prologue.
;	tinibios.c:251: __endasm;
	
	  mov dptr, #(s_XISEG)
	  ret
	  
00101$:
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '_xisegLen'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:258: static unsigned  _xisegLen(void) __naked
;	-----------------------------------------
;	 function _xisegLen
;	-----------------------------------------
__xisegLen:
;	naked function: no prologue.
;	tinibios.c:263: __endasm;
	
	  mov dptr, #(l_XISEG)
	  ret
	  
00101$:
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '_firstHeapByte'
;------------------------------------------------------------
;start                     Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	tinibios.c:268: static void __xdata *_firstHeapByte(void)
;	-----------------------------------------
;	 function _firstHeapByte
;	-----------------------------------------
__firstHeapByte:
;	tinibios.c:272: start = (unsigned char __xdata *) _xisegStart();
	lcall	__xisegStart
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
;	genAssign: resultIsFar = TRUE
;	tinibios.c:273: start += _xisegLen();
	push	ar2
	push	ar3
	push	ar4
	lcall	__xisegLen
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r5
	add	a,r2
	mov	r2,a
	mov	a,r6
	addc	a,r3
	mov	r3,a
	clr	a
	addc	a,r4
	mov	r4,a
;	tinibios.c:275: return (void __xdata *)start;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'romInit'
;------------------------------------------------------------
;speed                     Allocated with name '_romInit_PARM_2'
;noisy                     Allocated to registers r2 
;heapStart                 Allocated to registers r3 r4 r5 
;heapEnd                   Allocated to registers 
;heapLen                   Allocated to registers r2 r6 r7 r0 
;rc                        Allocated to registers r6 
;------------------------------------------------------------
;	tinibios.c:283: unsigned char romInit(unsigned char noisy, char speed)
;	-----------------------------------------
;	 function romInit
;	-----------------------------------------
_romInit:
	mov	r2,dpl
;	tinibios.c:290: if (speed == SPEED_2X)
	mov	dptr,#_romInit_PARM_2
	movx	a,@dptr
	cjne a,#0x01,00110$
00128$:
;	tinibios.c:292: PMR = 0x82;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x82
;	tinibios.c:293: PMR = 0x92;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x92
;	tinibios.c:295: while (!(EXIF & 8))
00101$:
	mov	a,_EXIF
	jnb  acc.3,00101$
00129$:
;	tinibios.c:298: PMR = 0x12;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x12
	sjmp 00111$
00110$:
;	tinibios.c:300: else if (speed == SPEED_4X)
	mov	dptr,#_romInit_PARM_2
	movx	a,@dptr
	cjne a,#0x02,00111$
00131$:
;	tinibios.c:303: PMR = 0x82;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x82
;	tinibios.c:304: PMR = 0x8a;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x8A
;	tinibios.c:305: PMR = 0x9a;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x9A
;	tinibios.c:307: while (!(EXIF & 8))
00104$:
	mov	a,_EXIF
	jnb  acc.3,00104$
00132$:
;	tinibios.c:310: PMR = 0x1a;
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x1A
00111$:
;	tinibios.c:313: heapStart = _firstHeapByte();
	push	ar2
	lcall	__firstHeapByte
	mov	r3,dpl
	mov	r4,dph
	mov	r5,dpx
	pop	ar2
;	genAssign: resultIsFar = TRUE
;	tinibios.c:316: rc = init_rom(heapStart, heapEnd);
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_init_rom_PARM_2
	mov  a,#0xFF
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x0F
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r3
	mov	dph,r4
	mov	dpx,r5
	lcall	_init_rom
	mov	r6,dpl
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
;	tinibios.c:318: if (noisy)
	mov	a,r2
	jnz	00133$
	ljmp	00116$
00133$:
;	tinibios.c:320: if (rc)
	mov	a,r6
	jz  00113$
00134$:
;	tinibios.c:322: printf("error: rom_init returns %d\n", (int)rc);
	mov	ar2,r6
	mov	r7,#0
	push	ar6
	push	ar2
	push	ar7
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#(__str_0 >> 16)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
;	stack adjustment for parms
	pop	acc
	pop	acc
	pop	acc
	pop	acc
	pop	acc
	pop	acc
	pop	ar6
;	tinibios.c:323: return rc;
	mov	dpl,r6
	ljmp	00117$
00113$:
;	tinibios.c:327: heapLen = CE0_END - (unsigned long)heapStart;
;	genAssign: resultIsFar = FALSE
	mov	ar2,r3
	mov	ar6,r4
	mov	ar7,r5
	mov	r0,#0
	clr	c
	mov	a,#0xFF
	subb	a,r2
	mov	r2,a
	mov	a,#0xFF
	subb	a,r6
	mov	r6,a
	mov	a,#0x0F
	subb	a,r7
	mov	r7,a
	clr  a
	subb	a,r0
	mov	r0,a
;	tinibios.c:328: printf("Heap starts at %p, length %luK\n", heapStart, heapLen / 1024);
	mov	ar2,r6
	mov	a,r7
	clr	c
	rrc	a
	xch	a,r2
	rrc	a
	xch	a,r2
	clr	c
	rrc	a
	xch	a,r2
	rrc	a
	xch	a,r2
	mov	r6,a
	mov	a,r0
	rr	a
	rr	a
	anl	a,#0xC0
	orl	a,r6
	mov	r6,a
	mov	a,r0
	rr	a
	rr	a
	anl	a,#0x3F
	mov	r7,a
	mov	r0,#0
;	genAssign: resultIsFar = FALSE
	mov	r1,#0x00
	push	ar2
	push	ar6
	push	ar7
	push	ar0
	push	ar3
	push	ar4
	push	ar5
	push	ar1
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#(__str_1 >> 16)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	clr	c
	mov	a,sp
	subb	a,#0x0C
	mov	sp,a
	mov	a,esp
	anl	a,#3
	orl	a,#0xDC
	subb	a,#0x00
	mov	esp,a
00116$:
;	tinibios.c:332: task_settickreload(RELOAD_14_746);
	mov  dptr,#0xFB33
	lcall	_task_settickreload
;	tinibios.c:335: Serial0SwitchToBuffered();
	lcall	_Serial0SwitchToBuffered
;	tinibios.c:337: P5 &= ~4; // LED on.
	anl	_P5,#0xFB
;	tinibios.c:339: return 0;
	mov	dpl,#0x00
00117$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'installInterrupt'
;------------------------------------------------------------
;offset                    Allocated with name '_installInterrupt_PARM_2'
;isrPtr                    Allocated to registers 
;vectPtr                   Allocated to registers r5 r6 r7 
;isr                       Allocated with name '_installInterrupt_isr_1_1'
;------------------------------------------------------------
;	tinibios.c:343: void installInterrupt(void (*isrPtr)(void), unsigned char offset)
;	-----------------------------------------
;	 function installInterrupt
;	-----------------------------------------
_installInterrupt:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
;	tinibios.c:345: unsigned char __xdata * vectPtr = (unsigned char __xdata *) offset;
	mov	dptr,#_installInterrupt_PARM_2
	movx	a,@dptr
	mov	r5,a
	mov	r6,#0
	mov	r7,#0
;	genAssign: resultIsFar = TRUE
	mov	dpl1,r5
	mov	dph1,r6
	mov	dpx1,r7
;	tinibios.c:346: unsigned long isr = (unsigned long)isrPtr;
	mov	dptr,#_installInterrupt_isr_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	tinibios.c:348: *vectPtr++ = 0x02;
	mov	a,#0x02
	inc	dps
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
;	tinibios.c:349: *vectPtr++ = (unsigned char)(isr >> 16);
	mov	dptr,#_installInterrupt_isr_1_1
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	mov	r3,#0
	mov	r4,#0
	mov	a,r1
	inc	dps
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
;	tinibios.c:350: *vectPtr++ = (unsigned char)(isr >> 8);
	mov	dptr,#_installInterrupt_isr_1_1
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	r0,#0
	mov	a,r2
	inc	dps
	movx	@dptr,a
	inc	dptr
	mov	dps,#0
;	tinibios.c:351: *vectPtr = (unsigned char)isr;
	mov	dptr,#_installInterrupt_isr_1_1
	movx	a,@dptr
	mov  r2,a
	inc	dps
	movx	@dptr,a
	mov	dps,#0
00101$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
__str_0:
	.ascii "error: rom_init returns %d"
	.db 0x0A
	.db 0x00
__str_1:
	.ascii "Heap starts at %p, length %luK"
	.db 0x0A
	.db 0x00
	.area XINIT   (CODE)
__xinit__receive0BufferHead:
	.byte #0x00,#0x00	;  0
__xinit__receive0BufferTail:
	.byte #0x00,#0x00	;  0
__xinit__transmit0IsBusy:
	.db #0x00	;  0
	.area CABS    (ABS,CODE)
