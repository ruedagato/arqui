;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module atan2f
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atan2f_PARM_2
	.globl _atan2f
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
_atan2f_PARM_2:
	.ds 4
_atan2f_x_1_1:
	.ds 4
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
;Allocation info for local variables in function 'atan2f'
;------------------------------------------------------------
;y                         Allocated with name '_atan2f_PARM_2'
;x                         Allocated with name '_atan2f_x_1_1'
;r                         Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	atan2f.c:34: float atan2f(const float x, const float y)
;	-----------------------------------------
;	 function atan2f
;	-----------------------------------------
_atan2f:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov	_atan2f_x_1_1,dpl
	mov	(_atan2f_x_1_1 + 1),dph
	mov	(_atan2f_x_1_1 + 2),b
	mov	(_atan2f_x_1_1 + 3),a
;	atan2f.c:38: if ((x==0.0) && (y==0.0))
	mov	a,_atan2f_x_1_1
	orl	a,(_atan2f_x_1_1 + 1)
	orl	a,(_atan2f_x_1_1 + 2)
	orl	a,(_atan2f_x_1_1 + 3)
	jnz	00102$
	mov	a,_atan2f_PARM_2
	orl	a,(_atan2f_PARM_2 + 1)
	orl	a,(_atan2f_PARM_2 + 2)
	orl	a,(_atan2f_PARM_2 + 3)
;	atan2f.c:40: errno=EDOM;
	jnz	00102$
	mov	_errno,#0x21
	mov	(_errno + 1),a
;	atan2f.c:41: return 0.0;
	mov	dptr,#(0x00&0x00ff)
	clr	a
	mov	b,a
	ret
00102$:
;	atan2f.c:44: if(fabsf(y)>=fabsf(x))
	mov	dpl,_atan2f_PARM_2
	mov	dph,(_atan2f_PARM_2 + 1)
	mov	b,(_atan2f_PARM_2 + 2)
	mov	a,(_atan2f_PARM_2 + 3)
	lcall	_fabsf
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	dpl,_atan2f_x_1_1
	mov	dph,(_atan2f_x_1_1 + 1)
	mov	b,(_atan2f_x_1_1 + 2)
	mov	a,(_atan2f_x_1_1 + 3)
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	_fabsf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jz	00123$
	ljmp	00107$
00123$:
;	atan2f.c:46: r=atanf(x/y);
	push	_atan2f_PARM_2
	push	(_atan2f_PARM_2 + 1)
	push	(_atan2f_PARM_2 + 2)
	push	(_atan2f_PARM_2 + 3)
	mov	dpl,_atan2f_x_1_1
	mov	dph,(_atan2f_x_1_1 + 1)
	mov	b,(_atan2f_x_1_1 + 2)
	mov	a,(_atan2f_x_1_1 + 3)
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	_atanf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	atan2f.c:47: if(y<0.0) r+=(x>=0?PI:-PI);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpl,_atan2f_PARM_2
	mov	dph,(_atan2f_PARM_2 + 1)
	mov	b,(_atan2f_PARM_2 + 2)
	mov	a,(_atan2f_PARM_2 + 3)
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jnz	00124$
	ljmp	00108$
00124$:
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpl,_atan2f_x_1_1
	mov	dph,(_atan2f_x_1_1 + 1)
	mov	b,(_atan2f_x_1_1 + 2)
	mov	a,(_atan2f_x_1_1 + 3)
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	cjne	a,#0x01,00125$
00125$:
	clr	a
	rlc	a
	mov	r6,a
	jz	00111$
	mov	r6,#0xDB
	mov	r7,#0x0F
	mov	r0,#0x49
	mov	r1,#0x40
	sjmp	00112$
00111$:
	mov	r6,#0xDB
	mov	r7,#0x0F
	mov	r0,#0x49
	mov	r1,#0xC0
00112$:
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	ljmp	00108$
00107$:
;	atan2f.c:51: r=-atanf(y/x);
	push	_atan2f_x_1_1
	push	(_atan2f_x_1_1 + 1)
	push	(_atan2f_x_1_1 + 2)
	push	(_atan2f_x_1_1 + 3)
	mov	dpl,_atan2f_PARM_2
	mov	dph,(_atan2f_PARM_2 + 1)
	mov	b,(_atan2f_PARM_2 + 2)
	mov	a,(_atan2f_PARM_2 + 3)
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	mov	a,r1
	lcall	_atanf
	mov	r6,dpl
	mov	r7,dph
	mov	r0,b
	mov	r1,a
	mov	ar2,r6
	mov	ar3,r7
	mov	ar4,r0
	mov	a,r1
	cpl	acc.7
	mov	r5,a
;	atan2f.c:52: r+=(x<0.0?-HALF_PI:HALF_PI);
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	clr	a
	push	acc
	push	acc
	push	acc
	push	acc
	mov	dpl,_atan2f_x_1_1
	mov	dph,(_atan2f_x_1_1 + 1)
	mov	b,(_atan2f_x_1_1 + 2)
	mov	a,(_atan2f_x_1_1 + 3)
	lcall	___fslt
	mov	r6,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,r6
	jz	00113$
	mov	r6,#0xDB
	mov	r7,#0x0F
	mov	r0,#0xC9
	mov	r1,#0xBF
	sjmp	00114$
00113$:
	mov	r6,#0xDB
	mov	r7,#0x0F
	mov	r0,#0xC9
	mov	r1,#0x3F
00114$:
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
00108$:
;	atan2f.c:54: return r;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
