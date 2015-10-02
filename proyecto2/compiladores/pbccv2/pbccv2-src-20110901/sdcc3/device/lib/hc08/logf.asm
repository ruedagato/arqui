;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module logf
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
	.globl _logf
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
;Allocation info for local variables in function 'logf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;Rz                        Allocated to registers 
;f                         Allocated to stack - offset -4
;z                         Allocated to stack - offset -8
;w                         Allocated to stack - offset -12
;znum                      Allocated to stack - offset -16
;zden                      Allocated to stack - offset -20
;xn                        Allocated to stack - offset -24
;n                         Allocated to stack - offset -26
;sloc0                     Allocated to stack - offset -27
;sloc1                     Allocated to stack - offset -31
;------------------------------------------------------------
;../logf.c:216: float logf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function logf
;	-----------------------------------------
_logf:
	ais	#-31
;../logf.c:226: if (x<=0.0)
	lda	34,s
	sta	___fsgt_PARM_1
	lda	35,s
	sta	(___fsgt_PARM_1 + 1)
	lda	36,s
	sta	(___fsgt_PARM_1 + 2)
	lda	37,s
	sta	(___fsgt_PARM_1 + 3)
	clra
	sta	___fsgt_PARM_2
	sta	(___fsgt_PARM_2 + 1)
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	5,s
	tst	5,s
	bne	00102$
00110$:
;../logf.c:228: errno=EDOM;
	clra
	sta	_errno
	lda	#0x21
	sta	(_errno + 1)
;../logf.c:229: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	jmp	00106$
00102$:
;../logf.c:231: f=frexpf(x, &n);
	tsx
	aix	#5
	pshh
	pula
	sta	_frexpf_PARM_2
	stx	(_frexpf_PARM_2 + 1)
	lda	34,s
	sta	_frexpf_PARM_1
	lda	35,s
	sta	(_frexpf_PARM_1 + 1)
	lda	36,s
	sta	(_frexpf_PARM_1 + 2)
	lda	37,s
	sta	(_frexpf_PARM_1 + 3)
	jsr	_frexpf
	sta	31,s
	stx	30,s
	lda	*__ret2
	sta	29,s
	lda	*__ret3
	sta	28,s
;../logf.c:232: znum=f-0.5;
	lda	28,s
	sta	___fssub_PARM_1
	lda	29,s
	sta	(___fssub_PARM_1 + 1)
	lda	30,s
	sta	(___fssub_PARM_1 + 2)
	lda	31,s
	sta	(___fssub_PARM_1 + 3)
	lda	#0x3F
	sta	___fssub_PARM_2
	clra
	sta	(___fssub_PARM_2 + 1)
	sta	(___fssub_PARM_2 + 2)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
	sta	19,s
	stx	18,s
	lda	*__ret2
	sta	17,s
	lda	*__ret3
	sta	16,s
;../logf.c:233: if (f>C0)
	lda	28,s
	sta	___fsgt_PARM_1
	lda	29,s
	sta	(___fsgt_PARM_1 + 1)
	lda	30,s
	sta	(___fsgt_PARM_1 + 2)
	lda	31,s
	sta	(___fsgt_PARM_1 + 3)
	lda	#0x3F
	sta	___fsgt_PARM_2
	lda	#0x35
	sta	(___fsgt_PARM_2 + 1)
	lda	#0x04
	sta	(___fsgt_PARM_2 + 2)
	lda	#0xF3
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	5,s
	tst	5,s
	bne	00111$
	jmp	00104$
00111$:
;../logf.c:235: znum-=0.5;
	lda	16,s
	sta	___fssub_PARM_1
	lda	17,s
	sta	(___fssub_PARM_1 + 1)
	lda	18,s
	sta	(___fssub_PARM_1 + 2)
	lda	19,s
	sta	(___fssub_PARM_1 + 3)
	lda	#0x3F
	sta	___fssub_PARM_2
	clra
	sta	(___fssub_PARM_2 + 1)
	sta	(___fssub_PARM_2 + 2)
	sta	(___fssub_PARM_2 + 3)
	jsr	___fssub
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
;../logf.c:236: zden=(f*0.5)+0.5;
	lda	#0x3F
	sta	___fsmul_PARM_1
	clra
	sta	(___fsmul_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 2)
	sta	(___fsmul_PARM_1 + 3)
	lda	28,s
	sta	___fsmul_PARM_2
	lda	29,s
	sta	(___fsmul_PARM_2 + 1)
	lda	30,s
	sta	(___fsmul_PARM_2 + 2)
	lda	31,s
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
	clra
	sta	(___fsadd_PARM_2 + 1)
	sta	(___fsadd_PARM_2 + 2)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	15,s
	stx	14,s
	lda	*__ret2
	sta	13,s
	lda	*__ret3
	sta	12,s
	lda	12,s
	sta	1,s
	lda	13,s
	sta	2,s
	lda	14,s
	sta	3,s
	lda	15,s
	sta	4,s
	jmp	00105$
00104$:
;../logf.c:240: n--;
	lda	7,s
	sub	#0x01
	sta	7,s
	lda	6,s
	sbc	#0x00
	sta	6,s
;../logf.c:241: zden=znum*0.5+0.5;
	lda	#0x3F
	sta	___fsmul_PARM_1
	clra
	sta	(___fsmul_PARM_1 + 1)
	sta	(___fsmul_PARM_1 + 2)
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
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3F
	sta	___fsadd_PARM_2
	clra
	sta	(___fsadd_PARM_2 + 1)
	sta	(___fsadd_PARM_2 + 2)
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	15,s
	stx	14,s
	lda	*__ret2
	sta	13,s
	lda	*__ret3
	sta	12,s
	lda	12,s
	sta	1,s
	lda	13,s
	sta	2,s
	lda	14,s
	sta	3,s
	lda	15,s
	sta	4,s
00105$:
;../logf.c:243: z=znum/zden;
	lda	16,s
	sta	___fsdiv_PARM_1
	lda	17,s
	sta	(___fsdiv_PARM_1 + 1)
	lda	18,s
	sta	(___fsdiv_PARM_1 + 2)
	lda	19,s
	sta	(___fsdiv_PARM_1 + 3)
	lda	1,s
	sta	___fsdiv_PARM_2
	lda	2,s
	sta	(___fsdiv_PARM_2 + 1)
	lda	3,s
	sta	(___fsdiv_PARM_2 + 2)
	lda	4,s
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	27,s
	stx	26,s
	lda	*__ret2
	sta	25,s
	lda	*__ret3
	sta	24,s
;../logf.c:244: w=z*z;
	lda	24,s
	sta	___fsmul_PARM_1
	lda	25,s
	sta	(___fsmul_PARM_1 + 1)
	lda	26,s
	sta	(___fsmul_PARM_1 + 2)
	lda	27,s
	sta	(___fsmul_PARM_1 + 3)
	lda	24,s
	sta	___fsmul_PARM_2
	lda	25,s
	sta	(___fsmul_PARM_2 + 1)
	lda	26,s
	sta	(___fsmul_PARM_2 + 2)
	lda	27,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	23,s
	stx	22,s
	lda	*__ret2
	sta	21,s
	lda	*__ret3
	sta	20,s
;../logf.c:246: Rz=z+z*(w*A(w)/B(w));
	lda	#0xBF
	sta	___fsmul_PARM_1
	lda	#0x0D
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x7E
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x3D
	sta	(___fsmul_PARM_1 + 3)
	lda	20,s
	sta	___fsmul_PARM_2
	lda	21,s
	sta	(___fsmul_PARM_2 + 1)
	lda	22,s
	sta	(___fsmul_PARM_2 + 2)
	lda	23,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsdiv_PARM_1 + 3)
	stx	(___fsdiv_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsdiv_PARM_1 + 1)
	lda	*__ret3
	sta	___fsdiv_PARM_1
	lda	20,s
	sta	___fsadd_PARM_1
	lda	21,s
	sta	(___fsadd_PARM_1 + 1)
	lda	22,s
	sta	(___fsadd_PARM_1 + 2)
	lda	23,s
	sta	(___fsadd_PARM_1 + 3)
	lda	#0xC0
	sta	___fsadd_PARM_2
	lda	#0xD4
	sta	(___fsadd_PARM_2 + 1)
	lda	#0x3F
	sta	(___fsadd_PARM_2 + 2)
	lda	#0x3A
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
	lda	24,s
	sta	___fsmul_PARM_1
	lda	25,s
	sta	(___fsmul_PARM_1 + 1)
	lda	26,s
	sta	(___fsmul_PARM_1 + 2)
	lda	27,s
	sta	(___fsmul_PARM_1 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	24,s
	sta	___fsadd_PARM_1
	lda	25,s
	sta	(___fsadd_PARM_1 + 1)
	lda	26,s
	sta	(___fsadd_PARM_1 + 2)
	lda	27,s
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
;../logf.c:247: xn=n;
	ldx	6,s
	lda	7,s
	jsr	___sint2fs
	sta	11,s
	stx	10,s
	lda	*__ret2
	sta	9,s
	lda	*__ret3
	sta	8,s
;../logf.c:248: return ((xn*C2+Rz)+xn*C1);
	lda	#0xB9
	sta	___fsmul_PARM_1
	lda	#0x5E
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x80
	sta	(___fsmul_PARM_1 + 2)
	lda	#0x83
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
	jsr	___fsadd
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3F
	sta	___fsmul_PARM_1
	lda	#0x31
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x80
	sta	(___fsmul_PARM_1 + 2)
	clra
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
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	jsr	___fsadd
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	*__ret3
	lda	2,s
	sta	*__ret2
	ldx	3,s
	lda	4,s
00106$:
	ais	#31
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
