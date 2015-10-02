;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module asincosf
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
	.globl _asincosf
	.globl _asincosf_PARM_2
	.globl _asincosf_PARM_1
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_asincosf_sloc0_1_0:
	.ds 1
_asincosf_sloc1_1_0:
	.ds 4
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
_asincosf_PARM_1:
	.ds 4
_asincosf_PARM_2:
	.ds 1
_asincosf_y_1_1:
	.ds 4
_asincosf_g_1_1:
	.ds 4
_asincosf_r_1_1:
	.ds 4
_asincosf_quartPI_1_1:
	.ds 1
_asincosf_a_1_1:
	.ds 8
_asincosf_b_1_1:
	.ds 8
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'asincosf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_asincosf_sloc0_1_0'
;sloc1                     Allocated with name '_asincosf_sloc1_1_0'
;x                         Allocated with name '_asincosf_PARM_1'
;isacos                    Allocated with name '_asincosf_PARM_2'
;y                         Allocated with name '_asincosf_y_1_1'
;g                         Allocated with name '_asincosf_g_1_1'
;r                         Allocated with name '_asincosf_r_1_1'
;i                         Allocated to registers 
;quartPI                   Allocated with name '_asincosf_quartPI_1_1'
;a                         Allocated with name '_asincosf_a_1_1'
;b                         Allocated with name '_asincosf_b_1_1'
;------------------------------------------------------------
;../asincosf.c:53: static const float a[2] = { 0.0, QUART_PI };
	clra
	sta	_asincosf_a_1_1
	sta	(_asincosf_a_1_1 + 1)
	sta	(_asincosf_a_1_1 + 2)
	sta	(_asincosf_a_1_1 + 3)
	lda	#0x3F
	sta	(_asincosf_a_1_1 + 0x0004)
	lda	#0x49
	sta	((_asincosf_a_1_1 + 0x0004) + 1)
	lda	#0x0F
	sta	((_asincosf_a_1_1 + 0x0004) + 2)
	lda	#0xDB
	sta	((_asincosf_a_1_1 + 0x0004) + 3)
;../asincosf.c:54: static const float b[2] = { HALF_PI, QUART_PI };
	lda	#0x3F
	sta	_asincosf_b_1_1
	lda	#0xC9
	sta	(_asincosf_b_1_1 + 1)
	lda	#0x0F
	sta	(_asincosf_b_1_1 + 2)
	lda	#0xDB
	sta	(_asincosf_b_1_1 + 3)
	lda	#0x3F
	sta	(_asincosf_b_1_1 + 0x0004)
	lda	#0x49
	sta	((_asincosf_b_1_1 + 0x0004) + 1)
	lda	#0x0F
	sta	((_asincosf_b_1_1 + 0x0004) + 2)
	lda	#0xDB
	sta	((_asincosf_b_1_1 + 0x0004) + 3)
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
;Allocation info for local variables in function 'asincosf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_asincosf_sloc0_1_0'
;sloc1                     Allocated with name '_asincosf_sloc1_1_0'
;x                         Allocated with name '_asincosf_PARM_1'
;isacos                    Allocated with name '_asincosf_PARM_2'
;y                         Allocated with name '_asincosf_y_1_1'
;g                         Allocated with name '_asincosf_g_1_1'
;r                         Allocated with name '_asincosf_r_1_1'
;i                         Allocated to registers 
;quartPI                   Allocated with name '_asincosf_quartPI_1_1'
;a                         Allocated with name '_asincosf_a_1_1'
;b                         Allocated with name '_asincosf_b_1_1'
;------------------------------------------------------------
;../asincosf.c:47: float asincosf(const float x, const BOOL isacos)
;	-----------------------------------------
;	 function asincosf
;	-----------------------------------------
_asincosf:
;../asincosf.c:51: BOOL quartPI = isacos;
	lda	_asincosf_PARM_2
	sta	_asincosf_quartPI_1_1
;../asincosf.c:56: y = fabsf(x);
	lda	(_asincosf_PARM_1 + 3)
	psha
	lda	(_asincosf_PARM_1 + 2)
	psha
	lda	(_asincosf_PARM_1 + 1)
	psha
	lda	_asincosf_PARM_1
	psha
	jsr	_fabsf
	sta	(_asincosf_y_1_1 + 3)
	stx	(_asincosf_y_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_y_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_y_1_1
	ais	#4
;../asincosf.c:57: if (y < EPS)
	lda	_asincosf_y_1_1
	sta	___fslt_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	lda	#0x39
	sta	___fslt_PARM_2
	lda	#0x80
	sta	(___fslt_PARM_2 + 1)
	clra
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_asincosf_sloc0_1_0
	tst	*_asincosf_sloc0_1_0
	beq	00107$
00125$:
;../asincosf.c:59: r = y;
	lda	_asincosf_y_1_1
	sta	_asincosf_r_1_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(_asincosf_r_1_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(_asincosf_r_1_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(_asincosf_r_1_1 + 3)
	jmp	00108$
00107$:
;../asincosf.c:63: if (y > 0.5)
	lda	_asincosf_y_1_1
	sta	___fsgt_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3F
	sta	___fsgt_PARM_2
	clra
	sta	(___fsgt_PARM_2 + 1)
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_asincosf_sloc0_1_0
	tst	*_asincosf_sloc0_1_0
	bne	00126$
	jmp	00104$
00126$:
;../asincosf.c:65: quartPI = !isacos;
	lda	_asincosf_quartPI_1_1
	beq	00127$
	lda	#0x01
00127$:
	eor	#0x01
	sta	_asincosf_quartPI_1_1
;../asincosf.c:66: if (y > 1.0)
	lda	_asincosf_y_1_1
	sta	___fsgt_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3F
	sta	___fsgt_PARM_2
	lda	#0x80
	sta	(___fsgt_PARM_2 + 1)
	clra
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_asincosf_sloc0_1_0
	tst	*_asincosf_sloc0_1_0
	beq	00102$
00128$:
;../asincosf.c:68: errno = EDOM;
	clra
	sta	_errno
	lda	#0x21
	sta	(_errno + 1)
;../asincosf.c:69: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00102$:
;../asincosf.c:71: g = (0.5 - y) + 0.5;
	lda	#0x3F
	sta	___fssub_PARM_1
	lda	#0x80
	sta	(___fssub_PARM_1 + 1)
	clra
	sta	(___fssub_PARM_1 + 2)
	sta	(___fssub_PARM_1 + 3)
	lda	_asincosf_y_1_1
	sta	___fssub_PARM_2
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fssub_PARM_2 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fssub_PARM_2 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(_asincosf_g_1_1 + 3)
	stx	(_asincosf_g_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_g_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_g_1_1
;../asincosf.c:72: g = ldexpf(g, -1);
	lda	_asincosf_g_1_1
	sta	_ldexpf_PARM_1
	lda	(_asincosf_g_1_1 + 1)
	sta	(_ldexpf_PARM_1 + 1)
	lda	(_asincosf_g_1_1 + 2)
	sta	(_ldexpf_PARM_1 + 2)
	lda	(_asincosf_g_1_1 + 3)
	sta	(_ldexpf_PARM_1 + 3)
	lda	#0xFF
	sta	_ldexpf_PARM_2
	sta	(_ldexpf_PARM_2 + 1)
	jsr	_ldexpf
	sta	(_asincosf_g_1_1 + 3)
	stx	(_asincosf_g_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_g_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_g_1_1
;../asincosf.c:73: y = sqrtf(g);
	lda	(_asincosf_g_1_1 + 3)
	psha
	lda	(_asincosf_g_1_1 + 2)
	psha
	lda	(_asincosf_g_1_1 + 1)
	psha
	lda	_asincosf_g_1_1
	psha
	jsr	_sqrtf
	sta	(_asincosf_y_1_1 + 3)
	stx	(_asincosf_y_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_y_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_y_1_1
	ais	#4
;../asincosf.c:74: y = -(y + y);
	lda	_asincosf_y_1_1
	sta	___fsadd_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	_asincosf_y_1_1
	sta	___fsadd_PARM_2
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	*(_asincosf_sloc1_1_0 + 3)
	stx	*(_asincosf_sloc1_1_0 + 2)
	mov	*__ret2,*(_asincosf_sloc1_1_0 + 1)
	mov	*__ret3,*_asincosf_sloc1_1_0
	lda	*(_asincosf_sloc1_1_0 + 3)
	sta	(_asincosf_y_1_1 + 3)
	lda	*(_asincosf_sloc1_1_0 + 2)
	sta	(_asincosf_y_1_1 + 2)
	lda	*(_asincosf_sloc1_1_0 + 1)
	sta	(_asincosf_y_1_1 + 1)
	lda	*_asincosf_sloc1_1_0
	eor	#0x80
	sta	_asincosf_y_1_1
	bra	00105$
00104$:
;../asincosf.c:78: g = y * y;
	lda	_asincosf_y_1_1
	sta	___fsmul_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	lda	_asincosf_y_1_1
	sta	___fsmul_PARM_2
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_asincosf_g_1_1 + 3)
	stx	(_asincosf_g_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_g_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_g_1_1
00105$:
;../asincosf.c:80: r = y + y * ((P(g) * g) / Q(g));
	lda	#0xBF
	sta	___fsmul_PARM_1
	lda	#0x01
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x20
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x65
	sta	(___fsmul_PARM_1 + 3)
	lda	_asincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_asincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_asincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_asincosf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3F
	sta	___fsadd_PARM_2
	lda	#0x6F
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x16
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x6B
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_asincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_asincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_asincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_asincosf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsdiv_PARM_1 + 3)
	stx	(___fsdiv_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_1 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_1
	lda	_asincosf_g_1_1
	sta	___fsadd_PARM_1
	lda	(_asincosf_g_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_asincosf_g_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_asincosf_g_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	lda	#0xC0
	sta	___fsadd_PARM_2
	lda	#0xB1
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x8D
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x0B
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	_asincosf_g_1_1
	sta	___fsmul_PARM_2
	lda	(_asincosf_g_1_1 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_asincosf_g_1_1 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_asincosf_g_1_1 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x40
	sta	___fsadd_PARM_2
	lda	#0xB3
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x50
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xF0
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsdiv_PARM_2 + 3)
	stx	(___fsdiv_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_2 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_2
	jsr	___fsdiv
	sta	(___fsmul_PARM_2 + 3)
	stx	(___fsmul_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_2 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_2
	lda	_asincosf_y_1_1
	sta	___fsmul_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsmul_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsmul_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsmul_PARM_1 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	_asincosf_y_1_1
	sta	___fsadd_PARM_1
	lda	(_asincosf_y_1_1 + 1)
	sta	(___fsadd_PARM_1 + 1)
	lda	(_asincosf_y_1_1 + 2)
	sta	(___fsadd_PARM_1 + 2)
	lda	(_asincosf_y_1_1 + 3)
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	(_asincosf_r_1_1 + 3)
	stx	(_asincosf_r_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_r_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_r_1_1
00108$:
;../asincosf.c:83: if (isacos)
	lda	_asincosf_PARM_2
	bne	00129$
	jmp	00115$
00129$:
;../asincosf.c:85: if (x < 0.0)
	lda	_asincosf_PARM_1
	sta	___fslt_PARM_1
	lda	(_asincosf_PARM_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_asincosf_PARM_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_asincosf_PARM_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_asincosf_sloc1_1_0
	tst	*_asincosf_sloc1_1_0
	bne	00130$
	jmp	00110$
00130$:
;../asincosf.c:86: r = (b[i] + r) + b[i];
	lda	_asincosf_quartPI_1_1
	lsla	
	lsla	
	tax
	clrh
	lda	_asincosf_b_1_1,x
	sta	___fsadd_PARM_1
	lda	(_asincosf_b_1_1 + 1),x
	sta	(___fsadd_PARM_1 + 1)
	lda	(_asincosf_b_1_1 + 2),x
	sta	(___fsadd_PARM_1 + 2)
	lda	(_asincosf_b_1_1 + 3),x
	sta	(___fsadd_PARM_1 + 3)
	lda	_asincosf_r_1_1
	sta	___fsadd_PARM_2
	lda	(_asincosf_r_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_asincosf_r_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_asincosf_r_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	_asincosf_quartPI_1_1
	lsla	
	lsla	
	tax
	clrh
	lda	_asincosf_b_1_1,x
	sta	___fsadd_PARM_2
	lda	(_asincosf_b_1_1 + 1),x
	sta	(___fsadd_PARM_2 + 1)
	lda	(_asincosf_b_1_1 + 2),x
	sta	(___fsadd_PARM_2 + 2)
	lda	(_asincosf_b_1_1 + 3),x
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_asincosf_r_1_1 + 3)
	stx	(_asincosf_r_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_r_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_r_1_1
	jmp	00116$
00110$:
;../asincosf.c:88: r = (a[i] - r) + a[i];
	lda	_asincosf_quartPI_1_1
	lsla	
	lsla	
	tax
	clrh
	lda	_asincosf_a_1_1,x
	sta	___fssub_PARM_1
	lda	(_asincosf_a_1_1 + 1),x
	sta	(___fssub_PARM_1 + 1)
	lda	(_asincosf_a_1_1 + 2),x
	sta	(___fssub_PARM_1 + 2)
	lda	(_asincosf_a_1_1 + 3),x
	sta	(___fssub_PARM_1 + 3)
	lda	_asincosf_r_1_1
	sta	___fssub_PARM_2
	lda	(_asincosf_r_1_1 + 1)
	sta	(___fssub_PARM_2 + 1)
	lda	(_asincosf_r_1_1 + 2)
	sta	(___fssub_PARM_2 + 2)
	lda	(_asincosf_r_1_1 + 3)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	_asincosf_quartPI_1_1
	lsla	
	lsla	
	tax
	clrh
	lda	_asincosf_a_1_1,x
	sta	___fsadd_PARM_2
	lda	(_asincosf_a_1_1 + 1),x
	sta	(___fsadd_PARM_2 + 1)
	lda	(_asincosf_a_1_1 + 2),x
	sta	(___fsadd_PARM_2 + 2)
	lda	(_asincosf_a_1_1 + 3),x
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_asincosf_r_1_1 + 3)
	stx	(_asincosf_r_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_r_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_r_1_1
	jmp	00116$
00115$:
;../asincosf.c:92: r = (a[i] + r) + a[i];
	lda	_asincosf_quartPI_1_1
	lsla	
	lsla	
	tax
	clrh
	lda	_asincosf_a_1_1,x
	sta	___fsadd_PARM_1
	lda	(_asincosf_a_1_1 + 1),x
	sta	(___fsadd_PARM_1 + 1)
	lda	(_asincosf_a_1_1 + 2),x
	sta	(___fsadd_PARM_1 + 2)
	lda	(_asincosf_a_1_1 + 3),x
	sta	(___fsadd_PARM_1 + 3)
	lda	_asincosf_r_1_1
	sta	___fsadd_PARM_2
	lda	(_asincosf_r_1_1 + 1)
	sta	(___fsadd_PARM_2 + 1)
	lda	(_asincosf_r_1_1 + 2)
	sta	(___fsadd_PARM_2 + 2)
	lda	(_asincosf_r_1_1 + 3)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	_asincosf_quartPI_1_1
	lsla	
	lsla	
	tax
	clrh
	lda	_asincosf_a_1_1,x
	sta	___fsadd_PARM_2
	lda	(_asincosf_a_1_1 + 1),x
	sta	(___fsadd_PARM_2 + 1)
	lda	(_asincosf_a_1_1 + 2),x
	sta	(___fsadd_PARM_2 + 2)
	lda	(_asincosf_a_1_1 + 3),x
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_asincosf_r_1_1 + 3)
	stx	(_asincosf_r_1_1 + 2)
	lda	*__ret2
	sta	(_asincosf_r_1_1 + 1)
	lda	*__ret3
	sta	_asincosf_r_1_1
;../asincosf.c:93: if (x < 0.0)
	lda	_asincosf_PARM_1
	sta	___fslt_PARM_1
	lda	(_asincosf_PARM_1 + 1)
	sta	(___fslt_PARM_1 + 1)
	lda	(_asincosf_PARM_1 + 2)
	sta	(___fslt_PARM_1 + 2)
	lda	(_asincosf_PARM_1 + 3)
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	*_asincosf_sloc1_1_0
	tst	*_asincosf_sloc1_1_0
	beq	00116$
00131$:
;../asincosf.c:94: r = -r;
	lda	_asincosf_r_1_1
	eor	#0x80
	sta	_asincosf_r_1_1
00116$:
;../asincosf.c:96: return r;
	lda	_asincosf_r_1_1
	sta	*__ret3
	lda	(_asincosf_r_1_1 + 1)
	sta	*__ret2
	ldx	(_asincosf_r_1_1 + 2)
	lda	(_asincosf_r_1_1 + 3)
00117$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
