;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _atof
	.optsdcc -mhc08
	
	.area HOME (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area CSEG (CODE)
	.area XINIT
	.area CONST   (CODE)
	.area DSEG
	.area OSEG    (OVR)
	.area BSEG
	.area XSEG
	.area XISEG
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atof
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_atof_sloc0_1_0:
	.ds 2
_atof_sloc1_1_0:
	.ds 2
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area OSEG    (OVR)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
_atof_s_1_1:
	.ds 2
_atof_value_1_1:
	.ds 4
_atof_fraction_1_1:
	.ds 4
_atof_iexp_1_1:
	.ds 1
_atof_sign_1_1:
	.ds 1
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME (CODE)
	.area HOME (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'atof'
;------------------------------------------------------------
;sloc0                     Allocated with name '_atof_sloc0_1_0'
;sloc1                     Allocated with name '_atof_sloc1_1_0'
;s                         Allocated with name '_atof_s_1_1'
;value                     Allocated with name '_atof_value_1_1'
;fraction                  Allocated with name '_atof_fraction_1_1'
;iexp                      Allocated with name '_atof_iexp_1_1'
;sign                      Allocated with name '_atof_sign_1_1'
;------------------------------------------------------------
;../_atof.c:33: float atof(const char * s)
;	-----------------------------------------
;	 function atof
;	-----------------------------------------
_atof:
	sta	(_atof_s_1_1 + 1)
	stx	_atof_s_1_1
;../_atof.c:40: while (isspace(*s)) s++;
	lda	_atof_s_1_1
	sta	*_atof_sloc0_1_0
	lda	(_atof_s_1_1 + 1)
	sta	*(_atof_sloc0_1_0 + 1)
00101$:
	ldhx	*_atof_sloc0_1_0
	lda	,x
	jsr	_isspace
	tsta
	beq	00148$
00151$:
	ldhx	*_atof_sloc0_1_0
	aix	#1
	sthx	*_atof_sloc0_1_0
	bra	00101$
00148$:
	lda	*_atof_sloc0_1_0
	sta	_atof_s_1_1
	lda	*(_atof_sloc0_1_0 + 1)
	sta	(_atof_s_1_1 + 1)
;../_atof.c:43: if (*s == '-')
	ldhx	*_atof_sloc0_1_0
	lda	,x
	cmp	#0x2D
	bne	00107$
00152$:
;../_atof.c:45: sign=1;
	lda	#0x01
	sta	_atof_sign_1_1
;../_atof.c:46: s++;
	lda	*(_atof_sloc0_1_0 + 1)
	add	#0x01
	sta	(_atof_s_1_1 + 1)
	lda	*_atof_sloc0_1_0
	adc	#0x00
	sta	_atof_s_1_1
	bra	00108$
00107$:
;../_atof.c:50: sign=0;
	clra
	sta	_atof_sign_1_1
;../_atof.c:51: if (*s == '+') s++;
	ldhx	*_atof_sloc0_1_0
	lda	,x
	cmp	#0x2B
	bne	00108$
00153$:
	lda	*(_atof_sloc0_1_0 + 1)
	add	#0x01
	sta	(_atof_s_1_1 + 1)
	lda	*_atof_sloc0_1_0
	adc	#0x00
	sta	_atof_s_1_1
00108$:
;../_atof.c:55: for (value=0.0; isdigit(*s); s++)
	clra
	sta	_atof_value_1_1
	sta	(_atof_value_1_1 + 1)
	sta	(_atof_value_1_1 + 2)
	sta	(_atof_value_1_1 + 3)
	lda	_atof_s_1_1
	sta	*_atof_sloc0_1_0
	lda	(_atof_s_1_1 + 1)
	sta	*(_atof_sloc0_1_0 + 1)
00121$:
	ldhx	*_atof_sloc0_1_0
	lda	,x
	jsr	_isdigit
	tsta
	bne	00154$
	jmp	00149$
00154$:
;../_atof.c:57: value=10.0*value+(*s-'0');
	lda	#0x41
	sta	___fsmul_PARM_1
	lda	#0x20
	sta	(___fsmul_PARM_1 + 1)
	clra
	sta	(___fsmul_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 3)
	lda	_atof_value_1_1
	sta	___fsmul_PARM_2
	lda	(_atof_value_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_atof_value_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_atof_value_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	ldhx	*_atof_sloc0_1_0
	lda	,x
	aix	#1
	sthx	*_atof_sloc0_1_0
	sta	*(_atof_sloc1_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_atof_sloc1_1_0
	lda	*(_atof_sloc1_1_0 + 1)
	sub	#0x30
	sta	*(_atof_sloc1_1_0 + 1)
	lda	*_atof_sloc1_1_0
	sbc	#0x00
	sta	*_atof_sloc1_1_0
	ldx	*_atof_sloc1_1_0
	lda	*(_atof_sloc1_1_0 + 1)
	jsr	___sint2fs
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	jsr	___fsadd
	sta	(_atof_value_1_1 + 3)
	stx	(_atof_value_1_1 + 2)
	lda	*__ret2
	sta	(_atof_value_1_1 + 1)
	lda	*__ret3
	sta	_atof_value_1_1
;../_atof.c:55: for (value=0.0; isdigit(*s); s++)
	jmp	00121$
00149$:
	lda	*_atof_sloc0_1_0
	sta	_atof_s_1_1
	lda	*(_atof_sloc0_1_0 + 1)
	sta	(_atof_s_1_1 + 1)
;../_atof.c:61: if (*s == '.')
	ldhx	*_atof_sloc0_1_0
	lda	,x
	cmp	#0x2E
	beq	00155$
	jmp	00110$
00155$:
;../_atof.c:63: s++;
	lda	*(_atof_sloc0_1_0 + 1)
	add	#0x01
	sta	(_atof_s_1_1 + 1)
	lda	*_atof_sloc0_1_0
	adc	#0x00
	sta	_atof_s_1_1
;../_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	lda	#0x3D
	sta	_atof_fraction_1_1
	lda	#0xCC
	sta	(_atof_fraction_1_1 + 1)
	sta	(_atof_fraction_1_1 + 2)
	lda	#0xCD
	sta	(_atof_fraction_1_1 + 3)
	lda	_atof_s_1_1
	sta	*_atof_sloc1_1_0
	lda	(_atof_s_1_1 + 1)
	sta	*(_atof_sloc1_1_0 + 1)
00125$:
	ldhx	*_atof_sloc1_1_0
	lda	,x
	jsr	_isdigit
	tsta
	bne	00156$
	jmp	00150$
00156$:
;../_atof.c:66: value+=(*s-'0')*fraction;
	ldhx	*_atof_sloc1_1_0
	lda	,x
	aix	#1
	sthx	*_atof_sloc1_1_0
	sta	*(_atof_sloc0_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_atof_sloc0_1_0
	lda	*(_atof_sloc0_1_0 + 1)
	sub	#0x30
	sta	*(_atof_sloc0_1_0 + 1)
	lda	*_atof_sloc0_1_0
	sbc	#0x00
	sta	*_atof_sloc0_1_0
	ldx	*_atof_sloc0_1_0
	lda	*(_atof_sloc0_1_0 + 1)
	jsr	___sint2fs
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_atof_fraction_1_1
	sta	___fsmul_PARM_2
	lda	(_atof_fraction_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_atof_fraction_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_atof_fraction_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	_atof_value_1_1
	sta	___fsadd_PARM_1
	lda	(_atof_value_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_atof_value_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_atof_value_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	(_atof_value_1_1 + 3)
	stx	(_atof_value_1_1 + 2)
	lda	*__ret2
	sta	(_atof_value_1_1 + 1)
	lda	*__ret3
	sta	_atof_value_1_1
;../_atof.c:67: fraction*=0.1;
	lda	#0x3D
	sta	___fsmul_PARM_1
	lda	#0xCC
	sta	(___fsmul_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xCD
	sta	(___fsmul_PARM_1 + 3)
	lda	_atof_fraction_1_1
	sta	___fsmul_PARM_2
	lda	(_atof_fraction_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_atof_fraction_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_atof_fraction_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_atof_fraction_1_1 + 3)
	stx	(_atof_fraction_1_1 + 2)
	lda	*__ret2
	sta	(_atof_fraction_1_1 + 1)
	lda	*__ret3
	sta	_atof_fraction_1_1
;../_atof.c:64: for (fraction=0.1; isdigit(*s); s++)
	jmp	00125$
00150$:
	lda	*_atof_sloc1_1_0
	sta	_atof_s_1_1
	lda	*(_atof_sloc1_1_0 + 1)
	sta	(_atof_s_1_1 + 1)
00110$:
;../_atof.c:72: if (toupper(*s)=='E')
	lda	_atof_s_1_1
	ldx	(_atof_s_1_1 + 1)
	psha
	pulh
	lda	,x
	jsr	_islower
	tsta
	beq	00131$
00157$:
	lda	_atof_s_1_1
	ldx	(_atof_s_1_1 + 1)
	psha
	pulh
	lda	,x
	and	#0xDF
	sta	*_atof_sloc1_1_0
	bra	00132$
00131$:
	lda	_atof_s_1_1
	ldx	(_atof_s_1_1 + 1)
	psha
	pulh
	lda	,x
	sta	*_atof_sloc1_1_0
00132$:
	lda	*_atof_sloc1_1_0
	cmp	#0x45
	beq	00158$
	jmp	00118$
00158$:
;../_atof.c:74: s++;
	lda	(_atof_s_1_1 + 1)
	inca
	sta	(_atof_s_1_1 + 1)
	bne	00159$
	lda	_atof_s_1_1
	inca
	sta	_atof_s_1_1
00159$:
;../_atof.c:75: iexp=(signed char)atoi(s);
	ldx	_atof_s_1_1
	lda	(_atof_s_1_1 + 1)
	jsr	_atoi
	sta	*(_atof_sloc1_1_0 + 1)
	stx	*_atof_sloc1_1_0
	lda	*(_atof_sloc1_1_0 + 1)
	sta	_atof_iexp_1_1
;../_atof.c:77: while(iexp!=0)
00114$:
	lda	_atof_iexp_1_1
	bne	00160$
	jmp	00118$
00160$:
;../_atof.c:79: if(iexp<0)
	lda	_atof_iexp_1_1
	cmp	#0x00
	bge	00112$
00161$:
;../_atof.c:81: value*=0.1;
	lda	#0x3D
	sta	___fsmul_PARM_1
	lda	#0xCC
	sta	(___fsmul_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xCD
	sta	(___fsmul_PARM_1 + 3)
	lda	_atof_value_1_1
	sta	___fsmul_PARM_2
	lda	(_atof_value_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_atof_value_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_atof_value_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_atof_value_1_1 + 3)
	stx	(_atof_value_1_1 + 2)
	lda	*__ret2
	sta	(_atof_value_1_1 + 1)
	lda	*__ret3
	sta	_atof_value_1_1
;../_atof.c:82: iexp++;
	lda	_atof_iexp_1_1
	inca
	sta	_atof_iexp_1_1
	bra	00114$
00112$:
;../_atof.c:86: value*=10.0;
	lda	#0x41
	sta	___fsmul_PARM_1
	lda	#0x20
	sta	(___fsmul_PARM_1 + 1)
	clra
	sta	(___fsmul_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 3)
	lda	_atof_value_1_1
	sta	___fsmul_PARM_2
	lda	(_atof_value_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_atof_value_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_atof_value_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_atof_value_1_1 + 3)
	stx	(_atof_value_1_1 + 2)
	lda	*__ret2
	sta	(_atof_value_1_1 + 1)
	lda	*__ret3
	sta	_atof_value_1_1
;../_atof.c:87: iexp--;
	lda	_atof_iexp_1_1
	deca
	sta	_atof_iexp_1_1
	jmp	00114$
00118$:
;../_atof.c:93: if(sign) value*=-1.0;
	lda	_atof_sign_1_1
	beq	00120$
00162$:
	lda	_atof_value_1_1
	eor	#0x80
	sta	_atof_value_1_1
00120$:
;../_atof.c:94: return (value);
	lda	_atof_value_1_1
	sta	*__ret3
	lda	(_atof_value_1_1 + 1)
	sta	*__ret2
	ldx	(_atof_value_1_1 + 2)
	lda	(_atof_value_1_1 + 3)
00129$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
