;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module atanf
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
	.globl _atanf
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
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
_atanf_a_1_1:
	.ds 16
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME (CODE)
	.area GSINIT (CODE)
	.area GSFINAL (CODE)
	.area GSINIT (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'atanf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;f                         Allocated to stack - offset -4
;r                         Allocated to stack - offset -8
;g                         Allocated to stack - offset -12
;n                         Allocated to stack - offset -14
;sloc0                     Allocated to stack - offset -15
;sloc1                     Allocated to stack - offset -19
;a                         Allocated with name '_atanf_a_1_1'
;------------------------------------------------------------
;../atanf.c:59: static myconst float a[]={  0.0, 0.5235987756, 1.5707963268, 1.0471975512 };
	clra
	sta	_atanf_a_1_1
	sta	(_atanf_a_1_1 + 1)
	sta	(_atanf_a_1_1 + 2)
	sta	(_atanf_a_1_1 + 3)
	lda	#0x3F
	sta	(_atanf_a_1_1 + 0x0004)
	lda	#0x06
	sta	((_atanf_a_1_1 + 0x0004) + 1)
	lda	#0x0A
	sta	((_atanf_a_1_1 + 0x0004) + 2)
	lda	#0x92
	sta	((_atanf_a_1_1 + 0x0004) + 3)
	lda	#0x3F
	sta	(_atanf_a_1_1 + 0x0008)
	lda	#0xC9
	sta	((_atanf_a_1_1 + 0x0008) + 1)
	lda	#0x0F
	sta	((_atanf_a_1_1 + 0x0008) + 2)
	lda	#0xDB
	sta	((_atanf_a_1_1 + 0x0008) + 3)
	lda	#0x3F
	sta	(_atanf_a_1_1 + 0x000c)
	lda	#0x86
	sta	((_atanf_a_1_1 + 0x000c) + 1)
	lda	#0x0A
	sta	((_atanf_a_1_1 + 0x000c) + 2)
	lda	#0x92
	sta	((_atanf_a_1_1 + 0x000c) + 3)
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
;Allocation info for local variables in function 'atanf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;f                         Allocated to stack - offset -4
;r                         Allocated to stack - offset -8
;g                         Allocated to stack - offset -12
;n                         Allocated to stack - offset -14
;sloc0                     Allocated to stack - offset -15
;sloc1                     Allocated to stack - offset -19
;a                         Allocated with name '_atanf_a_1_1'
;------------------------------------------------------------
;../atanf.c:55: float atanf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function atanf
;	-----------------------------------------
_atanf:
	ais	#-19
;../atanf.c:58: int n=0;
	clra
	sta	6,s
	clra
	sta	7,s
;../atanf.c:61: f=fabsf(x);
	lda	25,s
	psha
	lda	25,s
	psha
	lda	25,s
	psha
	lda	25,s
	psha
	jsr	_fabsf
	sta	23,s
	stx	22,s
	lda	*__ret2
	sta	21,s
	lda	*__ret3
	sta	20,s
	ais	#4
;../atanf.c:62: if(f>1.0)
	lda	16,s
	sta	___fsgt_PARM_1
	lda	17,s
	sta	(___fsgt_PARM_1 + 1)
	lda	18,s
	sta	(___fsgt_PARM_1 + 2)
	lda	19,s
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3F
	sta	___fsgt_PARM_2
	lda	#0x80
	sta	(___fsgt_PARM_2 + 1)
	clra
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	5,s
	tst	5,s
	beq	00102$
00119$:
;../atanf.c:64: f=1.0/f;
	lda	#0x3F
	sta	___fsdiv_PARM_1
	lda	#0x80
	sta	(___fsdiv_PARM_1 + 1)
	clra
	sta	(___fsdiv_PARM_1 + 2)
	sta	(___fsdiv_PARM_1 + 3)
	lda	16,s
	sta	___fsdiv_PARM_2
	lda	17,s
	sta	(___fsdiv_PARM_2 + 1)
	lda	18,s
	sta	(___fsdiv_PARM_2 + 2)
	lda	19,s
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	16,s
	lda	2,s
	sta	17,s
	lda	3,s
	sta	18,s
	lda	4,s
	sta	19,s
;../atanf.c:65: n=2;
	clra
	sta	6,s
	lda	#0x02
	sta	7,s
00102$:
;../atanf.c:67: if(f>K1)
	lda	16,s
	sta	___fsgt_PARM_1
	lda	17,s
	sta	(___fsgt_PARM_1 + 1)
	lda	18,s
	sta	(___fsgt_PARM_1 + 2)
	lda	19,s
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3E
	sta	___fsgt_PARM_2
	lda	#0x89
	sta	(___fsgt_PARM_2 + 1)
	lda	#0x30
	sta	(___fsgt_PARM_2 + 2)
	lda	#0xA3
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	1,s
	tst	1,s
	bne	00120$
	jmp	00104$
00120$:
;../atanf.c:69: f=((K2*f-1.0)+f)/(K3+f);
	lda	#0x3F
	sta	___fsmul_PARM_1
	lda	#0x3B
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x67
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xAF
	sta	(___fsmul_PARM_1 + 3)
	lda	16,s
	sta	___fsmul_PARM_2
	lda	17,s
	sta	(___fsmul_PARM_2 + 1)
	lda	18,s
	sta	(___fsmul_PARM_2 + 2)
	lda	19,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fssub_PARM_1 + 3)
	stx	(___fssub_PARM_1 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_1 + 1)
	lda	*__ret3
	sta	___fssub_PARM_1
	lda	#0x3F
	sta	___fssub_PARM_2
	lda	#0x80
	sta	(___fssub_PARM_2 + 1)
	clra
	sta	(___fssub_PARM_2 + 2)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	16,s
	sta	___fsadd_PARM_2
	lda	17,s
	sta	(___fsadd_PARM_2 + 1)
	lda	18,s
	sta	(___fsadd_PARM_2 + 2)
	lda	19,s
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsdiv_PARM_1 + 3)
	stx	(___fsdiv_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_1 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_1
	lda	16,s
	sta	___fsadd_PARM_1
	lda	17,s
	sta	(___fsadd_PARM_1 + 1)
	lda	18,s
	sta	(___fsadd_PARM_1 + 2)
	lda	19,s
	sta	(___fsadd_PARM_1 + 3)
	lda	#0x3F
	sta	___fsadd_PARM_2
	lda	#0xDD
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xB3
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xD7
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsdiv_PARM_2 + 3)
	stx	(___fsdiv_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_2 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_2
	jsr	___fsdiv
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	16,s
	lda	2,s
	sta	17,s
	lda	3,s
	sta	18,s
	lda	4,s
	sta	19,s
;../atanf.c:73: n++;
	inc	7,s
	bne	00121$
	inc	6,s
00121$:
00104$:
;../atanf.c:75: if(fabsf(f)<EPS) r=f;
	lda	19,s
	psha
	lda	19,s
	psha
	lda	19,s
	psha
	lda	19,s
	psha
	jsr	_fabsf
	sta	(___fslt_PARM_1 + 3)
	stx	(___fslt_PARM_1 + 2)
	lda	*__ret2
	sta	(___fslt_PARM_1 + 1)
	lda	*__ret3
	sta	___fslt_PARM_1
	ais	#4
	lda	#0x39
	sta	___fslt_PARM_2
	lda	#0x80
	sta	(___fslt_PARM_2 + 1)
	clra
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	1,s
	tst	1,s
	beq	00106$
00122$:
	lda	16,s
	sta	12,s
	lda	17,s
	sta	13,s
	lda	18,s
	sta	14,s
	lda	19,s
	sta	15,s
	jmp	00107$
00106$:
;../atanf.c:78: g=f*f;
	lda	16,s
	sta	___fsmul_PARM_1
	lda	17,s
	sta	(___fsmul_PARM_1 + 1)
	lda	18,s
	sta	(___fsmul_PARM_1 + 2)
	lda	19,s
	sta	(___fsmul_PARM_1 + 3)
	lda	16,s
	sta	___fsmul_PARM_2
	lda	17,s
	sta	(___fsmul_PARM_2 + 1)
	lda	18,s
	sta	(___fsmul_PARM_2 + 2)
	lda	19,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	11,s
	stx	10,s
	lda	*__ret2
	sta	9,s
	lda	*__ret3
	sta	8,s
;../atanf.c:79: r=f+P(g,f)/Q(g);
	lda	#0xBD
	sta	___fsmul_PARM_1
	lda	#0x50
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x86
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x91
	sta	(___fsmul_PARM_1 + 3)
	lda	8,s
	sta	___fsmul_PARM_2
	lda	9,s
	sta	(___fsmul_PARM_2 + 1)
	lda	10,s
	sta	(___fsmul_PARM_2 + 2)
	lda	11,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0xBE
	sta	___fsadd_PARM_2
	lda	#0xF1
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x10
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xF6
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	8,s
	sta	___fsmul_PARM_2
	lda	9,s
	sta	(___fsmul_PARM_2 + 1)
	lda	10,s
	sta	(___fsmul_PARM_2 + 2)
	lda	11,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	16,s
	sta	___fsmul_PARM_2
	lda	17,s
	sta	(___fsmul_PARM_2 + 1)
	lda	18,s
	sta	(___fsmul_PARM_2 + 2)
	lda	19,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsdiv_PARM_1 + 3)
	stx	(___fsdiv_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_1 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_1
	lda	8,s
	sta	___fsadd_PARM_1
	lda	9,s
	sta	(___fsadd_PARM_1 + 1)
	lda	10,s
	sta	(___fsadd_PARM_1 + 2)
	lda	11,s
	sta	(___fsadd_PARM_1 + 3)
	lda	#0x3F
	sta	___fsadd_PARM_2
	lda	#0xB4
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xCC
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xD3
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsdiv_PARM_2 + 3)
	stx	(___fsdiv_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_2 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_2
	jsr	___fsdiv
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	16,s
	sta	___fsadd_PARM_1
	lda	17,s
	sta	(___fsadd_PARM_1 + 1)
	lda	18,s
	sta	(___fsadd_PARM_1 + 2)
	lda	19,s
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	12,s
	lda	2,s
	sta	13,s
	lda	3,s
	sta	14,s
	lda	4,s
	sta	15,s
00107$:
;../atanf.c:81: if(n>1) r=-r;
	lda	#0x01
	sub	7,s
	clra
	sbc	6,s
	bge	00109$
00123$:
	lda	12,s
	eor	#0x80
	sta	12,s
00109$:
;../atanf.c:82: r+=a[n];
	lda	7,s
	ldx	6,s
	lsla
	rolx
	lsla
	rolx
	sta	2,s
	stx	1,s
	lda	1,s
	ldx	2,s
	psha
	pulh
	lda	_atanf_a_1_1,x
	sta	___fsadd_PARM_2
	lda	(_atanf_a_1_1 + 1),x
	sta	(___fsadd_PARM_2 + 1)
	lda	(_atanf_a_1_1 + 2),x
	sta	(___fsadd_PARM_2 + 2)
	lda	(_atanf_a_1_1 + 3),x
	sta	(___fsadd_PARM_2 + 3)
	lda	12,s
	sta	___fsadd_PARM_1
	lda	13,s
	sta	(___fsadd_PARM_1 + 1)
	lda	14,s
	sta	(___fsadd_PARM_1 + 2)
	lda	15,s
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	12,s
	lda	2,s
	sta	13,s
	lda	3,s
	sta	14,s
	lda	4,s
	sta	15,s
;../atanf.c:83: if(x<0.0) r=-r;
	lda	22,s
	sta	___fslt_PARM_1
	lda	23,s
	sta	(___fslt_PARM_1 + 1)
	lda	24,s
	sta	(___fslt_PARM_1 + 2)
	lda	25,s
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	1,s
	tst	1,s
	beq	00111$
00124$:
	lda	12,s
	eor	#0x80
	sta	12,s
00111$:
;../atanf.c:84: return r;
	lda	12,s
	sta	*__ret3
	lda	13,s
	sta	*__ret2
	ldx	14,s
	lda	15,s
00112$:
	ais	#19
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
