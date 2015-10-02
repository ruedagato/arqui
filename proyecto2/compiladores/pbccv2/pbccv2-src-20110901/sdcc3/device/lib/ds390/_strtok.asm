;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _strtok
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
	.globl _strtok_PARM_2
	.globl _strtok
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
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
_strtok_PARM_2:
	.ds 4
_strtok_s_1_1:
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
;Allocation info for local variables in function 'strtok'
;------------------------------------------------------------
;control                   Allocated with name '_strtok_PARM_2'
;str                       Allocated to registers r2 r3 r4 r5 
;s                         Allocated with name '_strtok_s_1_1'
;s1                        Allocated to registers r2 r3 r4 r5 
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
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	_strtok.c:43: if ( str )
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jz  00102$
00130$:
;	_strtok.c:44: s = str ;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strtok_s_1_1
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
00102$:
;	_strtok.c:45: if ( !s )
	mov	dptr,#_strtok_s_1_1
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
	mov	a,r2
	orl	a,r3
	orl	a,r4
	jnz  00108$
00131$:
;	_strtok.c:46: return NULL;
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00119$
;	_strtok.c:48: while (*s) {
00108$:
	mov	dptr,#_strtok_s_1_1
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r2,a
	jz  00110$
00132$:
;	_strtok.c:49: if (strchr(control,*s))
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strchr_PARM_2
	mov	a,r2
	movx	@dptr,a
	inc	dps
	mov	dptr,#_strtok_PARM_2
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
	lcall	_strchr
	mov	a,dpl
	orl	a,dph
	orl	a,dpx
	jz  00110$
00133$:
;	_strtok.c:50: s++;
	mov	dptr,#_strtok_s_1_1
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
;	_strtok.c:52: break;
	sjmp 00108$
00110$:
;	_strtok.c:55: s1 = s ;
	mov	dptr,#_strtok_s_1_1
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
;	genAssign: resultIsFar = TRUE
;	_strtok.c:57: while (*s) {
00113$:
	mov	dptr,#_strtok_s_1_1
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	__gptrget
	mov  r6,a
	jnz	00134$
	ljmp	00115$
00134$:
;	_strtok.c:58: if (strchr(control,*s)) {
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strchr_PARM_2
	mov	a,r6
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	inc	dps
	mov	dptr,#_strtok_PARM_2
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
	lcall	_strchr
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	orl	a,dph
	orl	a,dpx
	jz  00112$
00135$:
;	_strtok.c:59: *s++ = '\0';
	mov	dptr,#_strtok_s_1_1
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	clr  a
	lcall	__gptrput
	mov	dptr,#_strtok_s_1_1
	mov	a,#0x01
	add	a,r6
	movx	@dptr,a
	clr  a
	addc	a,r7
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r0
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
;	_strtok.c:60: return s1 ;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	sjmp 00119$
00112$:
;	_strtok.c:62: s++ ;
	mov	dptr,#_strtok_s_1_1
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	ljmp	00113$
00115$:
;	_strtok.c:65: s = NULL;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_strtok_s_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
;	_strtok.c:67: if (*s1)
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r6,a
	jz  00117$
00136$:
;	_strtok.c:68: return s1;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	sjmp 00119$
00117$:
;	_strtok.c:70: return NULL;
	mov  dptr,#0x0000
	mov	b,#0x00
00119$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
