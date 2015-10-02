;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module time
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
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
;  ram data
;--------------------------------------------------------
	.area DSEG
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
_asctime_sloc5_1_0:
	.ds 2
_asctime_sloc6_1_0:
	.ds 2
_ctime_sloc0_1_0:
	.ds 2
_localtime_sloc0_1_0:
	.ds 2
_gmtime_sloc0_1_0:
	.ds 4
_gmtime_sloc1_1_0:
	.ds 2
_gmtime_sloc2_1_0:
	.ds 4
_mktime_sloc0_1_0:
	.ds 2
_mktime_sloc1_1_0:
	.ds 4
_mktime_sloc2_1_0:
	.ds 2
_mktime_sloc3_1_0:
	.ds 4
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_CheckTime_sloc0_1_0::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
_time_timeptr_1_1:
	.ds 2
_time_now_1_1:
	.ds 12
_time_t_1_1:
	.ds 4
_ascTimeBuffer:
	.ds 32
_CheckTime_timeptr_1_1:
	.ds 2
_asctime_timeptr_1_1:
	.ds 2
_lastTime:
	.ds 12
_gmtime_timep_1_1:
	.ds 2
_gmtime_epoch_1_1:
	.ds 4
_gmtime_year_1_1:
	.ds 2
_gmtime_monthLength_1_1:
	.ds 1
_gmtime_days_1_1:
	.ds 4
_mktime_timeptr_1_1:
	.ds 2
_mktime_year_1_1:
	.ds 2
_mktime_month_1_1:
	.ds 2
_mktime_seconds_1_1:
	.ds 4
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'RtcRead'
;------------------------------------------------------------
;timeptr                   Allocated to registers 
;------------------------------------------------------------
;../time.c:42: unsigned char RtcRead(struct tm *timeptr) {
;	-----------------------------------------
;	 function RtcRead
;	-----------------------------------------
_RtcRead:
;../time.c:45: return 0;
	clra
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'time'
;------------------------------------------------------------
;timeptr                   Allocated with name '_time_timeptr_1_1'
;now                       Allocated with name '_time_now_1_1'
;t                         Allocated with name '_time_t_1_1'
;------------------------------------------------------------
;../time.c:50: time_t time(time_t *timeptr) {
;	-----------------------------------------
;	 function time
;	-----------------------------------------
_time:
	sta	(_time_timeptr_1_1 + 1)
	stx	_time_timeptr_1_1
;../time.c:52: time_t t=-1;
	lda	#0xFF
	sta	_time_t_1_1
	sta	(_time_t_1_1 + 1)
	sta	(_time_t_1_1 + 2)
	sta	(_time_t_1_1 + 3)
;../time.c:54: if (RtcRead(&now)) {
	ldx	#>_time_now_1_1
	lda	#_time_now_1_1
	jsr	_RtcRead
	tsta
	beq	00102$
00109$:
;../time.c:55: t=mktime(&now);
	ldx	#>_time_now_1_1
	lda	#_time_now_1_1
	jsr	_mktime
	sta	(_time_t_1_1 + 3)
	stx	(_time_t_1_1 + 2)
	lda	*__ret2
	sta	(_time_t_1_1 + 1)
	lda	*__ret3
	sta	_time_t_1_1
00102$:
;../time.c:57: if (timeptr) {
	lda	(_time_timeptr_1_1 + 1)
	ora	_time_timeptr_1_1
	beq	00104$
00110$:
;../time.c:58: *timeptr=t;
	lda	_time_timeptr_1_1
	ldx	(_time_timeptr_1_1 + 1)
	psha
	pulh
	lda	_time_t_1_1
	sta	,x
	aix	#1
	lda	(_time_t_1_1 + 1)
	sta	,x
	aix	#1
	lda	(_time_t_1_1 + 2)
	sta	,x
	aix	#1
	lda	(_time_t_1_1 + 3)
	sta	,x
00104$:
;../time.c:60: return t;
	lda	_time_t_1_1
	sta	*__ret3
	lda	(_time_t_1_1 + 1)
	sta	*__ret2
	ldx	(_time_t_1_1 + 2)
	lda	(_time_t_1_1 + 3)
00105$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'CheckTime'
;------------------------------------------------------------
;timeptr                   Allocated with name '_CheckTime_timeptr_1_1'
;sloc0                     Allocated with name '_CheckTime_sloc0_1_0'
;------------------------------------------------------------
;../time.c:73: static void CheckTime(struct tm *timeptr) {
;	-----------------------------------------
;	 function CheckTime
;	-----------------------------------------
_CheckTime:
	sta	(_CheckTime_timeptr_1_1 + 1)
	stx	_CheckTime_timeptr_1_1
;../time.c:84: if (timeptr->tm_sec>59) timeptr->tm_sec=59;
	lda	_CheckTime_timeptr_1_1
	ldx	(_CheckTime_timeptr_1_1 + 1)
	psha
	pulh
	lda	,x
	cmp	#0x3B
	bls	00102$
00128$:
	lda	_CheckTime_timeptr_1_1
	ldx	(_CheckTime_timeptr_1_1 + 1)
	psha
	pulh
	lda	#0x3B
	sta	,x
00102$:
;../time.c:85: if (timeptr->tm_min>59) timeptr->tm_min=59;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x01
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	cmp	#0x3B
	bls	00104$
00129$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x01
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	#0x3B
	sta	,x
00104$:
;../time.c:86: if (timeptr->tm_hour>23) timeptr->tm_hour=23;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x02
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	cmp	#0x17
	bls	00106$
00130$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x02
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	#0x17
	sta	,x
00106$:
;../time.c:87: if (timeptr->tm_wday>6) timeptr->tm_wday=6;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x07
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	cmp	#0x06
	bls	00108$
00131$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x07
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	#0x06
	sta	,x
00108$:
;../time.c:88: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x03
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	cmp	#0x01
	bcc	00112$
00132$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x03
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	#0x01
	sta	,x
	bra	00113$
00112$:
;../time.c:89: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x03
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	cmp	#0x1F
	bls	00113$
00133$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x03
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	#0x1F
	sta	,x
00113$:
;../time.c:90: if (timeptr->tm_mon>11) timeptr->tm_mon=11;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x04
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	cmp	#0x0B
	bls	00115$
00134$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x04
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	#0x0B
	sta	,x
00115$:
;../time.c:91: if (timeptr->tm_year<0) timeptr->tm_year=0;
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x05
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_CheckTime_sloc0_1_0
	lda	,x
	sta	*(_CheckTime_sloc0_1_0 + 1)
	ldhx	*_CheckTime_sloc0_1_0
	cphx	#0x0000
	bge	00118$
00135$:
	lda	(_CheckTime_timeptr_1_1 + 1)
	add	#0x05
	sta	*(_CheckTime_sloc0_1_0 + 1)
	lda	_CheckTime_timeptr_1_1
	adc	#0x00
	sta	*_CheckTime_sloc0_1_0
	ldhx	*_CheckTime_sloc0_1_0
	clra
	sta	,x
	aix	#1
	clra
	sta	,x
00118$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'asctime'
;------------------------------------------------------------
;sloc0                     Allocated with name '_asctime_sloc0_1_0'
;sloc1                     Allocated with name '_asctime_sloc1_1_0'
;sloc2                     Allocated with name '_asctime_sloc2_1_0'
;sloc3                     Allocated with name '_asctime_sloc3_1_0'
;sloc4                     Allocated with name '_asctime_sloc4_1_0'
;sloc5                     Allocated with name '_asctime_sloc5_1_0'
;sloc6                     Allocated with name '_asctime_sloc6_1_0'
;timeptr                   Allocated with name '_asctime_timeptr_1_1'
;------------------------------------------------------------
;../time.c:95: char *asctime(struct tm *timeptr) {
;	-----------------------------------------
;	 function asctime
;	-----------------------------------------
_asctime:
	sta	(_asctime_timeptr_1_1 + 1)
	stx	_asctime_timeptr_1_1
;../time.c:96: CheckTime(timeptr);
	ldx	_asctime_timeptr_1_1
	lda	(_asctime_timeptr_1_1 + 1)
	jsr	_CheckTime
;../time.c:100: timeptr->tm_year+1900);
	lda	(_asctime_timeptr_1_1 + 1)
	add	#0x05
	sta	*(_asctime_sloc0_1_0 + 1)
	lda	_asctime_timeptr_1_1
	adc	#0x00
	sta	*_asctime_sloc0_1_0
	ldhx	*_asctime_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_asctime_sloc0_1_0
	lda	,x
	sta	*(_asctime_sloc0_1_0 + 1)
	lda	*(_asctime_sloc0_1_0 + 1)
	add	#0x6C
	sta	*(_asctime_sloc0_1_0 + 1)
	lda	*_asctime_sloc0_1_0
	adc	#0x07
	sta	*_asctime_sloc0_1_0
;../time.c:99: timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec, 
	lda	_asctime_timeptr_1_1
	ldx	(_asctime_timeptr_1_1 + 1)
	psha
	pulh
	lda	,x
	sta	*(_asctime_sloc1_1_0 + 1)
	clr	*_asctime_sloc1_1_0
	lda	(_asctime_timeptr_1_1 + 1)
	add	#0x01
	sta	*(_asctime_sloc2_1_0 + 1)
	lda	_asctime_timeptr_1_1
	adc	#0x00
	sta	*_asctime_sloc2_1_0
	ldhx	*_asctime_sloc2_1_0
	lda	,x
	sta	*(_asctime_sloc2_1_0 + 1)
	clr	*_asctime_sloc2_1_0
	lda	(_asctime_timeptr_1_1 + 1)
	add	#0x02
	sta	*(_asctime_sloc3_1_0 + 1)
	lda	_asctime_timeptr_1_1
	adc	#0x00
	sta	*_asctime_sloc3_1_0
	ldhx	*_asctime_sloc3_1_0
	lda	,x
	sta	*(_asctime_sloc3_1_0 + 1)
	clr	*_asctime_sloc3_1_0
;../time.c:98: __day[timeptr->tm_wday], __month[timeptr->tm_mon], timeptr->tm_mday,
	lda	(_asctime_timeptr_1_1 + 1)
	add	#0x03
	sta	*(_asctime_sloc4_1_0 + 1)
	lda	_asctime_timeptr_1_1
	adc	#0x00
	sta	*_asctime_sloc4_1_0
	ldhx	*_asctime_sloc4_1_0
	lda	,x
	sta	*(_asctime_sloc4_1_0 + 1)
	clr	*_asctime_sloc4_1_0
	lda	(_asctime_timeptr_1_1 + 1)
	add	#0x04
	sta	*(_asctime_sloc5_1_0 + 1)
	lda	_asctime_timeptr_1_1
	adc	#0x00
	sta	*_asctime_sloc5_1_0
	ldhx	*_asctime_sloc5_1_0
	lda	,x
	lsla	
	tax
	clrh
	lda	___month,x
	sta	*_asctime_sloc5_1_0
	lda	(___month + 1),x
	sta	*(_asctime_sloc5_1_0 + 1)
	lda	(_asctime_timeptr_1_1 + 1)
	add	#0x07
	sta	*(_asctime_sloc6_1_0 + 1)
	lda	_asctime_timeptr_1_1
	adc	#0x00
	sta	*_asctime_sloc6_1_0
	ldhx	*_asctime_sloc6_1_0
	lda	,x
	lsla	
	tax
	clrh
	lda	___day,x
	sta	*_asctime_sloc6_1_0
	lda	(___day + 1),x
	sta	*(_asctime_sloc6_1_0 + 1)
;../time.c:97: sprintf (ascTimeBuffer, "%s %s %2d %02d:%02d:%02d %04d\n",
	lda	*(_asctime_sloc0_1_0 + 1)
	psha
	lda	*_asctime_sloc0_1_0
	psha
	lda	*(_asctime_sloc1_1_0 + 1)
	psha
	lda	*_asctime_sloc1_1_0
	psha
	lda	*(_asctime_sloc2_1_0 + 1)
	psha
	lda	*_asctime_sloc2_1_0
	psha
	lda	*(_asctime_sloc3_1_0 + 1)
	psha
	lda	*_asctime_sloc3_1_0
	psha
	lda	*(_asctime_sloc4_1_0 + 1)
	psha
	lda	*_asctime_sloc4_1_0
	psha
	lda	*(_asctime_sloc5_1_0 + 1)
	psha
	lda	*_asctime_sloc5_1_0
	psha
	lda	*(_asctime_sloc6_1_0 + 1)
	psha
	lda	*_asctime_sloc6_1_0
	psha
	ldhx	#__str_0
	pshx
	pshh
	ldhx	#_ascTimeBuffer
	pshx
	pshh
	jsr	_sprintf
	ais	#18
;../time.c:101: return ascTimeBuffer;
	ldx	#>_ascTimeBuffer
	lda	#_ascTimeBuffer
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'ctime'
;------------------------------------------------------------
;sloc0                     Allocated with name '_ctime_sloc0_1_0'
;timep                     Allocated to registers 
;------------------------------------------------------------
;../time.c:104: char *ctime(time_t *timep) {
;	-----------------------------------------
;	 function ctime
;	-----------------------------------------
_ctime:
;../time.c:105: return asctime(localtime(timep));
	jsr	_localtime
	jsr	_asctime
	sta	*(_ctime_sloc0_1_0 + 1)
	stx	*_ctime_sloc0_1_0
	ldx	*_ctime_sloc0_1_0
	lda	*(_ctime_sloc0_1_0 + 1)
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'localtime'
;------------------------------------------------------------
;sloc0                     Allocated with name '_localtime_sloc0_1_0'
;timep                     Allocated to registers 
;------------------------------------------------------------
;../time.c:121: struct tm *localtime(time_t *timep) {
;	-----------------------------------------
;	 function localtime
;	-----------------------------------------
_localtime:
;../time.c:122: return gmtime(timep);
	jsr	_gmtime
	sta	*(_localtime_sloc0_1_0 + 1)
	stx	*_localtime_sloc0_1_0
	ldx	*_localtime_sloc0_1_0
	lda	*(_localtime_sloc0_1_0 + 1)
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'gmtime'
;------------------------------------------------------------
;sloc0                     Allocated with name '_gmtime_sloc0_1_0'
;sloc1                     Allocated with name '_gmtime_sloc1_1_0'
;sloc2                     Allocated with name '_gmtime_sloc2_1_0'
;timep                     Allocated with name '_gmtime_timep_1_1'
;epoch                     Allocated with name '_gmtime_epoch_1_1'
;year                      Allocated with name '_gmtime_year_1_1'
;month                     Allocated to registers 
;monthLength               Allocated with name '_gmtime_monthLength_1_1'
;days                      Allocated with name '_gmtime_days_1_1'
;------------------------------------------------------------
;../time.c:125: struct tm *gmtime(time_t *timep) {
;	-----------------------------------------
;	 function gmtime
;	-----------------------------------------
_gmtime:
	sta	(_gmtime_timep_1_1 + 1)
	stx	_gmtime_timep_1_1
;../time.c:126: unsigned long epoch=*timep;
	lda	_gmtime_timep_1_1
	ldx	(_gmtime_timep_1_1 + 1)
	psha
	pulh
	lda	,x
	aix	#1
	sta	_gmtime_epoch_1_1
	lda	,x
	aix	#1
	sta	(_gmtime_epoch_1_1 + 1)
	lda	,x
	aix	#1
	sta	(_gmtime_epoch_1_1 + 2)
	lda	,x
	sta	(_gmtime_epoch_1_1 + 3)
;../time.c:131: lastTime.tm_sec=epoch%60;
	lda	_gmtime_epoch_1_1
	sta	__modulong_PARM_1
	lda	(_gmtime_epoch_1_1 + 1)
	sta	(__modulong_PARM_1 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	(__modulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 3)
	sta	(__modulong_PARM_1 + 3)
	clra
	sta	__modulong_PARM_2
	sta	(__modulong_PARM_2 + 1)
	sta	(__modulong_PARM_2 + 2)
	lda	#0x3C
	sta	(__modulong_PARM_2 + 3)
	jsr	__modulong
	sta	*(_gmtime_sloc0_1_0 + 3)
	stx	*(_gmtime_sloc0_1_0 + 2)
	mov	*__ret2,*(_gmtime_sloc0_1_0 + 1)
	mov	*__ret3,*_gmtime_sloc0_1_0
	lda	*(_gmtime_sloc0_1_0 + 3)
	sta	_lastTime
;../time.c:132: epoch/=60; // now it is minutes
	lda	_gmtime_epoch_1_1
	sta	__divulong_PARM_1
	lda	(_gmtime_epoch_1_1 + 1)
	sta	(__divulong_PARM_1 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	(__divulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 3)
	sta	(__divulong_PARM_1 + 3)
	clra
	sta	__divulong_PARM_2
	sta	(__divulong_PARM_2 + 1)
	sta	(__divulong_PARM_2 + 2)
	lda	#0x3C
	sta	(__divulong_PARM_2 + 3)
	jsr	__divulong
	sta	(_gmtime_epoch_1_1 + 3)
	stx	(_gmtime_epoch_1_1 + 2)
	lda	*__ret2
	sta	(_gmtime_epoch_1_1 + 1)
	lda	*__ret3
	sta	_gmtime_epoch_1_1
;../time.c:133: lastTime.tm_min=epoch%60;
	lda	_gmtime_epoch_1_1
	sta	__modulong_PARM_1
	lda	(_gmtime_epoch_1_1 + 1)
	sta	(__modulong_PARM_1 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	(__modulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 3)
	sta	(__modulong_PARM_1 + 3)
	clra
	sta	__modulong_PARM_2
	sta	(__modulong_PARM_2 + 1)
	sta	(__modulong_PARM_2 + 2)
	lda	#0x3C
	sta	(__modulong_PARM_2 + 3)
	jsr	__modulong
	sta	*(_gmtime_sloc0_1_0 + 3)
	stx	*(_gmtime_sloc0_1_0 + 2)
	mov	*__ret2,*(_gmtime_sloc0_1_0 + 1)
	mov	*__ret3,*_gmtime_sloc0_1_0
	lda	*(_gmtime_sloc0_1_0 + 3)
	sta	(_lastTime + 0x0001)
;../time.c:134: epoch/=60; // now it is hours
	lda	_gmtime_epoch_1_1
	sta	__divulong_PARM_1
	lda	(_gmtime_epoch_1_1 + 1)
	sta	(__divulong_PARM_1 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	(__divulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 3)
	sta	(__divulong_PARM_1 + 3)
	clra
	sta	__divulong_PARM_2
	sta	(__divulong_PARM_2 + 1)
	sta	(__divulong_PARM_2 + 2)
	lda	#0x3C
	sta	(__divulong_PARM_2 + 3)
	jsr	__divulong
	sta	(_gmtime_epoch_1_1 + 3)
	stx	(_gmtime_epoch_1_1 + 2)
	lda	*__ret2
	sta	(_gmtime_epoch_1_1 + 1)
	lda	*__ret3
	sta	_gmtime_epoch_1_1
;../time.c:135: lastTime.tm_hour=epoch%24;
	lda	_gmtime_epoch_1_1
	sta	__modulong_PARM_1
	lda	(_gmtime_epoch_1_1 + 1)
	sta	(__modulong_PARM_1 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	(__modulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 3)
	sta	(__modulong_PARM_1 + 3)
	clra
	sta	__modulong_PARM_2
	sta	(__modulong_PARM_2 + 1)
	sta	(__modulong_PARM_2 + 2)
	lda	#0x18
	sta	(__modulong_PARM_2 + 3)
	jsr	__modulong
	sta	*(_gmtime_sloc0_1_0 + 3)
	stx	*(_gmtime_sloc0_1_0 + 2)
	mov	*__ret2,*(_gmtime_sloc0_1_0 + 1)
	mov	*__ret3,*_gmtime_sloc0_1_0
	lda	*(_gmtime_sloc0_1_0 + 3)
	sta	(_lastTime + 0x0002)
;../time.c:136: epoch/=24; // now it is days
	lda	_gmtime_epoch_1_1
	sta	__divulong_PARM_1
	lda	(_gmtime_epoch_1_1 + 1)
	sta	(__divulong_PARM_1 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	(__divulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 3)
	sta	(__divulong_PARM_1 + 3)
	clra
	sta	__divulong_PARM_2
	sta	(__divulong_PARM_2 + 1)
	sta	(__divulong_PARM_2 + 2)
	lda	#0x18
	sta	(__divulong_PARM_2 + 3)
	jsr	__divulong
	sta	(_gmtime_epoch_1_1 + 3)
	stx	(_gmtime_epoch_1_1 + 2)
	lda	*__ret2
	sta	(_gmtime_epoch_1_1 + 1)
	lda	*__ret3
	sta	_gmtime_epoch_1_1
;../time.c:137: lastTime.tm_wday=(epoch+4)%7;
	lda	(_gmtime_epoch_1_1 + 3)
	add	#0x04
	sta	(__modulong_PARM_1 + 3)
	lda	(_gmtime_epoch_1_1 + 2)
	adc	#0x00
	sta	(__modulong_PARM_1 + 2)
	lda	(_gmtime_epoch_1_1 + 1)
	adc	#0x00
	sta	(__modulong_PARM_1 + 1)
	lda	_gmtime_epoch_1_1
	adc	#0x00
	sta	__modulong_PARM_1
	clra
	sta	__modulong_PARM_2
	sta	(__modulong_PARM_2 + 1)
	sta	(__modulong_PARM_2 + 2)
	lda	#0x07
	sta	(__modulong_PARM_2 + 3)
	jsr	__modulong
	sta	*(_gmtime_sloc0_1_0 + 3)
	stx	*(_gmtime_sloc0_1_0 + 2)
	mov	*__ret2,*(_gmtime_sloc0_1_0 + 1)
	mov	*__ret3,*_gmtime_sloc0_1_0
	lda	*(_gmtime_sloc0_1_0 + 3)
	sta	(_lastTime + 0x0007)
;../time.c:140: days=0;
	clra
	sta	_gmtime_days_1_1
	sta	(_gmtime_days_1_1 + 1)
	sta	(_gmtime_days_1_1 + 2)
	sta	(_gmtime_days_1_1 + 3)
;../time.c:141: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
	mov	#0x07,*_gmtime_sloc0_1_0
	mov	#0xB2,*(_gmtime_sloc0_1_0 + 1)
00101$:
	lda	*(_gmtime_sloc0_1_0 + 1)
	and	#0x03
	sta	*(_gmtime_sloc1_1_0 + 1)
	clr	*_gmtime_sloc1_1_0
	lda	*(_gmtime_sloc1_1_0 + 1)
	ora	*_gmtime_sloc1_1_0
	beq	00134$
	lda	#0x01
00134$:
	eor	#0x01
	tsta
	beq	00119$
00135$:
	mov	#0x01,*_gmtime_sloc1_1_0
	mov	#0x6E,*(_gmtime_sloc1_1_0 + 1)
	bra	00120$
00119$:
	mov	#0x01,*_gmtime_sloc1_1_0
	mov	#0x6D,*(_gmtime_sloc1_1_0 + 1)
00120$:
	mov	*(_gmtime_sloc1_1_0 + 1),*(_gmtime_sloc2_1_0 + 3)
	mov	*_gmtime_sloc1_1_0,*(_gmtime_sloc2_1_0 + 2)
	lda	*_gmtime_sloc1_1_0
	rola	
	clra	
	sbc	#0x00
	sta	*(_gmtime_sloc2_1_0 + 1)
	sta	*_gmtime_sloc2_1_0
	lda	(_gmtime_days_1_1 + 3)
	add	*(_gmtime_sloc2_1_0 + 3)
	sta	*(_gmtime_sloc2_1_0 + 3)
	lda	(_gmtime_days_1_1 + 2)
	adc	*(_gmtime_sloc2_1_0 + 2)
	sta	*(_gmtime_sloc2_1_0 + 2)
	lda	(_gmtime_days_1_1 + 1)
	adc	*(_gmtime_sloc2_1_0 + 1)
	sta	*(_gmtime_sloc2_1_0 + 1)
	lda	_gmtime_days_1_1
	adc	*_gmtime_sloc2_1_0
	sta	*_gmtime_sloc2_1_0
	lda	*_gmtime_sloc2_1_0
	sta	_gmtime_days_1_1
	lda	*(_gmtime_sloc2_1_0 + 1)
	sta	(_gmtime_days_1_1 + 1)
	lda	*(_gmtime_sloc2_1_0 + 2)
	sta	(_gmtime_days_1_1 + 2)
	lda	*(_gmtime_sloc2_1_0 + 3)
	sta	(_gmtime_days_1_1 + 3)
	lda	(_gmtime_epoch_1_1 + 3)
	sub	*(_gmtime_sloc2_1_0 + 3)
	lda	(_gmtime_epoch_1_1 + 2)
	sbc	*(_gmtime_sloc2_1_0 + 2)
	lda	(_gmtime_epoch_1_1 + 1)
	sbc	*(_gmtime_sloc2_1_0 + 1)
	lda	_gmtime_epoch_1_1
	sbc	*_gmtime_sloc2_1_0
	bcs	00132$
00136$:
;../time.c:142: year++;
	ldhx	*_gmtime_sloc0_1_0
	aix	#1
	sthx	*_gmtime_sloc0_1_0
	jmp	00101$
00132$:
	lda	*_gmtime_sloc0_1_0
	sta	_gmtime_year_1_1
	lda	*(_gmtime_sloc0_1_0 + 1)
	sta	(_gmtime_year_1_1 + 1)
;../time.c:144: lastTime.tm_year=year-1900;
	lda	*(_gmtime_sloc0_1_0 + 1)
	sub	#0x6C
	sta	*(_gmtime_sloc2_1_0 + 1)
	lda	*_gmtime_sloc0_1_0
	sbc	#0x07
	sta	*_gmtime_sloc2_1_0
	lda	*_gmtime_sloc2_1_0
	sta	(_lastTime + 0x0005)
	lda	*(_gmtime_sloc2_1_0 + 1)
	sta	((_lastTime + 0x0005) + 1)
;../time.c:146: days -= LEAP_YEAR(year) ? 366 : 365;
	lda	*(_gmtime_sloc0_1_0 + 1)
	and	#0x03
	sta	*(_gmtime_sloc2_1_0 + 1)
	clr	*_gmtime_sloc2_1_0
	lda	*(_gmtime_sloc2_1_0 + 1)
	ora	*_gmtime_sloc2_1_0
	beq	00137$
	lda	#0x01
00137$:
	eor	#0x01
	tsta
	beq	00121$
00138$:
	mov	#0x01,*_gmtime_sloc2_1_0
	mov	#0x6E,*(_gmtime_sloc2_1_0 + 1)
	bra	00122$
00121$:
	mov	#0x01,*_gmtime_sloc2_1_0
	mov	#0x6D,*(_gmtime_sloc2_1_0 + 1)
00122$:
	mov	*(_gmtime_sloc2_1_0 + 1),*(_gmtime_sloc2_1_0 + 3)
	mov	*_gmtime_sloc2_1_0,*(_gmtime_sloc2_1_0 + 2)
	lda	*_gmtime_sloc2_1_0
	rola	
	clra	
	sbc	#0x00
	sta	*(_gmtime_sloc2_1_0 + 1)
	sta	*_gmtime_sloc2_1_0
	lda	(_gmtime_days_1_1 + 3)
	sub	*(_gmtime_sloc2_1_0 + 3)
	sta	(_gmtime_days_1_1 + 3)
	lda	(_gmtime_days_1_1 + 2)
	sbc	*(_gmtime_sloc2_1_0 + 2)
	sta	(_gmtime_days_1_1 + 2)
	lda	(_gmtime_days_1_1 + 1)
	sbc	*(_gmtime_sloc2_1_0 + 1)
	sta	(_gmtime_days_1_1 + 1)
	lda	_gmtime_days_1_1
	sbc	*_gmtime_sloc2_1_0
	sta	_gmtime_days_1_1
;../time.c:147: epoch -= days; // now it is days in this year, starting at 0
	lda	(_gmtime_epoch_1_1 + 3)
	sub	(_gmtime_days_1_1 + 3)
	sta	(_gmtime_epoch_1_1 + 3)
	lda	(_gmtime_epoch_1_1 + 2)
	sbc	(_gmtime_days_1_1 + 2)
	sta	(_gmtime_epoch_1_1 + 2)
	lda	(_gmtime_epoch_1_1 + 1)
	sbc	(_gmtime_days_1_1 + 1)
	sta	(_gmtime_epoch_1_1 + 1)
	lda	_gmtime_epoch_1_1
	sbc	_gmtime_days_1_1
	sta	_gmtime_epoch_1_1
;../time.c:148: lastTime.tm_yday=epoch;
	lda	(_gmtime_epoch_1_1 + 3)
	sta	*(_gmtime_sloc2_1_0 + 1)
	lda	(_gmtime_epoch_1_1 + 2)
	sta	*_gmtime_sloc2_1_0
	lda	*_gmtime_sloc2_1_0
	sta	(_lastTime + 0x0008)
	lda	*(_gmtime_sloc2_1_0 + 1)
	sta	((_lastTime + 0x0008) + 1)
;../time.c:153: for (month=0; month<12; month++) {
	lda	(_gmtime_year_1_1 + 1)
	and	#0x03
	sta	*(_gmtime_sloc2_1_0 + 1)
	clr	*_gmtime_sloc2_1_0
	clr	*_gmtime_sloc1_1_0
00113$:
	lda	*_gmtime_sloc1_1_0
	cmp	#0x0C
	bcs	00139$
	jmp	00116$
00139$:
;../time.c:154: if (month==1) { // februari
	lda	*_gmtime_sloc1_1_0
	cmp	#0x01
	bne	00108$
00140$:
;../time.c:155: if (LEAP_YEAR(year)) {
	lda	*(_gmtime_sloc2_1_0 + 1)
	ora	*_gmtime_sloc2_1_0
	bne	00105$
00141$:
;../time.c:156: monthLength=29;
	lda	#0x1D
	sta	_gmtime_monthLength_1_1
	bra	00109$
00105$:
;../time.c:158: monthLength=28;
	lda	#0x1C
	sta	_gmtime_monthLength_1_1
	bra	00109$
00108$:
;../time.c:161: monthLength = monthDays[month];
	ldx	*_gmtime_sloc1_1_0
	clrh
	lda	_monthDays,x
	sta	_gmtime_monthLength_1_1
00109$:
;../time.c:164: if (epoch>=monthLength) {
	lda	_gmtime_monthLength_1_1
	sta	*(_gmtime_sloc0_1_0 + 3)
	clr	*(_gmtime_sloc0_1_0 + 2)
	clr	*(_gmtime_sloc0_1_0 + 1)
	clr	*_gmtime_sloc0_1_0
	lda	(_gmtime_epoch_1_1 + 3)
	sub	*(_gmtime_sloc0_1_0 + 3)
	lda	(_gmtime_epoch_1_1 + 2)
	sbc	*(_gmtime_sloc0_1_0 + 2)
	lda	(_gmtime_epoch_1_1 + 1)
	sbc	*(_gmtime_sloc0_1_0 + 1)
	lda	_gmtime_epoch_1_1
	sbc	*_gmtime_sloc0_1_0
	bcs	00116$
00142$:
;../time.c:165: epoch-=monthLength;
	lda	_gmtime_monthLength_1_1
	sta	*(_gmtime_sloc0_1_0 + 3)
	clr	*(_gmtime_sloc0_1_0 + 2)
	clr	*(_gmtime_sloc0_1_0 + 1)
	clr	*_gmtime_sloc0_1_0
	lda	(_gmtime_epoch_1_1 + 3)
	sub	*(_gmtime_sloc0_1_0 + 3)
	sta	(_gmtime_epoch_1_1 + 3)
	lda	(_gmtime_epoch_1_1 + 2)
	sbc	*(_gmtime_sloc0_1_0 + 2)
	sta	(_gmtime_epoch_1_1 + 2)
	lda	(_gmtime_epoch_1_1 + 1)
	sbc	*(_gmtime_sloc0_1_0 + 1)
	sta	(_gmtime_epoch_1_1 + 1)
	lda	_gmtime_epoch_1_1
	sbc	*_gmtime_sloc0_1_0
	sta	_gmtime_epoch_1_1
;../time.c:153: for (month=0; month<12; month++) {
	inc	*_gmtime_sloc1_1_0
	jmp	00113$
00116$:
;../time.c:170: lastTime.tm_mon=month;
	lda	*_gmtime_sloc1_1_0
	sta	(_lastTime + 0x0004)
;../time.c:171: lastTime.tm_mday=epoch+1;
	lda	(_gmtime_epoch_1_1 + 3)
	inca
	sta	(_lastTime + 0x0003)
;../time.c:173: lastTime.tm_isdst=0;
	clra
	sta	(_lastTime + 0x000a)
;../time.c:175: return &lastTime;
	ldx	#>_lastTime
	lda	#_lastTime
00117$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'mktime'
;------------------------------------------------------------
;sloc0                     Allocated with name '_mktime_sloc0_1_0'
;sloc1                     Allocated with name '_mktime_sloc1_1_0'
;sloc2                     Allocated with name '_mktime_sloc2_1_0'
;sloc3                     Allocated with name '_mktime_sloc3_1_0'
;timeptr                   Allocated with name '_mktime_timeptr_1_1'
;year                      Allocated with name '_mktime_year_1_1'
;month                     Allocated with name '_mktime_month_1_1'
;i                         Allocated to registers 
;seconds                   Allocated with name '_mktime_seconds_1_1'
;------------------------------------------------------------
;../time.c:179: time_t mktime(struct tm *timeptr) {
;	-----------------------------------------
;	 function mktime
;	-----------------------------------------
_mktime:
	sta	(_mktime_timeptr_1_1 + 1)
	stx	_mktime_timeptr_1_1
;../time.c:180: int year=timeptr->tm_year+1900, month=timeptr->tm_mon, i;
	lda	(_mktime_timeptr_1_1 + 1)
	add	#0x05
	sta	*(_mktime_sloc0_1_0 + 1)
	lda	_mktime_timeptr_1_1
	adc	#0x00
	sta	*_mktime_sloc0_1_0
	ldhx	*_mktime_sloc0_1_0
	lda	,x
	aix	#1
	sta	*_mktime_sloc0_1_0
	lda	,x
	sta	*(_mktime_sloc0_1_0 + 1)
	lda	*(_mktime_sloc0_1_0 + 1)
	add	#0x6C
	sta	(_mktime_year_1_1 + 1)
	lda	*_mktime_sloc0_1_0
	adc	#0x07
	sta	_mktime_year_1_1
	lda	(_mktime_timeptr_1_1 + 1)
	add	#0x04
	sta	*(_mktime_sloc0_1_0 + 1)
	lda	_mktime_timeptr_1_1
	adc	#0x00
	sta	*_mktime_sloc0_1_0
	ldhx	*_mktime_sloc0_1_0
	lda	,x
	sta	(_mktime_month_1_1 + 1)
	clrx
	stx	_mktime_month_1_1
;../time.c:183: CheckTime(timeptr);
	ldx	_mktime_timeptr_1_1
	lda	(_mktime_timeptr_1_1 + 1)
	jsr	_CheckTime
;../time.c:186: seconds= (year-1970)*(60*60*24L*365);
	lda	(_mktime_year_1_1 + 1)
	sub	#0xB2
	sta	*(_mktime_sloc0_1_0 + 1)
	lda	_mktime_year_1_1
	sbc	#0x07
	sta	*_mktime_sloc0_1_0
	lda	*(_mktime_sloc0_1_0 + 1)
	sta	(__mullong_PARM_2 + 3)
	lda	*_mktime_sloc0_1_0
	sta	(__mullong_PARM_2 + 2)
	lda	*_mktime_sloc0_1_0
	rola	
	clra	
	sbc	#0x00
	sta	(__mullong_PARM_2 + 1)
	sta	__mullong_PARM_2
	lda	#0x01
	sta	__mullong_PARM_1
	lda	#0xE1
	sta	(__mullong_PARM_1 + 1)
	lda	#0x33
	sta	(__mullong_PARM_1 + 2)
	lda	#0x80
	sta	(__mullong_PARM_1 + 3)
	jsr	__mullong
	sta	(_mktime_seconds_1_1 + 3)
	stx	(_mktime_seconds_1_1 + 2)
	lda	*__ret2
	sta	(_mktime_seconds_1_1 + 1)
	lda	*__ret3
	sta	_mktime_seconds_1_1
;../time.c:189: for (i=1970; i<year; i++) {
	lda	_mktime_seconds_1_1
	sta	*_mktime_sloc1_1_0
	lda	(_mktime_seconds_1_1 + 1)
	sta	*(_mktime_sloc1_1_0 + 1)
	lda	(_mktime_seconds_1_1 + 2)
	sta	*(_mktime_sloc1_1_0 + 2)
	lda	(_mktime_seconds_1_1 + 3)
	sta	*(_mktime_sloc1_1_0 + 3)
	mov	#0x07,*_mktime_sloc0_1_0
	mov	#0xB2,*(_mktime_sloc0_1_0 + 1)
00107$:
	lda	*(_mktime_sloc0_1_0 + 1)
	sub	(_mktime_year_1_1 + 1)
	lda	*_mktime_sloc0_1_0
	sbc	_mktime_year_1_1
	bge	00124$
00126$:
;../time.c:190: if (LEAP_YEAR(i)) {
	clra
	sta	__modsint_PARM_2
	lda	#0x04
	sta	(__modsint_PARM_2 + 1)
	ldx	*_mktime_sloc0_1_0
	lda	*(_mktime_sloc0_1_0 + 1)
	jsr	__modsint
	tsta
	bne	00127$
	tstx
00127$:
	bne	00109$
00128$:
;../time.c:191: seconds+= 60*60*24L;
	lda	*(_mktime_sloc1_1_0 + 3)
	add	#0x80
	sta	*(_mktime_sloc1_1_0 + 3)
	lda	*(_mktime_sloc1_1_0 + 2)
	adc	#0x51
	sta	*(_mktime_sloc1_1_0 + 2)
	lda	*(_mktime_sloc1_1_0 + 1)
	adc	#0x01
	sta	*(_mktime_sloc1_1_0 + 1)
	lda	*_mktime_sloc1_1_0
	adc	#0x00
	sta	*_mktime_sloc1_1_0
00109$:
;../time.c:189: for (i=1970; i<year; i++) {
	ldhx	*_mktime_sloc0_1_0
	aix	#1
	sthx	*_mktime_sloc0_1_0
	bra	00107$
00124$:
	lda	*_mktime_sloc1_1_0
	sta	_mktime_seconds_1_1
	lda	*(_mktime_sloc1_1_0 + 1)
	sta	(_mktime_seconds_1_1 + 1)
	lda	*(_mktime_sloc1_1_0 + 2)
	sta	(_mktime_seconds_1_1 + 2)
	lda	*(_mktime_sloc1_1_0 + 3)
	sta	(_mktime_seconds_1_1 + 3)
;../time.c:196: for (i=0; i<month; i++) {
	clra
	sta	__modsint_PARM_2
	lda	#0x04
	sta	(__modsint_PARM_2 + 1)
	ldx	_mktime_year_1_1
	lda	(_mktime_year_1_1 + 1)
	jsr	__modsint
	sta	*(_mktime_sloc1_1_0 + 1)
	stx	*_mktime_sloc1_1_0
	clr	*_mktime_sloc0_1_0
	clr	*(_mktime_sloc0_1_0 + 1)
00111$:
	lda	*(_mktime_sloc0_1_0 + 1)
	sub	(_mktime_month_1_1 + 1)
	lda	*_mktime_sloc0_1_0
	sbc	_mktime_month_1_1
	blt	00129$
	jmp	00114$
00129$:
;../time.c:197: if (i==1 && LEAP_YEAR(year)) { 
	ldhx	*_mktime_sloc0_1_0
	cphx	#0x0001
	bne	00104$
00130$:
	lda	*(_mktime_sloc1_1_0 + 1)
	ora	*_mktime_sloc1_1_0
	bne	00104$
00131$:
;../time.c:198: seconds+= 60*60*24L*29;
	lda	(_mktime_seconds_1_1 + 3)
	add	#0x80
	sta	(_mktime_seconds_1_1 + 3)
	lda	(_mktime_seconds_1_1 + 2)
	adc	#0x3B
	sta	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 1)
	adc	#0x26
	sta	(_mktime_seconds_1_1 + 1)
	lda	_mktime_seconds_1_1
	adc	#0x00
	sta	_mktime_seconds_1_1
	bra	00113$
00104$:
;../time.c:200: seconds+= 60*60*24L*monthDays[i];
	ldhx	*_mktime_sloc0_1_0
	lda	_monthDays,x
	sta	(__mullong_PARM_2 + 3)
	rola	
	clra	
	sbc	#0x00
	sta	(__mullong_PARM_2 + 2)
	sta	(__mullong_PARM_2 + 1)
	sta	__mullong_PARM_2
	clra
	sta	__mullong_PARM_1
	lda	#0x01
	sta	(__mullong_PARM_1 + 1)
	lda	#0x51
	sta	(__mullong_PARM_1 + 2)
	lda	#0x80
	sta	(__mullong_PARM_1 + 3)
	jsr	__mullong
	sta	*(_mktime_sloc3_1_0 + 3)
	stx	*(_mktime_sloc3_1_0 + 2)
	mov	*__ret2,*(_mktime_sloc3_1_0 + 1)
	mov	*__ret3,*_mktime_sloc3_1_0
	lda	(_mktime_seconds_1_1 + 3)
	add	*(_mktime_sloc3_1_0 + 3)
	sta	(_mktime_seconds_1_1 + 3)
	lda	(_mktime_seconds_1_1 + 2)
	adc	*(_mktime_sloc3_1_0 + 2)
	sta	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 1)
	adc	*(_mktime_sloc3_1_0 + 1)
	sta	(_mktime_seconds_1_1 + 1)
	lda	_mktime_seconds_1_1
	adc	*_mktime_sloc3_1_0
	sta	_mktime_seconds_1_1
00113$:
;../time.c:196: for (i=0; i<month; i++) {
	ldhx	*_mktime_sloc0_1_0
	aix	#1
	sthx	*_mktime_sloc0_1_0
	jmp	00111$
00114$:
;../time.c:204: seconds+= (timeptr->tm_mday-1)*60*60*24L;
	lda	(_mktime_timeptr_1_1 + 1)
	add	#0x03
	sta	*(_mktime_sloc3_1_0 + 1)
	lda	_mktime_timeptr_1_1
	adc	#0x00
	sta	*_mktime_sloc3_1_0
	ldhx	*_mktime_sloc3_1_0
	lda	,x
	sta	*(_mktime_sloc3_1_0 + 1)
	clr	*_mktime_sloc3_1_0
	lda	*(_mktime_sloc3_1_0 + 1)
	sub	#0x01
	sta	*(_mktime_sloc3_1_0 + 1)
	lda	*_mktime_sloc3_1_0
	sbc	#0x00
	sta	*_mktime_sloc3_1_0
	lda	*(_mktime_sloc3_1_0 + 1)
	sta	(__mullong_PARM_2 + 3)
	lda	*_mktime_sloc3_1_0
	sta	(__mullong_PARM_2 + 2)
	lda	*_mktime_sloc3_1_0
	rola	
	clra	
	sbc	#0x00
	sta	(__mullong_PARM_2 + 1)
	sta	__mullong_PARM_2
	clra
	sta	__mullong_PARM_1
	lda	#0x01
	sta	(__mullong_PARM_1 + 1)
	lda	#0x51
	sta	(__mullong_PARM_1 + 2)
	lda	#0x80
	sta	(__mullong_PARM_1 + 3)
	jsr	__mullong
	sta	*(_mktime_sloc3_1_0 + 3)
	stx	*(_mktime_sloc3_1_0 + 2)
	mov	*__ret2,*(_mktime_sloc3_1_0 + 1)
	mov	*__ret3,*_mktime_sloc3_1_0
	lda	(_mktime_seconds_1_1 + 3)
	add	*(_mktime_sloc3_1_0 + 3)
	sta	(_mktime_seconds_1_1 + 3)
	lda	(_mktime_seconds_1_1 + 2)
	adc	*(_mktime_sloc3_1_0 + 2)
	sta	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 1)
	adc	*(_mktime_sloc3_1_0 + 1)
	sta	(_mktime_seconds_1_1 + 1)
	lda	_mktime_seconds_1_1
	adc	*_mktime_sloc3_1_0
	sta	_mktime_seconds_1_1
;../time.c:205: seconds+= timeptr->tm_hour*60*60L;
	lda	(_mktime_timeptr_1_1 + 1)
	add	#0x02
	sta	*(_mktime_sloc3_1_0 + 1)
	lda	_mktime_timeptr_1_1
	adc	#0x00
	sta	*_mktime_sloc3_1_0
	ldhx	*_mktime_sloc3_1_0
	lda	,x
	sta	(__mullong_PARM_2 + 3)
	clrx
	stx	(__mullong_PARM_2 + 2)
	clrx
	stx	(__mullong_PARM_2 + 1)
	clrx
	stx	__mullong_PARM_2
	clra
	sta	__mullong_PARM_1
	sta	(__mullong_PARM_1 + 1)
	lda	#0x0E
	sta	(__mullong_PARM_1 + 2)
	lda	#0x10
	sta	(__mullong_PARM_1 + 3)
	jsr	__mullong
	sta	*(_mktime_sloc3_1_0 + 3)
	stx	*(_mktime_sloc3_1_0 + 2)
	mov	*__ret2,*(_mktime_sloc3_1_0 + 1)
	mov	*__ret3,*_mktime_sloc3_1_0
	lda	(_mktime_seconds_1_1 + 3)
	add	*(_mktime_sloc3_1_0 + 3)
	sta	(_mktime_seconds_1_1 + 3)
	lda	(_mktime_seconds_1_1 + 2)
	adc	*(_mktime_sloc3_1_0 + 2)
	sta	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 1)
	adc	*(_mktime_sloc3_1_0 + 1)
	sta	(_mktime_seconds_1_1 + 1)
	lda	_mktime_seconds_1_1
	adc	*_mktime_sloc3_1_0
	sta	_mktime_seconds_1_1
;../time.c:206: seconds+= timeptr->tm_min*60;
	lda	(_mktime_timeptr_1_1 + 1)
	add	#0x01
	sta	*(_mktime_sloc3_1_0 + 1)
	lda	_mktime_timeptr_1_1
	adc	#0x00
	sta	*_mktime_sloc3_1_0
	ldhx	*_mktime_sloc3_1_0
	lda	,x
	ldx	#0x3C
	mul
	sta	*(_mktime_sloc3_1_0 + 1)
	stx	*_mktime_sloc3_1_0
	mov	*(_mktime_sloc3_1_0 + 1),*(_mktime_sloc3_1_0 + 3)
	mov	*_mktime_sloc3_1_0,*(_mktime_sloc3_1_0 + 2)
	lda	*_mktime_sloc3_1_0
	rola	
	clra	
	sbc	#0x00
	sta	*(_mktime_sloc3_1_0 + 1)
	sta	*_mktime_sloc3_1_0
	lda	(_mktime_seconds_1_1 + 3)
	add	*(_mktime_sloc3_1_0 + 3)
	sta	(_mktime_seconds_1_1 + 3)
	lda	(_mktime_seconds_1_1 + 2)
	adc	*(_mktime_sloc3_1_0 + 2)
	sta	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 1)
	adc	*(_mktime_sloc3_1_0 + 1)
	sta	(_mktime_seconds_1_1 + 1)
	lda	_mktime_seconds_1_1
	adc	*_mktime_sloc3_1_0
	sta	_mktime_seconds_1_1
;../time.c:207: seconds+= timeptr->tm_sec;
	lda	_mktime_timeptr_1_1
	ldx	(_mktime_timeptr_1_1 + 1)
	psha
	pulh
	lda	,x
	sta	*(_mktime_sloc3_1_0 + 1)
	clr	*_mktime_sloc3_1_0
	mov	*(_mktime_sloc3_1_0 + 1),*(_mktime_sloc3_1_0 + 3)
	mov	*_mktime_sloc3_1_0,*(_mktime_sloc3_1_0 + 2)
	lda	*_mktime_sloc3_1_0
	rola	
	clra	
	sbc	#0x00
	sta	*(_mktime_sloc3_1_0 + 1)
	sta	*_mktime_sloc3_1_0
	lda	(_mktime_seconds_1_1 + 3)
	add	*(_mktime_sloc3_1_0 + 3)
	sta	(_mktime_seconds_1_1 + 3)
	lda	(_mktime_seconds_1_1 + 2)
	adc	*(_mktime_sloc3_1_0 + 2)
	sta	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 1)
	adc	*(_mktime_sloc3_1_0 + 1)
	sta	(_mktime_seconds_1_1 + 1)
	lda	_mktime_seconds_1_1
	adc	*_mktime_sloc3_1_0
	sta	_mktime_seconds_1_1
;../time.c:208: return seconds;
	lda	_mktime_seconds_1_1
	sta	*__ret3
	lda	(_mktime_seconds_1_1 + 1)
	sta	*__ret2
	ldx	(_mktime_seconds_1_1 + 2)
	lda	(_mktime_seconds_1_1 + 3)
00115$:
	rts
	.area CSEG (CODE)
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
	.dw _str_1
	.dw _str_2
	.dw _str_3
	.dw _str_4
	.dw _str_5
	.dw _str_6
	.dw _str_7
	.dw _str_8
	.dw _str_9
	.dw _str_10
	.dw _str_11
	.dw _str_12
___day:
	.dw _str_13
	.dw _str_14
	.dw _str_15
	.dw _str_16
	.dw _str_17
	.dw _str_18
	.dw _str_19
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
	.area XINIT
	.area CABS    (ABS,CODE)
