;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module _atoi
	.optsdcc -mds400 --model-flat24
	
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
	.globl _atoi
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
	.area REG_BANK_3	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_atoi_rv_1_1:
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
;Allocation info for local variables in function 'atoi'
;------------------------------------------------------------
;rv                        Allocated with name '_atoi_rv_1_1'
;sign                      Allocated to registers r0 
;s                         Allocated to registers r2 r3 r4 r5 
;sloc0                     Allocated with name '_atoi_sloc0_1_0'
;------------------------------------------------------------
;	_atoi.c:29: int atoi(const char * s)
;	-----------------------------------------
;	 function atoi
;	-----------------------------------------
_atoi:
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
;	_atoi.c:31: register int rv=0; 
;	genAssign: resultIsFar = FALSE
	clr	a
	mov	_atoi_rv_1_1,a
	mov	(_atoi_rv_1_1 + 1),a
;	_atoi.c:35: while (*s) {
;	genAssign: resultIsFar = FALSE
	mov	ar0,r2
	mov	ar1,r3
	mov	ar6,r4
	mov	ar7,r5
00107$:
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r6
	mov	b,r7
	lcall	__gptrget
	mov  r2,a
	jz  00133$
00135$:
;	_atoi.c:36: if (*s <= '9' && *s >= '0')
	clr	c
	mov  a,#(0x39 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
	jc   00102$
00136$:
	clr	c
	mov	a,r2
	xrl	a,#0x80
	subb	a,#0xB0
	jnc  00133$
00137$:
;	_atoi.c:37: break;
00102$:
;	_atoi.c:38: if (*s == '-' || *s == '+') 
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r6
	mov	b,r7
	lcall	__gptrget
	mov  r2,a
	cjne	a,#0x2D,00138$
	sjmp 00133$
00138$:
	mov	a,r2
	cjne	a,#0x2B,00139$
	sjmp 00133$
00139$:
;	_atoi.c:40: s++;
	inc	r0
	cjne	r0,#0,00140$
	inc	r1
	cjne	r1,#0,00140$
	inc	r6
00140$:
	sjmp 00107$
00133$:
;	genAssign: resultIsFar = TRUE
	mov	ar2,r0
	mov	ar3,r1
	mov	ar4,r6
	mov	ar5,r7
;	_atoi.c:43: sign = (*s == '-');
	mov	dpl,r0
	mov	dph,r1
	mov	dpx,r6
	mov	b,r7
	lcall	__gptrget
	mov  r6,a
	cjne	a,#0x2D,00141$
	mov	a,#1
	sjmp	00142$
00141$:
	clr	a
00142$:
;	genAssign: resultIsFar = FALSE
;	_atoi.c:44: if (*s == '-' || *s == '+') s++;
	mov  r7,a
	mov  ar0,r7 
	jnz  00110$
00143$:
	mov	a,r6
	cjne a,#0x2B,00131$
00145$:
00110$:
	inc	r2
	cjne	r2,#0,00146$
	inc	r3
	cjne	r3,#0,00146$
	inc	r4
00146$:
;	_atoi.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
;	genAssign: resultIsFar = FALSE
00115$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r6,a
	jz  00117$
00147$:
	clr	c
	mov	a,r6
	xrl	a,#0x80
	subb	a,#0xB0
	jc   00117$
00148$:
	clr	c
	mov  a,#(0x39 ^ 0x80)
	mov	b,r6
	xrl	b,#0x80
	subb	a,b
	jc   00117$
00149$:
;	_atoi.c:47: rv = (rv * 10) + (*s - '0');
	push	ar0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__mulint_PARM_2
	mov	a,_atoi_rv_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,(_atoi_rv_1_1 + 1)
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar0
	mov  dptr,#0x000A
	lcall	__mulint
	mov	r7,dpl
	mov	r1,dph
	pop	ar0
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	rlc	a
	subb	a,acc
	mov	r0,a
	mov	a,r6
	add	a,#0xD0
	mov	r6,a
	mov	a,r0
	addc	a,#0xFF
	mov	r0,a
	mov	a,r6
	add	a,r7
	mov	_atoi_rv_1_1,a
	mov	a,r0
	addc	a,r1
	mov	(_atoi_rv_1_1 + 1),a
;	_atoi.c:48: s++;
	inc	r2
	cjne	r2,#0,00150$
	inc	r3
	cjne	r3,#0,00150$
	inc	r4
00150$:
	pop	ar0
	ljmp	00115$
00117$:
;	_atoi.c:51: return (sign ? -rv : rv);
	mov	a,r0
	jz  00120$
00151$:
	clr	c
	clr	a
	subb	a,_atoi_rv_1_1
	mov	dpl,a
	clr	a
	subb	a,(_atoi_rv_1_1 + 1)
	mov	dph,a
	sjmp 00121$
00120$:
;	genAssign: resultIsFar = FALSE
	mov	dpl,_atoi_rv_1_1
	mov	dph,(_atoi_rv_1_1 + 1)
00121$:
00118$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
