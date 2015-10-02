;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:16 2015
;--------------------------------------------------------
	.module sincosf
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
	.globl _sincosf
	.globl _sincosf_PARM_2
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
_sincosf_PARM_2:
	.ds 1
_sincosf_sign_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_sincosf_x_1_1:
	.ds 4
_sincosf_f_1_1:
	.ds 4
_sincosf_r_1_1:
	.ds 4
_sincosf_XN_1_1:
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
;Allocation info for local variables in function 'sincosf'
;------------------------------------------------------------
;x                         Allocated with name '_sincosf_x_1_1'
;y                         Allocated to registers r6 r7 r0 r1 
;f                         Allocated with name '_sincosf_f_1_1'
;r                         Allocated with name '_sincosf_r_1_1'
;g                         Allocated to registers r6 r7 r0 r1 
;XN                        Allocated with name '_sincosf_XN_1_1'
;N                         Allocated to registers 
;sloc0                     Allocated with name '_sincosf_sloc0_1_0'
;------------------------------------------------------------
;	sincosf.c:50: float sincosf(const float x, const BOOL iscos)
;	-----------------------------------------
;	 function sincosf
;	-----------------------------------------
_sincosf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #_sincosf_x_1_1
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
;	sincosf.c:56: if(iscos)
	jnb  _sincosf_PARM_2,00105$
00126$:
;	sincosf.c:58: y=fabsf(x)+HALF_PI;
	inc	dps
	mov	dptr,#_sincosf_x_1_1
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
	lcall	_fabsf
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0xDB
	movx	@dptr,a
	inc	dptr
	mov	a,#0x0F
	movx	@dptr,a
	inc	dptr
	mov	a,#0xC9
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
;	sincosf.c:59: sign=0;
;	genAssign: resultIsFar = FALSE
	clr	_sincosf_sign_1_1
	sjmp 00106$
00105$:
;	sincosf.c:63: if(x<0.0)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fslt_PARM_2
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dps
	mov	dptr,#_sincosf_x_1_1
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
	lcall	___fslt
	mov	a,dpl
	jz  00102$
00127$:
;	sincosf.c:64: { y=-x; sign=1; }
	mov	dptr,#_sincosf_x_1_1
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
	cpl	acc.7
	mov	r1,a
;	genAssign: resultIsFar = FALSE
	setb	_sincosf_sign_1_1
	sjmp 00106$
00102$:
;	sincosf.c:66: { y=x; sign=0; }
	mov	dptr,#_sincosf_x_1_1
;	genAssign: resultIsFar = TRUE
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
;	genAssign: resultIsFar = FALSE
	clr	_sincosf_sign_1_1
00106$:
;	sincosf.c:69: if(y>YMAX)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsgt_PARM_2
	clr  a
	movx	@dptr,a
	inc	dptr
	mov	a,#0x0C
	movx	@dptr,a
	inc	dptr
	mov	a,#0x49
	movx	@dptr,a
	inc	dptr
	mov	a,#0x46
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsgt
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,dpl
	jz  00108$
00128$:
;	sincosf.c:71: errno=ERANGE;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_errno
	mov	a,#0x22
	movx	@dptr,a
	clr	a
	inc	dptr
	movx	@dptr,a
;	sincosf.c:72: return 0.0;
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00115$
00108$:
;	sincosf.c:76: N=((y*iPI)+0.5); /*y is positive*/
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
	mov	dptr,#0xA2F983
	mov	b,#0x3E
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
;	genAssign: resultIsFar = FALSE
	mov	dpl,r2
	mov	dph,r3
;	sincosf.c:79: if(N&1) sign=!sign;
	mov	a,dpl
	jnb  acc.0,00110$
00129$:
	cpl	_sincosf_sign_1_1
00110$:
;	sincosf.c:81: XN=N;
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_sincosf_XN_1_1
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
;	sincosf.c:83: if(iscos) XN-=0.5;
	jnb  _sincosf_PARM_2,00112$
00130$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fssub_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	inc	dps
	mov	dptr,#_sincosf_XN_1_1
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
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_sincosf_XN_1_1
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
00112$:
;	sincosf.c:85: y=fabsf(x);
	inc	dps
	mov	dptr,#_sincosf_x_1_1
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
	lcall	_fabsf
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
;	sincosf.c:86: r=(int)y;
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fs2sint
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_sincosf_r_1_1
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
;	sincosf.c:87: g=y-r;
	mov	dptr,#_sincosf_r_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fssub_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
;	sincosf.c:88: f=((r-XN*C1)+g)-XN*C2;
	mov	dptr,#_sincosf_XN_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsmul_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov  dptr,#0x0000
	mov	dpx,#0x49
	mov	b,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fssub_PARM_2
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	inc	dps
	mov	dptr,#_sincosf_r_1_1
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
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	mov	dptr,#_sincosf_XN_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsmul_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps,#0
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x7DAA22
	mov	b,#0x3A
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fssub_PARM_2
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_sincosf_f_1_1
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
;	sincosf.c:90: g=f*f;
	mov	dptr,#_sincosf_f_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsmul_PARM_2
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	mov	dps, #1
	mov	dptr,#_sincosf_f_1_1
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
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
;	sincosf.c:91: if(g>EPS2) //Used to be if(fabsf(f)>EPS)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsgt_PARM_2
	mov	a,#0xF3
	movx	@dptr,a
	inc	dptr
	mov	a,#0xFF
	movx	@dptr,a
	inc	dptr
	mov	a,#0x7F
	movx	@dptr,a
	inc	dptr
	mov	a,#0x33
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsgt
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
	mov	a,dpl
	jnz	00131$
	ljmp	00114$
00131$:
;	sincosf.c:93: r=(((r4*g+r3)*g+r2)*g+r1)*g;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dptr,#0x2E9C5B
	mov	b,#0x36
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0x22
	movx	@dptr,a
	inc	dptr
	mov	a,#0xB2
	movx	@dptr,a
	inc	dptr
	mov	a,#0x4F
	movx	@dptr,a
	inc	dptr
	mov	a,#0xB9
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0x3E
	movx	@dptr,a
	inc	dptr
	mov	a,#0x87
	movx	@dptr,a
	inc	dptr
	mov	a,#0x08
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3C
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0xA4
	movx	@dptr,a
	inc	dptr
	mov	a,#0xAA
	movx	@dptr,a
	inc	dptr
	mov	a,#0x2A
	movx	@dptr,a
	inc	dptr
	mov	a,#0xBE
	movx	@dptr,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar6
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_PARM_2
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
;	sincosf.c:94: f+=f*r;
	inc	dps
	mov	dptr,#_sincosf_f_1_1
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
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
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
	inc	dps
	mov	dptr,#_sincosf_f_1_1
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
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_sincosf_f_1_1
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
00114$:
;	sincosf.c:96: return (sign?-f:f);
	jnb  _sincosf_sign_1_1,00117$
00132$:
	mov	dptr,#_sincosf_f_1_1
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
	cpl	acc.7
	mov	r5,a
	sjmp 00118$
00117$:
	mov	dptr,#_sincosf_f_1_1
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
00118$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00115$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
