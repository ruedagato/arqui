;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:27 2015
;--------------------------------------------------------
	.module _atof
	.optsdcc -mmcs51 --model-large
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atof
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
_atof_sloc0_1_0:
	.ds 4
_atof_sloc1_1_0:
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
	.ds 3
_atof_value_1_1:
	.ds 4
_atof_fraction_1_1:
	.ds 4
_atof_iexp_1_1:
	.ds 1
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
;Allocation info for local variables in function 'atof'
;------------------------------------------------------------
;sloc0                     Allocated with name '_atof_sloc0_1_0'
;sloc1                     Allocated with name '_atof_sloc1_1_0'
;s                         Allocated with name '_atof_s_1_1'
;value                     Allocated with name '_atof_value_1_1'
;fraction                  Allocated with name '_atof_fraction_1_1'
;iexp                      Allocated with name '_atof_iexp_1_1'
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
	mov	r2,b
	mov	r3,dph
	mov	a,dpl
	mov	dptr,#_atof_s_1_1
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r2
	movx	@dptr,a
;	_atof.c:40: while (isspace(*s)) s++;
	mov	dptr,#_atof_s_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
00101$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_isspace
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
	jz	00148$
	inc	r2
	cjne	r2,#0x00,00152$
	inc	r3
00152$:
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	sjmp	00101$
00148$:
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_atof.c:43: if (*s == '-')
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	cjne	r5,#0x2D,00107$
;	_atof.c:45: sign=1;
	setb	_atof_sign_1_1
;	_atof.c:46: s++;
	mov	dptr,#_atof_s_1_1
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr	a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	sjmp	00108$
00107$:
;	_atof.c:50: sign=0;
	clr	_atof_sign_1_1
;	_atof.c:51: if (*s == '+') s++;
	cjne	r5,#0x2B,00108$
	mov	dptr,#_atof_s_1_1
	mov	a,#0x01
	add	a,r2
	movx	@dptr,a
	clr	a
	addc	a,r3
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
00108$:
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
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
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
00121$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_isdigit
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
	jnz	00157$
	ljmp	00149$
00157$:
;	_atof.c:57: value=10.0*value+(*s-'0');
	push	ar2
	push	ar3
	push	ar4
	mov	dptr,#_atof_value_1_1
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_atof_sloc0_1_0,dpl
	mov	(_atof_sloc0_1_0 + 1),dph
	mov	(_atof_sloc0_1_0 + 2),b
	mov	(_atof_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	a,r1
	rlc	a
	subb	a,acc
	mov	r5,a
	mov	a,r1
	add	a,#0xd0
	mov	r1,a
	mov	a,r5
	addc	a,#0xff
	mov	r5,a
	mov	dpl,r1
	mov	dph,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	___sint2fs
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	mov	dpl,_atof_sloc0_1_0
	mov	dph,(_atof_sloc0_1_0 + 1)
	mov	b,(_atof_sloc0_1_0 + 2)
	mov	a,(_atof_sloc0_1_0 + 3)
	lcall	___fsadd
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dptr,#_atof_value_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	ljmp	00121$
00149$:
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_atof.c:61: if (*s == '.')
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	cjne	r5,#0x2E,00158$
	sjmp	00159$
00158$:
	ljmp	00110$
00159$:
;	_atof.c:63: s++;
	inc	r2
	cjne	r2,#0x00,00160$
	inc	r3
00160$:
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	mov	dptr,#_atof_fraction_1_1
	mov	a,#0xCD
	movx	@dptr,a
	inc	dptr
	mov	a,#0xCC
	movx	@dptr,a
	inc	dptr
	movx	@dptr,a
	inc	dptr
	mov	a,#0x3D
	movx	@dptr,a
00125$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_isdigit
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
	jnz	00161$
	ljmp	00150$
00161$:
;	_atof.c:66: value+=(*s-'0')*fraction;
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	mov	r2,dpl
	mov	r3,dph
	mov	a,r5
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	a,r5
	add	a,#0xd0
	mov	_atof_sloc0_1_0,a
	mov	a,r6
	addc	a,#0xff
	mov	(_atof_sloc0_1_0 + 1),a
	mov	dptr,#_atof_fraction_1_1
	movx	a,@dptr
	mov	_atof_sloc1_1_0,a
	inc	dptr
	movx	a,@dptr
	mov	(_atof_sloc1_1_0 + 1),a
	inc	dptr
	movx	a,@dptr
	mov	(_atof_sloc1_1_0 + 2),a
	inc	dptr
	movx	a,@dptr
	mov	(_atof_sloc1_1_0 + 3),a
	mov	dpl,_atof_sloc0_1_0
	mov	dph,(_atof_sloc0_1_0 + 1)
	push	ar2
	push	ar3
	push	ar4
	lcall	___sint2fs
	mov	r6,dpl
	mov	r5,dph
	mov	r7,b
	mov	r0,a
	push	_atof_sloc1_1_0
	push	(_atof_sloc1_1_0 + 1)
	push	(_atof_sloc1_1_0 + 2)
	push	(_atof_sloc1_1_0 + 3)
	mov	dpl,r6
	mov	dph,r5
	mov	b,r7
	mov	a,r0
	lcall	___fsmul
	mov	_atof_sloc0_1_0,dpl
	mov	(_atof_sloc0_1_0 + 1),dph
	mov	(_atof_sloc0_1_0 + 2),b
	mov	(_atof_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_atof_value_1_1
	movx	a,@dptr
	mov	r1,a
	inc	dptr
	movx	a,@dptr
	mov	r5,a
	inc	dptr
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	mov	r7,a
	push	_atof_sloc0_1_0
	push	(_atof_sloc0_1_0 + 1)
	push	(_atof_sloc0_1_0 + 2)
	push	(_atof_sloc0_1_0 + 3)
	mov	dpl,r1
	mov	dph,r5
	mov	b,r6
	mov	a,r7
	lcall	___fsadd
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dptr,#_atof_value_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
;	_atof.c:67: fraction*=0.1;
	push	_atof_sloc1_1_0
	push	(_atof_sloc1_1_0 + 1)
	push	(_atof_sloc1_1_0 + 2)
	push	(_atof_sloc1_1_0 + 3)
	mov	dptr,#0xCCCD
	mov	b,#0xCC
	mov	a,#0x3D
	lcall	___fsmul
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
	mov	dptr,#_atof_fraction_1_1
	mov	a,r5
	movx	@dptr,a
	inc	dptr
	mov	a,r6
	movx	@dptr,a
	inc	dptr
	mov	a,r7
	movx	@dptr,a
	inc	dptr
	mov	a,r0
	movx	@dptr,a
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	ljmp	00125$
00150$:
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
00110$:
;	_atof.c:72: if (toupper(*s)=='E')
	mov	dptr,#_atof_s_1_1
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	mov	r4,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	dpl,a
	push	ar2
	push	ar3
	push	ar4
	lcall	_islower
	mov	a,dpl
	pop	ar4
	pop	ar3
	pop	ar2
	jz	00131$
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
	anl	ar5,#0xDF
	sjmp	00132$
00131$:
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	__gptrget
	mov	r5,a
00132$:
	cjne	r5,#0x45,00163$
	sjmp	00164$
00163$:
	ljmp	00118$
00164$:
;	_atof.c:74: s++;
	inc	r2
	cjne	r2,#0x00,00165$
	inc	r3
00165$:
	mov	dptr,#_atof_s_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
;	_atof.c:75: iexp=(signed char)atoi(s);
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	lcall	_atoi
	mov	r2,dpl
	mov	r3,dph
	mov	dptr,#_atof_iexp_1_1
	mov	a,r2
	movx	@dptr,a
;	_atof.c:77: while(iexp!=0)
00114$:
	mov	dptr,#_atof_iexp_1_1
	movx	a,@dptr
	mov	r2,a
	jnz	00166$
	ljmp	00118$
00166$:
;	_atof.c:79: if(iexp<0)
	mov	a,r2
	jnb	acc.7,00112$
;	_atof.c:81: value*=0.1;
	push	ar2
	mov	dptr,#_atof_value_1_1
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#0xCCCD
	mov	b,#0xCC
	mov	a,#0x3D
	lcall	___fsmul
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r6,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar2
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
	mov	dptr,#_atof_iexp_1_1
	mov	a,r2
	inc	a
	movx	@dptr,a
	sjmp	00114$
00112$:
;	_atof.c:86: value*=10.0;
	push	ar2
	mov	dptr,#_atof_value_1_1
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	inc	dptr
	movx	a,@dptr
	push	acc
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r6,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar2
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
	mov	dptr,#_atof_iexp_1_1
	movx	@dptr,a
	ljmp	00114$
00118$:
;	_atof.c:93: if(sign) value*=-1.0;
	jnb	_atof_sign_1_1,00120$
	mov	dptr,#_atof_value_1_1
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
	mov	dptr,#_atof_value_1_1
	mov	a,r2
	movx	@dptr,a
	inc	dptr
	mov	a,r3
	movx	@dptr,a
	inc	dptr
	mov	a,r4
	movx	@dptr,a
	mov	a,r5
	cpl	acc.7
	inc	dptr
	movx	@dptr,a
00120$:
;	_atof.c:94: return (value);
	mov	dptr,#_atof_value_1_1
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
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
