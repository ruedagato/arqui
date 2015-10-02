;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module i2c390
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
	.globl _i2c_recv
	.globl _I2CByteIn
	.globl _ByteOutI2C
	.globl _BitInI2C
	.globl _BitOutI2C
	.globl _I2CDelay
	.globl _I2CSendReceive_PARM_3
	.globl _I2CSendReceive_PARM_2
	.globl _i2c_recv_PARM_2
	.globl _I2CSendStop_PARM_3
	.globl _I2CSendStop_PARM_2
	.globl _i2cReceiveBuffer
	.globl _i2cTransmitBuffer
	.globl _I2CReset
	.globl _I2CStart
	.globl _I2CStop
	.globl _I2CSendStop
	.globl _I2CSendReceive
	.globl _I2CDumpError
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
_i2cTransmitBuffer::
	.ds 128
_i2cReceiveBuffer::
	.ds 128
_I2CDelay_delay_1_1:
	.ds 4
_I2CSendStop_PARM_2:
	.ds 1
_I2CSendStop_PARM_3:
	.ds 1
_i2c_recv_PARM_2:
	.ds 1
_I2CSendReceive_PARM_2:
	.ds 1
_I2CSendReceive_PARM_3:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
_i2cError:
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
;Allocation info for local variables in function 'I2CDelay'
;------------------------------------------------------------
;delay                     Allocated with name '_I2CDelay_delay_1_1'
;------------------------------------------------------------
;	i2c390.c:69: void I2CDelay(volatile long delay) {
;	-----------------------------------------
;	 function I2CDelay
;	-----------------------------------------
_I2CDelay:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #_I2CDelay_delay_1_1
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
;	i2c390.c:70: while (delay--)
00101$:
	mov	dptr,#_I2CDelay_delay_1_1
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
	mov	dptr,#_I2CDelay_delay_1_1
	movx	a,@dptr
	add	a,#0xFF
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r1,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_I2CDelay_delay_1_1
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
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00101$
00107$:
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CReset'
;------------------------------------------------------------
;------------------------------------------------------------
;	i2c390.c:81: char I2CReset(void)
;	-----------------------------------------
;	 function I2CReset
;	-----------------------------------------
_I2CReset:
;	i2c390.c:83: SDA_LOW;
;	i2c390.c:84: SCL_LOW;
	anl  _P5,#(0xFD & 0xFE)
;	i2c390.c:85: SCL_HIGH;
	orl	_P5,#0x01
;	i2c390.c:86: SDA_HIGH;
	orl	_P5,#0x02
;	i2c390.c:87: i2cError = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_i2cError
	clr  a
	movx	@dptr,a
;	i2c390.c:88: return (SCL_IN && SDA_IN);
	mov	a,_P5
	jnb  acc.0,00103$
00107$:
	mov	a,_P5
	clr	c
	rrc	a
	mov  r2,a
	jb   acc.0,00104$
00108$:
00103$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	sjmp 00105$
00104$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x01
00105$:
	mov	dpl,r2
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CStart'
;------------------------------------------------------------
;------------------------------------------------------------
;	i2c390.c:97: char I2CStart(void)
;	-----------------------------------------
;	 function I2CStart
;	-----------------------------------------
_I2CStart:
;	i2c390.c:99: SDA_HIGH;
	orl	_P5,#0x02
;	i2c390.c:100: SCL_HIGH;
	orl	_P5,#0x01
;	i2c390.c:101: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:102: SDA_LOW;        /* Pull SDA down... */
	anl	_P5,#0xFD
;	i2c390.c:103: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:104: SCL_LOW;        /* ...and then SCL -> start condition. */
	anl	_P5,#0xFE
;	i2c390.c:105: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:106: return 0;
	mov	dpl,#0x00
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CStop'
;------------------------------------------------------------
;------------------------------------------------------------
;	i2c390.c:115: char I2CStop(void)
;	-----------------------------------------
;	 function I2CStop
;	-----------------------------------------
_I2CStop:
;	i2c390.c:117: SDA_LOW;
	anl	_P5,#0xFD
;	i2c390.c:118: SCL_HIGH;        /* Let SCL go up */
	orl	_P5,#0x01
;	i2c390.c:119: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:120: SDA_HIGH;        /* ...and then SDA up -> stop condition. */
	orl	_P5,#0x02
;	i2c390.c:121: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:123: return (SCL_IN && SDA_IN);  /* Both will be up, if everything is fine */
	mov	a,_P5
	jnb  acc.0,00103$
00107$:
	mov	a,_P5
	clr	c
	rrc	a
	mov  r2,a
	jb   acc.0,00104$
00108$:
00103$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	sjmp 00105$
00104$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x01
00105$:
	mov	dpl,r2
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'BitOutI2C'
;------------------------------------------------------------
;bout                      Allocated to registers r2 
;------------------------------------------------------------
;	i2c390.c:132: char BitOutI2C(unsigned char bout)
;	-----------------------------------------
;	 function BitOutI2C
;	-----------------------------------------
_BitOutI2C:
	mov	r2,dpl
;	i2c390.c:134: SDA_OUT(bout);              /* Put data out on SDA */
	mov	a,r2
	jz  00108$
00114$:
	orl	_P5,#0x02
	sjmp 00109$
00108$:
	anl	_P5,#0xFD
00109$:
;	i2c390.c:135: I2CDelay(I2CDELAY);
	push	ar2
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
	pop	ar2
;	i2c390.c:136: SCL_HIGH;                   /* Let SCL go up */
	orl	_P5,#0x01
;	i2c390.c:137: while(!SCL_IN)              /* Wait until all other devices are ready */
00101$:
	mov	a,_P5
	jnb  acc.0,00101$
00115$:
;	i2c390.c:142: if (SDA_IN != bout)         /* Arbitration lost, release bus and return */
	mov	a,_P5
	clr	c
	rrc	a
	anl  a,#0x01
	mov  r3,a
	cjne	a,ar2,00116$
	sjmp 00105$
00116$:
;	i2c390.c:144: SDA_HIGH;               /* Should be up anyway, but make sure */
	orl	_P5,#0x02
;	i2c390.c:145: i2cError = I2CERR_LOST;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_i2cError
	mov	a,#0x02
	movx	@dptr,a
;	i2c390.c:146: I2CDumpError(i2cError);
	mov	dpl,#0x02
	lcall	_I2CDumpError
;	i2c390.c:147: return 1;
	mov	dpl,#0x01
	sjmp 00106$
00105$:
;	i2c390.c:149: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:150: SCL_LOW;                    /* Pull SCL back down */
	anl	_P5,#0xFE
;	i2c390.c:151: I2CDelay(I2CDELAY);
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
;	i2c390.c:152: return 0;                   /* OK */
	mov	dpl,#0x00
00106$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'BitInI2C'
;------------------------------------------------------------
;bin                       Allocated to registers r2 
;------------------------------------------------------------
;	i2c390.c:160: char BitInI2C(void)
;	-----------------------------------------
;	 function BitInI2C
;	-----------------------------------------
_BitInI2C:
;	i2c390.c:165: SDA_HIGH;
	orl	_P5,#0x02
;	i2c390.c:167: SCL_HIGH;                   /* Let SCL go up */
	orl	_P5,#0x01
;	i2c390.c:168: while(!SCL_IN)              /* Wait for other devices */
00101$:
	mov	a,_P5
	jnb  acc.0,00101$
00108$:
;	i2c390.c:172: bin = SDA_IN;               /* Read in data */
	mov	a,_P5
	clr	c
	rrc	a
	mov	r2,a
	anl	ar2,#0x01
;	i2c390.c:173: I2CDelay(I2CDELAY);
	push	ar2
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
	pop	ar2
;	i2c390.c:174: SCL_LOW;                    /* Pull SCL back up */
	anl	_P5,#0xFE
;	i2c390.c:175: I2CDelay(I2CDELAY);
	push	ar2
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
	pop	ar2
;	i2c390.c:176: return bin;                 /* Return the sampled bit */
	mov	dpl,r2
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ByteOutI2C'
;------------------------------------------------------------
;dat                       Allocated to registers r2 
;bit_count                 Allocated to registers 
;------------------------------------------------------------
;	i2c390.c:187: char ByteOutI2C(char dat)
;	-----------------------------------------
;	 function ByteOutI2C
;	-----------------------------------------
_ByteOutI2C:
	mov	r2,dpl
;	i2c390.c:192: while(bit_count) {
;	genAssign: resultIsFar = FALSE
	mov	r3,#0x08
00108$:
	mov	a,r3
	jz  00110$
00121$:
;	i2c390.c:193: if (dat & 0x80) {
	mov	a,r2
	jnb  acc.7,00106$
00122$:
;	i2c390.c:194: if (BitOutI2C(1)) {
	push	ar2
	push	ar3
	mov	dpl,#0x01
	lcall	_BitOutI2C
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00107$
00123$:
;	i2c390.c:195: I2CDumpError(i2cError);
	mov	dptr,#_i2cError
	movx	a,@dptr
	mov	dpl,a
	lcall	_I2CDumpError
;	i2c390.c:196: return 1;
	mov	dpl,#0x01
	sjmp 00113$
00106$:
;	i2c390.c:199: if (BitOutI2C(0)) {
	push	ar2
	push	ar3
	mov	dpl,#0x00
	lcall	_BitOutI2C
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00107$
00124$:
;	i2c390.c:200: I2CDumpError(i2cError);
	mov	dptr,#_i2cError
	movx	a,@dptr
	mov	dpl,a
	lcall	_I2CDumpError
;	i2c390.c:201: return 1;
	mov	dpl,#0x01
	sjmp 00113$
00107$:
;	i2c390.c:204: dat <<= 1;
	mov	a,r2
	add	a,acc
	mov	r4,a
;	genAssign: resultIsFar = TRUE
	mov	ar2,r4
;	i2c390.c:205: bit_count--;
	dec	r3
	sjmp 00108$
00110$:
;	i2c390.c:208: if (BitInI2C()) {
	lcall	_BitInI2C
	mov	a,dpl
	jz  00112$
00125$:
;	i2c390.c:209: i2cError = I2CERR_NAK;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_i2cError
	mov	a,#0x01
	movx	@dptr,a
;	i2c390.c:210: I2CDumpError(i2cError);
	mov	dpl,#0x01
	lcall	_I2CDumpError
;	i2c390.c:211: return 1;
	mov	dpl,#0x01
;	i2c390.c:213: return 0;
	ret
00112$:
	mov     dpl,#0x00
00113$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CByteIn'
;------------------------------------------------------------
;ack                       Allocated to registers r2 
;bit_count                 Allocated to registers 
;byte_in                   Allocated to registers r3 
;------------------------------------------------------------
;	i2c390.c:224: char I2CByteIn(char ack)
;	-----------------------------------------
;	 function I2CByteIn
;	-----------------------------------------
_I2CByteIn:
	mov	r2,dpl
;	i2c390.c:229: byte_in = 0;
;	genAssign: resultIsFar = TRUE
	mov	r3,#0x00
;	i2c390.c:231: while(bit_count)
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x08
00103$:
	mov	a,r4
	jz  00105$
00112$:
;	i2c390.c:233: byte_in <<= 1;
	mov	a,r3
	add	a,acc
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	ar3,r5
;	i2c390.c:234: if (BitInI2C()) byte_in |= 0x01;
	push	ar2
	push	ar3
	push	ar4
	lcall	_BitInI2C
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00102$
00113$:
	orl	ar3,#0x01
00102$:
;	i2c390.c:235: bit_count--;
	dec	r4
	sjmp 00103$
00105$:
;	i2c390.c:238: BitOutI2C(ack);
	push	ar3
	mov	dpl,r2
	lcall	_BitOutI2C
	pop	ar3
;	i2c390.c:239: SDA_HIGH;             /* Added 18-Jul-95 - thanks to Ray Bellis */
	orl	_P5,#0x02
;	i2c390.c:240: return byte_in;
	mov	dpl,r3
00106$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CSendStop'
;------------------------------------------------------------
;count                     Allocated with name '_I2CSendStop_PARM_2'
;send_stop                 Allocated with name '_I2CSendStop_PARM_3'
;addr                      Allocated to registers r2 
;byteptr                   Allocated to registers 
;byte_out                  Allocated to registers r2 
;------------------------------------------------------------
;	i2c390.c:249: char I2CSendStop(char addr, char count, char send_stop)
;	-----------------------------------------
;	 function I2CSendStop
;	-----------------------------------------
_I2CSendStop:
	mov	r2,dpl
;	i2c390.c:253: if (I2CStart()) return 1;
	push	ar2
	lcall	_I2CStart
	pop	ar2
	mov	a,dpl
	jz  00102$
00122$:
	mov	dpl,#0x01
	sjmp 00113$
00102$:
;	i2c390.c:254: i2cError = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_i2cError
	clr  a
	movx	@dptr,a
;	i2c390.c:256: byte_out = addr & 0xfe;     /* Ensure that it's a write address */
	anl	ar2,#0xFE
;	i2c390.c:257: count++;                    /* Include slave address to byte count */
	mov	dptr,#_I2CSendStop_PARM_2
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
;	i2c390.c:259: while(count)
;	genAssign: resultIsFar = FALSE
	mov	r3,#0x00
	mov	dptr,#_I2CSendStop_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
00108$:
	mov	a,r4
	jz  00110$
00123$:
;	i2c390.c:261: if (ByteOutI2C(byte_out))
	push	ar3
	push	ar4
	mov	dpl,r2
	lcall	_ByteOutI2C
	pop	ar4
	pop	ar3
	mov	a,dpl
	jz  00107$
00124$:
;	i2c390.c:263: if (i2cError == I2CERR_NAK && send_stop) I2CStop();
	mov	dptr,#_i2cError
	movx	a,@dptr
	cjne a,#0x01,00104$
00126$:
	mov	dptr,#_I2CSendStop_PARM_3
	movx	a,@dptr
	jz  00104$
00127$:
	lcall	_I2CStop
00104$:
;	i2c390.c:264: return i2cError;
	mov     dps, #1
	mov     dptr, #_i2cError
	movx	a,@dptr
	mov	dpl,a
	mov	dps,#0
	sjmp 00113$
00107$:
;	i2c390.c:266: byte_out = i2cTransmitBuffer[byteptr];
	mov	a,r3
	add	a,#_i2cTransmitBuffer
	mov	dpl,a
	clr	a
	addc	a,#(_i2cTransmitBuffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_i2cTransmitBuffer >> 16)
	mov	dpx,a
	movx	a,@dptr
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	ar2,r5
;	i2c390.c:267: byteptr++;
	inc	r3
;	i2c390.c:268: count--;
	dec	r4
	sjmp 00108$
00110$:
;	i2c390.c:271: if (send_stop) I2CStop();
	mov	dptr,#_I2CSendStop_PARM_3
	movx	a,@dptr
	jz  00112$
00128$:
	lcall	_I2CStop
00112$:
;	i2c390.c:272: return 0;
	mov	dpl,#0x00
00113$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'i2c_recv'
;------------------------------------------------------------
;count                     Allocated with name '_i2c_recv_PARM_2'
;addr                      Allocated to registers r2 
;byteptr                   Allocated to registers 
;byte_in                   Allocated to registers r2 
;------------------------------------------------------------
;	i2c390.c:281: char i2c_recv(char addr, char count)
;	-----------------------------------------
;	 function i2c_recv
;	-----------------------------------------
_i2c_recv:
	mov	r2,dpl
;	i2c390.c:285: if (I2CStart()) return 1;
	push	ar2
	lcall	_I2CStart
	pop	ar2
	mov	a,dpl
	jz  00102$
00125$:
	mov	dpl,#0x01
	ljmp	00113$
00102$:
;	i2c390.c:286: i2cError = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_i2cError
	clr  a
	movx	@dptr,a
;	i2c390.c:289: byte_in = addr | 0x01;
	orl	ar2,#0x01
;	i2c390.c:291: if (ByteOutI2C(byte_in))
	mov	dpl,r2
	lcall	_ByteOutI2C
	mov	a,dpl
	jz  00122$
00126$:
;	i2c390.c:293: if (i2cError == I2CERR_NAK) I2CStop();
	mov	dptr,#_i2cError
	movx	a,@dptr
	cjne a,#0x01,00104$
00128$:
	lcall	_I2CStop
00104$:
;	i2c390.c:294: return i2cError;
	mov     dps, #1
	mov     dptr, #_i2cError
	movx	a,@dptr
	mov	dpl,a
	mov	dps,#0
;	i2c390.c:297: while(count)
	sjmp 00113$
00122$:
	mov	dptr,#_i2c_recv_PARM_2
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x00
00110$:
	mov	a,r3
	jz  00112$
00129$:
;	i2c390.c:299: count-=1;
	dec	r3
;	i2c390.c:300: if (count) {
	mov	a,r3
	jz  00108$
00130$:
;	i2c390.c:301: byte_in = I2CByteIn(0);
	push	ar3
	push	ar4
	mov	dpl,#0x00
	lcall	_I2CByteIn
	mov	r5,dpl
	pop	ar4
	pop	ar3
;	genAssign: resultIsFar = TRUE
	mov	ar2,r5
	sjmp 00109$
00108$:
;	i2c390.c:303: byte_in = I2CByteIn(1);   /* No ACK during last byte */
	push	ar3
	push	ar4
	mov	dpl,#0x01
	lcall	_I2CByteIn
	mov	r5,dpl
	pop	ar4
	pop	ar3
;	genAssign: resultIsFar = TRUE
	mov	ar2,r5
00109$:
;	i2c390.c:305: i2cReceiveBuffer[byteptr] = byte_in;
	mov	a,r4
	add	a,#_i2cReceiveBuffer
	mov	dpl,a
	clr	a
	addc	a,#(_i2cReceiveBuffer >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_i2cReceiveBuffer >> 16)
	mov	dpx,a
	mov	a,r2
	movx	@dptr,a
;	i2c390.c:306: byteptr++;
	inc	r4
	sjmp 00110$
00112$:
;	i2c390.c:309: I2CStop();
	lcall	_I2CStop
;	i2c390.c:311: return (i2cError ? 1 : 0);
	mov	dptr,#_i2cError
	movx	a,@dptr
	jz  00115$
00131$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x01
	sjmp 00116$
00115$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
00116$:
	mov	dpl,r2
00113$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CSendReceive'
;------------------------------------------------------------
;tx_count                  Allocated with name '_I2CSendReceive_PARM_2'
;rx_count                  Allocated with name '_I2CSendReceive_PARM_3'
;addr                      Allocated to registers r2 
;------------------------------------------------------------
;	i2c390.c:322: char I2CSendReceive(char addr, char tx_count, char rx_count)
;	-----------------------------------------
;	 function I2CSendReceive
;	-----------------------------------------
_I2CSendReceive:
	mov	r2,dpl
;	i2c390.c:324: if (I2CSendStop(addr, tx_count, 0))
	mov	dptr,#_I2CSendReceive_PARM_2
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	dptr,#_I2CSendStop_PARM_2
	movx	@dptr,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_I2CSendStop_PARM_3
	clr  a
	movx	@dptr,a
	push	ar2
	mov	dpl,r2
	lcall	_I2CSendStop
	pop	ar2
	mov	a,dpl
	jz  00104$
00115$:
;	i2c390.c:329: if (i2cError != I2CERR_LOST) I2CStop();
	mov	dptr,#_i2cError
	movx	a,@dptr
	cjne	a,#0x02,00116$
	sjmp 00102$
00116$:
	lcall	_I2CStop
00102$:
;	i2c390.c:330: return 1;
	mov	dpl,#0x01
	sjmp 00107$
00104$:
;	i2c390.c:333: SDA_HIGH; /* One of these may be low now, in which case the next */
	orl	_P5,#0x02
;	i2c390.c:334: SCL_HIGH; /* start condition wouldn't be detected so make */
	orl	_P5,#0x01
;	i2c390.c:335: I2CDelay(I2CDELAY); /*   sure that they're up and wait for one delay slot */
	push	ar2
	mov	dptr,#0x000001
	mov	b,#0x00
	lcall	_I2CDelay
	pop	ar2
;	i2c390.c:337: if (i2c_recv((char)(addr|0x01), rx_count)) return 1;
	orl	ar2,#0x01
	mov	dptr,#_I2CSendReceive_PARM_3
;	genAssign: resultIsFar = TRUE
	movx	a,@dptr
	mov	dptr,#_i2c_recv_PARM_2
	movx	@dptr,a
	mov	dpl,r2
	lcall	_i2c_recv
	mov	a,dpl
	jz  00106$
00117$:
	mov	dpl,#0x01
	sjmp 00107$
00106$:
;	i2c390.c:338: return (i2cError ? 1 : 0);
	mov	dptr,#_i2cError
	movx	a,@dptr
	jz  00109$
00118$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x01
	sjmp 00110$
00109$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
00110$:
	mov	dpl,r2
00107$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2CDumpError'
;------------------------------------------------------------
;error                     Allocated to registers 
;------------------------------------------------------------
;	i2c390.c:345: void I2CDumpError(char error)
;	-----------------------------------------
;	 function I2CDumpError
;	-----------------------------------------
_I2CDumpError:
;	i2c390.c:370: error; // hush the compiler
00101$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
__xinit__i2cError:
	.db #0x00	;  0
	.area CABS    (ABS,CODE)
