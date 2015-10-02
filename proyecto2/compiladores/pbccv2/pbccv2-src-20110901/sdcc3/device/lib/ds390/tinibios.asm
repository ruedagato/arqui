;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module tinibios
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
	.globl _Serial1Init_PARM_2
	.globl _Serial0Init_PARM_2
	.globl _cpuSpeed
	.globl __sdcc_external_startup
	.globl _CpuSpeed
	.globl _Serial0Init
	.globl _Serial0Baud
	.globl _Serial0IrqHandler
	.globl _Serial0CharArrived
	.globl _Serial0PutChar
	.globl _Serial0GetChar
	.globl _Serial0SendBreak
	.globl _Serial0Flush
	.globl _Serial1Init
	.globl _Serial1Baud
	.globl _Serial1IrqHandler
	.globl _Serial1CharArrived
	.globl _Serial1PutChar
	.globl _Serial1GetChar
	.globl _Serial1SendBreak
	.globl _Serial1Flush
	.globl _ClockInit
	.globl _ClockIrqHandler
	.globl _ClockTicks
	.globl _ClockMilliSecondsDelay
	.globl _ClockMicroSecondsDelay
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
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_serial0Buffered:
	.ds 1
_serial1Buffered:
	.ds 1
_milliSeconds:
	.ds 4
_timer0ReloadValue:
	.ds 2
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
_cpuSpeed::
	.ds 2
_receive0Buffer:
	.ds 1024
_Serial0Init_PARM_2:
	.ds 1
_receive1Buffer:
	.ds 64
_Serial1Init_PARM_2:
	.ds 1
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
_receive1BufferHead:
	.ds 2
_receive1BufferTail:
	.ds 2
_transmit1IsBusy:
	.ds 1
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;	tinibios.c:478: static __data unsigned long milliSeconds=0;
;	genAssign: resultIsFar = FALSE
	clr	a
	mov	_milliSeconds,a
	mov	(_milliSeconds + 1),a
	mov	(_milliSeconds + 2),a
	mov	(_milliSeconds + 3),a
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
;	tinibios.c:34: unsigned char _sdcc_external_startup(void)
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
;	tinibios.c:36: IE=0; // disable ALL interrupts
;	genAssign: resultIsFar = FALSE
	mov	_IE,#0x00
;	tinibios.c:39: TIMED_ACCESS(P4CNT,0x3f);
;	genAssign: resultIsFar = FALSE
	mov	_TA,#0xAA
;	genAssign: resultIsFar = FALSE
	mov	_TA,#0x55
;	genAssign: resultIsFar = FALSE
	mov	_P4CNT,#0x3F
;	tinibios.c:42: TIMED_ACCESS(P5CNT,0x27);
;	genAssign: resultIsFar = FALSE
	mov	_TA,#0xAA
;	genAssign: resultIsFar = FALSE
	mov	_TA,#0x55
;	genAssign: resultIsFar = FALSE
	mov	_P5CNT,#0x27
;	tinibios.c:45: EWT=0;
;	genAssign: resultIsFar = FALSE
	clr	_EWT
;	tinibios.c:52: CKCON=0xf9;
;	genAssign: resultIsFar = FALSE
	mov	_CKCON,#0xF9
;	tinibios.c:57: TIMED_ACCESS(MCON,0xaf);
;	genAssign: resultIsFar = FALSE
	mov	_TA,#0xAA
;	genAssign: resultIsFar = FALSE
	mov	_TA,#0x55
;	genAssign: resultIsFar = FALSE
	mov	_MCON,#0xAF
;	tinibios.c:78: __endasm;
	
    ; save the 24-bit return address
; pop ar2; msb
	    mov r2, #0x00
	    pop ar1
	    pop ar0; lsb
	
	
	    mov _TA,#0xaa; timed access
	    mov _TA,#0x55
	    mov _ACON,#0x06; 24 bit addresses, 10 bit stack at 0x400000
	
	    mov _ESP,#0x00; reinitialize the stack
	    mov _SP,#0x00
	
    ; restore the 24-bit return address
	    push ar0; lsb
	    push ar1
	    push ar2; msb
	  
;	tinibios.c:81: CpuSpeed(CPU_SPEED);
	mov  dptr,#0x0002
	lcall	_CpuSpeed
;	tinibios.c:113: __endasm;
	
	    push dpx
	    push dph
	    push dpl
	    push dps
	    push b
	    push acc
	    mov dps,#0x00 ; make sure no autoincrement in progress
	    mov dptr,#0x10000 ; from
	    inc dps ; switch to alternate dptr
	    mov dptr,#0x100000 ; to
	    mov b,#0x80 ; count
	
	_Startup390CopyIVT:
	    inc dps
	    movx a,@dptr
	    inc dptr
	    inc dps
	    movx @dptr,a
	    inc dptr
	    djnz b,_Startup390CopyIVT
	
	    pop acc
	    pop b
	    pop dps
	    pop dpl
	    pop dph
	    pop dpx
	  
;	tinibios.c:117: IE = 0x80; 
;	genAssign: resultIsFar = FALSE
	mov	_IE,#0x80
;	tinibios.c:119: Serial0Init(SERIAL_0_BAUD,1);
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_Serial0Init_PARM_2
	mov	a,#0x01
	movx	@dptr,a
	mov	dptr,#0x01C200
	mov	b,#0x00
	lcall	_Serial0Init
;	tinibios.c:121: ClockInit();
	lcall	_ClockInit
;	tinibios.c:126: return 0; 
	mov	dpl,#0x00
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'CpuSpeed'
;------------------------------------------------------------
;speed                     Allocated to registers r2 r3 
;------------------------------------------------------------
;	tinibios.c:140: void CpuSpeed(unsigned int speed)
;	-----------------------------------------
;	 function CpuSpeed
;	-----------------------------------------
_CpuSpeed:
	mov	dpl1,dpl
	mov	dph1,dph
;	tinibios.c:146: PMR = 0x80; // div4, CTM off, multiplier 2x
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x80
;	tinibios.c:147: switch (speed) 
	mov	a,dpl1
	cjne	a,#0x01,00122$
	mov	a,dph1
	cjne	a,#0x00,00122$
	sjmp 00101$
00122$:
	mov	a,dpl1
	cjne	a,#0x02,00123$
	mov	a,dph1
	cjne	a,#0x00,00123$
	sjmp 00105$
00123$:
	mov	a,dpl1
	cjne	a,#0x04,00124$
	mov	a,dph1
	cjne	a,#0x00,00124$
	sjmp 00109$
00124$:
	mov	a,dpl1
;	tinibios.c:149: case 1:
	cjne a,#0x00,00112$
	mov  a,dph1
	cjne a,#0x04,00112$
	sjmp 00110$
00101$:
;	tinibios.c:150: PMR=0x88; // div4, CTM off, multiplier 4x
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x88
;	tinibios.c:151: PMR=0x98; // div4, CTM on, multiplier 4x
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x98
;	tinibios.c:152: while ((EXIF&0x08)==0) {
00102$:
	mov	a,_EXIF
	jnb  acc.3,00102$
00126$:
;	tinibios.c:155: PMR = 0x18; // use multiplier
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x18
;	tinibios.c:156: cpuSpeed=speed;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_cpuSpeed
	mov	a,dpl1
	movx	@dptr,a
	inc	dptr
	mov	a,dph1
	movx	@dptr,a
;	tinibios.c:157: break;
;	tinibios.c:158: case 2:
	sjmp 00112$
00105$:
;	tinibios.c:159: PMR=0x90; // div4, CTM on, multilier 2x
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x90
;	tinibios.c:160: while ((EXIF&0x08)==0) {
00106$:
	mov	a,_EXIF
	jnb  acc.3,00106$
00127$:
;	tinibios.c:163: PMR = 0x10; // use multiplier
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0x10
;	tinibios.c:164: cpuSpeed=speed;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_cpuSpeed
	mov	a,dpl1
	movx	@dptr,a
	inc	dptr
	mov	a,dph1
	movx	@dptr,a
;	tinibios.c:165: break;
;	tinibios.c:166: case 4:
	sjmp 00112$
00109$:
;	tinibios.c:168: cpuSpeed=speed;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_cpuSpeed
	mov	a,dpl1
	movx	@dptr,a
	inc	dptr
	mov	a,dph1
	movx	@dptr,a
;	tinibios.c:169: break;
;	tinibios.c:170: case 1024:
	sjmp 00112$
00110$:
;	tinibios.c:171: PMR = 0xc0; // div1024, CTM off
;	genAssign: resultIsFar = FALSE
	mov	_PMR,#0xC0
;	tinibios.c:172: cpuSpeed=speed;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_cpuSpeed
	mov	a,dpl1
	movx	@dptr,a
	inc	dptr
	mov	a,dph1
	movx	@dptr,a
;	tinibios.c:174: }
00112$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0Init'
;------------------------------------------------------------
;buffered                  Allocated with name '_Serial0Init_PARM_2'
;baud                      Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:199: void Serial0Init (unsigned long baud, unsigned char buffered)
;	-----------------------------------------
;	 function Serial0Init
;	-----------------------------------------
_Serial0Init:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	tinibios.c:201: if (baud==0) {
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00102$
00110$:
;	tinibios.c:202: ES0=0; // disable interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:203: SCON0 &= 0xef; // disable receiver
	anl	_SCON0,#0xEF
;	tinibios.c:204: return;
	sjmp 00106$
00102$:
;	tinibios.c:207: ES0 = 0; // disable serial channel 0 interrupt
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:208: TR2 = 0; // stop timer 2
;	genAssign: resultIsFar = FALSE
	clr	_TR2
;	tinibios.c:212: SCON0 = 0x50;
;	genAssign: resultIsFar = FALSE
	mov	_SCON0,#0x50
;	tinibios.c:214: PCON |= 0x80; // clock is 16x bitrate
	orl	_PCON,#0x80
;	tinibios.c:215: CKCON|=0x20; // timer uses xtal/4
	orl	_CKCON,#0x20
;	tinibios.c:217: T2MOD=0; // no fancy functions
;	genAssign: resultIsFar = FALSE
	mov	_T2MOD,#0x00
;	tinibios.c:218: T2CON=0x34; // start timer as a baudrate generator for serial0
;	genAssign: resultIsFar = FALSE
	mov	_T2CON,#0x34
;	tinibios.c:221: Serial0Baud(baud);
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	_Serial0Baud
;	tinibios.c:223: serial0Buffered=buffered;
	mov	dptr,#_Serial0Init_PARM_2
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
;	genAssign: resultIsFar = FALSE
;	tinibios.c:225: if (buffered) {
	mov  r2,a
	mov  _serial0Buffered,r2 
	jz  00104$
00111$:
;	tinibios.c:226: RI_0=TI_0=0; // clear "pending" interrupts
;	genAssign: resultIsFar = FALSE
	clr	_TI_0
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:227: ES0 = 1; // enable serial channel 0 interrupt
;	genAssign: resultIsFar = FALSE
	setb	_ES0
	sjmp 00106$
00104$:
;	tinibios.c:229: RI_0=0; // receive buffer empty
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:230: TI_0=1; // transmit buffer empty
;	genAssign: resultIsFar = FALSE
	setb	_TI_0
00106$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0Baud'
;------------------------------------------------------------
;baud                      Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:234: void Serial0Baud(unsigned long baud)
;	-----------------------------------------
;	 function Serial0Baud
;	-----------------------------------------
_Serial0Baud:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	tinibios.c:236: TR2=0; // stop timer
;	genAssign: resultIsFar = FALSE
	clr	_TR2
;	tinibios.c:237: baud=-((long)OSCILLATOR/(32*baud));
	mov	b,#0x06
	mov	r6,ar2
	mov	r7,ar3
	mov	r0,ar4
	mov	r1,ar5
	sjmp	00104$
00103$:
	mov	a,r6
	add	a,acc
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
	mov	a,r0
	rlc	a
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
00104$:
	djnz	b,00103$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_PARM_2
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
	mov	dptr,#0x194000
	mov	b,#0x01
	lcall	__divulong
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	clr	c
	clr	a
	subb	a,r6
	mov	r2,a
	clr	a
	subb	a,r7
	mov	r3,a
	clr	a
	subb	a,r0
	mov	r4,a
	clr	a
	subb	a,r1
	mov	r5,a
;	tinibios.c:238: TL2=RCAP2L= baud;
	mov	ar6,r2
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2L,r6
;	genAssign: resultIsFar = FALSE
	mov	_TL2,r6
;	tinibios.c:239: TH2=RCAP2H= baud>>8;
	mov	ar2,r3
	mov	ar3,r4
	mov	ar4,r5
	mov	r5,#0
;	genAssign: resultIsFar = FALSE
	mov	_RCAP2H,r2
;	genAssign: resultIsFar = FALSE
	mov	_TH2,r2
;	tinibios.c:240: TF2=0; // clear overflow flag
;	genAssign: resultIsFar = FALSE
	clr	_TF2
;	tinibios.c:241: TR2=1; // start timer
;	genAssign: resultIsFar = FALSE
	setb	_TR2
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0IrqHandler'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:244: void Serial0IrqHandler (void) __interrupt 4
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
;	tinibios.c:246: if (RI_0) {
	jnb  _RI_0,00104$
00112$:
;	tinibios.c:247: receive0Buffer[receive0BufferHead]=SBUF0;
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
;	tinibios.c:248: receive0BufferHead=(receive0BufferHead+1)&(S0RBS-1);
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
;	tinibios.c:249: if (receive0BufferHead==receive0BufferTail) {
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
;	tinibios.c:251: receive0BufferTail=(receive0BufferTail+1)&(S0RBS-1);
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
;	tinibios.c:253: RI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
00104$:
;	tinibios.c:255: if (TI_0) {
;	tinibios.c:256: TI_0=0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI_0,00115$
	sjmp    00107$
00115$:
;	tinibios.c:257: transmit0IsBusy=0;
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
;	tinibios.c:261: char Serial0CharArrived(void)
;	-----------------------------------------
;	 function Serial0CharArrived
;	-----------------------------------------
_Serial0CharArrived:
;	tinibios.c:263: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00106$
00113$:
;	tinibios.c:264: if (receive0BufferHead!=receive0BufferTail)
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
;	tinibios.c:265: return receive0Buffer[receive0BufferTail];
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
;	tinibios.c:267: if (RI_0)
	jnb  _RI_0,00107$
00115$:
;	tinibios.c:268: return SBUF0;
;	genAssign: resultIsFar = FALSE
	mov	r2,_SBUF0
	mov	dpl,r2
;	tinibios.c:270: return 0;
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
;	tinibios.c:273: void Serial0PutChar (char c)
;	-----------------------------------------
;	 function Serial0PutChar
;	-----------------------------------------
_Serial0PutChar:
	mov	r2,dpl
;	tinibios.c:275: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00104$
00116$:
;	tinibios.c:276: while (transmit0IsBusy)
00101$:
	mov	dptr,#_transmit0IsBusy
	movx	a,@dptr
	jnz  00101$
00117$:
;	tinibios.c:278: transmit0IsBusy=1;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_transmit0IsBusy
	mov	a,#0x01
	movx	@dptr,a
;	tinibios.c:279: SBUF0=c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF0,r2
;	tinibios.c:281: while (!TI_0)
	sjmp 00110$
00104$:
	jnb  _TI_0,00104$
00118$:
;	tinibios.c:283: SBUF0=c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF0,r2
;	tinibios.c:284: TI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_TI_0
00110$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0GetChar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	tinibios.c:288: char Serial0GetChar (void)
;	-----------------------------------------
;	 function Serial0GetChar
;	-----------------------------------------
_Serial0GetChar:
;	tinibios.c:291: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00104$
00116$:
;	tinibios.c:292: while (receive0BufferHead==receive0BufferTail)
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
;	tinibios.c:294: c=receive0Buffer[receive0BufferTail];
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
;	tinibios.c:295: ES0=0; // disable serial interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:296: receive0BufferTail=(receive0BufferTail+1)&(S0RBS-1);
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
;	tinibios.c:297: ES0=1; // enable serial interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ES0
;	tinibios.c:299: while (!RI_0)
	sjmp 00109$
00104$:
	jnb  _RI_0,00104$
00118$:
;	tinibios.c:301: c=SBUF0;
;	genAssign: resultIsFar = TRUE
	mov	r2,_SBUF0
;	tinibios.c:302: RI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
00109$:
;	tinibios.c:304: return c;
	mov	dpl,r2
00110$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0SendBreak'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:307: void Serial0SendBreak()
;	-----------------------------------------
;	 function Serial0SendBreak
;	-----------------------------------------
_Serial0SendBreak:
;	tinibios.c:309: P3 &= ~0x02;
	anl	_P3,#0xFD
;	tinibios.c:310: ClockMilliSecondsDelay(2);
	mov	dptr,#0x000002
	mov	b,#0x00
	lcall	_ClockMilliSecondsDelay
;	tinibios.c:311: P3 |= 0x02;
	orl	_P3,#0x02
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial0Flush'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:314: void Serial0Flush()
;	-----------------------------------------
;	 function Serial0Flush
;	-----------------------------------------
_Serial0Flush:
;	tinibios.c:316: ES0=0; // disable interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES0
;	tinibios.c:317: receive0BufferHead=receive0BufferTail=0;
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
;	tinibios.c:318: RI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_0
;	tinibios.c:319: if (serial0Buffered) {
	mov	a,_serial0Buffered
	jz  00102$
00107$:
;	tinibios.c:320: TI_0=0;
;	genAssign: resultIsFar = FALSE
	clr	_TI_0
;	tinibios.c:321: ES0=1; // enable interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ES0
	sjmp 00104$
00102$:
;	tinibios.c:323: TI_0=1;
;	genAssign: resultIsFar = FALSE
	setb	_TI_0
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1Init'
;------------------------------------------------------------
;buffered                  Allocated with name '_Serial1Init_PARM_2'
;baud                      Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:351: void Serial1Init (unsigned long baud, unsigned char buffered)
;	-----------------------------------------
;	 function Serial1Init
;	-----------------------------------------
_Serial1Init:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	tinibios.c:353: if (baud==0) {
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00102$
00110$:
;	tinibios.c:354: ES1=0; // disable interrupt
;	genAssign: resultIsFar = FALSE
	clr	_ES1
;	tinibios.c:355: SCON1 &= 0xef; // disable receiver
	anl	_SCON1,#0xEF
;	tinibios.c:356: return; // and don't touch it
	sjmp 00106$
00102$:
;	tinibios.c:359: ES1 = 0; // disable channel 1 interrupt
;	genAssign: resultIsFar = FALSE
	clr	_ES1
;	tinibios.c:360: TR1 = 0; // stop timer 1
;	genAssign: resultIsFar = FALSE
	clr	_TR1
;	tinibios.c:364: SCON1 = 0x50;
;	genAssign: resultIsFar = FALSE
	mov	_SCON1,#0x50
;	tinibios.c:366: WDCON |= 0x80; // clock is 16x bitrate
	orl	_WDCON,#0x80
;	tinibios.c:367: CKCON|=0x10; // timer uses xtal/4
	orl	_CKCON,#0x10
;	tinibios.c:369: TMOD = (TMOD&0x0f) | 0x20; // timer 1 is an 8bit auto-reload counter
	mov	a,#0x0F
	anl	a,_TMOD
	mov	r6,a
	mov	a,#0x20
	orl	a,r6
	mov	_TMOD,a
;	tinibios.c:372: Serial1Baud(baud);
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	_Serial1Baud
;	tinibios.c:374: serial1Buffered=buffered;
	mov	dptr,#_Serial1Init_PARM_2
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
;	genAssign: resultIsFar = FALSE
;	tinibios.c:376: if (buffered) {
	mov  r2,a
	mov  _serial1Buffered,r2 
	jz  00104$
00111$:
;	tinibios.c:377: RI_1=TI_1=0; // clear "pending" interrupts
;	genAssign: resultIsFar = FALSE
	clr	_TI_1
;	genAssign: resultIsFar = FALSE
	clr	_RI_1
;	tinibios.c:378: ES1 = 1; // enable serial channel 1 interrupt
;	genAssign: resultIsFar = FALSE
	setb	_ES1
	sjmp 00106$
00104$:
;	tinibios.c:380: RI_1=0; // receive buffer empty
;	genAssign: resultIsFar = FALSE
	clr	_RI_1
;	tinibios.c:381: TI_1=1; // transmit buffer empty
;	genAssign: resultIsFar = FALSE
	setb	_TI_1
00106$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1Baud'
;------------------------------------------------------------
;baud                      Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:385: void Serial1Baud(unsigned long baud)
;	-----------------------------------------
;	 function Serial1Baud
;	-----------------------------------------
_Serial1Baud:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	tinibios.c:387: TR1=0; // stop timer
;	genAssign: resultIsFar = FALSE
	clr	_TR1
;	tinibios.c:388: baud=-((long)OSCILLATOR/(32*baud));
	mov	b,#0x06
	mov	r6,ar2
	mov	r7,ar3
	mov	r0,ar4
	mov	r1,ar5
	sjmp	00104$
00103$:
	mov	a,r6
	add	a,acc
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
	mov	a,r0
	rlc	a
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
00104$:
	djnz	b,00103$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_PARM_2
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
	mov	dptr,#0x194000
	mov	b,#0x01
	lcall	__divulong
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	clr	c
	clr	a
	subb	a,r6
	mov	r2,a
	clr	a
	subb	a,r7
	mov	r3,a
	clr	a
	subb	a,r0
	mov	r4,a
	clr	a
	subb	a,r1
	mov	r5,a
;	tinibios.c:389: TL1=TH1 = baud;
;	genAssign: resultIsFar = FALSE
	mov	_TH1,r2
;	genAssign: resultIsFar = FALSE
	mov	_TL1,r2
;	tinibios.c:390: TF1=0; // clear overflow flag
;	genAssign: resultIsFar = FALSE
	clr	_TF1
;	tinibios.c:391: TR1=1; // start timer
;	genAssign: resultIsFar = FALSE
	setb	_TR1
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1IrqHandler'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:394: void Serial1IrqHandler (void) __interrupt 7
;	-----------------------------------------
;	 function Serial1IrqHandler
;	-----------------------------------------
_Serial1IrqHandler:
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
;	tinibios.c:396: if (RI_1) {
	jnb  _RI_1,00104$
00112$:
;	tinibios.c:397: receive1Buffer[receive1BufferHead]=SBUF1;
	mov	dptr,#_receive1BufferHead
	movx	a,@dptr
	add	a,#_receive1Buffer
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#(_receive1Buffer >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_receive1Buffer >> 16)
	mov	dpx1,a
	mov	a,_SBUF1
	inc	dps
	movx	@dptr,a
	mov	dps,#0
;	tinibios.c:398: receive1BufferHead=(receive1BufferHead+1)&(S1RBS-1);
	mov	dptr,#_receive1BufferHead
	movx	a,@dptr
	add	a,#0x01
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	mov	dptr,#_receive1BufferHead
	mov	a,#0x3F
	anl	a,r2
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	tinibios.c:399: if (receive1BufferHead==receive1BufferTail) /* buffer overrun, sorry :) */
	mov	dptr,#_receive1BufferTail
	mov     dps, #1
	mov     dptr, #_receive1BufferHead
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
;	tinibios.c:400: receive1BufferTail=(receive1BufferTail+1)&(S1RBS-1);
	mov	dptr,#_receive1BufferTail
	movx	a,@dptr
	add	a,#0x01
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	mov	dptr,#_receive1BufferTail
	mov	a,#0x3F
	anl	a,r2
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
00102$:
;	tinibios.c:401: RI_1=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_1
00104$:
;	tinibios.c:403: if (TI_1) {
;	tinibios.c:404: TI_1=0;
;	genAssign: resultIsFar = FALSE
	jbc     _TI_1,00115$
	sjmp    00107$
00115$:
;	tinibios.c:405: transmit1IsBusy=0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_transmit1IsBusy
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
;Allocation info for local variables in function 'Serial1CharArrived'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:409: char Serial1CharArrived(void)
;	-----------------------------------------
;	 function Serial1CharArrived
;	-----------------------------------------
_Serial1CharArrived:
;	tinibios.c:411: if (serial1Buffered) {
	mov	a,_serial1Buffered
	jz  00106$
00113$:
;	tinibios.c:412: if (receive1BufferHead!=receive1BufferTail)
	mov	dptr,#_receive1BufferTail
	mov     dps, #1
	mov     dptr, #_receive1BufferHead
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
;	tinibios.c:413: return receive1Buffer[receive1BufferTail];
	mov	dptr,#_receive1BufferTail
	movx	a,@dptr
	add	a,#_receive1Buffer
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#(_receive1Buffer >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_receive1Buffer >> 16)
	mov	dpx1,a
	inc	dps
	movx	a,@dptr
	mov	r2,a
	mov	dps,#0
	mov	dpl,r2
	sjmp 00108$
00106$:
;	tinibios.c:415: if (RI_1)
	jnb  _RI_1,00107$
00115$:
;	tinibios.c:416: return SBUF1;
;	genAssign: resultIsFar = FALSE
	mov	r2,_SBUF1
	mov	dpl,r2
;	tinibios.c:418: return 0;
	ret
00107$:
	mov     dpl,#0x00
00108$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1PutChar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	tinibios.c:421: void Serial1PutChar (char c)
;	-----------------------------------------
;	 function Serial1PutChar
;	-----------------------------------------
_Serial1PutChar:
	mov	r2,dpl
;	tinibios.c:423: if (serial1Buffered) {
	mov	a,_serial1Buffered
	jz  00104$
00116$:
;	tinibios.c:424: while (transmit1IsBusy)
00101$:
	mov	dptr,#_transmit1IsBusy
	movx	a,@dptr
	jnz  00101$
00117$:
;	tinibios.c:426: transmit1IsBusy=1;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_transmit1IsBusy
	mov	a,#0x01
	movx	@dptr,a
;	tinibios.c:427: SBUF1=c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF1,r2
;	tinibios.c:429: while (!TI_1)
	sjmp 00110$
00104$:
	jnb  _TI_1,00104$
00118$:
;	tinibios.c:431: SBUF1=c;
;	genAssign: resultIsFar = FALSE
	mov	_SBUF1,r2
;	tinibios.c:432: TI_1=0;
;	genAssign: resultIsFar = FALSE
	clr	_TI_1
00110$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1GetChar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	tinibios.c:436: char Serial1GetChar (void)
;	-----------------------------------------
;	 function Serial1GetChar
;	-----------------------------------------
_Serial1GetChar:
;	tinibios.c:439: if (serial1Buffered) {
	mov	a,_serial1Buffered
	jz  00104$
00116$:
;	tinibios.c:440: while (receive1BufferHead==receive1BufferTail)
00101$:
	mov	dptr,#_receive1BufferTail
	mov     dps, #1
	mov     dptr, #_receive1BufferHead
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
;	tinibios.c:442: c=receive1Buffer[receive1BufferTail];
	mov	dptr,#_receive1BufferTail
	movx	a,@dptr
	add	a,#_receive1Buffer
	mov	dpl1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#(_receive1Buffer >> 8)
	mov	dph1,a
	clr	a
	addc	a,#(_receive1Buffer >> 16)
	mov	dpx1,a
	inc	dps
	movx	a,@dptr
	mov	r2,a
	mov	dps,#0
;	genAssign: resultIsFar = TRUE
;	tinibios.c:443: ES1=0; // disable serial interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES1
;	tinibios.c:444: receive1BufferTail=(receive1BufferTail+1)&(S1RBS-1);
	mov	dptr,#_receive1BufferTail
	movx	a,@dptr
	add	a,#0x01
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	mov	dptr,#_receive1BufferTail
	mov	a,#0x3F
	anl	a,r3
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	tinibios.c:445: ES1=1; // enable serial interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ES1
;	tinibios.c:447: while (!RI_1)
	sjmp 00109$
00104$:
	jnb  _RI_1,00104$
00118$:
;	tinibios.c:449: c=SBUF1;
;	genAssign: resultIsFar = TRUE
	mov	r2,_SBUF1
;	tinibios.c:450: RI_1=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_1
00109$:
;	tinibios.c:452: return c;
	mov	dpl,r2
00110$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1SendBreak'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:455: void Serial1SendBreak()
;	-----------------------------------------
;	 function Serial1SendBreak
;	-----------------------------------------
_Serial1SendBreak:
;	tinibios.c:457: P5 &= ~0x08;
	anl	_P5,#0xF7
;	tinibios.c:458: ClockMilliSecondsDelay(2);
	mov	dptr,#0x000002
	mov	b,#0x00
	lcall	_ClockMilliSecondsDelay
;	tinibios.c:459: P5 |= 0x08;
	orl	_P5,#0x08
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Serial1Flush'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:462: void Serial1Flush()
;	-----------------------------------------
;	 function Serial1Flush
;	-----------------------------------------
_Serial1Flush:
;	tinibios.c:464: ES1=0; // disable interrupts
;	genAssign: resultIsFar = FALSE
	clr	_ES1
;	tinibios.c:465: receive1BufferHead=receive1BufferTail=0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_receive1BufferTail
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_receive1BufferHead
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	tinibios.c:466: RI_1=0;
;	genAssign: resultIsFar = FALSE
	clr	_RI_1
;	tinibios.c:467: if (serial1Buffered) {
	mov	a,_serial1Buffered
	jz  00102$
00107$:
;	tinibios.c:468: TI_1=0;
;	genAssign: resultIsFar = FALSE
	clr	_TI_1
;	tinibios.c:469: ES1=1; // enable interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ES1
	sjmp 00104$
00102$:
;	tinibios.c:471: TI_1=1;
;	genAssign: resultIsFar = FALSE
	setb	_TI_1
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockInit'
;------------------------------------------------------------
;timerReloadValue          Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:481: void ClockInit()
;	-----------------------------------------
;	 function ClockInit
;	-----------------------------------------
_ClockInit:
;	tinibios.c:485: switch (cpuSpeed) {
	mov	dptr,#_cpuSpeed
	movx	a,@dptr
	cjne	a,#0x01,00111$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00111$
	sjmp 00104$
00111$:
	mov	dptr,#_cpuSpeed
	movx	a,@dptr
	cjne	a,#0x02,00112$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00112$
	sjmp 00104$
00112$:
	mov	dptr,#_cpuSpeed
	movx	a,@dptr
	cjne	a,#0x04,00113$
	inc	dptr
	movx	a,@dptr
	cjne	a,#0x00,00113$
	sjmp	00114$
00113$:
	sjmp 00104$
00114$:
;	tinibios.c:486: case 4: timerReloadValue/=4; break;
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
	mov	r3,#0x12
	mov	r4,#0x00
	mov	r5,#0x00
;	tinibios.c:489: default: timerReloadValue/=2; break;
	sjmp 00105$
00104$:
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
	mov	r3,#0x24
	mov	r4,#0x00
	mov	r5,#0x00
;	tinibios.c:490: }
00105$:
;	tinibios.c:491: timer0ReloadValue=~timerReloadValue;
	mov	a,r2
	cpl	a
	mov	r2,a
	mov	a,r3
	cpl	a
	mov	r3,a
	mov	a,r4
	cpl	a
	mov	r4,a
	mov	a,r5
	cpl	a
	mov	r5,a
	mov	_timer0ReloadValue,r2
	mov	(_timer0ReloadValue + 1),r3
;	tinibios.c:493: ET0=0; // disable timer interrupts initially
;	genAssign: resultIsFar = FALSE
	clr	_ET0
;	tinibios.c:494: TCON = (TCON&0xcc)|0x00; // stop timer, clear overflow
	anl	_TCON,#0xCC
;	tinibios.c:495: TMOD = (TMOD&0xf0)|0x01; // 16 bit counter
	mov	a,#0xF0
	anl	a,_TMOD
	mov	r2,a
	mov	a,#0x01
	orl	a,r2
	mov	_TMOD,a
;	tinibios.c:496: CKCON|=0x08; // timer uses xtal/4
	orl	_CKCON,#0x08
;	tinibios.c:498: TL0=timer0ReloadValue&0xff;
	mov	r2,_timer0ReloadValue
	mov	r3,#0
	mov	_TL0,r2
;	tinibios.c:499: TH0=timer0ReloadValue>>8;
	mov	r2,(_timer0ReloadValue + 1)
	mov	r3,#0
	mov	_TH0,r2
;	tinibios.c:501: ET0=1; // enable timer interrupts
;	genAssign: resultIsFar = FALSE
	setb	_ET0
;	tinibios.c:502: TR0=1; // start timer
;	genAssign: resultIsFar = FALSE
	setb	_TR0
00106$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockIrqHandler'
;------------------------------------------------------------
;------------------------------------------------------------
;	tinibios.c:516: void ClockIrqHandler (void) __interrupt 1 __naked
;	-----------------------------------------
;	 function ClockIrqHandler
;	-----------------------------------------
_ClockIrqHandler:
;	naked function: no prologue.
;	tinibios.c:535: __endasm;
	
	    push acc
	    push psw
	    mov _TL0,_timer0ReloadValue
	    mov _TH0,_timer0ReloadValue+1
	    clr a
	    inc _milliSeconds+0
	    cjne a,_milliSeconds+0,_ClockIrqHandlerDone
	    inc _milliSeconds+1
	    cjne a,_milliSeconds+1,_ClockIrqHandlerDone
	    inc _milliSeconds+2
	    cjne a,_milliSeconds+2,_ClockIrqHandlerDone
	    inc _milliSeconds+3
	  _ClockIrqHandlerDone:
	    pop psw
	    pop acc
	    reti
	  
00101$:
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockTicks'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:540: unsigned long ClockTicks(void)
;	-----------------------------------------
;	 function ClockTicks
;	-----------------------------------------
_ClockTicks:
;	tinibios.c:543: ET0=0;
;	genAssign: resultIsFar = FALSE
	clr	_ET0
;	tinibios.c:544: ms=milliSeconds;
;	genAssign: resultIsFar = TRUE
	mov	r2,_milliSeconds
	mov	r3,(_milliSeconds + 1)
	mov	r4,(_milliSeconds + 2)
	mov	r5,(_milliSeconds + 3)
;	tinibios.c:545: ET0=1;
;	genAssign: resultIsFar = FALSE
	setb	_ET0
;	tinibios.c:546: return ms;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ClockMilliSecondsDelay'
;------------------------------------------------------------
;delay                     Allocated to registers r2 r3 r4 r5 
;ms                        Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	tinibios.c:549: void ClockMilliSecondsDelay(unsigned long delay)
;	-----------------------------------------
;	 function ClockMilliSecondsDelay
;	-----------------------------------------
_ClockMilliSecondsDelay:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	tinibios.c:551: long ms=ClockTicks()+delay;
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_ClockTicks
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
;	tinibios.c:553: while (ms>ClockTicks())
;	genAssign: resultIsFar = FALSE
00101$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_ClockTicks
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
;Allocation info for local variables in function 'ClockMicroSecondsDelay'
;------------------------------------------------------------
;delay                     Allocated to registers 
;------------------------------------------------------------
;	tinibios.c:558: void ClockMicroSecondsDelay(unsigned int delay)
;	-----------------------------------------
;	 function ClockMicroSecondsDelay
;	-----------------------------------------
_ClockMicroSecondsDelay:
;	tinibios.c:591: __endasm;
	
	
    ; delay is in dpl/dph
	    mov r0, dpl
	    mov r1, dph
	
	    mov a, r0
	    orl a, r1 ; quick out for zero case.
	    jz _usDelayDone
	
	    inc r1
	    cjne r0, #0, _usDelayLoop
	    dec r1
	
	  _usDelayLoop:
	    nop
	    nop
	    nop
	    nop
	    nop
	    nop
	    nop ; 7 nops
	    djnz r0, _usDelayLoop ; 3 cycles x 1 = 3 cycles
    ; 10 cycles per iter
    ; we want 9.216, but more is better
    ; than less.
	    djnz r1, _usDelayLoop
	  _usDelayDone:
	
	  
00101$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
__xinit__receive0BufferHead:
	.byte #0x00,#0x00	;  0
__xinit__receive0BufferTail:
	.byte #0x00,#0x00	;  0
__xinit__transmit0IsBusy:
	.db #0x00	;  0
__xinit__receive1BufferHead:
	.byte #0x00,#0x00	;  0
__xinit__receive1BufferTail:
	.byte #0x00,#0x00	;  0
__xinit__transmit1IsBusy:
	.db #0x00	;  0
	.area CABS    (ABS,CODE)
