;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:19 2015
;--------------------------------------------------------
	.module tanhf
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
	.globl _tanhf
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
;Allocation info for local variables in function 'tanhf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 1
;f                         Allocated to stack - offset 5
;g                         Allocated to registers r2 r3 r4 r5 
;r                         Allocated to registers r2 r3 r4 r5 
;sloc0                     Allocated to stack - offset 9
;------------------------------------------------------------
;	tanhf.c:50: float tanhf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function tanhf
;	-----------------------------------------
_tanhf:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	push	_bpx
	push	_bpx+1
	mov	_bpx,sp
	mov	_bpx+1,esp
	anl	_bpx+1,#3
	orl	_bpx+1,#0xDC
	mov	a,sp
	add	a,#0x0C
	mov	sp,a
	mov	a,esp
	anl	a,#3
	orl	a,#0xDC
	addc	a,#0x00
	mov	esp,a
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
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
;	tanhf.c:54: f=fabsf(x);
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
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
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph,a
	mov	dpx,#0xFF
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
;	tanhf.c:55: if(f>SBIG) r=1.0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsgt_PARM_2
	mov	a,#0xB0
	movx	@dptr,a
	inc	dptr
	mov	a,#0x2C
	movx	@dptr,a
	inc	dptr
	mov	a,#0x10
	movx	@dptr,a
	inc	dptr
	mov	a,#0x41
	movx	@dptr,a
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	lcall	___fsgt
	mov	a,dpl
	jz  00108$
00118$:
;	genAssign: resultIsFar = TRUE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x80
	mov	r5,#0x3F
	ljmp	00109$
00108$:
;	tanhf.c:56: else if(f>K1)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsgt_PARM_2
	mov	a,#0x54
	movx	@dptr,a
	inc	dptr
	mov	a,#0x9F
	movx	@dptr,a
	inc	dptr
	mov	a,#0x0C
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	lcall	___fsgt
	mov	a,dpl
	jnz	00119$
	ljmp	00105$
00119$:
;	tanhf.c:58: r=0.5-1.0/(expf(f+f)+1.0);
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph,a
	mov	dpx,#0xFF
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#___fsadd_PARM_2
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
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	lcall	_expf
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
	mov	a,#0x80
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3F
	movx	@dptr,a
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_PARM_2
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
	mov  dptr,#0x0000
	mov	dpx,#0x80
	mov	b,#0x3F
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
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
	mov  dptr,#0x0000
	mov	b,#0x3F
	lcall	___fssub
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	ar2,r6
	mov	ar3,r7
	mov	ar4,r0
	mov	ar5,r1
;	tanhf.c:59: r+=r;
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	ar2,r6
	mov	ar3,r7
	mov	ar4,r0
	mov	ar5,r1
	ljmp	00109$
00105$:
;	tanhf.c:61: else if(f<EPS) r=f;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fslt_PARM_2
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x80
	movx	@dptr,a
	inc	dptr
	mov	a,#0x39
	movx	@dptr,a
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
00120$:
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph,a
	mov	dpx,#0xFF
;	genAssign: resultIsFar = TRUE
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
	ljmp	00109$
00102$:
;	tanhf.c:64: g=f*f;
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph,a
	mov	dpx,#0xFF
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
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = FALSE
	mov	ar2,r6
	mov	ar3,r7
	mov	ar4,r0
	mov	ar5,r1
;	tanhf.c:65: r=f+f*(P(g)/Q(g));
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x7B11B2
	mov	b,#0xBB
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0xC6
	movx	@dptr,a
	inc	dptr
	mov	a,#0xE2
	movx	@dptr,a
	inc	dptr
	mov	a,#0x52
	movx	@dptr,a
	inc	dptr
	mov	a,#0xBF
	movx	@dptr,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsadd
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsmul
	mov	a,_bpx
	clr	c
	subb	a,#0xF7
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_PARM_2
	mov	a,#0x1A
	movx	@dptr,a
	inc	dptr
	mov	a,#0x2A
	movx	@dptr,a
	inc	dptr
	mov	a,#0x1E
	movx	@dptr,a
	inc	dptr
	mov	a,#0x40
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
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_PARM_2
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
	mov	a,_bpx
	clr	c
	subb	a,#0xF7
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	lcall	___fsdiv
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
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
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
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
	mov	a,_bpx
	clr	c
	subb	a,#0xFB
	mov	dpl1,a
	mov	a,_bpx+1
	subb	a,#0xFF
	mov	dph1,a
	mov	dpx1,#0xFF
	inc	dps
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
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
;	genAssign: resultIsFar = TRUE
	mov	ar2,r6
	mov	ar3,r7
	mov	ar4,r0
	mov	ar5,r1
00109$:
;	tanhf.c:67: if(x<0.0) r=-r;
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpx1,#0xFF
	mov	dph1,_bpx+1
	mov	dpl1,_bpx
	mov	dps,#1
	inc	dptr
	mov	dps, #1
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
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00111$
00121$:
	mov	a,r5
	cpl	acc.7
	mov	r5,a
00111$:
;	tanhf.c:68: return r;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00112$:
	mov	sp,_bpx
	mov	esp,_bpx+1
	pop	_bpx+1
	pop	_bpx
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
