;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module tanhf
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
	.globl _tanhf
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
;Allocation info for local variables in function 'tanhf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;f                         Allocated to stack - offset -4
;g                         Allocated to stack - offset -8
;r                         Allocated to stack - offset -12
;sloc0                     Allocated to stack - offset -13
;sloc1                     Allocated to stack - offset -17
;------------------------------------------------------------
;../tanhf.c:50: float tanhf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function tanhf
;	-----------------------------------------
_tanhf:
	ais	#-17
;../tanhf.c:54: f=fabsf(x);
	lda	23,s
	psha
	lda	23,s
	psha
	lda	23,s
	psha
	lda	23,s
	psha
	jsr	_fabsf
	sta	21,s
	stx	20,s
	lda	*__ret2
	sta	19,s
	lda	*__ret3
	sta	18,s
	ais	#4
;../tanhf.c:55: if(f>SBIG) r=1.0;
	lda	14,s
	sta	___fsgt_PARM_1
	lda	15,s
	sta	(___fsgt_PARM_1 + 1)
	lda	16,s
	sta	(___fsgt_PARM_1 + 2)
	lda	17,s
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x41
	sta	___fsgt_PARM_2
	lda	#0x10
	sta	(___fsgt_PARM_2 + 1)
	lda	#0x2C
	sta	(___fsgt_PARM_2 + 2)
	lda	#0xB0
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	5,s
	tst	5,s
	beq	00108$
00118$:
	lda	#0x3F
	sta	6,s
	lda	#0x80
	sta	7,s
	clra
	sta	8,s
	clra
	sta	9,s
	jmp	00109$
00108$:
;../tanhf.c:56: else if(f>K1)
	lda	14,s
	sta	___fsgt_PARM_1
	lda	15,s
	sta	(___fsgt_PARM_1 + 1)
	lda	16,s
	sta	(___fsgt_PARM_1 + 2)
	lda	17,s
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3F
	sta	___fsgt_PARM_2
	lda	#0x0C
	sta	(___fsgt_PARM_2 + 1)
	lda	#0x9F
	sta	(___fsgt_PARM_2 + 2)
	lda	#0x54
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	5,s
	tst	5,s
	bne	00119$
	jmp	00105$
00119$:
;../tanhf.c:58: r=0.5-1.0/(expf(f+f)+1.0);
	lda	14,s
	sta	___fsadd_PARM_1
	lda	15,s
	sta	(___fsadd_PARM_1 + 1)
	lda	16,s
	sta	(___fsadd_PARM_1 + 2)
	lda	17,s
	sta	(___fsadd_PARM_1 + 3)
	lda	14,s
	sta	___fsadd_PARM_2
	lda	15,s
	sta	(___fsadd_PARM_2 + 1)
	lda	16,s
	sta	(___fsadd_PARM_2 + 2)
	lda	17,s
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(_expf_PARM_1 + 3)
	stx	(_expf_PARM_1 + 2)
	lda	*__ret2
	sta	(_expf_PARM_1 + 1)
	lda	*__ret3
	sta	_expf_PARM_1
	jsr	_expf
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3F
	sta	___fsadd_PARM_2
	lda	#0x80
	sta	(___fsadd_PARM_2 + 1)
	clra
	sta	(___fsadd_PARM_2 + 2)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsdiv_PARM_2 + 3)
	stx	(___fsdiv_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_2 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_2
	lda	#0x3F
	sta	___fsdiv_PARM_1
	lda	#0x80
	sta	(___fsdiv_PARM_1 + 1)
	clra
	sta	(___fsdiv_PARM_1 + 2)
	sta	(___fsdiv_PARM_1 + 3)
	jsr	___fsdiv
	sta	(___fssub_PARM_2 + 3)
	stx	(___fssub_PARM_2 + 2)
	lda	*__ret2
	sta	(___fssub_PARM_2 + 1)
	lda	*__ret3
	sta	___fssub_PARM_2
	lda	#0x3F
	sta	___fssub_PARM_1
	clra
	sta	(___fssub_PARM_1 + 1)
	sta	(___fssub_PARM_1 + 2)
	sta	(___fssub_PARM_1 + 3)
	jsr	___fssub
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	6,s
	lda	2,s
	sta	7,s
	lda	3,s
	sta	8,s
	lda	4,s
	sta	9,s
;../tanhf.c:59: r+=r;
	lda	6,s
	sta	___fsadd_PARM_1
	lda	7,s
	sta	(___fsadd_PARM_1 + 1)
	lda	8,s
	sta	(___fsadd_PARM_1 + 2)
	lda	9,s
	sta	(___fsadd_PARM_1 + 3)
	lda	6,s
	sta	___fsadd_PARM_2
	lda	7,s
	sta	(___fsadd_PARM_2 + 1)
	lda	8,s
	sta	(___fsadd_PARM_2 + 2)
	lda	9,s
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	6,s
	lda	2,s
	sta	7,s
	lda	3,s
	sta	8,s
	lda	4,s
	sta	9,s
	jmp	00109$
00105$:
;../tanhf.c:61: else if(f<EPS) r=f;
	lda	14,s
	sta	___fslt_PARM_1
	lda	15,s
	sta	(___fslt_PARM_1 + 1)
	lda	16,s
	sta	(___fslt_PARM_1 + 2)
	lda	17,s
	sta	(___fslt_PARM_1 + 3)
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
	beq	00102$
00120$:
	lda	14,s
	sta	6,s
	lda	15,s
	sta	7,s
	lda	16,s
	sta	8,s
	lda	17,s
	sta	9,s
	jmp	00109$
00102$:
;../tanhf.c:64: g=f*f;
	lda	14,s
	sta	___fsmul_PARM_1
	lda	15,s
	sta	(___fsmul_PARM_1 + 1)
	lda	16,s
	sta	(___fsmul_PARM_1 + 2)
	lda	17,s
	sta	(___fsmul_PARM_1 + 3)
	lda	14,s
	sta	___fsmul_PARM_2
	lda	15,s
	sta	(___fsmul_PARM_2 + 1)
	lda	16,s
	sta	(___fsmul_PARM_2 + 2)
	lda	17,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	13,s
	stx	12,s
	lda	*__ret2
	sta	11,s
	lda	*__ret3
	sta	10,s
;../tanhf.c:65: r=f+f*(P(g)/Q(g));
	lda	#0xBB
	sta	___fsmul_PARM_1
	lda	#0x7B
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x11
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xB2
	sta	(___fsmul_PARM_1 + 3)
	lda	10,s
	sta	___fsmul_PARM_2
	lda	11,s
	sta	(___fsmul_PARM_2 + 1)
	lda	12,s
	sta	(___fsmul_PARM_2 + 2)
	lda	13,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0xBF
	sta	___fsadd_PARM_2
	lda	#0x52
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xE2
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xC6
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	lda	10,s
	sta	___fsmul_PARM_2
	lda	11,s
	sta	(___fsmul_PARM_2 + 1)
	lda	12,s
	sta	(___fsmul_PARM_2 + 2)
	lda	13,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsdiv_PARM_1 + 3)
	stx	(___fsdiv_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_1 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_1
	lda	10,s
	sta	___fsadd_PARM_1
	lda	11,s
	sta	(___fsadd_PARM_1 + 1)
	lda	12,s
	sta	(___fsadd_PARM_1 + 2)
	lda	13,s
	sta	(___fsadd_PARM_1 + 3)
	lda	#0x40
	sta	___fsadd_PARM_2
	lda	#0x1E
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x2A
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x1A
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
	lda	14,s
	sta	___fsmul_PARM_1
	lda	15,s
	sta	(___fsmul_PARM_1 + 1)
	lda	16,s
	sta	(___fsmul_PARM_1 + 2)
	lda	17,s
	sta	(___fsmul_PARM_1 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	14,s
	sta	___fsadd_PARM_1
	lda	15,s
	sta	(___fsadd_PARM_1 + 1)
	lda	16,s
	sta	(___fsadd_PARM_1 + 2)
	lda	17,s
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	6,s
	lda	2,s
	sta	7,s
	lda	3,s
	sta	8,s
	lda	4,s
	sta	9,s
00109$:
;../tanhf.c:67: if(x<0.0) r=-r;
	lda	20,s
	sta	___fslt_PARM_1
	lda	21,s
	sta	(___fslt_PARM_1 + 1)
	lda	22,s
	sta	(___fslt_PARM_1 + 2)
	lda	23,s
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
00121$:
	lda	6,s
	eor	#0x80
	sta	6,s
00111$:
;../tanhf.c:68: return r;
	lda	6,s
	sta	*__ret3
	lda	7,s
	sta	*__ret2
	ldx	8,s
	lda	9,s
00112$:
	ais	#17
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
