;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module _atof
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
	.globl _atof
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
_atof_sign_1_1:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
_atof_s_1_1:
	.ds 4
_atof_value_1_1:
	.ds 4
_atof_fraction_1_1:
	.ds 4
_atof_sloc0_1_0:
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
;Allocation info for local variables in function 'atof'
;------------------------------------------------------------
;s                         Allocated with name '_atof_s_1_1'
;value                     Allocated with name '_atof_value_1_1'
;fraction                  Allocated with name '_atof_fraction_1_1'
;iexp                      Allocated to registers r2 
;sloc0                     Allocated with name '_atof_sloc0_1_0'
;sloc1                     Allocated with name '_atof_sloc1_1_0'
;------------------------------------------------------------
;	_atof.c:33: float atof(const char * s)
;	-----------------------------------------
;	 function atof
;	-----------------------------------------
_atof:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
	mov     dps, #1
	mov     dptr, #_atof_s_1_1
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
;	_atof.c:40: while (isspace(*s)) s++;
	mov	dptr,#_atof_s_1_1
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
00101$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	lcall	_isspace
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	jz  00148$
00151$:
	inc	r2
	cjne	r2,#0,00101$
	inc	r3
	cjne	r3,#0,00101$
	inc	r4
	sjmp 00101$
00148$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_s_1_1
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
;	_atof.c:43: if (*s == '-')
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov  r6,a
	cjne a,#0x2D,00107$
00153$:
;	_atof.c:45: sign=1;
;	genAssign: resultIsFar = FALSE
	setb	_atof_sign_1_1
;	_atof.c:46: s++;
	mov	dptr,#_atof_s_1_1
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr  a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r4
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
	sjmp 00108$
00107$:
;	_atof.c:50: sign=0;
;	genAssign: resultIsFar = FALSE
	clr	_atof_sign_1_1
;	_atof.c:51: if (*s == '+') s++;
	mov	a,r6
	cjne a,#0x2B,00108$
00155$:
	mov	dptr,#_atof_s_1_1
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr  a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	clr  a
	addc	a,r4
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r5
	movx	@dptr,a
00108$:
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_value_1_1
	clr	a
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	mov	dptr,#_atof_s_1_1
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_atof_sloc0_1_0
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
00121$:
	mov     dps, #1
	mov     dptr, #_atof_sloc0_1_0
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
	lcall	__gptrget
	mov	r6,a
	mov	dpl,r6
	lcall	_isdigit
	mov	a,dpl
	jnz	00156$
	ljmp	00149$
00156$:
;	_atof.c:57: value=10.0*value+(*s-'0');
	mov	dptr,#_atof_value_1_1
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
	mov  dptr,#0x0000
	mov	dpx,#0x20
	mov	b,#0x41
	lcall	___fsmul
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	mov     dps, #1
	mov     dptr, #_atof_sloc0_1_0
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
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	inc	dps
	lcall	__decdptr
	lcall	__decdptr
	lcall	__decdptr
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
	mov	a,r2
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	a,r2
	add	a,#0xD0
	mov	r2,a
	mov	a,r3
	addc	a,#0xFF
	mov	r3,a
	push	ar6
	push	ar7
	push	ar0
	push	ar1
	mov	dpl,r2
	mov	dph,r3
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
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_value_1_1
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
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
	ljmp	00121$
00149$:
	mov	dptr,#_atof_sloc0_1_0
;	genAssign: resultIsFar = TRUE
	mov	dps,#0x21
	mov	dptr,#_atof_s_1_1
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
;	_atof.c:61: if (*s == '.')
	mov     dps, #1
	mov     dptr, #_atof_sloc0_1_0
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
	lcall	__gptrget
	mov  r2,a
	cjne	a,#0x2E,00157$
	sjmp	00158$
00157$:
	ljmp	00110$
00158$:
;	_atof.c:63: s++;
	mov	dptr,#_atof_sloc0_1_0
	mov	dps, #1
	mov	dptr, #_atof_s_1_1
	dec	dps
	movx	a,@dptr
	add	a,#0x01
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	addc	a,#0x00
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
	inc	dptr
	movx	a,@dptr
	mov	dps,#1
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_fraction_1_1
	mov	a,#0xCD
	movx	@dptr,a
	inc	dptr
	mov  a,#0xCC
	movx @dptr,a
	inc  dptr
	movx @dptr,a
	inc	dptr
	mov	a,#0x3D
	movx	@dptr,a
	mov	dptr,#_atof_s_1_1
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
00125$:
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	lcall	_isdigit
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	a,dpl
	jnz	00159$
	ljmp	00150$
00159$:
;	_atof.c:66: value+=(*s-'0')*fraction;
	mov	dpl,r2
	mov	dph,r3
	mov	dpx,r4
	mov	b,r5
	lcall	__gptrget
	mov	r6,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	r4,dpx
	mov	r5,b
	mov	a,r6
	rlc	a
	subb	a,acc
	mov	r7,a
	mov	a,r6
	add	a,#0xD0
	mov	r6,a
	mov	a,r7
	addc	a,#0xFF
	mov	r7,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	lcall	___sint2fs
	mov	r6,dpl
	mov	r7,dph
	mov	r0,dpx
	mov	r1,b
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dptr,#_atof_fraction_1_1
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dpl,r6
	mov	dph,r7
	mov	dpx,r0
	mov	b,r1
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	inc	dps
	mov	dptr,#_atof_value_1_1
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
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_value_1_1
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
;	_atof.c:67: fraction*=0.1;
	mov	dptr,#_atof_fraction_1_1
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
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xCCCCCD
	mov	b,#0x3D
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
	mov	dptr,#_atof_fraction_1_1
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
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	ljmp	00125$
00150$:
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_s_1_1
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
00110$:
;	_atof.c:72: if (toupper(*s)=='E')
	mov     dps, #1
	mov     dptr, #_atof_s_1_1
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
	lcall	__gptrget
	mov	r2,a
	mov	dpl,r2
	lcall	_islower
	mov	a,dpl
	jz  00131$
00160$:
	mov     dps, #1
	mov     dptr, #_atof_s_1_1
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
	lcall	__gptrget
	mov	r2,a
	anl	ar2,#0xDF
	sjmp 00132$
00131$:
	mov     dps, #1
	mov     dptr, #_atof_s_1_1
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
	lcall	__gptrget
	mov	r2,a
00132$:
	mov	a,r2
	cjne	a,#0x45,00161$
	sjmp	00162$
00161$:
	ljmp	00118$
00162$:
;	_atof.c:74: s++;
	mov	dptr,#_atof_s_1_1
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
;	_atof.c:75: iexp=(signed char)atoi(s);
	inc	dps
	mov	dptr,#_atof_s_1_1
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
	lcall	_atoi
	mov	r2,dpl
	mov	r3,dph
;	_atof.c:77: while(iexp!=0)
00114$:
	mov	a,r2
	jnz	00163$
	ljmp	00118$
00163$:
;	_atof.c:79: if(iexp<0)
	mov	a,r2
	jnb  acc.7,00112$
00164$:
;	_atof.c:81: value*=0.1;
	mov	dptr,#_atof_value_1_1
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
	push	ar2
	mov	dptr,#0xCCCCCD
	mov	b,#0x3D
	lcall	___fsmul
	mov	r3,dpl
	mov	r4,dph
	mov	r5,dpx
	mov	r6,b
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_value_1_1
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
;	_atof.c:82: iexp++;
	inc	r2
	sjmp 00114$
00112$:
;	_atof.c:86: value*=10.0;
	mov	dptr,#_atof_value_1_1
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
	push	ar2
	mov  dptr,#0x0000
	mov	dpx,#0x20
	mov	b,#0x41
	lcall	___fsmul
	mov	r3,dpl
	mov	r4,dph
	mov	r5,dpx
	mov	r6,b
	pop	ar2
;	genAssign: resultIsFar = TRUE
	mov	dptr,#_atof_value_1_1
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
;	_atof.c:87: iexp--;
	mov	a,r2
	dec	a
;	genAssign: resultIsFar = TRUE
	mov	r2,a
	ljmp	00114$
00118$:
;	_atof.c:93: if(sign) value*=-1.0;
	jnb  _atof_sign_1_1,00120$
00165$:
	mov	dptr,#_atof_value_1_1
	mov	dps, #1
	mov	dptr, #_atof_value_1_1
	dec	dps
	movx	a,@dptr
	inc	dps
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	inc	dps
	inc	dptr
	movx	@dptr,a
	dec	dps
	inc	dptr
	movx	a,@dptr
	cpl	acc.7
	inc	dps
	inc	dptr
	movx	@dptr,a
	mov	dps,#0
00120$:
;	_atof.c:94: return (value);
	mov     dps, #1
	mov     dptr, #_atof_value_1_1
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
00129$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
