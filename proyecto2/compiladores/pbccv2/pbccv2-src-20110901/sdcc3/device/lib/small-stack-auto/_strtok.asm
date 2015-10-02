;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:31 2015
;--------------------------------------------------------
	.module _strtok
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strtok
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
_strtok_s_1_1:
	.ds 3
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
;Allocation info for local variables in function 'strtok'
;------------------------------------------------------------
;control                   Allocated to stack - offset -5
;str                       Allocated to registers r2 r3 r4 
;s1                        Allocated to registers r2 r3 r4 
;s                         Allocated with name '_strtok_s_1_1'
;------------------------------------------------------------
;	_strtok.c:36: char * strtok (
;	-----------------------------------------
;	 function strtok
;	-----------------------------------------
_strtok:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bp
	mov	_bp,sp
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	_strtok.c:43: if ( str )
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jz	00102$
;	_strtok.c:44: s = str ;
	mov	_strtok_s_1_1,r2
	mov	(_strtok_s_1_1 + 1),r3
	mov	(_strtok_s_1_1 + 2),r4
00102$:
;	_strtok.c:45: if ( !s )
	mov	a,_strtok_s_1_1
	orl	a,(_strtok_s_1_1 + 1)
	orl	a,(_strtok_s_1_1 + 2)
;	_strtok.c:46: return NULL;
	jnz	00108$
	mov	dptr,#0x0000
	mov	b,a
	ljmp	00119$
;	_strtok.c:48: while (*s) {
00108$:
	mov	r2,_strtok_s_1_1
	mov	r3,(_strtok_s_1_1 + 1)
	mov	r4,(_strtok_s_1_1 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	jz	00110$
;	_strtok.c:49: if (strchr(control,*s))
	mov	r2,_strtok_s_1_1
	mov	r3,(_strtok_s_1_1 + 1)
	mov	r4,(_strtok_s_1_1 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r2,a
	push	ar2
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	_strchr
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	dec	sp
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jz	00110$
;	_strtok.c:50: s++;
	inc	_strtok_s_1_1
	clr	a
;	_strtok.c:52: break;
	cjne	a,_strtok_s_1_1,00108$
	inc	(_strtok_s_1_1 + 1)
	sjmp	00108$
00110$:
;	_strtok.c:55: s1 = s ;
	mov	r2,_strtok_s_1_1
	mov	r3,(_strtok_s_1_1 + 1)
	mov	r4,(_strtok_s_1_1 + 2)
;	_strtok.c:57: while (*s) {
00113$:
	mov	r5,_strtok_s_1_1
	mov	r6,(_strtok_s_1_1 + 1)
	mov	r7,(_strtok_s_1_1 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	jz	00115$
;	_strtok.c:58: if (strchr(control,*s)) {
	mov	r5,_strtok_s_1_1
	mov	r6,(_strtok_s_1_1 + 1)
	mov	r7,(_strtok_s_1_1 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	a,_bp
	add	a,#0xfb
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	_strchr
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r5
	orl	a,r6
	orl	a,r7
	jz	00112$
;	_strtok.c:59: *s++ = '\0';
	mov	r5,_strtok_s_1_1
	mov	r6,(_strtok_s_1_1 + 1)
	mov	r7,(_strtok_s_1_1 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	clr	a
	lcall	__gptrput
	inc	_strtok_s_1_1
	clr	a
	cjne	a,_strtok_s_1_1,00137$
	inc	(_strtok_s_1_1 + 1)
00137$:
;	_strtok.c:60: return s1 ;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	sjmp	00119$
00112$:
;	_strtok.c:62: s++ ;
	inc	_strtok_s_1_1
	clr	a
	cjne	a,_strtok_s_1_1,00113$
	inc	(_strtok_s_1_1 + 1)
	sjmp	00113$
00115$:
;	_strtok.c:65: s = NULL;
	clr	a
	mov	_strtok_s_1_1,a
	mov	(_strtok_s_1_1 + 1),a
	mov	(_strtok_s_1_1 + 2),a
;	_strtok.c:67: if (*s1)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	jz	00117$
;	_strtok.c:68: return s1;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	sjmp	00119$
00117$:
;	_strtok.c:70: return NULL;
	mov	dptr,#0x0000
	mov	b,#0x00
00119$:
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
