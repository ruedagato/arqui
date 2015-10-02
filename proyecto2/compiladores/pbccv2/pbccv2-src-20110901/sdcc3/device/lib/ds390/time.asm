;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module time
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
	.globl ___day
	.globl ___month
	.globl _time
	.globl _asctime
	.globl _ctime
	.globl _localtime
	.globl _gmtime
	.globl _mktime
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
_time_timeptr_1_1:
	.ds 4
_time_now_1_1:
	.ds 12
_ascTimeBuffer:
	.ds 32
_CheckTime_sloc0_1_0:
	.ds 1
_asctime_timeptr_1_1:
	.ds 4
_asctime_sloc0_1_0:
	.ds 2
_asctime_sloc1_1_0:
	.ds 2
_asctime_sloc2_1_0:
	.ds 2
_asctime_sloc3_1_0:
	.ds 2
_asctime_sloc4_1_0:
	.ds 2
_lastTime:
	.ds 12
_gmtime_epoch_1_1:
	.ds 4
_mktime_timeptr_1_1:
	.ds 4
_mktime_year_1_1:
	.ds 2
_mktime_month_1_1:
	.ds 2
_mktime_seconds_1_1:
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
;Allocation info for local variables in function 'time'
;------------------------------------------------------------
;timeptr                   Allocated with name '_time_timeptr_1_1'
;now                       Allocated with name '_time_now_1_1'
;t                         Allocated to registers r6 r7 r0 r1 
;------------------------------------------------------------
;	time.c:50: time_t time(time_t *timeptr) {
;	-----------------------------------------
;	 function time
;	-----------------------------------------
_time:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #_time_timeptr_1_1
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
;	time.c:52: time_t t=-1;
;	genAssign: resultIsFar = TRUE
	mov	r6,#0xFF
	mov	r7,#0xFF
	mov	r0,#0xFF
	mov	r1,#0xFF
;	time.c:54: if (RtcRead(&now)) {
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov dptr,#_time_now_1_1
	mov	b,#0x00
	lcall	_RtcRead
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,dpl
	jz  00102$
00109$:
;	time.c:55: t=mktime(&now);
	mov dptr,#_time_now_1_1
	mov	b,#0x00
	lcall	_mktime
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
00102$:
;	time.c:57: if (timeptr) {
	mov	dptr,#_time_timeptr_1_1
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jz  00104$
00110$:
;	time.c:58: *timeptr=t;
	mov     dps, #1
	mov     dptr, #_time_timeptr_1_1
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
	mov	_ap, r6
	mov	a,r7
	lcall	__gptrputWord
	inc	dptr
	mov	_ap, r0
	mov	a,r1
	lcall	__gptrputWord
00104$:
;	time.c:60: return t;
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
00105$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'CheckTime'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 r5 
;sloc0                     Allocated with name '_CheckTime_sloc0_1_0'
;------------------------------------------------------------
;	time.c:73: static void CheckTime(struct tm *timeptr) {
;	-----------------------------------------
;	 function CheckTime
;	-----------------------------------------
_CheckTime:
;	time.c:84: if (timeptr->tm_sec>59) timeptr->tm_sec=59;
	mov     r2,dpl
	mov     r3,dph
	mov     r4,dpx
	mov     r5,b
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	clr	c
	mov	a,#0x3B
	subb	a,r6
	jnc  00102$
00128$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	mov	a,#0x3B
	lcall	__gptrput
00102$:
;	time.c:85: if (timeptr->tm_min>59) timeptr->tm_min=59;
	mov	a,#0x01
	add	a,r2
	mov	r6,a
	clr  a
	addc	a,r3
	mov	r7,a
	clr  a
	addc	a,r4
	mov	r0,a
	mov	ar1,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r2,a
	clr	c
	mov	a,#0x3B
	subb	a,r2
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnc  00104$
00129$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x3B
	lcall	__gptrput
00104$:
;	time.c:86: if (timeptr->tm_hour>23) timeptr->tm_hour=23;
	mov	a,#0x02
	add	a,r2
	mov	r6,a
	clr  a
	addc	a,r3
	mov	r7,a
	clr  a
	addc	a,r4
	mov	r0,a
	mov	ar1,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r2,a
	clr	c
	mov	a,#0x17
	subb	a,r2
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnc  00106$
00130$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x17
	lcall	__gptrput
00106$:
;	time.c:87: if (timeptr->tm_wday>6) timeptr->tm_wday=6;
	mov	a,#0x07
	add	a,r2
	mov	r6,a
	clr  a
	addc	a,r3
	mov	r7,a
	clr  a
	addc	a,r4
	mov	r0,a
	mov	ar1,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r2,a
	clr	c
	mov	a,#0x06
	subb	a,r2
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnc  00108$
00131$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x06
	lcall	__gptrput
00108$:
;	time.c:88: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
	mov	a,#0x03
	add	a,r2
	mov	r6,a
	clr  a
	addc	a,r3
	mov	r7,a
	clr  a
	addc	a,r4
	mov	r0,a
	mov	ar1,r5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	dps, #1
	mov	dptr, #_CheckTime_sloc0_1_0
	dec	dps
	lcall	__gptrget
	mov	dps,#1
	movx	@dptr,a
	mov	dps,#0
	mov	dptr,#_CheckTime_sloc0_1_0
	movx	a,@dptr
	cjne	a,#0x01,00132$
00132$:
	jnc  00112$
00133$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x01
	lcall	__gptrput
	sjmp 00113$
00112$:
;	time.c:89: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
	mov	dptr,#_CheckTime_sloc0_1_0
	clr	c
	mov	a,#0x1F
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	jnc  00113$
00134$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x1F
	lcall	__gptrput
00113$:
;	time.c:90: if (timeptr->tm_mon>11) timeptr->tm_mon=11;
	mov	a,#0x04
	add	a,r2
	mov	r6,a
	clr  a
	addc	a,r3
	mov	r7,a
	clr  a
	addc	a,r4
	mov	r0,a
	mov	ar1,r5
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov	r2,a
	clr	c
	mov	a,#0x0B
	subb	a,r2
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jnc  00115$
00135$:
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	mov	a,#0x0B
	lcall	__gptrput
00115$:
;	time.c:91: if (timeptr->tm_year<0) timeptr->tm_year=0;
	mov	a,#0x05
	add	a,r2
	mov	r2,a
	clr  a
	addc	a,r3
	mov	r3,a
	clr  a
	addc	a,r4
	mov	r4,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrgetWord
	mov	r6,a
	mov	r7,_ap
	mov	a,r7
	jnb  acc.7,00118$
00136$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	clr  a
	mov  _ap,a
	lcall	__gptrputWord
00118$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'asctime'
;------------------------------------------------------------
;timeptr                   Allocated with name '_asctime_timeptr_1_1'
;sloc0                     Allocated with name '_asctime_sloc0_1_0'
;sloc1                     Allocated with name '_asctime_sloc1_1_0'
;sloc2                     Allocated with name '_asctime_sloc2_1_0'
;sloc3                     Allocated with name '_asctime_sloc3_1_0'
;sloc4                     Allocated with name '_asctime_sloc4_1_0'
;------------------------------------------------------------
;	time.c:95: char *asctime(struct tm *timeptr) {
;	-----------------------------------------
;	 function asctime
;	-----------------------------------------
_asctime:
	mov     dps, #1
	mov     dptr, #_asctime_timeptr_1_1
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
;	time.c:96: CheckTime(timeptr);
	mov	dps, #1
	mov	dptr,#_asctime_timeptr_1_1
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
	lcall	_CheckTime
;	time.c:100: timeptr->tm_year+1900);
	mov	dptr,#_asctime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x05
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrgetWord
	mov	r6,a
	mov	r7,_ap
	mov	dptr,#_asctime_sloc4_1_0
	mov	a,#0x6C
	add	a,r6
	movx	@dptr,a
	mov	a,#0x07
	addc	a,r7
	inc	dptr
	movx	@dptr,a
;	time.c:99: timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec, 
	mov     dps, #1
	mov     dptr, #_asctime_timeptr_1_1
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
	lcall	__gptrget
	mov  r0,a
	mov  dptr,#_asctime_sloc3_1_0
	movx @dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	mov	dptr,#_asctime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x01
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r2,a
	mov  dptr,#_asctime_sloc0_1_0
	movx @dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	mov	dptr,#_asctime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x02
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r2
	mov	b,r3
	lcall	__gptrget
	mov  r4,a
	mov  dptr,#_asctime_sloc1_1_0
	movx @dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	time.c:98: __day[timeptr->tm_wday], __month[timeptr->tm_mon], timeptr->tm_mday,
	mov	dptr,#_asctime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x03
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	dpl,r3
	mov	dph,r5
	mov	dpx,r2
	mov	b,r4
	lcall	__gptrget
	mov  r3,a
	mov  dptr,#_asctime_sloc2_1_0
	movx @dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	mov	dptr,#_asctime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x04
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	mov	dpl,r4
	mov	dph,r5
	mov	dpx,r2
	mov	b,r3
	lcall	__gptrget
	mov	r4,a
	mov	b,#0x03
	mov	a,r4
	mul	ab
	mov  r4,a
	mov	b,a
	mov	dptr,#___month
	movc	a,@a+dptr
	inc	dptr
	mov	r2,a
	mov	a,b
	movc	a,@a+dptr
	inc	dptr
	mov	r3,a
	mov	a,b
	movc	a,@a+dptr
	mov	r4,a
	mov	r5,#0x80
	mov	dptr,#_asctime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x07
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	mov	b,#0x03
	mov	a,r0
	mul	ab
	mov  r0,a
	mov	b,a
	mov	dptr,#___day
	movc	a,@a+dptr
	inc	dptr
	mov	r6,a
	mov	a,b
	movc	a,@a+dptr
	inc	dptr
	mov	r7,a
	mov	a,b
	movc	a,@a+dptr
	mov	r0,a
	mov	r1,#0x80
;	time.c:97: sprintf (ascTimeBuffer, "%s %s %2d %02d:%02d:%02d %04d\n",
	mov	dptr,#_asctime_sloc4_1_0
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#_asctime_sloc3_1_0
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#_asctime_sloc0_1_0
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#_asctime_sloc1_1_0
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#_asctime_sloc2_1_0
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#(__str_0 >> 16)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_ascTimeBuffer
	push	acc
	mov	a,#(_ascTimeBuffer >> 8)
	push	acc
	mov	a,#(_ascTimeBuffer >> 16)
	push	acc
	clr  a
	push	acc
	lcall	_sprintf
	clr	c
	mov	a,sp
	subb	a,#0x1A
	mov	sp,a
	mov	a,esp
	anl	a,#3
	subb	a,#0x00
	mov	esp,a
;	time.c:101: return ascTimeBuffer;
	mov dptr,#_ascTimeBuffer
	mov	b,#0x00
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ctime'
;------------------------------------------------------------
;timep                     Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	time.c:104: char *ctime(time_t *timep) {
;	-----------------------------------------
;	 function ctime
;	-----------------------------------------
_ctime:
;	time.c:105: return asctime(localtime(timep));
	mov     r2,dpl
	mov     r3,dph
	mov     r4,dpx
	mov     r5,b
	mov	b,r5
	lcall	_localtime
	lcall	_asctime
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'localtime'
;------------------------------------------------------------
;timep                     Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	time.c:121: struct tm *localtime(time_t *timep) {
;	-----------------------------------------
;	 function localtime
;	-----------------------------------------
_localtime:
;	time.c:122: return gmtime(timep);
	mov     r2,dpl
	mov     r3,dph
	mov     r4,dpx
	mov     r5,b
	mov	b,r5
	lcall	_gmtime
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'gmtime'
;------------------------------------------------------------
;timep                     Allocated to registers 
;epoch                     Allocated with name '_gmtime_epoch_1_1'
;year                      Allocated to registers 
;month                     Allocated to registers 
;monthLength               Allocated to registers r1 
;days                      Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	time.c:125: struct tm *gmtime(time_t *timep) {
;	-----------------------------------------
;	 function gmtime
;	-----------------------------------------
_gmtime:
;	time.c:126: unsigned long epoch=*timep;
	lcall	__gptrgetWord
	mov	r2,a
	mov	r3,_ap
	inc	dptr
	lcall	__gptrgetWord
	mov	r4,a
	mov	r5,_ap
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_gmtime_epoch_1_1
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
;	time.c:131: lastTime.tm_sec=epoch%60;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modulong_PARM_2
	mov	a,#0x3C
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_gmtime_epoch_1_1
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
	mov	r6,dpl
	mov	dptr,#_lastTime
	mov	a,r6
	movx	@dptr,a
;	time.c:132: epoch/=60; // now it is minutes
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_PARM_2
	mov	a,#0x3C
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_gmtime_epoch_1_1
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
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_gmtime_epoch_1_1
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
;	time.c:133: lastTime.tm_min=epoch%60;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modulong_PARM_2
	mov	a,#0x3C
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_gmtime_epoch_1_1
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
	mov	r6,dpl
	mov	dptr,#(_lastTime + 0x000001)
	mov	a,r6
	movx	@dptr,a
;	time.c:134: epoch/=60; // now it is hours
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_PARM_2
	mov	a,#0x3C
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_gmtime_epoch_1_1
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
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_gmtime_epoch_1_1
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
;	time.c:135: lastTime.tm_hour=epoch%24;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modulong_PARM_2
	mov	a,#0x18
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_gmtime_epoch_1_1
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
	mov	r6,dpl
	mov	dptr,#(_lastTime + 0x000002)
	mov	a,r6
	movx	@dptr,a
;	time.c:136: epoch/=24; // now it is days
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__divulong_PARM_2
	mov	a,#0x18
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_gmtime_epoch_1_1
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
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_gmtime_epoch_1_1
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
;	time.c:137: lastTime.tm_wday=(epoch+4)%7;
	mov	dptr,#_gmtime_epoch_1_1
	movx	a,@dptr
	add	a,#0x04
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r1,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modulong_PARM_2
	mov	a,#0x07
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__modulong
	mov	r6,dpl
	mov	dptr,#(_lastTime + 0x000007)
	mov	a,r6
	movx	@dptr,a
;	time.c:140: days=0;
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
;	time.c:141: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
;	genAssign: resultIsFar = FALSE
	mov	r6,#0xB2
	mov	r7,#0x07
00101$:
	mov	a,#0x03
	anl	a,r6
	mov	r0,a
	mov	r1,#0
	mov	a,r0
	orl	a,r1
	cjne	a,#0x01,00134$
00134$:
	clr	a
	rlc	a
	mov  r0,a
	jz  00119$
00135$:
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x6E
	mov	r1,#0x01
	sjmp 00120$
00119$:
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x6D
	mov	r1,#0x01
00120$:
	push	ar6
	push	ar7
	mov	a,r1
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	r7,a
	mov	a,r0
	add	a,r2
	mov	r0,a
	mov	a,r1
	addc	a,r3
	mov	r1,a
	mov	a,r6
	addc	a,r4
	mov	r6,a
	mov	a,r7
	addc	a,r5
	mov	r7,a
;	genAssign: resultIsFar = FALSE
	mov	ar2,r0
	mov	ar3,r1
	mov	ar4,r6
	mov	ar5,r7
	mov	dptr,#_gmtime_epoch_1_1
	clr	c
	movx	a,@dptr
	subb	a,r0
	inc	dptr
	movx	a,@dptr
	subb	a,r1
	inc	dptr
	movx	a,@dptr
	subb	a,r6
	inc	dptr
	movx	a,@dptr
	subb	a,r7
	pop	ar7
	pop	ar6
	jc   00103$
00136$:
;	time.c:142: year++;
	inc	r6
	cjne	r6,#0,00137$
	inc	r7
00137$:
	sjmp 00101$
00103$:
;	time.c:144: lastTime.tm_year=year-1900;
	mov	a,r6
	add	a,#0x94
	mov	r0,a
	mov	a,r7
	addc	a,#0xF8
	mov	r1,a
	mov	dptr,#(_lastTime + 0x000005)
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	time.c:146: days -= LEAP_YEAR(year) ? 366 : 365;
	anl	ar6,#0x03
	mov	r7,#0
	mov	a,r6
	orl	a,r7
	cjne	a,#0x01,00138$
00138$:
	clr	a
	rlc	a
	mov  r0,a
	jz  00121$
00139$:
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x6E
	mov	r1,#0x01
	sjmp 00122$
00121$:
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x6D
	mov	r1,#0x01
00122$:
	push	ar6
	push	ar7
	mov	a,r1
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	r7,a
	clr	c
	mov	a,r2
	subb	a,r0
	mov	r2,a
	mov	a,r3
	subb	a,r1
	mov	r3,a
	mov	a,r4
	subb	a,r6
	mov	r4,a
	mov	a,r5
	subb	a,r7
	mov	r5,a
;	time.c:147: epoch -= days; // now it is days in this year, starting at 0
	mov	dptr,#_gmtime_epoch_1_1
	clr	c
	movx	a,@dptr
	subb	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	subb	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	subb	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	subb	a,r5
	movx	@dptr,a
;	time.c:148: lastTime.tm_yday=epoch;
	mov	dptr,#_gmtime_epoch_1_1
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dptr,#(_lastTime + 0x000008)
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	time.c:175: return &lastTime;
	pop	ar7
	pop	ar6
;	time.c:153: for (month=0; month<12; month++) {
;	genAssign: resultIsFar = FALSE
	mov	r0,#0x00
00113$:
	cjne	r0,#0x0C,00140$
00140$:
	jnc  00116$
00141$:
;	time.c:154: if (month==1) { // februari
	mov	a,r0
	cjne a,#0x01,00108$
00143$:
;	time.c:155: if (LEAP_YEAR(year)) {
	mov	a,r6
	orl	a,r7
	jnz  00105$
00144$:
;	time.c:156: monthLength=29;
;	genAssign: resultIsFar = TRUE
	mov	r1,#0x1D
	sjmp 00109$
00105$:
;	time.c:158: monthLength=28;
;	genAssign: resultIsFar = TRUE
	mov	r1,#0x1C
	sjmp 00109$
00108$:
;	time.c:161: monthLength = monthDays[month];
	mov	a,r0
	mov	dptr,#_monthDays
	movc	a,@a+dptr
	mov	r2,a
;	genAssign: resultIsFar = TRUE
	mov	ar1,r2
00109$:
;	time.c:164: if (epoch>=monthLength) {
	mov	ar2,r1
	mov	r3,#0
	mov	r4,#0
	mov	r5,#0
	mov	dptr,#_gmtime_epoch_1_1
	clr	c
	movx	a,@dptr
	subb	a,r2
	inc	dptr
	movx	a,@dptr
	subb	a,r3
	inc	dptr
	movx	a,@dptr
	subb	a,r4
	inc	dptr
	movx	a,@dptr
	subb	a,r5
	jc   00116$
00145$:
;	time.c:165: epoch-=monthLength;
	mov	dptr,#_gmtime_epoch_1_1
	clr	c
	movx	a,@dptr
	subb	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	subb	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	subb	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	subb	a,r5
	movx	@dptr,a
;	time.c:153: for (month=0; month<12; month++) {
	inc	r0
	sjmp 00113$
00116$:
;	time.c:170: lastTime.tm_mon=month;
	mov	dptr,#(_lastTime + 0x000004)
	mov	a,r0
	movx	@dptr,a
;	time.c:171: lastTime.tm_mday=epoch+1;
	mov	dptr,#_gmtime_epoch_1_1
	movx	a,@dptr
	inc  a
	mov  r2,a
	mov  dptr,#(_lastTime + 0x000003)
	movx @dptr,a
;	time.c:173: lastTime.tm_isdst=0;
	mov	dptr,#(_lastTime + 0x00000a)
	clr  a
	movx	@dptr,a
;	time.c:175: return &lastTime;
	mov dptr,#_lastTime
	mov	b,#0x00
00117$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'mktime'
;------------------------------------------------------------
;timeptr                   Allocated with name '_mktime_timeptr_1_1'
;year                      Allocated with name '_mktime_year_1_1'
;month                     Allocated with name '_mktime_month_1_1'
;i                         Allocated to registers 
;seconds                   Allocated with name '_mktime_seconds_1_1'
;sloc0                     Allocated with name '_mktime_sloc0_1_0'
;------------------------------------------------------------
;	time.c:179: time_t mktime(struct tm *timeptr) {
;	-----------------------------------------
;	 function mktime
;	-----------------------------------------
_mktime:
	mov     dps, #1
	mov     dptr, #_mktime_timeptr_1_1
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
;	time.c:180: int year=timeptr->tm_year+1900, month=timeptr->tm_mon, i;
	mov	dptr,#_mktime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x05
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	mov	r1,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrgetWord
	mov	r6,a
	mov	r7,_ap
	mov	dptr,#_mktime_year_1_1
	mov	a,#0x6C
	add	a,r6
	movx	@dptr,a
	mov	a,#0x07
	addc	a,r7
	inc	dptr
	movx	@dptr,a
	mov	dptr,#_mktime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x04
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r6
	mov	b,r7
	lcall	__gptrget
	mov  r0,a
	mov  dptr,#_mktime_month_1_1
	movx @dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
;	time.c:183: CheckTime(timeptr);
	inc	dps
	mov	dptr,#_mktime_timeptr_1_1
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
	lcall	_CheckTime
;	time.c:186: seconds= (year-1970)*(60*60*24L*365);
	mov	dptr,#_mktime_year_1_1
	movx	a,@dptr
	add	a,#0x4E
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xF8
	mov	r1,a
	mov	dptr,#__mullong_PARM_2
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	mov	a,r1
	rlc	a
	subb	a,acc
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	mov	dptr,#0xE13380
	mov	b,#0x01
	lcall	__mullong
	mov	r0,dpl
	mov	r1,dph
	mov	r6,dpx
	mov	r7,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_mktime_seconds_1_1
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	time.c:189: for (i=1970; i<year; i++) {
	mov	dptr,#_mktime_seconds_1_1
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
;	genAssign: resultIsFar = FALSE
	mov	r6,#0xB2
	mov	r7,#0x07
00107$:
	mov	dptr,#_mktime_year_1_1
	clr	c
	mov	a,r6
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	a,r7
	xrl	a,#0x80
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	xrl	b,#0x80
	subb	a,b
	jnc  00124$
00126$:
;	time.c:190: if (LEAP_YEAR(i)) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modsint_PARM_2
	mov	a,#0x04
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	mov	dpl,r6
	mov	dph,r7
	lcall	__modsint
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	orl	a,dph
	jnz  00109$
00127$:
;	time.c:191: seconds+= 60*60*24L;
	mov	a,#0x80
	add	a,r2
	mov	r2,a
	mov	a,#0x51
	addc	a,r3
	mov	r3,a
	mov	a,#0x01
	addc	a,r4
	mov	r4,a
	clr  a
	addc	a,r5
	mov	r5,a
00109$:
;	time.c:189: for (i=1970; i<year; i++) {
	inc	r6
	cjne	r6,#0,00128$
	inc	r7
00128$:
	sjmp 00107$
00124$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_mktime_seconds_1_1
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
;	time.c:196: for (i=0; i<month; i++) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__modsint_PARM_2
	mov	a,#0x04
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_mktime_year_1_1
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	mov	dps,#0
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x00
	mov	r5,#0x00
00111$:
	mov	dptr,#_mktime_month_1_1
	clr	c
	mov	a,r4
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	a,r5
	xrl	a,#0x80
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	xrl	b,#0x80
	subb	a,b
	jc	00129$
	ljmp	00114$
00129$:
;	time.c:197: if (i==1 && LEAP_YEAR(year)) { 
	mov	a,r4
	cjne a,#0x01,00104$
	mov  a,r5
	cjne a,#0x00,00104$
00131$:
	mov	a,r2
	orl	a,r3
	jnz  00104$
00132$:
;	time.c:198: seconds+= 60*60*24L*29;
	mov	dptr,#_mktime_seconds_1_1
	movx	a,@dptr
	add	a,#0x80
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x3B
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x26
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	sjmp 00113$
00104$:
;	time.c:200: seconds+= 60*60*24L*monthDays[i];
	push	ar2
	push	ar3
	mov	a,r4
	add	a,#_monthDays
	mov	dpl,a
	mov	a,r5
	addc	a,#(_monthDays >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_monthDays >> 16)
	mov	dpx,a
	clr	a
	movc	a,@a+dptr
	mov  r2,a
	mov  dptr,#__mullong_PARM_2
	movx @dptr,a
	mov	a,r2
	rlc	a
	subb	a,acc
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	push	ar4
	push	ar5
	mov	dptr,#0x015180
	mov	b,#0x00
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r6,dpx
	mov	r7,b
	pop	ar5
	pop	ar4
	mov	dptr,#_mktime_seconds_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r6
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r7
	movx	@dptr,a
;	time.c:208: return seconds;
	pop	ar3
	pop	ar2
;	time.c:200: seconds+= 60*60*24L*monthDays[i];
00113$:
;	time.c:196: for (i=0; i<month; i++) {
	inc	r4
	cjne	r4,#0,00133$
	inc	r5
00133$:
	ljmp	00111$
00114$:
;	time.c:204: seconds+= (timeptr->tm_mday-1)*60*60*24L;
	mov	dptr,#_mktime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x03
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r2,a
	mov	r3,#0
	dec	r2
	cjne	r2,#0xFF,00134$
	dec	r3
00134$:
	mov	dptr,#__mullong_PARM_2
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	mov	a,r3
	rlc	a
	subb	a,acc
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	mov	dptr,#0x015180
	mov	b,#0x00
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	mov	dptr,#_mktime_seconds_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r5
	movx	@dptr,a
;	time.c:205: seconds+= timeptr->tm_hour*60*60L;
	mov	dptr,#_mktime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x02
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r2,a
	mov  dptr,#__mullong_PARM_2
	movx @dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	inc	dptr
	clr	a
	movx	@dptr,a
	mov	dptr,#0x000E10
	mov	b,#0x00
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	mov	dptr,#_mktime_seconds_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r5
	movx	@dptr,a
;	time.c:206: seconds+= timeptr->tm_min*60;
	mov	dptr,#_mktime_timeptr_1_1
	movx	a,@dptr
	add	a,#0x01
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r2,a
	mov	b,#0x3C
	mov	a,r2
	mul	ab
	mov	r2,a
	mov	r3,b
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
	mov	dptr,#_mktime_seconds_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r5
	movx	@dptr,a
;	time.c:207: seconds+= timeptr->tm_sec;
	mov     dps, #1
	mov     dptr, #_mktime_timeptr_1_1
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
	lcall	__gptrget
	mov	r2,a
	mov	r3,#0
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
	mov	dptr,#_mktime_seconds_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r5
	movx	@dptr,a
;	time.c:208: return seconds;
	mov     dps, #1
	mov     dptr, #_mktime_seconds_1_1
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
00115$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
_monthDays:
	.db #0x1F	;  31
	.db #0x1C	;  28
	.db #0x1F	;  31
	.db #0x1E	;  30
	.db #0x1F	;  31
	.db #0x1E	;  30
	.db #0x1F	;  31
	.db #0x1F	;  31
	.db #0x1E	;  30
	.db #0x1F	;  31
	.db #0x1E	;  30
	.db #0x1F	;  31
___month:
	.byte _str_1,(_str_1 >> 8),(_str_1 >> 16)
	.byte _str_2,(_str_2 >> 8),(_str_2 >> 16)
	.byte _str_3,(_str_3 >> 8),(_str_3 >> 16)
	.byte _str_4,(_str_4 >> 8),(_str_4 >> 16)
	.byte _str_5,(_str_5 >> 8),(_str_5 >> 16)
	.byte _str_6,(_str_6 >> 8),(_str_6 >> 16)
	.byte _str_7,(_str_7 >> 8),(_str_7 >> 16)
	.byte _str_8,(_str_8 >> 8),(_str_8 >> 16)
	.byte _str_9,(_str_9 >> 8),(_str_9 >> 16)
	.byte _str_10,(_str_10 >> 8),(_str_10 >> 16)
	.byte _str_11,(_str_11 >> 8),(_str_11 >> 16)
	.byte _str_12,(_str_12 >> 8),(_str_12 >> 16)
___day:
	.byte _str_13,(_str_13 >> 8),(_str_13 >> 16)
	.byte _str_14,(_str_14 >> 8),(_str_14 >> 16)
	.byte _str_15,(_str_15 >> 8),(_str_15 >> 16)
	.byte _str_16,(_str_16 >> 8),(_str_16 >> 16)
	.byte _str_17,(_str_17 >> 8),(_str_17 >> 16)
	.byte _str_18,(_str_18 >> 8),(_str_18 >> 16)
	.byte _str_19,(_str_19 >> 8),(_str_19 >> 16)
__str_0:
	.ascii "%s %s %2d %02d:%02d:%02d %04d"
	.db 0x0A
	.db 0x00
_str_1:
	.ascii "Jan"
	.db 0x00
_str_2:
	.ascii "Feb"
	.db 0x00
_str_3:
	.ascii "Mar"
	.db 0x00
_str_4:
	.ascii "Apr"
	.db 0x00
_str_5:
	.ascii "May"
	.db 0x00
_str_6:
	.ascii "Jun"
	.db 0x00
_str_7:
	.ascii "Jul"
	.db 0x00
_str_8:
	.ascii "Aug"
	.db 0x00
_str_9:
	.ascii "Sep"
	.db 0x00
_str_10:
	.ascii "Oct"
	.db 0x00
_str_11:
	.ascii "Nov"
	.db 0x00
_str_12:
	.ascii "Dec"
	.db 0x00
_str_13:
	.ascii "Sun"
	.db 0x00
_str_14:
	.ascii "Mon"
	.db 0x00
_str_15:
	.ascii "Tue"
	.db 0x00
_str_16:
	.ascii "Wed"
	.db 0x00
_str_17:
	.ascii "Thu"
	.db 0x00
_str_18:
	.ascii "Fri"
	.db 0x00
_str_19:
	.ascii "Sat"
	.db 0x00
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
