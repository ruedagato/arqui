;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module _atof
	.optsdcc -mmcs51 --model-small
	
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
_atof_s_1_1:
	.ds 3
_atof_value_1_1:
	.ds 4
_atof_fraction_1_1:
	.ds 4
_atof_sloc0_1_0:
	.ds 3
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
	mov	_atof_s_1_1,dpl
	mov	(_atof_s_1_1 + 1),dph
	mov	(_atof_s_1_1 + 2),b
;	_atof.c:40: while (isspace(*s)) s++;
	mov	r5,_atof_s_1_1
	mov	r6,(_atof_s_1_1 + 1)
	mov	r7,(_atof_s_1_1 + 2)
00101$:
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	dpl,a
	push	ar5
	push	ar6
	push	ar7
	lcall	_isspace
	mov	a,dpl
	pop	ar7
	pop	ar6
	pop	ar5
	jz	00148$
	inc	r5
	cjne	r5,#0x00,00101$
	inc	r6
	sjmp	00101$
00148$:
	mov	_atof_s_1_1,r5
	mov	(_atof_s_1_1 + 1),r6
	mov	(_atof_s_1_1 + 2),r7
;	_atof.c:43: if (*s == '-')
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	cjne	r0,#0x2D,00107$
;	_atof.c:45: sign=1;
	setb	_atof_sign_1_1
;	_atof.c:46: s++;
	mov	a,#0x01
	add	a,r5
	mov	_atof_s_1_1,a
	clr	a
	addc	a,r6
	mov	(_atof_s_1_1 + 1),a
	mov	(_atof_s_1_1 + 2),r7
	sjmp	00108$
00107$:
;	_atof.c:50: sign=0;
	clr	_atof_sign_1_1
;	_atof.c:51: if (*s == '+') s++;
	cjne	r0,#0x2B,00108$
	mov	a,#0x01
	add	a,r5
	mov	_atof_s_1_1,a
	clr	a
	addc	a,r6
	mov	(_atof_s_1_1 + 1),a
	mov	(_atof_s_1_1 + 2),r7
00108$:
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
	clr	a
	mov	_atof_value_1_1,a
	mov	(_atof_value_1_1 + 1),a
	mov	(_atof_value_1_1 + 2),a
	mov	(_atof_value_1_1 + 3),a
	mov	_atof_sloc0_1_0,_atof_s_1_1
	mov	(_atof_sloc0_1_0 + 1),(_atof_s_1_1 + 1)
	mov	(_atof_sloc0_1_0 + 2),(_atof_s_1_1 + 2)
00121$:
	mov	dpl,_atof_sloc0_1_0
	mov	dph,(_atof_sloc0_1_0 + 1)
	mov	b,(_atof_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	dpl,a
	lcall	_isdigit
	mov	a,dpl
	jz	00149$
;	_atof.c:57: value=10.0*value+(*s-'0');
	push	_atof_value_1_1
	push	(_atof_value_1_1 + 1)
	push	(_atof_value_1_1 + 2)
	push	(_atof_value_1_1 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_atof_sloc1_1_0,dpl
	mov	(_atof_sloc1_1_0 + 1),dph
	mov	(_atof_sloc1_1_0 + 2),b
	mov	(_atof_sloc1_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_atof_sloc0_1_0
	mov	dph,(_atof_sloc0_1_0 + 1)
	mov	b,(_atof_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	mov	_atof_sloc0_1_0,dpl
	mov	(_atof_sloc0_1_0 + 1),dph
	mov	a,r2
	rlc	a
	subb	a,acc
	mov	r3,a
	mov	a,r2
	add	a,#0xd0
	mov	dpl,a
	mov	a,r3
	addc	a,#0xff
	mov	dph,a
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r1,a
	push	ar2
	push	ar3
	push	ar4
	push	ar1
	mov	dpl,_atof_sloc1_1_0
	mov	dph,(_atof_sloc1_1_0 + 1)
	mov	b,(_atof_sloc1_1_0 + 2)
	mov	a,(_atof_sloc1_1_0 + 3)
	lcall	___fsadd
	mov	_atof_value_1_1,dpl
	mov	(_atof_value_1_1 + 1),dph
	mov	(_atof_value_1_1 + 2),b
	mov	(_atof_value_1_1 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
	ljmp	00121$
00149$:
	mov	_atof_s_1_1,_atof_sloc0_1_0
	mov	(_atof_s_1_1 + 1),(_atof_sloc0_1_0 + 1)
	mov	(_atof_s_1_1 + 2),(_atof_sloc0_1_0 + 2)
;	_atof.c:61: if (*s == '.')
	mov	dpl,_atof_sloc0_1_0
	mov	dph,(_atof_sloc0_1_0 + 1)
	mov	b,(_atof_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	r2,a
	cjne	r2,#0x2E,00157$
	sjmp	00158$
00157$:
	ljmp	00110$
00158$:
;	_atof.c:63: s++;
	mov	a,#0x01
	add	a,_atof_sloc0_1_0
	mov	_atof_s_1_1,a
	clr	a
	addc	a,(_atof_sloc0_1_0 + 1)
	mov	(_atof_s_1_1 + 1),a
	mov	(_atof_s_1_1 + 2),(_atof_sloc0_1_0 + 2)
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	mov	_atof_fraction_1_1,#0xCD
	mov	(_atof_fraction_1_1 + 1),#0xCC
	mov	(_atof_fraction_1_1 + 2),#0xCC
	mov	(_atof_fraction_1_1 + 3),#0x3D
	mov	r2,_atof_s_1_1
	mov	r3,(_atof_s_1_1 + 1)
	mov	r4,(_atof_s_1_1 + 2)
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
	jnz	00159$
	ljmp	00150$
00159$:
;	_atof.c:66: value+=(*s-'0')*fraction;
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
	mov	dpl,a
	mov	a,r5
	addc	a,#0xff
	mov	dph,a
	push	ar2
	push	ar3
	push	ar4
	lcall	___sint2fs
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	push	_atof_fraction_1_1
	push	(_atof_fraction_1_1 + 1)
	push	(_atof_fraction_1_1 + 2)
	push	(_atof_fraction_1_1 + 3)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r0
	lcall	___fsmul
	mov	r5,dpl
	mov	r6,dph
	mov	r7,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	mov	dpl,_atof_value_1_1
	mov	dph,(_atof_value_1_1 + 1)
	mov	b,(_atof_value_1_1 + 2)
	mov	a,(_atof_value_1_1 + 3)
	lcall	___fsadd
	mov	_atof_value_1_1,dpl
	mov	(_atof_value_1_1 + 1),dph
	mov	(_atof_value_1_1 + 2),b
	mov	(_atof_value_1_1 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
;	_atof.c:67: fraction*=0.1;
	push	_atof_fraction_1_1
	push	(_atof_fraction_1_1 + 1)
	push	(_atof_fraction_1_1 + 2)
	push	(_atof_fraction_1_1 + 3)
	mov	dptr,#0xCCCD
	mov	b,#0xCC
	mov	a,#0x3D
	lcall	___fsmul
	mov	_atof_fraction_1_1,dpl
	mov	(_atof_fraction_1_1 + 1),dph
	mov	(_atof_fraction_1_1 + 2),b
	mov	(_atof_fraction_1_1 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar4
	pop	ar3
	pop	ar2
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	ljmp	00125$
00150$:
	mov	_atof_s_1_1,r2
	mov	(_atof_s_1_1 + 1),r3
	mov	(_atof_s_1_1 + 2),r4
00110$:
;	_atof.c:72: if (toupper(*s)=='E')
	mov	dpl,_atof_s_1_1
	mov	dph,(_atof_s_1_1 + 1)
	mov	b,(_atof_s_1_1 + 2)
	lcall	__gptrget
	mov	dpl,a
	lcall	_islower
	mov	a,dpl
	jz	00131$
	mov	dpl,_atof_s_1_1
	mov	dph,(_atof_s_1_1 + 1)
	mov	b,(_atof_s_1_1 + 2)
	lcall	__gptrget
	mov	r2,a
	anl	ar2,#0xDF
	sjmp	00132$
00131$:
	mov	dpl,_atof_s_1_1
	mov	dph,(_atof_s_1_1 + 1)
	mov	b,(_atof_s_1_1 + 2)
	lcall	__gptrget
	mov	r2,a
00132$:
	cjne	r2,#0x45,00118$
;	_atof.c:74: s++;
	inc	_atof_s_1_1
	clr	a
	cjne	a,_atof_s_1_1,00163$
	inc	(_atof_s_1_1 + 1)
00163$:
;	_atof.c:75: iexp=(signed char)atoi(s);
	mov	dpl,_atof_s_1_1
	mov	dph,(_atof_s_1_1 + 1)
	mov	b,(_atof_s_1_1 + 2)
	lcall	_atoi
	mov	r2,dpl
	mov	r3,dph
;	_atof.c:77: while(iexp!=0)
00114$:
	mov	a,r2
	jz	00118$
;	_atof.c:79: if(iexp<0)
	mov	a,r2
	jnb	acc.7,00112$
;	_atof.c:81: value*=0.1;
	push	ar2
	push	_atof_value_1_1
	push	(_atof_value_1_1 + 1)
	push	(_atof_value_1_1 + 2)
	push	(_atof_value_1_1 + 3)
	mov	dptr,#0xCCCD
	mov	b,#0xCC
	mov	a,#0x3D
	lcall	___fsmul
	mov	_atof_value_1_1,dpl
	mov	(_atof_value_1_1 + 1),dph
	mov	(_atof_value_1_1 + 2),b
	mov	(_atof_value_1_1 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar2
;	_atof.c:82: iexp++;
	inc	r2
	sjmp	00114$
00112$:
;	_atof.c:86: value*=10.0;
	push	ar2
	push	_atof_value_1_1
	push	(_atof_value_1_1 + 1)
	push	(_atof_value_1_1 + 2)
	push	(_atof_value_1_1 + 3)
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	mov	_atof_value_1_1,dpl
	mov	(_atof_value_1_1 + 1),dph
	mov	(_atof_value_1_1 + 2),b
	mov	(_atof_value_1_1 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar2
;	_atof.c:87: iexp--;
	dec	r2
	sjmp	00114$
00118$:
;	_atof.c:93: if(sign) value*=-1.0;
	jnb	_atof_sign_1_1,00120$
	mov	a,(_atof_value_1_1 + 3)
	cpl	acc.7
	mov	(_atof_value_1_1 + 3),a
00120$:
;	_atof.c:94: return (value);
	mov	dpl,_atof_value_1_1
	mov	dph,(_atof_value_1_1 + 1)
	mov	b,(_atof_value_1_1 + 2)
	mov	a,(_atof_value_1_1 + 3)
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
