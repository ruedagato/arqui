;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module sqrtf
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
	.globl _sqrtf
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
;Allocation info for local variables in function 'sqrtf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;f                         Allocated to stack - offset -4
;y                         Allocated to stack - offset -8
;n                         Allocated to stack - offset -10
;sloc0                     Allocated to stack - offset -11
;sloc1                     Allocated to stack - offset -15
;------------------------------------------------------------
;../sqrtf.c:37: float sqrtf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function sqrtf
;	-----------------------------------------
_sqrtf:
	ais	#-15
;../sqrtf.c:42: if (x==0.0) return x;
	lda	21,s
	ora	20,s
	ora	19,s
	ora	18,s
	bne	00107$
00117$:
	lda	18,s
	sta	*__ret3
	lda	19,s
	sta	*__ret2
	ldx	20,s
	lda	21,s
	jmp	00111$
00107$:
;../sqrtf.c:43: else if (x==1.0) return 1.0;
	lda	18,s
	sta	___fseq_PARM_1
	lda	19,s
	sta	(___fseq_PARM_1 + 1)
	lda	20,s
	sta	(___fseq_PARM_1 + 2)
	lda	21,s
	sta	(___fseq_PARM_1 + 3)
	lda	#0x3F
	sta	___fseq_PARM_2
	lda	#0x80
	sta	(___fseq_PARM_2 + 1)
	clra
	sta	(___fseq_PARM_2 + 2)
	sta	(___fseq_PARM_2 + 3)
	jsr	___fseq
	sta	5,s
	tst	5,s
	beq	00104$
00118$:
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	jmp	00111$
00104$:
;../sqrtf.c:44: else if (x<0.0)
	lda	18,s
	sta	___fslt_PARM_1
	lda	19,s
	sta	(___fslt_PARM_1 + 1)
	lda	20,s
	sta	(___fslt_PARM_1 + 2)
	lda	21,s
	sta	(___fslt_PARM_1 + 3)
	clra
	sta	___fslt_PARM_2
	sta	(___fslt_PARM_2 + 1)
	sta	(___fslt_PARM_2 + 2)
	sta	(___fslt_PARM_2 + 3)
	jsr	___fslt
	sta	5,s
	tst	5,s
	beq	00108$
00119$:
;../sqrtf.c:46: errno=EDOM;
	clra
	sta	_errno
	lda	#0x21
	sta	(_errno + 1)
;../sqrtf.c:47: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	jmp	00111$
00108$:
;../sqrtf.c:49: f=frexpf(x, &n);
	tsx
	aix	#5
	pshh
	pula
	sta	_frexpf_PARM_2
	stx	(_frexpf_PARM_2 + 1)
	lda	18,s
	sta	_frexpf_PARM_1
	lda	19,s
	sta	(_frexpf_PARM_1 + 1)
	lda	20,s
	sta	(_frexpf_PARM_1 + 2)
	lda	21,s
	sta	(_frexpf_PARM_1 + 3)
	jsr	_frexpf
	sta	15,s
	stx	14,s
	lda	*__ret2
	sta	13,s
	lda	*__ret3
	sta	12,s
;../sqrtf.c:50: y=0.41731+0.59016*f; /*Educated guess*/
	lda	#0x3F
	sta	___fsmul_PARM_1
	lda	#0x17
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x14
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xBA
	sta	(___fsmul_PARM_1 + 3)
	lda	12,s
	sta	___fsmul_PARM_2
	lda	13,s
	sta	(___fsmul_PARM_2 + 1)
	lda	14,s
	sta	(___fsmul_PARM_2 + 2)
	lda	15,s
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	#0x3E
	sta	___fsadd_PARM_2
	lda	#0xD5
	sta	(___fsadd_PARM_2 + 1)
	lda	#0xA9
	sta	(___fsadd_PARM_2 + 2)
	lda	#0xA8
	sta	(___fsadd_PARM_2 + 3)
	jsr	___fsadd
	sta	11,s
	stx	10,s
	lda	*__ret2
	sta	9,s
	lda	*__ret3
	sta	8,s
;../sqrtf.c:52: y+=f/y;
	lda	12,s
	sta	___fsdiv_PARM_1
	lda	13,s
	sta	(___fsdiv_PARM_1 + 1)
	lda	14,s
	sta	(___fsdiv_PARM_1 + 2)
	lda	15,s
	sta	(___fsdiv_PARM_1 + 3)
	lda	8,s
	sta	___fsdiv_PARM_2
	lda	9,s
	sta	(___fsdiv_PARM_2 + 1)
	lda	10,s
	sta	(___fsdiv_PARM_2 + 2)
	lda	11,s
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
	sta	(___fsadd_PARM_2 + 3)
	stx	(___fsadd_PARM_2 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_2 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_2
	lda	8,s
	sta	___fsadd_PARM_1
	lda	9,s
	sta	(___fsadd_PARM_1 + 1)
	lda	10,s
	sta	(___fsadd_PARM_1 + 2)
	lda	11,s
	sta	(___fsadd_PARM_1 + 3)
	jsr	___fsadd
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	8,s
	lda	2,s
	sta	9,s
	lda	3,s
	sta	10,s
	lda	4,s
	sta	11,s
;../sqrtf.c:53: y=ldexpf(y, -2) + f/y; /*Faster version of 0.25 * y + f/y*/
	lda	8,s
	sta	_ldexpf_PARM_1
	lda	9,s
	sta	(_ldexpf_PARM_1 + 1)
	lda	10,s
	sta	(_ldexpf_PARM_1 + 2)
	lda	11,s
	sta	(_ldexpf_PARM_1 + 3)
	lda	#0xFF
	sta	_ldexpf_PARM_2
	lda	#0xFE
	sta	(_ldexpf_PARM_2 + 1)
	jsr	_ldexpf
	sta	(___fsadd_PARM_1 + 3)
	stx	(___fsadd_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsadd_PARM_1 + 1)
	lda	*__ret3
	sta	___fsadd_PARM_1
	lda	12,s
	sta	___fsdiv_PARM_1
	lda	13,s
	sta	(___fsdiv_PARM_1 + 1)
	lda	14,s
	sta	(___fsdiv_PARM_1 + 2)
	lda	15,s
	sta	(___fsdiv_PARM_1 + 3)
	lda	8,s
	sta	___fsdiv_PARM_2
	lda	9,s
	sta	(___fsdiv_PARM_2 + 1)
	lda	10,s
	sta	(___fsdiv_PARM_2 + 2)
	lda	11,s
	sta	(___fsdiv_PARM_2 + 3)
	jsr	___fsdiv
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
	sta	8,s
	lda	2,s
	sta	9,s
	lda	3,s
	sta	10,s
	lda	4,s
	sta	11,s
;../sqrtf.c:55: if (n&1)
	lda	7,s
	and	#0x01
	bne	00120$
00120$:
	beq	00110$
00121$:
;../sqrtf.c:57: y*=0.7071067812;
	lda	#0x3F
	sta	___fsmul_PARM_1
	lda	#0x35
	sta	(___fsmul_PARM_1 + 1)
	lda	#0x04
	sta	(___fsmul_PARM_1 + 2)
	lda	#0xF3
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
	sta	4,s
	stx	3,s
	lda	*__ret2
	sta	2,s
	lda	*__ret3
	sta	1,s
	lda	1,s
	sta	8,s
	lda	2,s
	sta	9,s
	lda	3,s
	sta	10,s
	lda	4,s
	sta	11,s
;../sqrtf.c:58: ++n;
	inc	7,s
	bne	00122$
	inc	6,s
00122$:
00110$:
;../sqrtf.c:60: return ldexpf(y, n/2);
	clra
	sta	__divsint_PARM_2
	lda	#0x02
	sta	(__divsint_PARM_2 + 1)
	ldx	6,s
	lda	7,s
	jsr	__divsint
	sta	(_ldexpf_PARM_2 + 1)
	stx	_ldexpf_PARM_2
	lda	8,s
	sta	_ldexpf_PARM_1
	lda	9,s
	sta	(_ldexpf_PARM_1 + 1)
	lda	10,s
	sta	(_ldexpf_PARM_1 + 2)
	lda	11,s
	sta	(_ldexpf_PARM_1 + 3)
	jsr	_ldexpf
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
00111$:
	ais	#15
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
