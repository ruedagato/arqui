;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module _fsadd
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
	.globl ___fsadd_PARM_2
	.globl ___fsadd
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
___fsadd_sign_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
___fsadd_PARM_2:
	.ds 4
___fsadd_a1_1_1:
	.ds 4
___fsadd_mant1_1_1:
	.ds 4
___fsadd_mant2_1_1:
	.ds 4
___fsadd_exp1_1_1:
	.ds 2
___fsadd_exp2_1_1:
	.ds 2
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
;Allocation info for local variables in function '__fsadd'
;------------------------------------------------------------
;a2                        Allocated with name '___fsadd_PARM_2'
;a1                        Allocated with name '___fsadd_a1_1_1'
;mant1                     Allocated with name '___fsadd_mant1_1_1'
;mant2                     Allocated with name '___fsadd_mant2_1_1'
;pfl1                      Allocated to registers 
;pfl2                      Allocated to registers 
;exp1                      Allocated with name '___fsadd_exp1_1_1'
;exp2                      Allocated with name '___fsadd_exp2_1_1'
;expd                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	_fsadd.c:171: float __fsadd (float a1, float a2)
;	-----------------------------------------
;	 function __fsadd
;	-----------------------------------------
___fsadd:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #___fsadd_a1_1_1
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
;	_fsadd.c:179: pfl2 = (long _AUTOMEM *)&a2;
;	_fsadd.c:180: exp2 = EXP (*pfl2);
	mov	dptr,#___fsadd_PARM_2
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	mov	ar6,r0
	mov	a,r1
	mov	c,acc.7
	xch	a,r6
	rlc	a
	xch	a,r6
	rlc	a
	xch	a,r6
	anl	a,#0x01
	mov	r7,a
	mov	r0,#0
	mov	r1,#0
	mov	r7,#0
	mov	r0,#0
	mov	r1,#0
	mov	dptr,#___fsadd_exp2_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_fsadd.c:181: mant2 = MANT (*pfl2) << 4;
	mov	ar0,r2
	mov	ar1,r3
	mov	a,#0x7F
	anl	a,r4
	mov	r6,a
	mov	r7,#0
	orl	ar6,#0x80
	mov	b,#0x05
	sjmp	00165$
00164$:
	mov	a,r0
	add	a,acc
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
	mov	a,r6
	rlc	a
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
00165$:
	djnz	b,00164$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_mant2_1_1
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_fsadd.c:182: if (SIGN (*pfl2))
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	mov	a,r1
	rl	a
	anl	a,#0x01
	mov  r6,a
	jz  00102$
00166$:
;	_fsadd.c:183: mant2 = -mant2;
	mov	dptr,#___fsadd_mant2_1_1
	mov	dps, #1
	mov	dptr, #___fsadd_mant2_1_1
	dec	dps
	movx	a,@dptr
	setb	c
	cpl	a
	addc	a,#0x00
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
00102$:
;	_fsadd.c:185: if (!*pfl2)
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00104$
00167$:
;	_fsadd.c:186: return (a1);
	mov     dps, #1
	mov     dptr, #___fsadd_a1_1_1
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
	ljmp	00137$
00104$:
;	_fsadd.c:188: pfl1 = (long _AUTOMEM *)&a1;
;	_fsadd.c:189: exp1 = EXP (*pfl1);
	mov	dptr,#___fsadd_a1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r2,a
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	mov	r5,a
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	mov	ar6,r0
	mov	a,r1
	mov	c,acc.7
	xch	a,r6
	rlc	a
	xch	a,r6
	rlc	a
	xch	a,r6
	anl	a,#0x01
	mov	r7,a
	mov	r0,#0
	mov	r1,#0
	mov	r7,#0
	mov	r0,#0
	mov	r1,#0
	mov	dptr,#___fsadd_exp1_1_1
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_fsadd.c:190: mant1 = MANT (*pfl1) << 4;
	mov	ar0,r2
	mov	ar1,r3
	mov	a,#0x7F
	anl	a,r4
	mov	r6,a
	mov	r7,#0
	orl	ar6,#0x80
	mov	b,#0x05
	sjmp	00169$
00168$:
	mov	a,r0
	add	a,acc
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
	mov	a,r6
	rlc	a
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
00169$:
	djnz	b,00168$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_mant1_1_1
	mov	a,r0
	movx	@dptr,a
	inc	dptr
	mov	a,r1
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_fsadd.c:191: if (SIGN(*pfl1))
;	genAssign: resultIsFar = FALSE
	mov	ar6,r2
	mov	ar7,r3
	mov	ar0,r4
	mov	ar1,r5
	mov	a,r1
	rl	a
	anl	a,#0x01
	mov  r6,a
	jz  00108$
00170$:
;	_fsadd.c:192: if (*pfl1 & 0x80000000)
	mov	a,r5
	jnb  acc.7,00108$
00171$:
;	_fsadd.c:193: mant1 = -mant1;
	mov	dptr,#___fsadd_mant1_1_1
	mov	dps, #1
	mov	dptr, #___fsadd_mant1_1_1
	dec	dps
	movx	a,@dptr
	setb	c
	cpl	a
	addc	a,#0x00
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
00108$:
;	_fsadd.c:195: if (!*pfl1)
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00110$
00172$:
;	_fsadd.c:196: return (a2);
	mov     dps, #1
	mov     dptr, #___fsadd_PARM_2
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
	ljmp	00137$
00110$:
;	_fsadd.c:198: expd = exp1 - exp2;
	mov	dptr,#___fsadd_exp2_1_1
	mov	dps, #1
	mov	dptr, #___fsadd_exp1_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	b,a
	inc	dps
	movx	a,@dptr
	subb	a,b
	push	acc
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	push	acc
	mov	dps,#0
	pop	acc
	mov	r3,a
	pop	acc
	mov	r2,a
;	_fsadd.c:199: if (expd > 25)
	clr	c
	mov	a,#0x19
	subb	a,r2
	mov  a,#(0x00 ^ 0x80)
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc  00112$
00173$:
;	_fsadd.c:200: return (a1);
	mov     dps, #1
	mov     dptr, #___fsadd_a1_1_1
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
	ljmp	00137$
00112$:
;	_fsadd.c:201: if (expd < -25)
	clr	c
	mov	a,r2
	subb	a,#0xE7
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x7F
	jnc  00114$
00174$:
;	_fsadd.c:202: return (a2);
	mov     dps, #1
	mov     dptr, #___fsadd_PARM_2
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
	ljmp	00137$
00114$:
;	_fsadd.c:204: if (expd < 0)
	mov	a,r3
	jnb  acc.7,00116$
00175$:
;	_fsadd.c:206: expd = -expd;
	clr	c
	clr	a
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
;	_fsadd.c:207: exp1 += expd;
	mov	dptr,#___fsadd_exp1_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
;	_fsadd.c:208: mant1 >>= expd;
	mov	b,r2
	inc	b
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	inc	dptr
	movx	a,@dptr
	mov     r6,a
	inc	dptr
	movx	a,@dptr
	mov     r7,a
	movx	a,@dptr
	rlc	a
	mov	ov,c
	sjmp	00177$
00176$:
	mov	c,ov
	mov	a,r7
	rrc	a
	mov	r7,a
	mov	a,r6
	rrc	a
	mov	r6,a
	mov	a,r5
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
00177$:
	djnz	b,00176$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_mant1_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	sjmp 00117$
00116$:
;	_fsadd.c:212: mant2 >>= expd;
	mov	b,r2
	inc	b
	mov	dptr,#___fsadd_mant2_1_1
	movx	a,@dptr
	mov     r2,a
	inc	dptr
	movx	a,@dptr
	mov     r3,a
	inc	dptr
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	movx	a,@dptr
	rlc	a
	mov	ov,c
	sjmp	00179$
00178$:
	mov	c,ov
	mov	a,r5
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
	mov	a,r3
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a
00179$:
	djnz	b,00178$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_mant2_1_1
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
00117$:
;	_fsadd.c:214: mant1 += mant2;
	mov	dptr,#___fsadd_mant2_1_1
	mov	dps, #1
	mov	dptr, #___fsadd_mant1_1_1
	dec	dps
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	movx	a,@dptr
	xch	a, _ap
	add	a,_ap
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	inc	dps
	inc	dptr
	movx	a,@dptr
	xch	a, _ap
	addc	a,_ap
	movx	@dptr,a
	mov	dps,#0
;	_fsadd.c:216: sign = false;
;	genAssign: resultIsFar = FALSE
	clr	___fsadd_sign_1_1
;	_fsadd.c:218: if (mant1 < 0)
	mov	dptr,#___fsadd_mant1_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	jnb  acc.7,00121$
00180$:
;	_fsadd.c:220: mant1 = -mant1;
	mov	dptr,#___fsadd_mant1_1_1
	mov	dps, #1
	mov	dptr, #___fsadd_mant1_1_1
	dec	dps
	movx	a,@dptr
	setb	c
	cpl	a
	addc	a,#0x00
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	a
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
;	_fsadd.c:221: sign = true;
;	genAssign: resultIsFar = FALSE
	setb	___fsadd_sign_1_1
	sjmp 00154$
00121$:
;	_fsadd.c:223: else if (!mant1)
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	mov	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	b,a
	inc	dptr
	movx	a,@dptr
	orl	a,b
	jnz  00154$
00181$:
;	_fsadd.c:224: return (0);
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00137$
;	_fsadd.c:227: while (mant1 < (HIDDEN<<4)) {
00154$:
	mov	dptr,#___fsadd_exp1_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
00123$:
	mov	dptr,#___fsadd_mant1_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	clr	c
	mov	a,r4
	subb	a,#0x00
	mov	a,r5
	subb	a,#0x00
	mov	a,r6
	subb	a,#0x00
	mov	a,r7
	subb	a,#0x08
	jnc  00157$
00182$:
;	_fsadd.c:228: mant1 <<= 1;
	mov	b,#0x02
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	inc	dptr
	movx	a,@dptr
	mov     r6,a
	inc	dptr
	movx	a,@dptr
	mov     r7,a
	sjmp	00184$
00183$:
	mov	a,r4
	add	a,acc
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
00184$:
	djnz	b,00183$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_mant1_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_fsadd.c:229: exp1--;
	dec	r2
	cjne	r2,#0xFF,00185$
	dec	r3
00185$:
;	_fsadd.c:233: while (mant1 & 0xf0000000) {
	sjmp 00123$
00157$:
;	genAssign: resultIsFar = FALSE
00128$:
	mov	dptr,#___fsadd_mant1_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	anl	a,#0xF0
	jz  00163$
00186$:
;	_fsadd.c:234: if (mant1&1)
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	jnb  acc.0,00127$
00187$:
;	_fsadd.c:235: mant1 += 2;
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	add	a,#0x02
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
	addc	a,#0x00
	movx	@dptr,a
00127$:
;	_fsadd.c:236: mant1 >>= 1;
	mov	dptr,#___fsadd_mant1_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	c,acc.7
	rrc	a
	mov	r7,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r6,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r5,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
;	genAssign: resultIsFar = TRUE
	mov  r4,a
	mov  dptr,#___fsadd_mant1_1_1
	movx @dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
;	_fsadd.c:237: exp1++;
	inc	r2
	cjne	r2,#0,00188$
	inc	r3
00188$:
	sjmp 00128$
00163$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsadd_exp1_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_fsadd.c:241: mant1 &= ~(HIDDEN<<4);
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	anl	a,#0xF7
	movx	@dptr,a
;	_fsadd.c:244: if (exp1 >= 0x100)
	clr	c
	mov	a,r2
	subb	a,#0x00
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x81
	jc   00135$
00189$:
;	_fsadd.c:245: *pfl1 = (sign ? (SIGNBIT | __INFINITY) : __INFINITY);
	jnb  ___fsadd_sign_1_1,00139$
00190$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x00
	mov	r5,#0x00
	mov	r6,#0x80
	mov	r7,#0xFF
	sjmp 00140$
00139$:
;	genAssign: resultIsFar = FALSE
	mov	r4,#0x00
	mov	r5,#0x00
	mov	r6,#0x80
	mov	r7,#0x7F
00140$:
	mov	dptr,#___fsadd_a1_1_1
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	ljmp	00136$
00135$:
;	_fsadd.c:246: else if (exp1 < 0)
	mov	a,r3
	jnb  acc.7,00132$
00191$:
;	_fsadd.c:247: *pfl1 = 0;
	mov	dptr,#___fsadd_a1_1_1
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	ljmp	00136$
00132$:
;	_fsadd.c:249: *pfl1 = PACK (sign ? SIGNBIT : 0 , exp1, mant1>>4);
	jnb  ___fsadd_sign_1_1,00141$
00192$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x80
	sjmp 00142$
00141$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
00142$:
	mov	dptr,#___fsadd_exp1_1_1
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	movx	a,@dptr
	rlc	a
	subb	a,acc
	mov	r0,a
	mov	r1,a
	mov	b,#0x18
	sjmp	00194$
00193$:
	mov	a,r6
	add	a,acc
	mov	r6,a
	mov	a,r7
	rlc	a
	mov	r7,a
	mov	a,r0
	rlc	a
	mov	r0,a
	mov	a,r1
	rlc	a
	mov	r1,a
00194$:
	djnz	b,00193$
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
	mov	a,r0
	orl	ar4,a
	mov	a,r1
	orl	ar5,a
	mov	dptr,#___fsadd_mant1_1_1
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	swap	a
	xch	a,r6
	swap	a
	anl	a,#0x0F
	xrl	a,r6
	xch	a,r6
	anl	a,#0x0F
	xch	a,r6
	xrl	a,r6
	xch	a,r6
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	swap	a
	anl	a,#0xF0
	orl	a,r7
	mov	r7,a
	movx	a,@dptr
	mov	r0,a
	inc	dptr
	movx	a,@dptr
	swap	a
	xch	a,r0
	swap	a
	anl	a,#0x0F
	xrl	a,r0
	xch	a,r0
	anl	a,#0x0F
	xch	a,r0
	xrl	a,r0
	xch	a,r0
	jnb	acc.3,00195$
	orl	a,#0xF0
00195$:
	mov	r1,a
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
	mov	a,r0
	orl	ar4,a
	mov	a,r1
	orl	ar5,a
	mov	dptr,#___fsadd_a1_1_1
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
00136$:
;	_fsadd.c:250: return (a1);
	mov     dps, #1
	mov     dptr, #___fsadd_a1_1_1
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
00137$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
