;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:16 2015
;--------------------------------------------------------
	.module _fsmul
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
	.globl ___fsmul_PARM_2
	.globl ___fsmul
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
___fsmul_PARM_2:
	.ds 4
___fsmul_fl1_1_1:
	.ds 4
___fsmul_fl2_1_1:
	.ds 4
___fsmul_result_1_1:
	.ds 4
___fsmul_exp_1_1:
	.ds 2
___fsmul_sign_1_1:
	.ds 1
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
;Allocation info for local variables in function '__fsmul'
;------------------------------------------------------------
;a2                        Allocated with name '___fsmul_PARM_2'
;a1                        Allocated to registers r2 r3 r4 r5 
;fl1                       Allocated with name '___fsmul_fl1_1_1'
;fl2                       Allocated with name '___fsmul_fl2_1_1'
;result                    Allocated with name '___fsmul_result_1_1'
;exp                       Allocated with name '___fsmul_exp_1_1'
;sign                      Allocated with name '___fsmul_sign_1_1'
;------------------------------------------------------------
;	_fsmul.c:241: float __fsmul (float a1, float a2) {
;	-----------------------------------------
;	 function __fsmul
;	-----------------------------------------
___fsmul:
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
;	_fsmul.c:247: fl1.f = a1;
	mov	dptr,#___fsmul_fl1_1_1
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
;	_fsmul.c:248: fl2.f = a2;
	mov	dptr,#___fsmul_fl2_1_1
	mov     dps, #1
	mov     dptr, #___fsmul_PARM_2
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
;	_fsmul.c:250: if (!fl1.l || !fl2.l)
	mov	dptr,#___fsmul_fl1_1_1
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
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jz  00101$
00125$:
	mov	dptr,#___fsmul_fl2_1_1
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
	mov	a,r2
	orl	a,r3
	orl	a,r4
	orl	a,r5
	jnz  00102$
00126$:
00101$:
;	_fsmul.c:251: return (0);
	mov  dptr,#0x0000
	mov	b,#0x00
	ljmp	00113$
00102$:
;	_fsmul.c:254: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	mov	dptr,#___fsmul_fl1_1_1
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
	mov	dptr,#___fsmul_fl2_1_1
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
	mov	r3,a
	mov	dptr,#___fsmul_sign_1_1
	mov	a,r2
	xrl	a,r3
	movx	@dptr,a
;	_fsmul.c:255: exp = EXP (fl1.l) - EXCESS;
	mov	dptr,#___fsmul_fl1_1_1
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
	mov	ar3,r5
	mov	a,r6
	mov	c,acc.7
	xch	a,r3
	rlc	a
	xch	a,r3
	rlc	a
	xch	a,r3
	anl	a,#0x01
	mov	r4,a
	mov	r5,#0
	mov	r6,#0
	mov	r4,#0
	mov	r5,#0
	mov	r6,#0
	mov	a,r3
	add	a,#0x82
	mov	r3,a
	mov	a,r4
	addc	a,#0xFF
	mov	r4,a
	mov	a,r5
	addc	a,#0xFF
	mov	r5,a
	mov	a,r6
	addc	a,#0xFF
	mov	r6,a
	mov	dptr,#___fsmul_exp_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_fsmul.c:256: exp += EXP (fl2.l);
	mov	dptr,#___fsmul_fl2_1_1
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
	mov	ar3,r5
	mov	a,r6
	mov	c,acc.7
	xch	a,r3
	rlc	a
	xch	a,r3
	rlc	a
	xch	a,r3
	anl	a,#0x01
	mov	r4,a
	mov	r5,#0
	mov	r6,#0
	mov	r4,#0
	mov	r5,#0
	mov	r6,#0
	mov	dptr,#___fsmul_exp_1_1
	movx	a,@dptr
	mov	r7,a
	inc	dptr
	movx	a,@dptr
	mov	r0,a
	movx	a,@dptr
	rlc	a
	subb	a,acc
	mov	r1,a
	mov	r2,a
	mov	a,r3
	add	a,r7
	mov	r3,a
	mov	a,r4
	addc	a,r0
	mov	r4,a
	mov	a,r5
	addc	a,r1
	mov	r5,a
	mov	a,r6
	addc	a,r2
	mov	r6,a
	mov	dptr,#___fsmul_exp_1_1
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_fsmul.c:258: fl1.l = MANT (fl1.l);
	mov	dptr,#___fsmul_fl1_1_1
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
	anl	ar4,#0x7F
	mov	r5,#0
	orl	ar4,#0x80
	mov	dptr,#___fsmul_fl1_1_1
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
;	_fsmul.c:259: fl2.l = MANT (fl2.l);
	mov	dptr,#___fsmul_fl2_1_1
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
	anl	ar4,#0x7F
	mov	r5,#0
	orl	ar4,#0x80
	mov	dptr,#___fsmul_fl2_1_1
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
;	_fsmul.c:262: result = (fl1.l >> 8) * (fl2.l >> 8);
	mov	dptr,#___fsmul_fl1_1_1
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
	mov	ar2,r3
	mov	ar3,r4
	mov	ar4,r5
	mov	r5,#0
	mov	dptr,#___fsmul_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	mov	ar6,r7
	mov	ar7,r0
	mov	ar0,r1
	mov	r1,#0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__mullong_PARM_2
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
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_result_1_1
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
;	_fsmul.c:263: result += ((fl1.l & (unsigned long) 0xFF) * (fl2.l >> 8)) >> 8;
	mov	dptr,#___fsmul_fl1_1_1
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
	mov	r3,#0
	mov	r4,#0
	mov	r5,#0
	mov	dptr,#___fsmul_fl2_1_1
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	mov	ar6,r7
	mov	ar7,r0
	mov	ar0,r1
	mov	r1,#0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__mullong_PARM_2
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
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	mov	ar2,r3
	mov	ar3,r4
	mov	ar4,r5
	mov	r5,#0
	mov	dptr,#___fsmul_result_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r5
	movx	@dptr,a
;	_fsmul.c:264: result += ((fl2.l & (unsigned long) 0xFF) * (fl1.l >> 8)) >> 8;
	mov	dptr,#___fsmul_fl2_1_1
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
	mov	r3,#0
	mov	r4,#0
	mov	r5,#0
	mov	dptr,#___fsmul_fl1_1_1
	movx	a,@dptr
	inc	dptr
	mov	r6,a
	movx	a,@dptr
	inc	dptr
	mov	r7,a
	movx	a,@dptr
	inc	dptr
	mov	r0,a
	movx	a,@dptr
	mov	r1,a
	mov	ar6,r7
	mov	ar7,r0
	mov	ar0,r1
	mov	r1,#0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#__mullong_PARM_2
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
	lcall	__mullong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	mov	ar2,r3
	mov	ar3,r4
	mov	ar4,r5
	mov	r5,#0
	mov	dptr,#___fsmul_result_1_1
	movx	a,@dptr
	add	a,r2
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r3
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r4
	movx	@dptr,a
	inc	dptr
	movx	a,@dptr
	addc	a,r5
	movx	@dptr,a
;	_fsmul.c:267: result += 0x40;
	mov	dptr,#___fsmul_result_1_1
	movx	a,@dptr
	add	a,#0x40
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
;	_fsmul.c:269: if (result & SIGNBIT)
	mov	dptr,#___fsmul_result_1_1
	inc	dptr
	inc	dptr
	inc	dptr
	movx	a,@dptr
	jnb  acc.7,00105$
00127$:
;	_fsmul.c:272: result += 0x40;
	mov	dptr,#___fsmul_result_1_1
	movx	a,@dptr
	add	a,#0x40
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
;	_fsmul.c:273: result >>= 8;
	mov	dptr,#___fsmul_result_1_1
	inc	dptr
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	r5,#0
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_result_1_1
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
	sjmp 00106$
00105$:
;	_fsmul.c:277: result >>= 7;
	mov	dptr,#___fsmul_result_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	c,acc.7
	xch	a,r2
	rlc	a
	xch	a,r2
	rlc	a
	xch	a,r2
	anl	a,#0x01
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	add	a,acc
	orl	a,r3
	mov	r3,a
	movx	a,@dptr
	mov	r4,a
	inc	dptr
	movx	a,@dptr
	mov	c,acc.7
	xch	a,r4
	rlc	a
	xch	a,r4
	rlc	a
	xch	a,r4
	anl	a,#0x01
	mov	r5,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_result_1_1
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
;	_fsmul.c:278: exp--;
	mov	dptr,#___fsmul_exp_1_1
	movx	a,@dptr
	add	a,#0xFF
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	addc	a,#0xFF
	mov	r3,a
;	genAssign: resultIsFar = TRUE
	mov	dptr,#___fsmul_exp_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
00106$:
;	_fsmul.c:281: result &= ~HIDDEN;
	mov	dptr,#___fsmul_result_1_1
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
;	_fsmul.c:284: if (exp >= 0x100)
	mov	dptr,#___fsmul_exp_1_1
	clr	c
	movx	a,@dptr
	subb	a,#0x00
	inc	dptr
	movx	a,@dptr
	xrl	a,#0x80
	subb	a,#0x81
	jc   00111$
00128$:
;	_fsmul.c:285: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	mov	dptr,#___fsmul_sign_1_1
	movx	a,@dptr
	jz  00115$
00129$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x80
	sjmp 00116$
00115$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
00116$:
	orl	ar4,#0x80
	orl	ar5,#0x7F
	mov	dptr,#___fsmul_fl1_1_1
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
	ljmp	00112$
00111$:
;	_fsmul.c:286: else if (exp < 0)
	mov	dptr,#___fsmul_exp_1_1
	inc	dptr
	movx	a,@dptr
	jnb  acc.7,00108$
00130$:
;	_fsmul.c:287: fl1.l = 0;
	mov	dptr,#___fsmul_fl1_1_1
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	clr  a
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	sjmp 00112$
00108$:
;	_fsmul.c:289: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	mov	dptr,#___fsmul_sign_1_1
	movx	a,@dptr
	jz  00117$
00131$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x80
	sjmp 00118$
00117$:
;	genAssign: resultIsFar = FALSE
	mov	r2,#0x00
	mov	r3,#0x00
	mov	r4,#0x00
	mov	r5,#0x00
00118$:
	mov	dptr,#___fsmul_exp_1_1
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
	sjmp	00133$
00132$:
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
00133$:
	djnz	b,00132$
	mov	a,r6
	orl	ar2,a
	mov	a,r7
	orl	ar3,a
	mov	a,r0
	orl	ar4,a
	mov	a,r1
	orl	ar5,a
	mov	dptr,#___fsmul_result_1_1
	movx	a,@dptr
	orl	ar2,a
	inc	dptr
	movx	a,@dptr
	orl	ar3,a
	inc	dptr
	movx	a,@dptr
	orl	ar4,a
	inc	dptr
	movx	a,@dptr
	orl	ar5,a
	mov	dptr,#___fsmul_fl1_1_1
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
;	_fsmul.c:290: return (fl1.f);
	mov	dptr,#___fsmul_fl1_1_1
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
00113$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
