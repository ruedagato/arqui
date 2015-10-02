;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module acosf
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
	.globl _acosf
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
;Allocation info for local variables in function 'acosf'
;------------------------------------------------------------
;x                         Allocated to stack - offset 2
;sloc0                     Allocated to stack - offset -1
;sloc1                     Allocated to stack - offset -5
;------------------------------------------------------------
;../acosf.c:36: float acosf(const float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function acosf
;	-----------------------------------------
_acosf:
	ais	#-5
;../acosf.c:38: if (x == 1.0) return 0.0;
	lda	8,s
	sta	___fseq_PARM_1
	lda	9,s
	sta	(___fseq_PARM_1 + 1)
	lda	10,s
	sta	(___fseq_PARM_1 + 2)
	lda	11,s
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
	beq	00108$
00115$:
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	jmp	00110$
00108$:
;../acosf.c:39: else if (x ==-1.0) return PI;
	lda	8,s
	sta	___fseq_PARM_1
	lda	9,s
	sta	(___fseq_PARM_1 + 1)
	lda	10,s
	sta	(___fseq_PARM_1 + 2)
	lda	11,s
	sta	(___fseq_PARM_1 + 3)
	lda	#0xBF
	sta	___fseq_PARM_2
	lda	#0x80
	sta	(___fseq_PARM_2 + 1)
	clra
	sta	(___fseq_PARM_2 + 2)
	sta	(___fseq_PARM_2 + 3)
	jsr	___fseq
	sta	5,s
	tst	5,s
	beq	00105$
00116$:
	clr	*__ret3
	clr	*__ret2
	ldx	#0x0F
	lda	#0xDB
	bra	00110$
00105$:
;../acosf.c:40: else if (x == 0.0) return HALF_PI;
	lda	11,s
	ora	10,s
	ora	9,s
	ora	8,s
	bne	00102$
00117$:
	clr	*__ret3
	clr	*__ret2
	ldx	#0x0F
	lda	#0xDB
	bra	00110$
00102$:
;../acosf.c:41: else               return asincosf(x, true);
	lda	8,s
	sta	_asincosf_PARM_1
	lda	9,s
	sta	(_asincosf_PARM_1 + 1)
	lda	10,s
	sta	(_asincosf_PARM_1 + 2)
	lda	11,s
	sta	(_asincosf_PARM_1 + 3)
	lda	#0x01
	sta	_asincosf_PARM_2
	jsr	_asincosf
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
00110$:
	ais	#5
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
