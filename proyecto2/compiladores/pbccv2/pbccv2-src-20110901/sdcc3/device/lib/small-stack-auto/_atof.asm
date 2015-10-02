;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:30 2015
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
; overlayable bit register bank
;--------------------------------------------------------
	.area BIT_BANK	(REL,OVR,DATA)
bits:
	.ds 1
	b0 = bits[0]
	b1 = bits[1]
	b2 = bits[2]
	b3 = bits[3]
	b4 = bits[4]
	b5 = bits[5]
	b6 = bits[6]
	b7 = bits[7]
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
;s                         Allocated to registers r3 r4 r6 
;value                     Allocated to stack - offset 1
;fraction                  Allocated to stack - offset 5
;iexp                      Allocated to registers r2 
;sign                      Allocated to registers b0 
;sloc0                     Allocated to stack - offset 9
;sloc1                     Allocated to stack - offset 12
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
	push	_bp
	mov	a,sp
	mov	_bp,a
	add	a,#0x0f
	mov	sp,a
	mov	r3,dpl
	mov	r4,dph
	mov	r6,b
;	_atof.c:40: while (isspace(*s)) s++;
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar6
00101$:
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	dpl,a
	lcall	_isspace
	mov	a,dpl
	jz	00148$
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	inc	@r0
	cjne	@r0,#0x00,00101$
	inc	r0
	inc	@r0
	sjmp	00101$
00148$:
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar6,@r0
;	_atof.c:43: if (*s == '-')
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r5,a
	cjne	r5,#0x2D,00107$
;	_atof.c:45: sign=1;
	setb	b0
;	_atof.c:46: s++;
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	a,#0x01
	add	a,@r0
	mov	r3,a
	clr	a
	inc	r0
	addc	a,@r0
	mov	r4,a
	inc	r0
	mov	ar6,@r0
	sjmp	00108$
00107$:
;	_atof.c:50: sign=0;
	clr	b0
;	_atof.c:51: if (*s == '+') s++;
	cjne	r5,#0x2B,00108$
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	a,#0x01
	add	a,@r0
	mov	r3,a
	clr	a
	inc	r0
	addc	a,@r0
	mov	r4,a
	inc	r0
	mov	ar6,@r0
00108$:
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
	mov	r0,_bp
	inc	r0
	clr	a
	mov	@r0,a
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,a
	inc	r0
	mov	@r0,a
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar6
00121$:
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	dpl,a
	push	bits
	lcall	_isdigit
	mov	a,dpl
	pop	bits
	jnz	00156$
	ljmp	00149$
00156$:
;	_atof.c:57: value=10.0*value+(*s-'0');
	push	bits
	mov	r0,_bp
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	dptr,#0x0000
	mov	b,#0x20
	mov	a,#0x41
	lcall	___fsmul
	xch	a,r0
	mov	a,_bp
	add	a,#0x0c
	xch	a,r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	inc	r0
	mov	@r0,b
	inc	r0
	mov	@r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	bits
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	a,r3
	add	a,#0xd0
	mov	dpl,a
	mov	a,r4
	addc	a,#0xff
	mov	dph,a
	push	bits
	lcall	___sint2fs
	mov	r3,dpl
	mov	r4,dph
	mov	r2,b
	mov	r5,a
	pop	bits
	push	bits
	push	ar3
	push	ar4
	push	ar2
	push	ar5
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	bits
	mov	r0,_bp
	inc	r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;	_atof.c:55: for (value=0.0; isdigit(*s); s++)
	ljmp	00121$
00149$:
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar6,@r0
;	_atof.c:61: if (*s == '.')
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r2,a
	cjne	r2,#0x2E,00157$
	sjmp	00158$
00157$:
	ljmp	00110$
00158$:
;	_atof.c:63: s++;
	mov	a,_bp
	add	a,#0x09
	mov	r0,a
	mov	a,#0x01
	add	a,@r0
	mov	r3,a
	clr	a
	inc	r0
	addc	a,@r0
	mov	r4,a
	inc	r0
	mov	ar6,@r0
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,#0xCD
	inc	r0
	mov	@r0,#0xCC
	inc	r0
	mov	@r0,#0xCC
	inc	r0
	mov	@r0,#0x3D
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar6
00125$:
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	dpl,a
	push	bits
	lcall	_isdigit
	mov	a,dpl
	pop	bits
	jnz	00159$
	ljmp	00150$
00159$:
;	_atof.c:66: value+=(*s-'0')*fraction;
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	dec	r0
	dec	r0
	mov	@r0,dpl
	inc	r0
	mov	@r0,dph
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	a,r3
	add	a,#0xd0
	mov	dpl,a
	mov	a,r4
	addc	a,#0xff
	mov	dph,a
	push	bits
	lcall	___sint2fs
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r2,a
	pop	bits
	push	bits
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	dpl,r3
	mov	dph,r4
	mov	b,r5
	mov	a,r2
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	bits
	push	bits
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	r0,_bp
	inc	r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	bits
	mov	r0,_bp
	inc	r0
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;	_atof.c:67: fraction*=0.1;
	push	bits
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	mov	dptr,#0xCCCD
	mov	b,#0xCC
	mov	a,#0x3D
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	bits
	mov	a,_bp
	add	a,#0x05
	mov	r0,a
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
;	_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	ljmp	00125$
00150$:
	mov	a,_bp
	add	a,#0x0c
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	inc	r0
	mov	ar6,@r0
00110$:
;	_atof.c:72: if (toupper(*s)=='E')
	mov	dpl,r3
	mov	dph,r4
	mov	b,r6
	lcall	__gptrget
	mov	dpl,a
	push	ar3
	push	ar4
	push	ar6
	push	bits
	lcall	_islower
	mov	a,dpl
	pop	bits
	pop	ar6
	pop	ar4
	pop	ar3
	jz	00131$
	mov	dpl,r3
	mov	dph,r4
	mov	b,r6
	lcall	__gptrget
	mov	r2,a
	anl	ar2,#0xDF
	sjmp	00132$
00131$:
	mov	dpl,r3
	mov	dph,r4
	mov	b,r6
	lcall	__gptrget
	mov	r2,a
00132$:
	cjne	r2,#0x45,00161$
	sjmp	00162$
00161$:
	ljmp	00118$
00162$:
;	_atof.c:74: s++;
	inc	r3
	cjne	r3,#0x00,00163$
	inc	r4
00163$:
;	_atof.c:75: iexp=(signed char)atoi(s);
	mov	dpl,r3
	mov	dph,r4
	mov	b,r6
	push	bits
	lcall	_atoi
	mov	r2,dpl
	mov	r3,dph
	pop	bits
;	_atof.c:77: while(iexp!=0)
00114$:
	mov	a,r2
	jnz	00164$
	ljmp	00118$
00164$:
;	_atof.c:79: if(iexp<0)
	mov	a,r2
	jnb	acc.7,00112$
;	_atof.c:81: value*=0.1;
	push	ar2
	push	bits
	mov	r0,_bp
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
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
	pop	bits
	pop	ar2
	mov	r0,_bp
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
;	_atof.c:82: iexp++;
	inc	r2
	sjmp	00114$
00112$:
;	_atof.c:86: value*=10.0;
	push	ar2
	push	bits
	mov	r0,_bp
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
	push	acc
	inc	r0
	mov	a,@r0
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
	pop	bits
	pop	ar2
	mov	r0,_bp
	inc	r0
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
	inc	r0
	mov	@r0,ar6
;	_atof.c:87: iexp--;
	dec	r2
	ljmp	00114$
00118$:
;	_atof.c:93: if(sign) value*=-1.0;
	jnb	b0,00120$
	mov	r0,_bp
	inc	r0
	mov	a,@r0
	mov	@r0,a
	inc	r0
	mov	a,@r0
	mov	@r0,a
	inc	r0
	mov	a,@r0
	mov	@r0,a
	inc	r0
	mov	a,@r0
	cpl	acc.7
	mov	@r0,a
00120$:
;	_atof.c:94: return (value);
	mov	r0,_bp
	inc	r0
	mov	dpl,@r0
	inc	r0
	mov	dph,@r0
	inc	r0
	mov	b,@r0
	inc	r0
	mov	a,@r0
	mov	sp,_bp
	pop	_bp
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
