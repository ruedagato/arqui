;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:18 2015
;--------------------------------------------------------
	.module time
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _RtcRead
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
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area _DATA
_monthDays:
	.ds 12
___month::
	.ds 24
___day::
	.ds 14
_ascTimeBuffer:
	.ds 32
_lastTime:
	.ds 12
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area _OVERLAY
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;../time.c:63: static _CODE char monthDays[]={31,28,31,30,31,30,31,31,30,31,30,31};
	ld	hl,#_monthDays
	ld	(hl),#0x1F
	ld	hl,#0x0001 + _monthDays
	ld	(hl),#0x1C
	inc	hl
	ld	(hl),#0x1F
	inc	hl
	ld	(hl),#0x1E
	inc	hl
	ld	(hl),#0x1F
	inc	hl
	ld	(hl),#0x1E
	inc	hl
	ld	(hl),#0x1F
	inc	hl
	ld	(hl),#0x1F
	inc	hl
	ld	(hl),#0x1E
	inc	hl
	ld	(hl),#0x1F
	inc	hl
	ld	(hl),#0x1E
	inc	hl
	ld	(hl),#0x1F
;../time.c:65: _CODE const char * _CODE __month[]={"Jan","Feb","Mar","Apr","May","Jun",
	ld	hl,#___month
	ld	(hl),#<(__str_1)
	inc	hl
	ld	(hl),#>(__str_1)
	ld	hl,#0x0002 + ___month
	ld	(hl),#<(__str_2)
	inc	hl
	ld	(hl),#>(__str_2)
	inc	hl
	ld	(hl),#<(__str_3)
	inc	hl
	ld	(hl),#>(__str_3)
	inc	hl
	ld	(hl),#<(__str_4)
	inc	hl
	ld	(hl),#>(__str_4)
	inc	hl
	ld	(hl),#<(__str_5)
	inc	hl
	ld	(hl),#>(__str_5)
	inc	hl
	ld	(hl),#<(__str_6)
	inc	hl
	ld	(hl),#>(__str_6)
	inc	hl
	ld	(hl),#<(__str_7)
	inc	hl
	ld	(hl),#>(__str_7)
	inc	hl
	ld	(hl),#<(__str_8)
	inc	hl
	ld	(hl),#>(__str_8)
	inc	hl
	ld	(hl),#<(__str_9)
	inc	hl
	ld	(hl),#>(__str_9)
	inc	hl
	ld	(hl),#<(__str_10)
	inc	hl
	ld	(hl),#>(__str_10)
	inc	hl
	ld	(hl),#<(__str_11)
	inc	hl
	ld	(hl),#>(__str_11)
	inc	hl
	ld	(hl),#<(__str_12)
	inc	hl
	ld	(hl),#>(__str_12)
;../time.c:68: _CODE const char * _CODE __day[]={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
	ld	hl,#___day
	ld	(hl),#<(__str_13)
	inc	hl
	ld	(hl),#>(__str_13)
	ld	hl,#0x0002 + ___day
	ld	(hl),#<(__str_14)
	inc	hl
	ld	(hl),#>(__str_14)
	inc	hl
	ld	(hl),#<(__str_15)
	inc	hl
	ld	(hl),#>(__str_15)
	inc	hl
	ld	(hl),#<(__str_16)
	inc	hl
	ld	(hl),#>(__str_16)
	inc	hl
	ld	(hl),#<(__str_17)
	inc	hl
	ld	(hl),#>(__str_17)
	inc	hl
	ld	(hl),#<(__str_18)
	inc	hl
	ld	(hl),#>(__str_18)
	inc	hl
	ld	(hl),#<(__str_19)
	inc	hl
	ld	(hl),#>(__str_19)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;../time.c:42: unsigned char RtcRead(struct tm *timeptr) {
;	---------------------------------
; Function RtcRead
; ---------------------------------
_RtcRead_start::
_RtcRead:
	push	ix
	ld	ix,#0
	add	ix,sp
;../time.c:45: return 0;
	ld	l,#0x00
	pop	ix
	ret
_RtcRead_end::
;../time.c:50: time_t time(time_t *timeptr) {
;	---------------------------------
; Function time
; ---------------------------------
_time_start::
_time:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-16
	add	hl,sp
	ld	sp,hl
;../time.c:52: time_t t=-1;
	ld	bc,#0xFFFF
	ld	de,#0xFFFF
;../time.c:54: if (RtcRead(&now)) {
	ld	hl,#0x0004
	add	hl,sp
	push	bc
	push	de
	push	hl
	call	_RtcRead
	pop	af
	pop	de
	pop	bc
	xor	a,a
	or	a,l
	jr	Z,00102$
;../time.c:55: t=mktime(&now);
	ld	hl,#0x0004
	add	hl,sp
	push	hl
	call	_mktime
	pop	af
	ld	-13 (ix),d
	ld	-14 (ix),e
	ld	-15 (ix),h
	ld	-16 (ix), l
	ld	c, l
	ld	b,-15 (ix)
	ld	e,-14 (ix)
	ld	d,-13 (ix)
00102$:
;../time.c:57: if (timeptr) {
	ld	a,4 (ix)
	or	a,5 (ix)
	jr	Z,00104$
;../time.c:58: *timeptr=t;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
00104$:
;../time.c:60: return t;
	ld	l,c
	ld	h,b
	ld	sp,ix
	pop	ix
	ret
_time_end::
;../time.c:73: static void CheckTime(struct tm *timeptr) {
;	---------------------------------
; Function CheckTime
; ---------------------------------
_CheckTime:
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;../time.c:84: if (timeptr->tm_sec>59) timeptr->tm_sec=59;
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	a,(bc)
	ld	l,a
	ld	a,#0x3B
	cp	a,l
	jr	NC,00102$
	ld	(bc),a
00102$:
;../time.c:85: if (timeptr->tm_min>59) timeptr->tm_min=59;
	ld	e,c
	ld	d,b
	inc	de
	ld	a,(de)
	ld	l,a
	ld	a,#0x3B
	cp	a,l
	jr	NC,00104$
	ld	(de),a
00104$:
;../time.c:86: if (timeptr->tm_hour>23) timeptr->tm_hour=23;
	ld	e,c
	ld	d,b
	inc	de
	inc	de
	ld	a,(de)
	ld	l,a
	ld	a,#0x17
	cp	a,l
	jr	NC,00106$
	ld	(de),a
00106$:
;../time.c:87: if (timeptr->tm_wday>6) timeptr->tm_wday=6;
	ld	hl,#0x0007
	add	hl,bc
	ld	e,l
	ld	d,h
	ld	a,(de)
	ld	l,a
	ld	a,#0x06
	cp	a,l
	jr	NC,00108$
	ld	(de),a
00108$:
;../time.c:88: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
	ld	e,c
	ld	d,b
	inc	de
	inc	de
	inc	de
	ld	a,(de)
	ld	-1 (ix), a
	sub	a, #0x01
	jr	NC,00112$
	ld	a,#0x01
	ld	(de),a
	jr	00113$
00112$:
;../time.c:89: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
	ld	a,#0x1F
	sub	a, -1 (ix)
	jr	NC,00113$
	ld	a,#0x1F
	ld	(de),a
00113$:
;../time.c:90: if (timeptr->tm_mon>11) timeptr->tm_mon=11;
	ld	hl,#0x0004
	add	hl,bc
	ld	e,l
	ld	d,h
	ld	a,(de)
	ld	l,a
	ld	a,#0x0B
	cp	a,l
	jr	NC,00115$
	ld	(de),a
00115$:
;../time.c:91: if (timeptr->tm_year<0) timeptr->tm_year=0;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	l,c
	ld	h,b
	inc	hl
	ld	a, (hl)
	bit	7,a
	jr	Z,00118$
	ld	l,c
	ld	h,b
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
00118$:
	ld	sp,ix
	pop	ix
	ret
;../time.c:95: char *asctime(struct tm *timeptr) {
;	---------------------------------
; Function asctime
; ---------------------------------
_asctime_start::
_asctime:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-10
	add	hl,sp
	ld	sp,hl
;../time.c:96: CheckTime(timeptr);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_CheckTime
	pop	af
;../time.c:100: timeptr->tm_year+1900);
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	hl,#0x0005
	add	hl,bc
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	add	a,#0x6C
	ld	-2 (ix),a
	ld	a,h
	adc	a,#0x07
	ld	-1 (ix),a
;../time.c:99: timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec, 
	ld	a,(bc)
	ld	-4 (ix), a
	ld	-3 (ix),#0x00
	ld	e,c
	ld	d,b
	inc	de
	ld	a,(de)
	ld	-6 (ix), a
	ld	-5 (ix),#0x00
	ld	e,c
	ld	d,b
	inc	de
	inc	de
	ld	a,(de)
	ld	-8 (ix), a
	ld	-7 (ix),#0x00
;../time.c:98: __day[timeptr->tm_wday], __month[timeptr->tm_mon], timeptr->tm_mday,
	ld	e,c
	ld	d,b
	inc	de
	inc	de
	inc	de
	ld	a,(de)
	ld	-10 (ix), a
	ld	-9 (ix),#0x00
	ld	hl,#0x0004
	add	hl,bc
	ld	a,(hl)
	add	a,a
	add	a,#<(___month)
	ld	l, a
	ld	a, #>(___month)
	adc	a, #0x00
	ld	h, a
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0007
	add	hl,bc
	ld	a,(hl)
	add	a,a
	add	a,#<(___day)
	ld	l, a
	ld	a, #>(___day)
	adc	a, #0x00
	ld	h, a
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
;../time.c:97: sprintf (ascTimeBuffer, "%s %s %2d %02d:%02d:%02d %04d\n",
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	push	de
	push	bc
	ld	hl,#__str_0
	push	hl
	ld	hl,#_ascTimeBuffer
	push	hl
	call	_sprintf
	ld	hl,#0x0012
	add	hl,sp
	ld	sp,hl
;../time.c:101: return ascTimeBuffer;
	ld	hl,#_ascTimeBuffer
	ld	sp,ix
	pop	ix
	ret
_asctime_end::
__str_0:
	.ascii "%s %s %2d %02d:%02d:%02d %04d"
	.db 0x0A
	.db 0x00
;../time.c:104: char *ctime(time_t *timep) {
;	---------------------------------
; Function ctime
; ---------------------------------
_ctime_start::
_ctime:
	push	ix
	ld	ix,#0
	add	ix,sp
;../time.c:105: return asctime(localtime(timep));
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_localtime
	ex	(sp),hl
	call	_asctime
	pop	af
	pop	ix
	ret
_ctime_end::
;../time.c:121: struct tm *localtime(time_t *timep) {
;	---------------------------------
; Function localtime
; ---------------------------------
_localtime_start::
_localtime:
	push	ix
	ld	ix,#0
	add	ix,sp
;../time.c:122: return gmtime(timep);
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_gmtime
	pop	af
	pop	ix
	ret
_localtime_end::
;../time.c:125: struct tm *gmtime(time_t *timep) {
;	---------------------------------
; Function gmtime
; ---------------------------------
_gmtime_start::
_gmtime:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-13
	add	hl,sp
	ld	sp,hl
;../time.c:126: unsigned long epoch=*timep;
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	-4 (ix),c
	ld	-3 (ix),b
	ld	-2 (ix),e
	ld	-1 (ix),d
;../time.c:131: lastTime.tm_sec=epoch%60;
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__modulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a, l
	ld	(#_lastTime),a
;../time.c:132: epoch/=60; // now it is minutes
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__divulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../time.c:133: lastTime.tm_min=epoch%60;
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__modulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a, l
	ld	(#0x0001 + _lastTime),a
;../time.c:134: epoch/=60; // now it is hours
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__divulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../time.c:135: lastTime.tm_hour=epoch%24;
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0018
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__modulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a, l
	ld	(#0x0002 + _lastTime),a
;../time.c:136: epoch/=24; // now it is days
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0018
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	call	__divulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	ld	-2 (ix),e
	ld	-1 (ix),d
;../time.c:137: lastTime.tm_wday=(epoch+4)%7;
	ld	a,-4 (ix)
	add	a,#0x04
	ld	c,a
	ld	a,-3 (ix)
	adc	a,#0x00
	ld	b,a
	ld	a,-2 (ix)
	adc	a,#0x00
	ld	e,a
	ld	a,-1 (ix)
	adc	a,#0x00
	ld	d,a
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0007
	push	hl
	push	de
	push	bc
	call	__modulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a, l
	ld	(#0x0007 + _lastTime),a
;../time.c:140: days=0;
	xor	a,a
	ld	-11 (ix),a
	ld	-10 (ix),a
	ld	-9 (ix),a
	ld	-8 (ix),a
;../time.c:141: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
	ld	-6 (ix),#0xB2
	ld	-5 (ix),#0x07
00101$:
	ld	a,-6 (ix)
	and	a,#0x03
	ld	d, #0x00
	or	a,d
	sub	a,#0x01
	ld	a,#0x00
	rla
	or	a,a
	jr	Z,00119$
	ld	de,#0x016E
	jr	00120$
00119$:
	ld	de,#0x016D
00120$:
	ld	a,d
	rla	
	sbc	a,a
	ld	c,a
	ld	b,a
	ld	a,-11 (ix)
	add	a,e
	ld	e,a
	ld	a,-10 (ix)
	adc	a,d
	ld	d,a
	ld	a,-9 (ix)
	adc	a,c
	ld	c,a
	ld	a,-8 (ix)
	adc	a,b
	ld	b,a
	ld	-11 (ix),e
	ld	-10 (ix),d
	ld	-9 (ix),c
	ld	-8 (ix),b
	ld	a,-4 (ix)
	sub	a, e
	ld	a,-3 (ix)
	sbc	a, d
	ld	a,-2 (ix)
	sbc	a, c
	ld	a,-1 (ix)
	sbc	a, b
	jr	C,00103$
;../time.c:142: year++;
	inc	-6 (ix)
	jr	NZ,00101$
	inc	-5 (ix)
	jr	00101$
00103$:
;../time.c:144: lastTime.tm_year=year-1900;
	ld	a,-6 (ix)
	add	a,#0x94
	ld	c,a
	ld	a,-5 (ix)
	adc	a,#0xF8
	ld	b,a
	ld	hl,#0x0005 + _lastTime
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../time.c:146: days -= LEAP_YEAR(year) ? 366 : 365;
	ld	a,-6 (ix)
	and	a,#0x03
	ld	-13 (ix),a
	ld	-12 (ix),#0x00
	ld	a,-13 (ix)
	or	a,-12 (ix)
	sub	a,#0x01
	ld	a,#0x00
	rla
	or	a,a
	jr	Z,00121$
	ld	de,#0x016E
	jr	00122$
00121$:
	ld	de,#0x016D
00122$:
	ld	a,d
	rla	
	sbc	a,a
	ld	c,a
	ld	b,a
	ld	a,-11 (ix)
	sub	a,e
	ld	-11 (ix),a
	ld	a,-10 (ix)
	sbc	a,d
	ld	-10 (ix),a
	ld	a,-9 (ix)
	sbc	a,c
	ld	-9 (ix),a
	ld	a,-8 (ix)
	sbc	a,b
	ld	-8 (ix),a
;../time.c:147: epoch -= days; // now it is days in this year, starting at 0
	ld	a,-4 (ix)
	sub	a,-11 (ix)
	ld	-4 (ix),a
	ld	a,-3 (ix)
	sbc	a,-10 (ix)
	ld	-3 (ix),a
	ld	a,-2 (ix)
	sbc	a,-9 (ix)
	ld	-2 (ix),a
	ld	a,-1 (ix)
	sbc	a,-8 (ix)
	ld	-1 (ix),a
;../time.c:148: lastTime.tm_yday=epoch;
	ld	c,-4 (ix)
	ld	b,-3 (ix)
	ld	hl,#0x0008 + _lastTime
	ld	(hl),c
	inc	hl
	ld	(hl),b
;../time.c:153: for (month=0; month<12; month++) {
	ld	-7 (ix),#0x00
00113$:
	ld	a,-7 (ix)
	sub	a, #0x0C
	jr	NC,00116$
;../time.c:154: if (month==1) { // februari
	ld	a,-7 (ix)
	sub	a,#0x01
	jr	NZ,00108$
;../time.c:155: if (LEAP_YEAR(year)) {
	ld	a,-13 (ix)
	or	a,-12 (ix)
	jr	NZ,00105$
;../time.c:156: monthLength=29;
	ld	b,#0x1D
	jr	00109$
00105$:
;../time.c:158: monthLength=28;
	ld	b,#0x1C
	jr	00109$
00108$:
;../time.c:161: monthLength = monthDays[month];
	ld	a,#<(_monthDays)
	add	a,-7 (ix)
	ld	e,a
	ld	a,#>(_monthDays)
	adc	a,#0x00
	ld	d,a
	ld	a,(de)
	ld	b,a
00109$:
;../time.c:164: if (epoch>=monthLength) {
	ld	de,#0x0000
	ld	c,#0x00
	ld	a,-4 (ix)
	sub	a, b
	ld	a,-3 (ix)
	sbc	a, e
	ld	a,-2 (ix)
	sbc	a, d
	ld	a,-1 (ix)
	sbc	a, c
	jr	C,00116$
;../time.c:165: epoch-=monthLength;
	ld	a,-4 (ix)
	sub	a,b
	ld	-4 (ix),a
	ld	a,-3 (ix)
	sbc	a,e
	ld	-3 (ix),a
	ld	a,-2 (ix)
	sbc	a,d
	ld	-2 (ix),a
	ld	a,-1 (ix)
	sbc	a,c
	ld	-1 (ix),a
;../time.c:153: for (month=0; month<12; month++) {
	inc	-7 (ix)
	jr	00113$
00116$:
;../time.c:170: lastTime.tm_mon=month;
	ld	hl,#0x0004 + _lastTime
	ld	a,-7 (ix)
	ld	(hl),a
;../time.c:171: lastTime.tm_mday=epoch+1;
	ld	a, -4 (ix)
	inc	a
	ld	(#0x0003 + _lastTime),a
;../time.c:173: lastTime.tm_isdst=0;
	ld	hl,#0x000a + _lastTime
	ld	(hl),#0x00
;../time.c:175: return &lastTime;
	ld	hl,#_lastTime
	ld	sp,ix
	pop	ix
	ret
_gmtime_end::
;../time.c:179: time_t mktime(struct tm *timeptr) {
;	---------------------------------
; Function mktime
; ---------------------------------
_mktime_start::
_mktime:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-16
	add	hl,sp
	ld	sp,hl
;../time.c:180: int year=timeptr->tm_year+1900, month=timeptr->tm_mon, i;
	ld	a,4 (ix)
	ld	-12 (ix),a
	ld	a,5 (ix)
	ld	-11 (ix),a
	ld	a,-12 (ix)
	add	a,#0x05
	ld	l, a
	ld	a, -11 (ix)
	adc	a, #0x00
	ld	h, a
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	add	a,#0x6C
	ld	-2 (ix),a
	ld	a,h
	adc	a,#0x07
	ld	-1 (ix),a
	ld	a,-12 (ix)
	add	a,#0x04
	ld	e,a
	ld	a,-11 (ix)
	adc	a,#0x00
	ld	d,a
	ld	a,(de)
	ld	-4 (ix), a
	ld	-3 (ix),#0x00
;../time.c:183: CheckTime(timeptr);
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	push	hl
	call	_CheckTime
	pop	af
;../time.c:186: seconds= (year-1970)*(60*60*24L*365);
	ld	a,-2 (ix)
	add	a,#0x4E
	ld	e, a
	ld	a, -1 (ix)
	adc	a, #0xF8
	ld	d,a
	rla	
	sbc	a,a
	ld	l, a
	ld	h,a
	push	hl
	push	de
	ld	hl,#0x01E1
	push	hl
	ld	hl,#0x1E13380
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	-10 (ix), l
	ld	-9 (ix), h
	ld	-8 (ix),e
	ld	-7 (ix),d
;../time.c:189: for (i=1970; i<year; i++) {
	ld	a,-10 (ix)
	ld	-16 (ix),a
	ld	a,-9 (ix)
	ld	-15 (ix),a
	ld	a,-8 (ix)
	ld	-14 (ix),a
	ld	a,-7 (ix)
	ld	-13 (ix),a
	ld	bc,#0x07B2
00107$:
	ld	a,c
	sub	a, -2 (ix)
	ld	a,b
	sbc	a, -1 (ix)
	jp	PO, 00126$
	xor	a, #0x80
00126$:
	jp	P,00124$
;../time.c:190: if (LEAP_YEAR(i)) {
	push	bc
	ld	hl,#0x0004
	push	hl
	push	bc
	call	__modsint_rrx_s
	pop	af
	pop	af
	ld	d,h
	ld	e,l
	pop	bc
	ld	a,e
	or	a,d
	jr	NZ,00109$
;../time.c:191: seconds+= 60*60*24L;
	ld	a,-16 (ix)
	add	a,#0x80
	ld	-16 (ix),a
	ld	a,-15 (ix)
	adc	a,#0x51
	ld	-15 (ix),a
	ld	a,-14 (ix)
	adc	a,#0x01
	ld	-14 (ix),a
	ld	a,-13 (ix)
	adc	a,#0x00
	ld	-13 (ix),a
00109$:
;../time.c:189: for (i=1970; i<year; i++) {
	inc	bc
	jr	00107$
00124$:
	ld	a,-16 (ix)
	ld	-10 (ix),a
	ld	a,-15 (ix)
	ld	-9 (ix),a
	ld	a,-14 (ix)
	ld	-8 (ix),a
	ld	a,-13 (ix)
	ld	-7 (ix),a
;../time.c:196: for (i=0; i<month; i++) {
	ld	hl,#0x0004
	push	hl
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	call	__modsint_rrx_s
	pop	af
	pop	af
	ld	-15 (ix),h
	ld	-16 (ix),l
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x00
00111$:
	ld	a,-6 (ix)
	sub	a, -4 (ix)
	ld	a,-5 (ix)
	sbc	a, -3 (ix)
	jp	PO, 00127$
	xor	a, #0x80
00127$:
	jp	P,00114$
;../time.c:197: if (i==1 && LEAP_YEAR(year)) { 
	ld	a,-6 (ix)
	sub	a,#0x01
	jr	NZ,00104$
	ld	a,-5 (ix)
	or	a,a
	jr	NZ,00104$
	ld	a,-16 (ix)
	or	a,-15 (ix)
	jr	NZ,00104$
;../time.c:198: seconds+= 60*60*24L*29;
	ld	a,-10 (ix)
	add	a,#0x80
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,#0x3B
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a,#0x26
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,#0x00
	ld	-7 (ix),a
	jr	00113$
00104$:
;../time.c:200: seconds+= 60*60*24L*monthDays[i];
	ld	a,#<(_monthDays)
	add	a,-6 (ix)
	ld	e,a
	ld	a,#>(_monthDays)
	adc	a,-5 (ix)
	ld	d,a
	ld	a,(de)
	ld	e,a
	rla	
	sbc	a,a
	ld	d,a
	ld	l, a
	ld	h,a
	push	hl
	push	de
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x15180
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	a,-10 (ix)
	add	a,c
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,b
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a,e
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,d
	ld	-7 (ix),a
00113$:
;../time.c:196: for (i=0; i<month; i++) {
	inc	-6 (ix)
	jp	NZ,00111$
	inc	-5 (ix)
	jp	00111$
00114$:
;../time.c:204: seconds+= (timeptr->tm_mday-1)*60*60*24L;
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	inc	bc
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	l,a
	ld	h,#0x00
	dec	hl
	ld	c,l
	ld	a,h
	ld	b,a
	rla	
	sbc	a,a
	ld	l, a
	ld	h,a
	push	hl
	push	bc
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x15180
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	a,-10 (ix)
	add	a,c
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,b
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a,e
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,d
	ld	-7 (ix),a
;../time.c:205: seconds+= timeptr->tm_hour*60*60L;
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	c, a
	ld	b,#0x00
	ld	hl,#0x0000
	push	hl
	push	bc
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0E10
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	b,h
	ld	c,l
	ld	a,-10 (ix)
	add	a,c
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,b
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a,e
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,d
	ld	-7 (ix),a
;../time.c:206: seconds+= timeptr->tm_min*60;
	ld	c,-12 (ix)
	ld	b,-11 (ix)
	inc	bc
	ld	a,(bc)
	ld	e, a
	ld	d, #0x00
	ld	l, a
	ld	h,d
	add	hl,hl
	add	hl,de
	add	hl,hl
	add	hl,de
	add	hl,hl
	add	hl,de
	add	hl,hl
	add	hl,hl
	ld	c,l
	ld	b,h
	ld	a,b
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,-10 (ix)
	add	a,c
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,b
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a,e
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,d
	ld	-7 (ix),a
;../time.c:207: seconds+= timeptr->tm_sec;
	ld	l,-12 (ix)
	ld	h,-11 (ix)
	ld	c, (hl)
	ld	a, #0x00
	ld	b,a
	rla	
	sbc	a,a
	ld	e,a
	ld	d,a
	ld	a,-10 (ix)
	add	a,c
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a,b
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a,e
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a,d
	ld	-7 (ix),a
;../time.c:208: return seconds;
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	e,-8 (ix)
	ld	d,-7 (ix)
	ld	sp,ix
	pop	ix
	ret
_mktime_end::
	.area _CODE
__str_1:
	.ascii "Jan"
	.db 0x00
__str_2:
	.ascii "Feb"
	.db 0x00
__str_3:
	.ascii "Mar"
	.db 0x00
__str_4:
	.ascii "Apr"
	.db 0x00
__str_5:
	.ascii "May"
	.db 0x00
__str_6:
	.ascii "Jun"
	.db 0x00
__str_7:
	.ascii "Jul"
	.db 0x00
__str_8:
	.ascii "Aug"
	.db 0x00
__str_9:
	.ascii "Sep"
	.db 0x00
__str_10:
	.ascii "Oct"
	.db 0x00
__str_11:
	.ascii "Nov"
	.db 0x00
__str_12:
	.ascii "Dec"
	.db 0x00
__str_13:
	.ascii "Sun"
	.db 0x00
__str_14:
	.ascii "Mon"
	.db 0x00
__str_15:
	.ascii "Tue"
	.db 0x00
__str_16:
	.ascii "Wed"
	.db 0x00
__str_17:
	.ascii "Thu"
	.db 0x00
__str_18:
	.ascii "Fri"
	.db 0x00
__str_19:
	.ascii "Sat"
	.db 0x00
	.area _CABS
