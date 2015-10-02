;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:24 2015
;--------------------------------------------------------
	.module time
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___day
	.globl ___month
	.globl _RtcRead
	.globl _time
	.globl _asctime
	.globl _ctime
	.globl _localtime
	.globl _gmtime
	.globl _mktime
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_time_now_1_1:
	.ds 12
_ascTimeBuffer:
	.ds 32
_asctime_timeptr_1_1:
	.ds 3
_asctime_sloc0_1_0:
	.ds 2
_asctime_sloc1_1_0:
	.ds 2
_asctime_sloc2_1_0:
	.ds 2
_asctime_sloc3_1_0:
	.ds 2
_lastTime:
	.ds 12
_gmtime_epoch_1_1:
	.ds 4
_gmtime_days_1_1:
	.ds 4
_gmtime_sloc0_1_0:
	.ds 4
_mktime_timeptr_1_1:
	.ds 3
_mktime_year_1_1:
	.ds 2
_mktime_month_1_1:
	.ds 2
_mktime_i_1_1:
	.ds 2
_mktime_seconds_1_1:
	.ds 4
_mktime_sloc0_1_0:
	.ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
	.area	OSEG    (OVR,DATA)
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
;Allocation info for local variables in function 'RtcRead'
;------------------------------------------------------------
;timeptr                   Allocated to registers 
;------------------------------------------------------------
;	time.c:42: unsigned char RtcRead(struct tm *timeptr) {
;	-----------------------------------------
;	 function RtcRead
;	-----------------------------------------
_RtcRead:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	time.c:45: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'time'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;now                       Allocated with name '_time_now_1_1'
;t                         Allocated to registers r5 r6 r7 r0 
;------------------------------------------------------------
;	time.c:50: time_t time(time_t *timeptr) {
;	-----------------------------------------
;	 function time
;	-----------------------------------------
_time:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	time.c:52: time_t t=-1;
	mov	r5,#0xFF
	mov	r6,#0xFF
	mov	r7,#0xFF
	mov	r0,#0xFF
;	time.c:54: if (RtcRead(&now)) {
	mov	dptr,#_time_now_1_1
	mov	b,#0x40
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_RtcRead
	mov	a,dpl
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	jz	00102$
;	time.c:55: t=mktime(&now);
	mov	dptr,#_time_now_1_1
	mov	b,#0x40
	push	ar2
	push	ar3
	push	ar4
	lcall	_mktime
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	pop	ar4
	pop	ar3
	pop	ar2
00102$:
;	time.c:57: if (timeptr) {
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jz	00104$
;	time.c:58: *timeptr=t;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__gptrput
	inc	dptr
	mov	a,r6
	lcall	__gptrput
	inc	dptr
	mov	a,r7
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	lcall	__gptrput
00104$:
;	time.c:60: return t;
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'CheckTime'
;------------------------------------------------------------
;timeptr                   Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	time.c:73: static void CheckTime(struct tm *timeptr) {
;	-----------------------------------------
;	 function CheckTime
;	-----------------------------------------
_CheckTime:
;	time.c:84: if (timeptr->tm_sec>59) timeptr->tm_sec=59;
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	lcall	__gptrget
	mov	r5,a
	mov	a,#0x3B
	cjne	a,ar5,00128$
00128$:
	jnc	00102$
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,#0x3B
	lcall	__gptrput
00102$:
;	time.c:85: if (timeptr->tm_min>59) timeptr->tm_min=59;
	mov	a,#0x01
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	mov	a,#0x3B
	cjne	a,ar0,00130$
00130$:
	jnc	00104$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x3B
	lcall	__gptrput
00104$:
;	time.c:86: if (timeptr->tm_hour>23) timeptr->tm_hour=23;
	mov	a,#0x02
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	mov	a,#0x17
	cjne	a,ar0,00132$
00132$:
	jnc	00106$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x17
	lcall	__gptrput
00106$:
;	time.c:87: if (timeptr->tm_wday>6) timeptr->tm_wday=6;
	mov	a,#0x07
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	mov	a,#0x06
	cjne	a,ar0,00134$
00134$:
	jnc	00108$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x06
	lcall	__gptrput
00108$:
;	time.c:88: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
	mov	a,#0x03
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	cjne	r0,#0x01,00136$
00136$:
	jnc	00112$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x01
	lcall	__gptrput
	sjmp	00113$
00112$:
;	time.c:89: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
	mov	a,#0x1F
	cjne	a,ar0,00138$
00138$:
	jnc	00113$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x1F
	lcall	__gptrput
00113$:
;	time.c:90: if (timeptr->tm_mon>11) timeptr->tm_mon=11;
	mov	a,#0x04
	add	a,r2
	mov	r5,a
	clr	a
	addc	a,r3
	mov	r6,a
	mov	ar7,r4
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	mov	a,#0x0B
	cjne	a,ar0,00140$
00140$:
	jnc	00115$
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,#0x0B
	lcall	__gptrput
00115$:
;	time.c:91: if (timeptr->tm_year<0) timeptr->tm_year=0;
	mov	a,#0x05
	add	a,r2
	mov	r2,a
	clr	a
	addc	a,r3
	mov	r3,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
	mov	r6,a
	jnb	acc.7,00118$
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	ljmp	__gptrput
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
;------------------------------------------------------------
;	time.c:95: char *asctime(struct tm *timeptr) {
;	-----------------------------------------
;	 function asctime
;	-----------------------------------------
_asctime:
;	time.c:96: CheckTime(timeptr);
	mov	_asctime_timeptr_1_1,dpl
	mov	(_asctime_timeptr_1_1 + 1),dph
	mov	(_asctime_timeptr_1_1 + 2),b
	lcall	_CheckTime
;	time.c:100: timeptr->tm_year+1900);
	mov	a,#0x05
	add	a,_asctime_timeptr_1_1
	mov	r5,a
	clr	a
	addc	a,(_asctime_timeptr_1_1 + 1)
	mov	r6,a
	mov	r7,(_asctime_timeptr_1_1 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
	mov	r6,a
	mov	a,#0x6C
	add	a,r5
	mov	r5,a
	mov	a,#0x07
	addc	a,r6
	mov	r6,a
;	time.c:99: timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec, 
	mov	dpl,_asctime_timeptr_1_1
	mov	dph,(_asctime_timeptr_1_1 + 1)
	mov	b,(_asctime_timeptr_1_1 + 2)
	lcall	__gptrget
	mov	r7,a
	mov	_asctime_sloc3_1_0,r7
	mov	(_asctime_sloc3_1_0 + 1),#0x00
	mov	a,#0x01
	add	a,_asctime_timeptr_1_1
	mov	r1,a
	clr	a
	addc	a,(_asctime_timeptr_1_1 + 1)
	mov	r2,a
	mov	r3,(_asctime_timeptr_1_1 + 2)
	mov	dpl,r1
	mov	dph,r2
	mov	b,r3
	lcall	__gptrget
	mov	r1,a
	mov	_asctime_sloc0_1_0,r1
	mov	(_asctime_sloc0_1_0 + 1),#0x00
	mov	a,#0x02
	add	a,_asctime_timeptr_1_1
	mov	r3,a
	clr	a
	addc	a,(_asctime_timeptr_1_1 + 1)
	mov	r4,a
	mov	r2,(_asctime_timeptr_1_1 + 2)
	mov	dpl,r3
	mov	dph,r4
	mov	b,r2
	lcall	__gptrget
	mov	r3,a
	mov	_asctime_sloc1_1_0,r3
	mov	(_asctime_sloc1_1_0 + 1),#0x00
;	time.c:98: __day[timeptr->tm_wday], __month[timeptr->tm_mon], timeptr->tm_mday,
	mov	a,#0x03
	add	a,_asctime_timeptr_1_1
	mov	r4,a
	clr	a
	addc	a,(_asctime_timeptr_1_1 + 1)
	mov	r1,a
	mov	r2,(_asctime_timeptr_1_1 + 2)
	mov	dpl,r4
	mov	dph,r1
	mov	b,r2
	lcall	__gptrget
	mov	r4,a
	mov	_asctime_sloc2_1_0,r4
	mov	(_asctime_sloc2_1_0 + 1),#0x00
	mov	a,#0x04
	add	a,_asctime_timeptr_1_1
	mov	r3,a
	clr	a
	addc	a,(_asctime_timeptr_1_1 + 1)
	mov	r1,a
	mov	r2,(_asctime_timeptr_1_1 + 2)
	mov	dpl,r3
	mov	dph,r1
	mov	b,r2
	lcall	__gptrget
	add	a,acc
	mov	r2,a
	mov	dptr,#___month
	movc	a,@a+dptr
	xch	a,r2
	inc	dptr
	movc	a,@a+dptr
	mov	r3,a
	mov	r4,#0x80
	mov	a,#0x07
	add	a,_asctime_timeptr_1_1
	mov	r1,a
	clr	a
	addc	a,(_asctime_timeptr_1_1 + 1)
	mov	r7,a
	mov	r0,(_asctime_timeptr_1_1 + 2)
	mov	dpl,r1
	mov	dph,r7
	mov	b,r0
	lcall	__gptrget
	add	a,acc
	mov	r7,a
	mov	dptr,#___day
	movc	a,@a+dptr
	xch	a,r7
	inc	dptr
	movc	a,@a+dptr
	mov	r0,a
	mov	r1,#0x80
;	time.c:97: sprintf (ascTimeBuffer, "%s %s %2d %02d:%02d:%02d %04d\n",
	push	ar5
	push	ar6
	push	_asctime_sloc3_1_0
	push	(_asctime_sloc3_1_0 + 1)
	push	_asctime_sloc0_1_0
	push	(_asctime_sloc0_1_0 + 1)
	push	_asctime_sloc1_1_0
	push	(_asctime_sloc1_1_0 + 1)
	push	_asctime_sloc2_1_0
	push	(_asctime_sloc2_1_0 + 1)
	push	ar2
	push	ar3
	push	ar4
	push	ar7
	push	ar0
	push	ar1
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_ascTimeBuffer
	push	acc
	mov	a,#(_ascTimeBuffer >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xea
	mov	sp,a
;	time.c:101: return ascTimeBuffer;
	mov	dptr,#_ascTimeBuffer
	mov	b,#0x40
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ctime'
;------------------------------------------------------------
;timep                     Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	time.c:104: char *ctime(time_t *timep) {
;	-----------------------------------------
;	 function ctime
;	-----------------------------------------
_ctime:
;	time.c:105: return asctime(localtime(timep));
	lcall	_localtime
	ljmp	_asctime
;------------------------------------------------------------
;Allocation info for local variables in function 'localtime'
;------------------------------------------------------------
;timep                     Allocated to registers r2 r3 r4 
;------------------------------------------------------------
;	time.c:121: struct tm *localtime(time_t *timep) {
;	-----------------------------------------
;	 function localtime
;	-----------------------------------------
_localtime:
;	time.c:122: return gmtime(timep);
	ljmp	_gmtime
;------------------------------------------------------------
;Allocation info for local variables in function 'gmtime'
;------------------------------------------------------------
;timep                     Allocated to registers r2 r3 r4 
;epoch                     Allocated with name '_gmtime_epoch_1_1'
;year                      Allocated to registers r6 r7 
;month                     Allocated to registers r4 
;monthLength               Allocated to registers r5 
;days                      Allocated with name '_gmtime_days_1_1'
;sloc0                     Allocated with name '_gmtime_sloc0_1_0'
;------------------------------------------------------------
;	time.c:125: struct tm *gmtime(time_t *timep) {
;	-----------------------------------------
;	 function gmtime
;	-----------------------------------------
_gmtime:
;	time.c:126: unsigned long epoch=*timep;
	lcall	__gptrget
	mov	_gmtime_epoch_1_1,a
	inc	dptr
	lcall	__gptrget
	mov	(_gmtime_epoch_1_1 + 1),a
	inc	dptr
	lcall	__gptrget
	mov	(_gmtime_epoch_1_1 + 2),a
	inc	dptr
	lcall	__gptrget
	mov	(_gmtime_epoch_1_1 + 3),a
;	time.c:131: lastTime.tm_sec=epoch%60;
	mov	__modulong_PARM_2,#0x3C
	clr	a
	mov	(__modulong_PARM_2 + 1),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 3),a
	mov	dpl,_gmtime_epoch_1_1
	mov	dph,(_gmtime_epoch_1_1 + 1)
	mov	b,(_gmtime_epoch_1_1 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	lcall	__modulong
	mov	r6,dpl
	mov	_lastTime,r6
;	time.c:132: epoch/=60; // now it is minutes
	mov	__divulong_PARM_2,#0x3C
	clr	a
	mov	(__divulong_PARM_2 + 1),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 3),a
	mov	dpl,_gmtime_epoch_1_1
	mov	dph,(_gmtime_epoch_1_1 + 1)
	mov	b,(_gmtime_epoch_1_1 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	lcall	__divulong
	mov	_gmtime_epoch_1_1,dpl
	mov	(_gmtime_epoch_1_1 + 1),dph
	mov	(_gmtime_epoch_1_1 + 2),b
	mov	(_gmtime_epoch_1_1 + 3),a
;	time.c:133: lastTime.tm_min=epoch%60;
	mov	__modulong_PARM_2,#0x3C
	clr	a
	mov	(__modulong_PARM_2 + 1),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 3),a
	mov	dpl,_gmtime_epoch_1_1
	mov	dph,(_gmtime_epoch_1_1 + 1)
	mov	b,(_gmtime_epoch_1_1 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	lcall	__modulong
	mov	r2,dpl
	mov	(_lastTime + 0x0001),r2
;	time.c:134: epoch/=60; // now it is hours
	mov	__divulong_PARM_2,#0x3C
	clr	a
	mov	(__divulong_PARM_2 + 1),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 3),a
	mov	dpl,_gmtime_epoch_1_1
	mov	dph,(_gmtime_epoch_1_1 + 1)
	mov	b,(_gmtime_epoch_1_1 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	lcall	__divulong
	mov	_gmtime_epoch_1_1,dpl
	mov	(_gmtime_epoch_1_1 + 1),dph
	mov	(_gmtime_epoch_1_1 + 2),b
	mov	(_gmtime_epoch_1_1 + 3),a
;	time.c:135: lastTime.tm_hour=epoch%24;
	mov	__modulong_PARM_2,#0x18
	clr	a
	mov	(__modulong_PARM_2 + 1),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 3),a
	mov	dpl,_gmtime_epoch_1_1
	mov	dph,(_gmtime_epoch_1_1 + 1)
	mov	b,(_gmtime_epoch_1_1 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	lcall	__modulong
	mov	r2,dpl
	mov	(_lastTime + 0x0002),r2
;	time.c:136: epoch/=24; // now it is days
	mov	__divulong_PARM_2,#0x18
	clr	a
	mov	(__divulong_PARM_2 + 1),a
	mov	(__divulong_PARM_2 + 2),a
	mov	(__divulong_PARM_2 + 3),a
	mov	dpl,_gmtime_epoch_1_1
	mov	dph,(_gmtime_epoch_1_1 + 1)
	mov	b,(_gmtime_epoch_1_1 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	lcall	__divulong
	mov	_gmtime_epoch_1_1,dpl
	mov	(_gmtime_epoch_1_1 + 1),dph
	mov	(_gmtime_epoch_1_1 + 2),b
	mov	(_gmtime_epoch_1_1 + 3),a
;	time.c:137: lastTime.tm_wday=(epoch+4)%7;
	mov	a,#0x04
	add	a,_gmtime_epoch_1_1
	mov	r2,a
	clr	a
	addc	a,(_gmtime_epoch_1_1 + 1)
	mov	r3,a
	clr	a
	addc	a,(_gmtime_epoch_1_1 + 2)
	mov	r4,a
	clr	a
	addc	a,(_gmtime_epoch_1_1 + 3)
	mov	r5,a
	mov	__modulong_PARM_2,#0x07
	clr	a
	mov	(__modulong_PARM_2 + 1),a
	mov	(__modulong_PARM_2 + 2),a
	mov	(__modulong_PARM_2 + 3),a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	__modulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	(_lastTime + 0x0007),r2
;	time.c:140: days=0;
	clr	a
	mov	_gmtime_days_1_1,a
	mov	(_gmtime_days_1_1 + 1),a
	mov	(_gmtime_days_1_1 + 2),a
	mov	(_gmtime_days_1_1 + 3),a
;	time.c:141: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
	mov	r6,#0xB2
	mov	r7,#0x07
00101$:
	mov	a,#0x03
	anl	a,r6
	mov	r2,a
	mov	r3,#0x00
	orl	a,r3
	cjne	a,#0x01,00134$
00134$:
	clr	a
	rlc	a
	mov	r2,a
	jz	00119$
	mov	r2,#0x6E
	mov	r3,#0x01
	sjmp	00120$
00119$:
	mov	r2,#0x6D
	mov	r3,#0x01
00120$:
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
	mov	a,r2
	add	a,_gmtime_days_1_1
	mov	r2,a
	mov	a,r3
	addc	a,(_gmtime_days_1_1 + 1)
	mov	r3,a
	mov	a,r4
	addc	a,(_gmtime_days_1_1 + 2)
	mov	r4,a
	mov	a,r5
	addc	a,(_gmtime_days_1_1 + 3)
	mov	r5,a
	mov	_gmtime_days_1_1,r2
	mov	(_gmtime_days_1_1 + 1),r3
	mov	(_gmtime_days_1_1 + 2),r4
	mov	(_gmtime_days_1_1 + 3),r5
	clr	c
	mov	a,_gmtime_epoch_1_1
	subb	a,r2
	mov	a,(_gmtime_epoch_1_1 + 1)
	subb	a,r3
	mov	a,(_gmtime_epoch_1_1 + 2)
	subb	a,r4
	mov	a,(_gmtime_epoch_1_1 + 3)
	subb	a,r5
	jc	00103$
;	time.c:142: year++;
	inc	r6
	cjne	r6,#0x00,00101$
	inc	r7
	sjmp	00101$
00103$:
;	time.c:144: lastTime.tm_year=year-1900;
	mov	a,r6
	add	a,#0x94
	mov	r2,a
	mov	a,r7
	addc	a,#0xf8
	mov	r3,a
	mov	((_lastTime + 0x0005) + 0),r2
	mov	((_lastTime + 0x0005) + 1),r3
;	time.c:146: days -= LEAP_YEAR(year) ? 366 : 365;
	mov	a,#0x03
	anl	a,r6
	mov	r2,a
	mov	r3,#0x00
	orl	a,r3
	cjne	a,#0x01,00138$
00138$:
	clr	a
	rlc	a
	mov	r4,a
	jz	00121$
	mov	r4,#0x6E
	mov	r5,#0x01
	sjmp	00122$
00121$:
	mov	r4,#0x6D
	mov	r5,#0x01
00122$:
	mov	a,r5
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	r7,a
	mov	a,_gmtime_days_1_1
	clr	c
	subb	a,r4
	mov	_gmtime_days_1_1,a
	mov	a,(_gmtime_days_1_1 + 1)
	subb	a,r5
	mov	(_gmtime_days_1_1 + 1),a
	mov	a,(_gmtime_days_1_1 + 2)
	subb	a,r6
	mov	(_gmtime_days_1_1 + 2),a
	mov	a,(_gmtime_days_1_1 + 3)
	subb	a,r7
	mov	(_gmtime_days_1_1 + 3),a
;	time.c:147: epoch -= days; // now it is days in this year, starting at 0
	mov	a,_gmtime_epoch_1_1
	clr	c
	subb	a,_gmtime_days_1_1
	mov	_gmtime_epoch_1_1,a
	mov	a,(_gmtime_epoch_1_1 + 1)
	subb	a,(_gmtime_days_1_1 + 1)
	mov	(_gmtime_epoch_1_1 + 1),a
	mov	a,(_gmtime_epoch_1_1 + 2)
	subb	a,(_gmtime_days_1_1 + 2)
	mov	(_gmtime_epoch_1_1 + 2),a
	mov	a,(_gmtime_epoch_1_1 + 3)
	subb	a,(_gmtime_days_1_1 + 3)
	mov	(_gmtime_epoch_1_1 + 3),a
;	time.c:148: lastTime.tm_yday=epoch;
	mov	r4,_gmtime_epoch_1_1
	mov	r5,(_gmtime_epoch_1_1 + 1)
	mov	((_lastTime + 0x0008) + 0),r4
	mov	((_lastTime + 0x0008) + 1),r5
;	time.c:153: for (month=0; month<12; month++) {
	mov	r4,#0x00
00113$:
	cjne	r4,#0x0C,00140$
00140$:
	jnc	00116$
;	time.c:154: if (month==1) { // februari
	cjne	r4,#0x01,00108$
;	time.c:155: if (LEAP_YEAR(year)) {
	mov	a,r2
	orl	a,r3
	jnz	00105$
;	time.c:156: monthLength=29;
	mov	r5,#0x1D
	sjmp	00109$
00105$:
;	time.c:158: monthLength=28;
	mov	r5,#0x1C
	sjmp	00109$
00108$:
;	time.c:161: monthLength = monthDays[month];
	mov	a,r4
	mov	dptr,#_monthDays
	movc	a,@a+dptr
	mov	r5,a
00109$:
;	time.c:164: if (epoch>=monthLength) {
	mov	_gmtime_sloc0_1_0,r5
	mov	(_gmtime_sloc0_1_0 + 1),#0x00
	mov	(_gmtime_sloc0_1_0 + 2),#0x00
	mov	(_gmtime_sloc0_1_0 + 3),#0x00
	clr	c
	mov	a,_gmtime_epoch_1_1
	subb	a,_gmtime_sloc0_1_0
	mov	a,(_gmtime_epoch_1_1 + 1)
	subb	a,(_gmtime_sloc0_1_0 + 1)
	mov	a,(_gmtime_epoch_1_1 + 2)
	subb	a,(_gmtime_sloc0_1_0 + 2)
	mov	a,(_gmtime_epoch_1_1 + 3)
	subb	a,(_gmtime_sloc0_1_0 + 3)
	jc	00116$
;	time.c:165: epoch-=monthLength;
	mov	a,_gmtime_epoch_1_1
	clr	c
	subb	a,_gmtime_sloc0_1_0
	mov	_gmtime_epoch_1_1,a
	mov	a,(_gmtime_epoch_1_1 + 1)
	subb	a,(_gmtime_sloc0_1_0 + 1)
	mov	(_gmtime_epoch_1_1 + 1),a
	mov	a,(_gmtime_epoch_1_1 + 2)
	subb	a,(_gmtime_sloc0_1_0 + 2)
	mov	(_gmtime_epoch_1_1 + 2),a
	mov	a,(_gmtime_epoch_1_1 + 3)
	subb	a,(_gmtime_sloc0_1_0 + 3)
	mov	(_gmtime_epoch_1_1 + 3),a
;	time.c:153: for (month=0; month<12; month++) {
	inc	r4
	sjmp	00113$
00116$:
;	time.c:170: lastTime.tm_mon=month;
	mov	(_lastTime + 0x0004),r4
;	time.c:171: lastTime.tm_mday=epoch+1;
	mov	a,_gmtime_epoch_1_1
	inc	a
	mov	(_lastTime + 0x0003),a
;	time.c:173: lastTime.tm_isdst=0;
	mov	(_lastTime + 0x000a),#0x00
;	time.c:175: return &lastTime;
	mov	dptr,#_lastTime
	mov	b,#0x40
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'mktime'
;------------------------------------------------------------
;timeptr                   Allocated with name '_mktime_timeptr_1_1'
;year                      Allocated with name '_mktime_year_1_1'
;month                     Allocated with name '_mktime_month_1_1'
;i                         Allocated with name '_mktime_i_1_1'
;seconds                   Allocated with name '_mktime_seconds_1_1'
;sloc0                     Allocated with name '_mktime_sloc0_1_0'
;------------------------------------------------------------
;	time.c:179: time_t mktime(struct tm *timeptr) {
;	-----------------------------------------
;	 function mktime
;	-----------------------------------------
_mktime:
	mov	_mktime_timeptr_1_1,dpl
	mov	(_mktime_timeptr_1_1 + 1),dph
	mov	(_mktime_timeptr_1_1 + 2),b
;	time.c:180: int year=timeptr->tm_year+1900, month=timeptr->tm_mon, i;
	mov	a,#0x05
	add	a,_mktime_timeptr_1_1
	mov	r5,a
	clr	a
	addc	a,(_mktime_timeptr_1_1 + 1)
	mov	r6,a
	mov	r7,(_mktime_timeptr_1_1 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
	mov	r6,a
	mov	a,#0x6C
	add	a,r5
	mov	_mktime_year_1_1,a
	mov	a,#0x07
	addc	a,r6
	mov	(_mktime_year_1_1 + 1),a
	mov	a,#0x04
	add	a,_mktime_timeptr_1_1
	mov	r7,a
	clr	a
	addc	a,(_mktime_timeptr_1_1 + 1)
	mov	r0,a
	mov	r1,(_mktime_timeptr_1_1 + 2)
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	mov	_mktime_month_1_1,r7
	mov	(_mktime_month_1_1 + 1),#0x00
;	time.c:183: CheckTime(timeptr);
	mov	dpl,_mktime_timeptr_1_1
	mov	dph,(_mktime_timeptr_1_1 + 1)
	mov	b,(_mktime_timeptr_1_1 + 2)
	lcall	_CheckTime
;	time.c:186: seconds= (year-1970)*(60*60*24L*365);
	mov	a,_mktime_year_1_1
	add	a,#0x4e
	mov	r1,a
	mov	a,(_mktime_year_1_1 + 1)
	addc	a,#0xf8
	mov	r7,a
	mov	__mullong_PARM_2,r1
	mov	a,r7
	mov	(__mullong_PARM_2 + 1),a
	rlc	a
	subb	a,acc
	mov	(__mullong_PARM_2 + 2),a
	mov	(__mullong_PARM_2 + 3),a
	mov	dptr,#0x3380
	mov	b,#0xE1
	mov	a,#0x01
	lcall	__mullong
	mov	_mktime_seconds_1_1,dpl
	mov	(_mktime_seconds_1_1 + 1),dph
	mov	(_mktime_seconds_1_1 + 2),b
	mov	(_mktime_seconds_1_1 + 3),a
;	time.c:189: for (i=1970; i<year; i++) {
	mov	_mktime_sloc0_1_0,_mktime_seconds_1_1
	mov	(_mktime_sloc0_1_0 + 1),(_mktime_seconds_1_1 + 1)
	mov	(_mktime_sloc0_1_0 + 2),(_mktime_seconds_1_1 + 2)
	mov	(_mktime_sloc0_1_0 + 3),(_mktime_seconds_1_1 + 3)
	mov	r2,#0xB2
	mov	r3,#0x07
00107$:
	clr	c
	mov	a,r2
	subb	a,_mktime_year_1_1
	mov	a,r3
	xrl	a,#0x80
	mov	b,(_mktime_year_1_1 + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	00124$
;	time.c:190: if (LEAP_YEAR(i)) {
	mov	__modsint_PARM_2,#0x04
	mov	(__modsint_PARM_2 + 1),#0x00
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	__modsint
	mov	a,dpl
	mov	b,dph
	pop	ar3
	pop	ar2
	orl	a,b
	jnz	00109$
;	time.c:191: seconds+= 60*60*24L;
	mov	a,#0x80
	add	a,_mktime_sloc0_1_0
	mov	_mktime_sloc0_1_0,a
	mov	a,#0x51
	addc	a,(_mktime_sloc0_1_0 + 1)
	mov	(_mktime_sloc0_1_0 + 1),a
	mov	a,#0x01
	addc	a,(_mktime_sloc0_1_0 + 2)
	mov	(_mktime_sloc0_1_0 + 2),a
	clr	a
	addc	a,(_mktime_sloc0_1_0 + 3)
	mov	(_mktime_sloc0_1_0 + 3),a
00109$:
;	time.c:189: for (i=1970; i<year; i++) {
	inc	r2
	cjne	r2,#0x00,00107$
	inc	r3
	sjmp	00107$
00124$:
	mov	_mktime_seconds_1_1,_mktime_sloc0_1_0
	mov	(_mktime_seconds_1_1 + 1),(_mktime_sloc0_1_0 + 1)
	mov	(_mktime_seconds_1_1 + 2),(_mktime_sloc0_1_0 + 2)
	mov	(_mktime_seconds_1_1 + 3),(_mktime_sloc0_1_0 + 3)
;	time.c:196: for (i=0; i<month; i++) {
	mov	__modsint_PARM_2,#0x04
	mov	(__modsint_PARM_2 + 1),#0x00
	mov	dpl,_mktime_year_1_1
	mov	dph,(_mktime_year_1_1 + 1)
	lcall	__modsint
	mov	r2,dpl
	mov	r3,dph
	clr	a
	mov	_mktime_i_1_1,a
	mov	(_mktime_i_1_1 + 1),a
00111$:
	clr	c
	mov	a,_mktime_i_1_1
	subb	a,_mktime_month_1_1
	mov	a,(_mktime_i_1_1 + 1)
	xrl	a,#0x80
	mov	b,(_mktime_month_1_1 + 1)
	xrl	b,#0x80
	subb	a,b
	jc	00128$
	ljmp	00114$
00128$:
;	time.c:197: if (i==1 && LEAP_YEAR(year)) { 
	mov	a,#0x01
	cjne	a,_mktime_i_1_1,00129$
	clr	a
	cjne	a,(_mktime_i_1_1 + 1),00129$
	sjmp	00130$
00129$:
	sjmp	00104$
00130$:
	mov	a,r2
	orl	a,r3
	jnz	00104$
;	time.c:198: seconds+= 60*60*24L*29;
	mov	a,#0x80
	add	a,_mktime_seconds_1_1
	mov	_mktime_seconds_1_1,a
	mov	a,#0x3B
	addc	a,(_mktime_seconds_1_1 + 1)
	mov	(_mktime_seconds_1_1 + 1),a
	mov	a,#0x26
	addc	a,(_mktime_seconds_1_1 + 2)
	mov	(_mktime_seconds_1_1 + 2),a
	clr	a
	addc	a,(_mktime_seconds_1_1 + 3)
	mov	(_mktime_seconds_1_1 + 3),a
	sjmp	00113$
00104$:
;	time.c:200: seconds+= 60*60*24L*monthDays[i];
	mov	a,_mktime_i_1_1
	add	a,#_monthDays
	mov	dpl,a
	mov	a,(_mktime_i_1_1 + 1)
	addc	a,#(_monthDays >> 8)
	mov	dph,a
	clr	a
	movc	a,@a+dptr
	mov	r4,a
	mov	__mullong_PARM_2,r4
	rlc	a
	subb	a,acc
	mov	(__mullong_PARM_2 + 1),a
	mov	(__mullong_PARM_2 + 2),a
	mov	(__mullong_PARM_2 + 3),a
	mov	dptr,#0x5180
	mov	b,#0x01
	clr	a
	push	ar2
	push	ar3
	lcall	__mullong
	mov	r4,dpl
	mov	r6,dph
	mov	r5,b
	mov	r7,a
	pop	ar3
	pop	ar2
	mov	a,r4
	add	a,_mktime_seconds_1_1
	mov	_mktime_seconds_1_1,a
	mov	a,r6
	addc	a,(_mktime_seconds_1_1 + 1)
	mov	(_mktime_seconds_1_1 + 1),a
	mov	a,r5
	addc	a,(_mktime_seconds_1_1 + 2)
	mov	(_mktime_seconds_1_1 + 2),a
	mov	a,r7
	addc	a,(_mktime_seconds_1_1 + 3)
	mov	(_mktime_seconds_1_1 + 3),a
00113$:
;	time.c:196: for (i=0; i<month; i++) {
	inc	_mktime_i_1_1
	clr	a
	cjne	a,_mktime_i_1_1,00132$
	inc	(_mktime_i_1_1 + 1)
00132$:
	ljmp	00111$
00114$:
;	time.c:204: seconds+= (timeptr->tm_mday-1)*60*60*24L;
	mov	a,#0x03
	add	a,_mktime_timeptr_1_1
	mov	r2,a
	clr	a
	addc	a,(_mktime_timeptr_1_1 + 1)
	mov	r3,a
	mov	r4,(_mktime_timeptr_1_1 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	mov	r3,#0x00
	dec	r2
	cjne	r2,#0xff,00133$
	dec	r3
00133$:
	mov	__mullong_PARM_2,r2
	mov	a,r3
	mov	(__mullong_PARM_2 + 1),a
	rlc	a
	subb	a,acc
	mov	(__mullong_PARM_2 + 2),a
	mov	(__mullong_PARM_2 + 3),a
	mov	dptr,#0x5180
	mov	b,#0x01
	clr	a
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,r2
	add	a,_mktime_seconds_1_1
	mov	_mktime_seconds_1_1,a
	mov	a,r3
	addc	a,(_mktime_seconds_1_1 + 1)
	mov	(_mktime_seconds_1_1 + 1),a
	mov	a,r4
	addc	a,(_mktime_seconds_1_1 + 2)
	mov	(_mktime_seconds_1_1 + 2),a
	mov	a,r5
	addc	a,(_mktime_seconds_1_1 + 3)
	mov	(_mktime_seconds_1_1 + 3),a
;	time.c:205: seconds+= timeptr->tm_hour*60*60L;
	mov	a,#0x02
	add	a,_mktime_timeptr_1_1
	mov	r2,a
	clr	a
	addc	a,(_mktime_timeptr_1_1 + 1)
	mov	r3,a
	mov	r4,(_mktime_timeptr_1_1 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	mov	__mullong_PARM_2,r2
	mov	(__mullong_PARM_2 + 1),#0x00
	mov	(__mullong_PARM_2 + 2),#0x00
	mov	(__mullong_PARM_2 + 3),#0x00
	mov	dptr,#0x0E10
	clr	a
	mov	b,a
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,r2
	add	a,_mktime_seconds_1_1
	mov	_mktime_seconds_1_1,a
	mov	a,r3
	addc	a,(_mktime_seconds_1_1 + 1)
	mov	(_mktime_seconds_1_1 + 1),a
	mov	a,r4
	addc	a,(_mktime_seconds_1_1 + 2)
	mov	(_mktime_seconds_1_1 + 2),a
	mov	a,r5
	addc	a,(_mktime_seconds_1_1 + 3)
	mov	(_mktime_seconds_1_1 + 3),a
;	time.c:206: seconds+= timeptr->tm_min*60;
	mov	a,#0x01
	add	a,_mktime_timeptr_1_1
	mov	r2,a
	clr	a
	addc	a,(_mktime_timeptr_1_1 + 1)
	mov	r3,a
	mov	r4,(_mktime_timeptr_1_1 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	b,#0x3C
	mul	ab
	mov	r2,a
	mov	a,b
	mov	r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
	mov	a,r2
	add	a,_mktime_seconds_1_1
	mov	_mktime_seconds_1_1,a
	mov	a,r3
	addc	a,(_mktime_seconds_1_1 + 1)
	mov	(_mktime_seconds_1_1 + 1),a
	mov	a,r4
	addc	a,(_mktime_seconds_1_1 + 2)
	mov	(_mktime_seconds_1_1 + 2),a
	mov	a,r5
	addc	a,(_mktime_seconds_1_1 + 3)
	mov	(_mktime_seconds_1_1 + 3),a
;	time.c:207: seconds+= timeptr->tm_sec;
	mov	dpl,_mktime_timeptr_1_1
	mov	dph,(_mktime_timeptr_1_1 + 1)
	mov	b,(_mktime_timeptr_1_1 + 2)
	lcall	__gptrget
	mov	r2,a
	clr	a
	mov	r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
	mov	a,r2
	add	a,_mktime_seconds_1_1
	mov	_mktime_seconds_1_1,a
	mov	a,r3
	addc	a,(_mktime_seconds_1_1 + 1)
	mov	(_mktime_seconds_1_1 + 1),a
	mov	a,r4
	addc	a,(_mktime_seconds_1_1 + 2)
	mov	(_mktime_seconds_1_1 + 2),a
	mov	a,r5
	addc	a,(_mktime_seconds_1_1 + 3)
;	time.c:208: return seconds;
	mov	(_mktime_seconds_1_1 + 3),a
	mov	dpl,_mktime_seconds_1_1
	mov	dph,(_mktime_seconds_1_1 + 1)
	mov	b,(_mktime_seconds_1_1 + 2)
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
	.byte _str_1,(_str_1 >> 8)
	.byte _str_2,(_str_2 >> 8)
	.byte _str_3,(_str_3 >> 8)
	.byte _str_4,(_str_4 >> 8)
	.byte _str_5,(_str_5 >> 8)
	.byte _str_6,(_str_6 >> 8)
	.byte _str_7,(_str_7 >> 8)
	.byte _str_8,(_str_8 >> 8)
	.byte _str_9,(_str_9 >> 8)
	.byte _str_10,(_str_10 >> 8)
	.byte _str_11,(_str_11 >> 8)
	.byte _str_12,(_str_12 >> 8)
___day:
	.byte _str_13,(_str_13 >> 8)
	.byte _str_14,(_str_14 >> 8)
	.byte _str_15,(_str_15 >> 8)
	.byte _str_16,(_str_16 >> 8)
	.byte _str_17,(_str_17 >> 8)
	.byte _str_18,(_str_18 >> 8)
	.byte _str_19,(_str_19 >> 8)
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
