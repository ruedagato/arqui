;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module lcd390
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
	.globl _LcdCharDefine
	.globl _LcdScrollOff
	.globl _LcdScrollOn
	.globl _LcdCursorOff
	.globl _LcdCursorOn
	.globl _LcdLPutString_PARM_2
	.globl _LcdInit
	.globl _LcdOn
	.globl _LcdOff
	.globl _LcdClear
	.globl _LcdHome
	.globl _LcdGoto
	.globl _LcdPutChar
	.globl _LcdPutString
	.globl _LcdLPutString
	.globl _LcdPrintf
	.globl _LcdLPrintf
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
_lcdIwr	=	0x380002
_lcdDwr	=	0x38000a
_LcdLPutString_PARM_2:
	.ds 4
_lcdPrintfBuffer:
	.ds 80
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
_lcdLinesStart:
	.ds 4
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
;Allocation info for local variables in function 'LcdInit'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:65: void LcdInit() {
;	-----------------------------------------
;	 function LcdInit
;	-----------------------------------------
_LcdInit:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	lcd390.c:67: ClockMilliSecondsDelay(16); // >15 ms
	mov	dptr,#0x000010
	mov	b,#0x00
	lcall	_ClockMilliSecondsDelay
;	lcd390.c:69: lcdIwr=0x38 ;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x38
	movx	@dptr,a
;	lcd390.c:70: ClockMilliSecondsDelay(5); // >4.1 ms
	mov	dptr,#0x000005
	mov	b,#0x00
	lcall	_ClockMilliSecondsDelay
;	lcd390.c:72: lcdIwr=0x38;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x38
	movx	@dptr,a
;	lcd390.c:73: ClockMicroSecondsDelay(101); // >100 us
	mov  dptr,#0x0065
	lcall	_ClockMicroSecondsDelay
;	lcd390.c:75: lcdIwr=0x38;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x38
	movx	@dptr,a
;	lcd390.c:76: ClockMicroSecondsDelay(101); // >100 us
	mov  dptr,#0x0065
	lcall	_ClockMicroSecondsDelay
;	lcd390.c:78: lcdIwr=0x38; // interface 8 bit
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x38
	movx	@dptr,a
;	lcd390.c:79: ClockMicroSecondsDelay(41); // >40 us
	mov  dptr,#0x0029
	lcall	_ClockMicroSecondsDelay
;	lcd390.c:81: lcdIwr=0x0c; // display on
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x0C
	movx	@dptr,a
;	lcd390.c:82: ClockMicroSecondsDelay(41); // >40 us
	mov  dptr,#0x0029
	lcall	_ClockMicroSecondsDelay
;	lcd390.c:84: LcdClear();
	lcall	_LcdClear
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdOn'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:87: void LcdOn() {
;	-----------------------------------------
;	 function LcdOn
;	-----------------------------------------
_LcdOn:
;	lcd390.c:88: lcdIwr=0x0c; // display on
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x0C
	movx	@dptr,a
;	lcd390.c:89: LcdWait;
	mov  dptr,#0x0064
	lcall	_ClockMicroSecondsDelay
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdOff'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:92: void LcdOff() {
;	-----------------------------------------
;	 function LcdOff
;	-----------------------------------------
_LcdOff:
;	lcd390.c:93: lcdIwr=0x08; // display off
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x08
	movx	@dptr,a
;	lcd390.c:94: LcdWait;
	mov  dptr,#0x0064
	lcall	_ClockMicroSecondsDelay
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdCursorOn'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:97: void LcdCursorOn() {
;	-----------------------------------------
;	 function LcdCursorOn
;	-----------------------------------------
_LcdCursorOn:
;	lcd390.c:99: }
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdCursorOff'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:101: void LcdCursorOff() {
;	-----------------------------------------
;	 function LcdCursorOff
;	-----------------------------------------
_LcdCursorOff:
;	lcd390.c:103: }
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdScrollOn'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:105: void LcdScrollOn() {
;	-----------------------------------------
;	 function LcdScrollOn
;	-----------------------------------------
_LcdScrollOn:
;	lcd390.c:107: }
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdScrollOff'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:109: void LcdScrollOff() {
;	-----------------------------------------
;	 function LcdScrollOff
;	-----------------------------------------
_LcdScrollOff:
;	lcd390.c:111: }
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdCharDefine'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:113: void LcdCharDefine() {
;	-----------------------------------------
;	 function LcdCharDefine
;	-----------------------------------------
_LcdCharDefine:
;	lcd390.c:115: }
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdClear'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:117: void LcdClear() {
;	-----------------------------------------
;	 function LcdClear
;	-----------------------------------------
_LcdClear:
;	lcd390.c:118: lcdIwr=0x01; // display clear
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x01
	movx	@dptr,a
;	lcd390.c:119: ClockMilliSecondsDelay(6); // > 5ms
	mov	dptr,#0x000006
	mov	b,#0x00
	lcall	_ClockMilliSecondsDelay
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdHome'
;------------------------------------------------------------
;------------------------------------------------------------
;	lcd390.c:122: void LcdHome() {
;	-----------------------------------------
;	 function LcdHome
;	-----------------------------------------
_LcdHome:
;	lcd390.c:123: lcdIwr=0x80; // set dd ram address 0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_lcdIwr
	mov	a,#0x80
	movx	@dptr,a
;	lcd390.c:124: LcdWait;
	mov  dptr,#0x0064
	lcall	_ClockMicroSecondsDelay
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdGoto'
;------------------------------------------------------------
;collumnRow                Allocated to registers r2 r3 
;------------------------------------------------------------
;	lcd390.c:127: void LcdGoto(unsigned int collumnRow) { // msb=collumn, lsb=row
;	-----------------------------------------
;	 function LcdGoto
;	-----------------------------------------
_LcdGoto:
	mov	dpl1,dpl
	mov	dph1,dph
;	lcd390.c:128: lcdIwr=0x80 + \
	mov	r4,dpl1
	mov	r5,#0
	mov	a,r4
	add	a,#_lcdLinesStart
	mov	dpl,a
	mov	a,r5
	addc	a,#(_lcdLinesStart >> 8)
	mov	dph,a
	clr	a
	addc	a,#(_lcdLinesStart >> 16)
	mov	dpx,a
	movx	a,@dptr
	add  a,#0x80
	mov  r4,a
	mov	r2,dph1
	mov	r3,#0
	mov	dptr,#_lcdIwr
	mov	a,r2
	add	a,r4
	movx	@dptr,a
;	lcd390.c:130: LcdWait;
	mov  dptr,#0x0064
	lcall	_ClockMicroSecondsDelay
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdPutChar'
;------------------------------------------------------------
;c                         Allocated to registers 
;------------------------------------------------------------
;	lcd390.c:133: void LcdPutChar(char c) {
;	-----------------------------------------
;	 function LcdPutChar
;	-----------------------------------------
_LcdPutChar:
	mov     dps, #1
	mov     dptr, #_lcdDwr
	mov	a,dpl
	movx	@dptr,a
	mov	dps,#0
;	lcd390.c:135: LcdWait;
	mov  dptr,#0x0064
	lcall	_ClockMicroSecondsDelay
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdPutString'
;------------------------------------------------------------
;string                    Allocated to registers r2 r3 r4 r5 
;c                         Allocated to registers r7 
;------------------------------------------------------------
;	lcd390.c:138: void LcdPutString (char *string) {
;	-----------------------------------------
;	 function LcdPutString
;	-----------------------------------------
_LcdPutString:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	lcd390.c:140: while (c=*string++) {
;	genAssign: resultIsFar = FALSE
00101$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar7,r6
	mov	a,r6
	jz  00104$
00109$:
;	lcd390.c:141: LcdPutChar (c);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r7
	lcall	_LcdPutChar
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp 00101$
00104$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdLPutString'
;------------------------------------------------------------
;string                    Allocated with name '_LcdLPutString_PARM_2'
;collumnRow                Allocated to registers r2 r3 
;------------------------------------------------------------
;	lcd390.c:145: void LcdLPutString (unsigned int collumnRow, char *string) {
;	-----------------------------------------
;	 function LcdLPutString
;	-----------------------------------------
_LcdLPutString:
;	lcd390.c:146: LcdGoto(collumnRow);
	lcall	_LcdGoto
;	lcd390.c:147: LcdPutString(string);
	inc	dps
	mov	dptr,#_LcdLPutString_PARM_2
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
	lcall	_LcdPutString
00101$:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdPrintf'
;------------------------------------------------------------
;format                    Allocated to stack - offset -8
;arg                       Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	lcd390.c:154: void LcdPrintf (const char *format, ...) __reentrant {
;	-----------------------------------------
;	 function LcdPrintf
;	-----------------------------------------
_LcdPrintf:
	push	_bpx
	push	_bpx+1
	mov	_bpx,sp
	mov	_bpx+1,esp
	anl	_bpx+1,#3
;	lcd390.c:157: va_start (arg, format);
	mov	a,_bpx
	add	a,#0xF8
	mov	b,a
	mov	a,_bpx+1
	addc	a,#0xFF
	mov	r2,b
	mov	r3,a
	mov	r4,#0x40
	mov	r5,#0x00
;	lcd390.c:158: vsprintf (lcdPrintfBuffer, format, arg);
	mov	a,_bpx
	clr	c
	subb	a,#0x08
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0x40
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
	mov	dptr,#_vsprintf_PARM_2
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
	mov	dptr,#_vsprintf_PARM_3
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
	mov dptr,#_lcdPrintfBuffer
	mov	b,#0x00
	lcall	_vsprintf
;	lcd390.c:159: puts (lcdPrintfBuffer);
	mov dptr,#_lcdPrintfBuffer
	mov	b,#0x00
	lcall	_puts
;	lcd390.c:160: LcdPutString(lcdPrintfBuffer);
	mov dptr,#_lcdPrintfBuffer
	mov	b,#0x00
	lcall	_LcdPutString
;	lcd390.c:162: va_end (arg);
00101$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LcdLPrintf'
;------------------------------------------------------------
;collumnRow                Allocated to stack - offset -6
;format                    Allocated to stack - offset -10
;arg                       Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	lcd390.c:165: void LcdLPrintf (unsigned int collumnRow, const char *format, ...) __reentrant {
;	-----------------------------------------
;	 function LcdLPrintf
;	-----------------------------------------
_LcdLPrintf:
	push	_bpx
	push	_bpx+1
	mov	_bpx,sp
	mov	_bpx+1,esp
	anl	_bpx+1,#3
;	lcd390.c:168: LcdGoto(collumnRow);
	mov	a,_bpx
	clr	c
	subb	a,#0x06
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph1,a
	mov	dpx1,#0x40
	inc	dps
	movx	a,@dptr
	mov	dpl,a
	inc	dptr
	movx	a,@dptr
	mov	dph,a
	mov	dps,#0
	lcall	_LcdGoto
;	lcd390.c:172: va_start (arg, format);
	mov	a,_bpx
	add	a,#0xF6
	mov	b,a
	mov	a,_bpx+1
	addc	a,#0xFF
	mov	r2,b
	mov	r3,a
	mov	r4,#0x40
	mov	r5,#0x00
;	lcd390.c:173: vsprintf (lcdPrintfBuffer, format, arg);
	mov	a,_bpx
	clr	c
	subb	a,#0x0A
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0x00
	mov	dph,a
	mov	dpx,#0x40
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
	mov	dptr,#_vsprintf_PARM_2
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
	mov	dptr,#_vsprintf_PARM_3
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
	mov dptr,#_lcdPrintfBuffer
	mov	b,#0x00
	lcall	_vsprintf
;	lcd390.c:175: LcdPutString(lcdPrintfBuffer);
	mov dptr,#_lcdPrintfBuffer
	mov	b,#0x00
	lcall	_LcdPutString
;	lcd390.c:177: va_end (arg);
00101$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
__xinit__lcdLinesStart:
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x14	; 20
	.db #0x54	; 84	T
	.area CABS    (ABS,CODE)
