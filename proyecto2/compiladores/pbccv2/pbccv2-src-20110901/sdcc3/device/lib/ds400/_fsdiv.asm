;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module _fsdiv
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
	.globl ___fsdiv_PARM_2
	.globl ___fsdiv
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
___fsdiv_PARM_2:
	.ds 4
___fsdiv_fl1_1_1:
	.ds 4
___fsdiv_fl2_1_1:
	.ds 4
___fsdiv_result_1_1:
	.ds 4
___fsdiv_mask_1_1:
	.ds 4
___fsdiv_mant1_1_1:
	.ds 4
___fsdiv_mant2_1_1:
	.ds 4
___fsdiv_exp_1_1:
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
;Allocation info for local variables in function '__fsdiv'
;------------------------------------------------------------
;a2                        Allocated with name '___fsdiv_PARM_2'
;a1                        Allocated to registers r2 r3 r4 r5 
;fl1                       Allocated with name '___fsdiv_fl1_1_1'
;fl2                       Allocated with name '___fsdiv_fl2_1_1'
;result                    Allocated with name '___fsdiv_result_1_1'
;mask                      Allocated with name '___fsdiv_mask_1_1'
;mant1                     Allocated with name '___fsdiv_mant1_1_1'
;mant2                     Allocated with name '___fsdiv_mant2_1_1'
;exp                       Allocated with name '___fsdiv_exp_1_1'
;sign                      Allocated to registers r2 
;------------------------------------------------------------
;	_fsdiv.c:274: float __fsdiv (float a1, float a2)
;	-----------------------------------------
;	 function __fsdiv
;	-----------------------------------------
___fsdiv:
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
;	_fsdiv.c:283: fl1.f = a1;
	mov	dptr,#___fsdiv_fl1_1_1
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
;	_fsdiv.c:284: fl2.f = a2;
	mov	dptr,#___fsdiv_fl2_1_1
	mov     dps, #1
	mov     dptr, #___fsdiv_PARM_2
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
	inc	dptr
	inc	dps
	inc	dptr
	movx	a,@dptr
	dec	dps
	movx	@dptr,a
;	_fsdiv.c:287: exp = EXP (fl1.l) ;
	mov	dptr,#___fsdiv_fl1_1_1
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
	mov	ar2,r4
	mov	a,r5
	mov	c,acc.7
	xch	a,r2
	rlc	a
	xch	a,r2
	rlc	a
	xch	a,r2
	anl	a,#0x01
	mov	r3,a
	mov	r4,#0
	mov	r5,#0
	mov	r3,#0
	mov	r4,#0
	mov	r5,#0
	mov	dptr,#___fsdiv_exp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_fsdiv.c:288: exp -= EXP (fl2.l);
	mov	dptr,#___fsdiv_fl2_1_1
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
	mov	ar2,r4
	mov	a,r5
	mov	c,acc.7
	xch	a,r2
	rlc	a
	xch	a,r2
	rlc	a
	xch	a,r2
	anl	a,#0x01
	mov	r3,a
	mov	r4,#0
	mov	r5,#0
	mov	r3,#0
	mov	r4,#0
	mov	r5,#0
	mov	dptr,#___fsdiv_exp_1_1
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
	clr	c
	mov	a,r6
	subb	a,r2
	mov	r2,a
	mov	a,r7
	subb	a,r3
	mov	r3,a
	mov	a,r0
	subb	a,r4
	mov	r4,a
	mov	a,r1
	subb	a,r5
	mov	r5,a
	mov	dptr,#___fsdiv_exp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
;	_fsdiv.c:289: exp += EXCESS;
	mov	dptr,#___fsdiv_exp_1_1
	movx	a,@dptr
	add	a,#0x7E
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
;	_fsdiv.c:292: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	mov	dptr,#___fsdiv_fl1_1_1
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
	mov  r5,a
	rl	a
	anl	a,#0x01
	mov	r2,a
	mov	dptr,#___fsdiv_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov  r6,a
	rl	a
	anl	a,#0x01
	mov  r3,a
	xrl	ar2,a
;	_fsdiv.c:295: if (!fl2.l)
	mov	dptr,#___fsdiv_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	mov	a,r3
	orl	a,r4
	orl	a,r5
	orl	a,r6
	jnz  00102$
00134$:
;	_fsdiv.c:297: fl2.l = 0x7FC00000;
	mov	dptr,#___fsdiv_fl2_1_1
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0xC0
	movx	@dptr,a
	inc	dptr
	mov	a,#0x7F
	movx	@dptr,a
;	_fsdiv.c:298: return (fl2.f);
	mov	dptr,#___fsdiv_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	mov	dpl,r3
	mov	dph,r4
	mov	dpx,r5
	mov	b,r6
	ljmp	00118$
00102$:
;	_fsdiv.c:302: if (!fl1.l)
	mov	dptr,#___fsdiv_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	mov	a,r3
	orl	a,r4
	orl	a,r5
	orl	a,r6
	jnz  00104$
00135$:
;	_fsdiv.c:303: return (0);
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00118$
00104$:
;	_fsdiv.c:306: mant1 = MANT (fl1.l);
	mov	dptr,#___fsdiv_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	anl	ar5,#0x7F
	mov	r6,#0
	mov	dptr,#___fsdiv_mant1_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	mov	a,#0x80
	orl	a,r5
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_fsdiv.c:307: mant2 = MANT (fl2.l);
	mov	dptr,#___fsdiv_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r3,a
	movx	a,@dptr
	inc	dptr
	mov	r4,a
	movx	a,@dptr
	inc	dptr
	mov	r5,a
	movx	a,@dptr
	mov	r6,a
	anl	ar5,#0x7F
	mov	r6,#0
	mov	dptr,#___fsdiv_mant2_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	mov	a,#0x80
	orl	a,r5
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_fsdiv.c:310: if (mant1 < mant2)
	mov	dptr,#___fsdiv_mant2_1_1
	mov	dps, #1
	mov	dptr, #___fsdiv_mant1_1_1
	dec	dps
	clr	c
	mov	dps,#1
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xrl	a,#0x80
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	xrl	b,#0x80
	subb	a,b
	jnc  00106$
00136$:
;	_fsdiv.c:312: mant1 <<= 1;
	mov	b,#0x02
	mov	dptr,#___fsdiv_mant1_1_1
	movx	a,@dptr
	mov     r3,a
	inc	dptr
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	inc	dptr
	movx	a,@dptr
	mov     r6,a
	sjmp	00138$
00137$:
	mov	a,r3
	add	a,acc
	mov	r3,a
	mov	a,r4
	rlc	a
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
00138$:
	djnz	b,00137$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_mant1_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_fsdiv.c:313: exp--;
	mov	dptr,#___fsdiv_exp_1_1
	movx	a,@dptr
	add	a,#0xFF
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r4,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_exp_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
00106$:
;	_fsdiv.c:317: mask = 0x1000000;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_mask_1_1
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx	@dptr,a
	inc	dptr
	mov	a,#0x01
	movx	@dptr,a
;	_fsdiv.c:318: result = 0;
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_result_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
;	_fsdiv.c:319: while (mask)
00109$:
	mov	dptr,#___fsdiv_mask_1_1
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
	jnz	00139$
	ljmp	00111$
00139$:
;	_fsdiv.c:321: if (mant1 >= mant2)
	mov	dptr,#___fsdiv_mant2_1_1
	mov	dps, #1
	mov	dptr, #___fsdiv_mant1_1_1
	dec	dps
	clr	c
	mov	dps,#1
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	subb	a,b
	mov	dps,#1
	inc	dptr
	movx	a,@dptr
	mov	dps,#0
	xrl	a,#0x80
	xch	a, b
	inc	dptr
	movx	a,@dptr
	xch	a, b
	xrl	b,#0x80
	subb	a,b
	jnc	00140$
	ljmp	00108$
00140$:
;	_fsdiv.c:323: result |= mask;
	mov	dptr,#___fsdiv_result_1_1
;	genAssign: resultIsFar = FALSE
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	mov	dptr,#___fsdiv_mask_1_1
	movx	a,@dptr
	orl	ar3,a
	inc	dptr
	movx	a,@dptr
	orl	ar4,a
	inc	dptr
	movx	a,@dptr
	orl	ar5,a
	inc	dptr
	movx	a,@dptr
	orl	ar6,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_result_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_fsdiv.c:324: mant1 -= mant2;
	mov	dptr,#___fsdiv_mant2_1_1
	mov	dps, #1
	mov	dptr, #___fsdiv_mant1_1_1
	dec	dps
	clr	c
	movx	a,@dptr
	mov	b,a
	inc	dps
	movx	a,@dptr
	subb	a,b
	mov	r3,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	mov	r4,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	mov	r5,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	mov	b,a
	inc	dps
	inc	dptr
	movx	a,@dptr
	subb	a,b
	mov	r6,a
	mov	dps,#0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_mant1_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
00108$:
;	_fsdiv.c:326: mant1 <<= 1;
	mov	b,#0x02
	mov	dptr,#___fsdiv_mant1_1_1
	movx	a,@dptr
	mov     r3,a
	inc	dptr
	movx	a,@dptr
	mov     r4,a
	inc	dptr
	movx	a,@dptr
	mov     r5,a
	inc	dptr
	movx	a,@dptr
	mov     r6,a
	sjmp	00142$
00141$:
	mov	a,r3
	add	a,acc
	mov	r3,a
	mov	a,r4
	rlc	a
	mov	r4,a
	mov	a,r5
	rlc	a
	mov	r5,a
	mov	a,r6
	rlc	a
	mov	r6,a
00142$:
	djnz	b,00141$
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsdiv_mant1_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_fsdiv.c:327: mask >>= 1;
	mov	dptr,#___fsdiv_mask_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	clr	c
	rrc	a
	mov	r6,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r5,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r4,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
;	genAssign: resultIsFar = TRUE
	mov  r3,a
	mov  dptr,#___fsdiv_mask_1_1
	movx @dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	ljmp	00109$
00111$:
;	_fsdiv.c:331: result += 1;
	mov	dptr,#___fsdiv_result_1_1
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
	addc	a,#0x00
	movx	@dptr,a
;	_fsdiv.c:334: exp++;
	mov	dptr,#___fsdiv_exp_1_1
	movx	a,@dptr
	add	a,#0x01
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	movx	@dptr,a
;	_fsdiv.c:335: result >>= 1;
	mov	dptr,#___fsdiv_result_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	mov	c,acc.7
	rrc	a
	mov	r6,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r5,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
	mov	r4,a
	lcall	__decdptr
	movx	a,@dptr
	rrc	a
;	genAssign: resultIsFar = TRUE
	mov  r3,a
	mov  dptr,#___fsdiv_result_1_1
	movx @dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
;	_fsdiv.c:337: result &= ~HIDDEN;
	mov	dptr,#___fsdiv_result_1_1
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	anl	a,#0x7F
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	movx	@dptr,a
;	_fsdiv.c:340: if (exp >= 0x100)
	mov	dptr,#___fsdiv_exp_1_1
	clr	c
	movx	a,@dptr
	subb	a,#0x00
	inc	dptr
	movx	a,@dptr
	xrl	a,#0x80
	subb	a,#0x81
	jc   00116$
00143$:
;	_fsdiv.c:341: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	mov	a,r2
	jz  00120$
00144$:
;	genAssign: resultIsFar = FALSE
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
	mov	r6,#0x80
	sjmp 00121$
00120$:
;	genAssign: resultIsFar = FALSE
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
	mov	r6,#0x00
00121$:
	orl	ar5,#0x80
	orl	ar6,#0x7F
	mov	dptr,#___fsdiv_fl1_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	ljmp	00117$
00116$:
;	_fsdiv.c:342: else if (exp < 0)
	mov	dptr,#___fsdiv_exp_1_1
	inc	dptr
	movx	a,@dptr
	jnb  acc.7,00113$
00145$:
;	_fsdiv.c:343: fl1.l = 0;
	mov	dptr,#___fsdiv_fl1_1_1
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	sjmp 00117$
00113$:
;	_fsdiv.c:345: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	mov	a,r2
	jz  00122$
00146$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x80
	sjmp 00123$
00122$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
00123$:
	mov	dptr,#___fsdiv_exp_1_1
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
	sjmp	00148$
00147$:
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
00148$:
	djnz	b,00147$
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
	mov	a,r0
	orl	ar4,a
	mov	a,r1
	orl	ar5,a
	mov	dptr,#___fsdiv_result_1_1
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
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
	mov	a,r0
	orl	ar4,a
	mov	a,r1
	orl	ar5,a
	mov	dptr,#___fsdiv_fl1_1_1
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
;	_fsdiv.c:346: return (fl1.f);
	mov	dptr,#___fsdiv_fl1_1_1
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
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
00118$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
