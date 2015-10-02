;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:18:20 2015
;--------------------------------------------------------
	.module time
	.optsdcc -mgbz80
	
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
	ld	de,#_monthDays
	ld	a,#0x1F
	ld	(de),a
	ld	de,#0x0001 + _monthDays
	ld	a,#0x1C
	ld	(de),a
	ld	de,#0x0002 + _monthDays
	ld	a,#0x1F
	ld	(de),a
	ld	de,#0x0003 + _monthDays
	ld	a,#0x1E
	ld	(de),a
	ld	de,#0x0004 + _monthDays
	ld	a,#0x1F
	ld	(de),a
	ld	de,#0x0005 + _monthDays
	ld	a,#0x1E
	ld	(de),a
	ld	de,#0x0006 + _monthDays
	ld	a,#0x1F
	ld	(de),a
	ld	de,#0x0007 + _monthDays
	ld	a,#0x1F
	ld	(de),a
	ld	de,#0x0008 + _monthDays
	ld	a,#0x1E
	ld	(de),a
	ld	de,#0x0009 + _monthDays
	ld	a,#0x1F
	ld	(de),a
	ld	de,#0x000a + _monthDays
	ld	a,#0x1E
	ld	(de),a
	ld	de,#0x000b + _monthDays
	ld	a,#0x1F
	ld	(de),a
;../time.c:65: _CODE const char * _CODE __month[]={"Jan","Feb","Mar","Apr","May","Jun",
	ld	de,#___month
	ld	a,#<(__str_1)
	ld	(de),a
	inc	de
	ld	a,#>(__str_1)
	ld	(de),a
	ld	de,#0x0002 + ___month
	ld	a,#<(__str_2)
	ld	(de),a
	inc	de
	ld	a,#>(__str_2)
	ld	(de),a
	ld	de,#0x0004 + ___month
	ld	a,#<(__str_3)
	ld	(de),a
	inc	de
	ld	a,#>(__str_3)
	ld	(de),a
	ld	de,#0x0006 + ___month
	ld	a,#<(__str_4)
	ld	(de),a
	inc	de
	ld	a,#>(__str_4)
	ld	(de),a
	ld	de,#0x0008 + ___month
	ld	a,#<(__str_5)
	ld	(de),a
	inc	de
	ld	a,#>(__str_5)
	ld	(de),a
	ld	de,#0x000a + ___month
	ld	a,#<(__str_6)
	ld	(de),a
	inc	de
	ld	a,#>(__str_6)
	ld	(de),a
	ld	de,#0x000c + ___month
	ld	a,#<(__str_7)
	ld	(de),a
	inc	de
	ld	a,#>(__str_7)
	ld	(de),a
	ld	de,#0x000e + ___month
	ld	a,#<(__str_8)
	ld	(de),a
	inc	de
	ld	a,#>(__str_8)
	ld	(de),a
	ld	de,#0x0010 + ___month
	ld	a,#<(__str_9)
	ld	(de),a
	inc	de
	ld	a,#>(__str_9)
	ld	(de),a
	ld	de,#0x0012 + ___month
	ld	a,#<(__str_10)
	ld	(de),a
	inc	de
	ld	a,#>(__str_10)
	ld	(de),a
	ld	de,#0x0014 + ___month
	ld	a,#<(__str_11)
	ld	(de),a
	inc	de
	ld	a,#>(__str_11)
	ld	(de),a
	ld	de,#0x0016 + ___month
	ld	a,#<(__str_12)
	ld	(de),a
	inc	de
	ld	a,#>(__str_12)
	ld	(de),a
;../time.c:68: _CODE const char * _CODE __day[]={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
	ld	de,#___day
	ld	a,#<(__str_13)
	ld	(de),a
	inc	de
	ld	a,#>(__str_13)
	ld	(de),a
	ld	de,#0x0002 + ___day
	ld	a,#<(__str_14)
	ld	(de),a
	inc	de
	ld	a,#>(__str_14)
	ld	(de),a
	ld	de,#0x0004 + ___day
	ld	a,#<(__str_15)
	ld	(de),a
	inc	de
	ld	a,#>(__str_15)
	ld	(de),a
	ld	de,#0x0006 + ___day
	ld	a,#<(__str_16)
	ld	(de),a
	inc	de
	ld	a,#>(__str_16)
	ld	(de),a
	ld	de,#0x0008 + ___day
	ld	a,#<(__str_17)
	ld	(de),a
	inc	de
	ld	a,#>(__str_17)
	ld	(de),a
	ld	de,#0x000a + ___day
	ld	a,#<(__str_18)
	ld	(de),a
	inc	de
	ld	a,#>(__str_18)
	ld	(de),a
	ld	de,#0x000c + ___day
	ld	a,#<(__str_19)
	ld	(de),a
	inc	de
	ld	a,#>(__str_19)
	ld	(de),a
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
	
;../time.c:45: return 0;
	ld	e,#0x00
00101$:
	
	ret
_RtcRead_end::
;../time.c:50: time_t time(time_t *timeptr) {
;	---------------------------------
; Function time
; ---------------------------------
_time_start::
_time:
	lda	sp,-20(sp)
;../time.c:52: time_t t=-1;
	ldhl	sp,#4
	ld	(hl),#0xFF
	inc	hl
	ld	(hl),#0xFF
	inc	hl
	ld	(hl),#0xFF
	inc	hl
	ld	(hl),#0xFF
;../time.c:54: if (RtcRead(&now)) {
	ldhl	sp,#8
	ld	c,l
	ld	b,h
	push	bc
	call	_RtcRead
	lda	sp,2(sp)
	ld	c,e
	xor	a,a
	or	a,c
	jp	Z,00102$
;../time.c:55: t=mktime(&now);
	ldhl	sp,#8
	ld	c,l
	ld	b,h
	push	bc
	call	_mktime
	lda	sp,2(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#0
	ld	d,h
	ld	e,l
	ldhl	sp,#4
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
00102$:
;../time.c:57: if (timeptr) {
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	Z,00104$
;../time.c:58: *timeptr=t;
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	e,c
	ld	d,b
	ldhl	sp,#4
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
	inc	de
	inc	hl
	ld	a,(hl)
	ld	(de),a
00104$:
;../time.c:60: return t;
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00105$:
	lda	sp,20(sp)
	ret
_time_end::
;../time.c:73: static void CheckTime(struct tm *timeptr) {
;	---------------------------------
; Function CheckTime
; ---------------------------------
_CheckTime:
	
	push	af
	push	af
;../time.c:84: if (timeptr->tm_sec>59) timeptr->tm_sec=59;
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#2
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,#0x3B
	sub	a, c
	jp	NC,00102$
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x3B
	ld	(de),a
00102$:
;../time.c:85: if (timeptr->tm_min>59) timeptr->tm_min=59;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0001
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,#0x3B
	sub	a, c
	jp	NC,00104$
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x3B
	ld	(de),a
00104$:
;../time.c:86: if (timeptr->tm_hour>23) timeptr->tm_hour=23;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0002
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,#0x17
	sub	a, c
	jp	NC,00106$
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x17
	ld	(de),a
00106$:
;../time.c:87: if (timeptr->tm_wday>6) timeptr->tm_wday=6;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0007
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,#0x06
	sub	a, c
	jp	NC,00108$
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x06
	ld	(de),a
00108$:
;../time.c:88: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
	ldhl	sp,#2
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a,(bc)
	ldhl	sp,#0
	ld	(hl),a
	ld	a,(hl)
	sub	a, #0x01
	jp	NC,00112$
	ld	a,#0x01
	ld	(bc),a
	jr	00113$
00112$:
;../time.c:89: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
	ld	a,#0x1F
	ldhl	sp,#0
	sub	a, (hl)
	jp	NC,00113$
	ld	a,#0x1F
	ld	(bc),a
00113$:
;../time.c:90: if (timeptr->tm_mon>11) timeptr->tm_mon=11;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	a,#0x0B
	sub	a, c
	jp	NC,00115$
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x0B
	ld	(de),a
00115$:
;../time.c:91: if (timeptr->tm_year<0) timeptr->tm_year=0;
	ldhl	sp,#3
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0005
	add	hl,de
	ld	a,l
	ld	d,h
	ldhl	sp,#0
	ld	(hl),a
	inc	hl
	ld	(hl),d
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	ld	a, #0x00
	ld	e, a
	ld	a, b
	ld	d, a
	ld	a,b
	bit	7,a
	jp	Z,00118$
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,#0x00
	ld	(de),a
	inc	de
	ld	a,#0x00
	ld	(de),a
00118$:
	lda	sp,4(sp)
	ret
;../time.c:95: char *asctime(struct tm *timeptr) {
;	---------------------------------
; Function asctime
; ---------------------------------
_asctime_start::
_asctime:
	lda	sp,-14(sp)
;../time.c:96: CheckTime(timeptr);
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_CheckTime
	lda	sp,2(sp)
;../time.c:100: timeptr->tm_year+1900);
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#12
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0005
	add	hl,de
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	ld	hl,#0x076C
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#10
	ld	(hl),a
	inc	hl
	ld	(hl),d
;../time.c:99: timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec, 
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ldhl	sp,#8
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#12
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#6
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#12
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#4
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
;../time.c:98: __day[timeptr->tm_wday], __month[timeptr->tm_mon], timeptr->tm_mday,
	ldhl	sp,#12
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#2
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#13
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	add	a,a
	add	a,#<(___month)
	ld	c,a
	ld	a,#>(___month)
	adc	a,#0x00
	ld	b,a
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#0
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	ldhl	sp,#13
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0007
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	add	a,a
	add	a,#<(___day)
	ld	c,a
	ld	a,#>(___day)
	adc	a,#0x00
	ld	b,a
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
;../time.c:97: sprintf (ascTimeBuffer, "%s %s %2d %02d:%02d:%02d %04d\n",
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	push	bc
	ld	hl,#__str_0
	push	hl
	ld	hl,#_ascTimeBuffer
	push	hl
	call	_sprintf
	lda	sp,18(sp)
;../time.c:101: return ascTimeBuffer;
	ld	de,#_ascTimeBuffer
00101$:
	lda	sp,14(sp)
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
	
;../time.c:105: return asctime(localtime(timep));
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_localtime
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	push	bc
	call	_asctime
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	ld	e,c
	ld	d,b
00101$:
	
	ret
_ctime_end::
;../time.c:121: struct tm *localtime(time_t *timep) {
;	---------------------------------
; Function localtime
; ---------------------------------
_localtime_start::
_localtime:
	
;../time.c:122: return gmtime(timep);
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_gmtime
	lda	sp,2(sp)
	ld	b,d
	ld	c,e
	ld	e,c
	ld	d,b
00101$:
	
	ret
_localtime_end::
;../time.c:125: struct tm *gmtime(time_t *timep) {
;	---------------------------------
; Function gmtime
; ---------------------------------
_gmtime_start::
_gmtime:
	lda	sp,-19(sp)
;../time.c:126: unsigned long epoch=*timep;
	ldhl	sp,#22
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	e,c
	ld	d,b
	ld	a,(de)
	ldhl	sp,#15
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
	inc	de
	ld	a,(de)
	inc	hl
	ld	(hl),a
;../time.c:131: lastTime.tm_sec=epoch%60;
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	a,(hl)
	ld	de,#_lastTime
	ld	(de),a
;../time.c:132: epoch/=60; // now it is minutes
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__divulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../time.c:133: lastTime.tm_min=epoch%60;
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	a,(hl)
	ld	de,#0x0001 + _lastTime
	ld	(de),a
;../time.c:134: epoch/=60; // now it is hours
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x003C
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__divulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../time.c:135: lastTime.tm_hour=epoch%24;
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0018
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	a,(hl)
	ld	de,#0x0002 + _lastTime
	ld	(de),a
;../time.c:136: epoch/=24; // now it is days
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0018
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#21
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__divulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#15
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../time.c:137: lastTime.tm_wday=(epoch+4)%7;
	ldhl	sp,#16
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	add	a,#0x04
	ld	e,a
	ld	a,d
	adc	a,#0x00
	push	af
	ldhl	sp,#7
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#20
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	af
	ld	a,e
	adc	a,#0x00
	ld	e,a
	ld	a,d
	adc	a,#0x00
	ldhl	sp,#7
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0007
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#10
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modulong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#6
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#4
	ld	a,(hl)
	ld	de,#0x0007 + _lastTime
	ld	(de),a
;../time.c:140: days=0;
	xor	a,a
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
;../time.c:141: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
	inc	hl
	inc	hl
	ld	(hl),#0xB2
	inc	hl
	ld	(hl),#0x07
00101$:
	ldhl	sp,#13
	ld	a,(hl)
	and	a,#0x03
	ld	c,a
	ld	b,#0x00
	ld	a,c
	or	a,b
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	or	a,a
	jp	Z,00119$
	ld	bc,#0x016E
	jr	00120$
00119$:
	ld	bc,#0x016D
00120$:
	ldhl	sp,#4
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	inc	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#4
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#13
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#8
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ld	(hl),a
	dec	hl
	ld	(hl),e
	dec	hl
	dec	hl
	ld	d,h
	ld	e,l
	ldhl	sp,#8
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	ldhl	sp,#15
	ld	d, h
	ld	e, l
	ldhl	sp,#4
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jp	C,00103$
;../time.c:142: year++;
	ldhl	sp,#13
	inc	(hl)
	jp	NZ,00101$
	inc	hl
	inc	(hl)
00134$:
	jp	00101$
00103$:
;../time.c:144: lastTime.tm_year=year-1900;
	ldhl	sp,#14
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x076C
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ld	b,a
	ld	c,e
	ld	de,#0x0005 + _lastTime
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;../time.c:146: days -= LEAP_YEAR(year) ? 366 : 365;
	ldhl	sp,#13
	ld	a,(hl)
	and	a,#0x03
	ldhl	sp,#4
	ld	(hl),a
	inc	hl
	ld	(hl),#0x00
	dec	hl
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	sub	a,#0x01
	ld	a,#0x00
	rla
	ld	c,a
	or	a,a
	jp	Z,00121$
	ld	bc,#0x016E
	jr	00122$
00121$:
	ld	bc,#0x016D
00122$:
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#11
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#13
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#11
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:147: epoch -= days; // now it is days in this year, starting at 0
	ldhl	sp,#16
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#8
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#18
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#20
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#12
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#18
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:148: lastTime.tm_yday=epoch;
	dec	hl
	dec	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	de,#0x0008 + _lastTime
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;../time.c:153: for (month=0; month<12; month++) {
	ldhl	sp,#12
	ld	(hl),#0x00
00113$:
	ldhl	sp,#12
	ld	a,(hl)
	sub	a, #0x0C
	jp	NC,00116$
;../time.c:154: if (month==1) { // februari
	ld	a,(hl)
	sub	a,#0x01
	jp	Z,00136$
00135$:
	jr	00108$
00136$:
;../time.c:155: if (LEAP_YEAR(year)) {
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00105$
;../time.c:156: monthLength=29;
	ld	b,#0x1D
	jr	00109$
00105$:
;../time.c:158: monthLength=28;
	ld	b,#0x1C
	jr	00109$
00108$:
;../time.c:161: monthLength = monthDays[month];
	ld	de,#_monthDays
	ldhl	sp,#12
	ld	l,(hl)
	ld	h,#0x00
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ld	b,a
00109$:
;../time.c:164: if (epoch>=monthLength) {
	ldhl	sp,#0
	ld	(hl),b
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	ldhl	sp,#15
	ld	d, h
	ld	e, l
	ldhl	sp,#0
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	jp	C,00116$
;../time.c:165: epoch-=monthLength;
	ldhl	sp,#16
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	sub	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	push	af
	ldhl	sp,#18
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#20
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	sbc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	sbc	a,(hl)
	ldhl	sp,#18
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:153: for (month=0; month<12; month++) {
	ldhl	sp,#12
	inc	(hl)
	jp	00113$
00116$:
;../time.c:170: lastTime.tm_mon=month;
	ld	de,#0x0004 + _lastTime
	ldhl	sp,#12
	ld	a,(hl)
	ld	(de),a
;../time.c:171: lastTime.tm_mday=epoch+1;
	ldhl	sp,#15
	ld	c,(hl)
	ld	a,c
	inc	a
	ld	de,#0x0003 + _lastTime
	ld	(de),a
;../time.c:173: lastTime.tm_isdst=0;
	ld	de,#0x000a + _lastTime
	ld	a,#0x00
	ld	(de),a
;../time.c:175: return &lastTime;
	ld	de,#_lastTime
00117$:
	lda	sp,19(sp)
	ret
_gmtime_end::
;../time.c:179: time_t mktime(struct tm *timeptr) {
;	---------------------------------
; Function mktime
; ---------------------------------
_mktime_start::
_mktime:
	lda	sp,-20(sp)
;../time.c:180: int year=timeptr->tm_year+1900, month=timeptr->tm_mon, i;
	ldhl	sp,#22
	ld	a,(hl)
	inc	hl
	ld	e,(hl)
	ldhl	sp,#8
	ld	(hl),a
	inc	hl
	ld	(hl),e
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0005
	add	hl,de
	ld	c,l
	ld	b,h
	ld	e,c
	ld	d,b
	ld	a,(de)
	ld	c,a
	inc	de
	ld	a,(de)
	ld	b,a
	ld	hl,#0x076C
	add	hl,bc
	ld	a,l
	ld	d,h
	ldhl	sp,#18
	ld	(hl),a
	inc	hl
	ld	(hl),d
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x0004
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#16
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
;../time.c:183: CheckTime(timeptr);
	ldhl	sp,#8
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	_CheckTime
	lda	sp,2(sp)
;../time.c:186: seconds= (year-1970)*(60*60*24L*365);
	ldhl	sp,#19
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,#0x07B2
	ld	a,e
	sub	a,l
	ld	e,a
	ld	a,d
	sbc	a,h
	ld	b,a
	ld	c,e
	ldhl	sp,#4
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#6
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x01E1
	push	hl
	ld	hl,#0x1E13380
	push	hl
	call	__mullong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#12
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;../time.c:189: for (i=1970; i<year; i++) {
	ldhl	sp,#10
	ld	d,h
	ld	e,l
	ldhl	sp,#4
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	ldhl	sp,#14
	ld	(hl),#0xB2
	inc	hl
	ld	(hl),#0x07
00107$:
	ldhl	sp,#14
	ld	d, h
	ld	e, l
	ldhl	sp,#18
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00126$
	bit	7, d
	jp	NZ, 00127$
	cp	a, a
	jr	00127$
00126$:
	bit	7, d
	jp	Z, 00127$
	scf
00127$:
	jp	NC,00124$
;../time.c:190: if (LEAP_YEAR(i)) {
	ld	hl,#0x0004
	push	hl
	ldhl	sp,#16
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modsint_rrx_s
	lda	sp,4(sp)
	ld	b,d
	ld	c,e
	ld	a,c
	or	a,b
	jp	NZ,00109$
;../time.c:191: seconds+= 60*60*24L;
	ldhl	sp,#5
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	add	a,#0x80
	ld	e,a
	ld	a,d
	adc	a,#0x51
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	af
	ld	a,e
	adc	a,#0x01
	ld	e,a
	ld	a,d
	adc	a,#0x00
	ld	(hl),a
	dec	hl
	ld	(hl),e
00109$:
;../time.c:189: for (i=1970; i<year; i++) {
	ldhl	sp,#14
	inc	(hl)
	jp	NZ,00107$
	inc	hl
	inc	(hl)
00128$:
	jp	00107$
00124$:
	ldhl	sp,#4
	ld	d,h
	ld	e,l
	ldhl	sp,#10
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
	inc	hl
	inc	de
	ld	a,(de)
	ld	(hl),a
;../time.c:196: for (i=0; i<month; i++) {
	ld	hl,#0x0004
	push	hl
	ldhl	sp,#20
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	call	__modsint_rrx_s
	lda	sp,4(sp)
	ldhl	sp,#5
	ld	(hl),d
	dec	hl
	ld	(hl),e
	ldhl	sp,#14
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
00111$:
	ldhl	sp,#14
	ld	d, h
	ld	e, l
	inc	hl
	inc	hl
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jp	Z, 00129$
	bit	7, d
	jp	NZ, 00130$
	cp	a, a
	jr	00130$
00129$:
	bit	7, d
	jp	Z, 00130$
	scf
00130$:
	jp	NC,00114$
;../time.c:197: if (i==1 && LEAP_YEAR(year)) { 
	ldhl	sp,#14
	ld	a,(hl)
	sub	a,#0x01
	jp	NZ,00104$
	inc	hl
	ld	a,(hl)
	or	a,a
	jp	Z,00132$
00131$:
	jr	00104$
00132$:
	ldhl	sp,#4
	ld	a,(hl)
	inc	hl
	or	a,(hl)
	jp	NZ,00104$
;../time.c:198: seconds+= 60*60*24L*29;
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	add	a,#0x80
	ld	e,a
	ld	a,d
	adc	a,#0x3B
	push	af
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	af
	ld	a,e
	adc	a,#0x26
	ld	e,a
	ld	a,d
	adc	a,#0x00
	ld	(hl),a
	dec	hl
	ld	(hl),e
	jp	00113$
00104$:
;../time.c:200: seconds+= 60*60*24L*monthDays[i];
	ld	de,#_monthDays
	ldhl	sp,#14
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	add	hl,de
	ld	c,l
	ld	b,h
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#0
	ld	(hl),c
	ld	a,c
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x15180
	push	hl
	call	__mullong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
00113$:
;../time.c:196: for (i=0; i<month; i++) {
	ldhl	sp,#14
	inc	(hl)
	jp	NZ,00111$
	inc	hl
	inc	(hl)
00133$:
	jp	00111$
00114$:
;../time.c:204: seconds+= (timeptr->tm_mday-1)*60*60*24L;
	ldhl	sp,#8
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	c,a
	ld	b,#0x00
	dec	bc
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x0001
	push	hl
	ld	hl,#0x15180
	push	hl
	call	__mullong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:205: seconds+= timeptr->tm_hour*60*60L;
	ldhl	sp,#8
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	inc	bc
	ld	a,(bc)
	ld	c,a
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	inc	hl
	ld	(hl),#0x00
	dec	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ldhl	sp,#2
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	hl,#0x0E10
	push	hl
	call	__mullong_rrx_s
	lda	sp,8(sp)
	push	hl
	ldhl	sp,#2
	ld	(hl),e
	inc	hl
	ld	(hl),d
	pop	de
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:206: seconds+= timeptr->tm_min*60;
	ldhl	sp,#8
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	bc
	ld	a,(bc)
	ld	c,a
	ld	e,c
	ld	d,#0x00
	ld	l,e
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
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:207: seconds+= timeptr->tm_sec;
	ldhl	sp,#9
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(de)
	ld	c,a
	ld	b,#0x00
	ldhl	sp,#0
	ld	(hl),c
	inc	hl
	ld	(hl),b
	ld	a,b
	rla	
	sbc	a,a
	inc	hl
	ld	(hl),a
	inc	hl
	ld	(hl),a
	ldhl	sp,#11
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ldhl	sp,#0
	add	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	push	af
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
	ldhl	sp,#15
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ldhl	sp,#4
	pop	af
	ld	a,e
	adc	a,(hl)
	ld	e,a
	ld	a,d
	inc	hl
	adc	a,(hl)
	ldhl	sp,#13
	ld	(hl),a
	dec	hl
	ld	(hl),e
;../time.c:208: return seconds;
	dec	hl
	dec	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	a,(hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
00115$:
	lda	sp,20(sp)
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
