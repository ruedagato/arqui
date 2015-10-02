;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module powf
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
	.globl _powf_PARM_2
	.globl _powf_PARM_1
	.globl _powf
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_powf_sloc0_1_0:
	.ds 1
_powf_sloc1_1_0:
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
_powf_PARM_1:
	.ds 4
_powf_PARM_2:
	.ds 4
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
;Allocation info for local variables in function 'powf'
;------------------------------------------------------------
;sloc0                     Allocated with name '_powf_sloc0_1_0'
;sloc1                     Allocated with name '_powf_sloc1_1_0'
;x                         Allocated with name '_powf_PARM_1'
;y                         Allocated with name '_powf_PARM_2'
;------------------------------------------------------------
;../powf.c:35: float powf(const float x, const float y)
;	-----------------------------------------
;	 function powf
;	-----------------------------------------
_powf:
;../powf.c:37: if(y == 0.0) return 1.0;
	lda	(_powf_PARM_2 + 3)
	ora	(_powf_PARM_2 + 2)
	ora	(_powf_PARM_2 + 1)
	ora	_powf_PARM_2
	bne	00102$
00112$:
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00102$:
;../powf.c:38: if(y==1.0) return x;
	lda	_powf_PARM_2
	sta	___fseq_PARM_1
	lda	(_powf_PARM_2 + 1)
	sta	(___fseq_PARM_1 + 1)
	lda	(_powf_PARM_2 + 2)
	sta	(___fseq_PARM_1 + 2)
	lda	(_powf_PARM_2 + 3)
	sta	(___fseq_PARM_1 + 3)
	lda	#0x3F
	sta	___fseq_PARM_2
	lda	#0x80
	sta	(___fseq_PARM_2 + 1)
	clra
	sta	(___fseq_PARM_2 + 2)
	sta	(___fseq_PARM_2 + 3)
	jsr	___fseq
	sta	*_powf_sloc0_1_0
	tst	*_powf_sloc0_1_0
	beq	00104$
00113$:
	lda	_powf_PARM_1
	sta	*__ret3
	lda	(_powf_PARM_1 + 1)
	sta	*__ret2
	ldx	(_powf_PARM_1 + 2)
	lda	(_powf_PARM_1 + 3)
	rts
00104$:
;../powf.c:39: if(x <= 0.0) return 0.0;
	lda	_powf_PARM_1
	sta	___fsgt_PARM_1
	lda	(_powf_PARM_1 + 1)
	sta	(___fsgt_PARM_1 + 1)
	lda	(_powf_PARM_1 + 2)
	sta	(___fsgt_PARM_1 + 2)
	lda	(_powf_PARM_1 + 3)
	sta	(___fsgt_PARM_1 + 3)
	clra
	sta	___fsgt_PARM_2
	sta	(___fsgt_PARM_2 + 1)
	sta	(___fsgt_PARM_2 + 2)
	sta	(___fsgt_PARM_2 + 3)
	jsr	___fsgt
	sta	*_powf_sloc0_1_0
	tst	*_powf_sloc0_1_0
	bne	00106$
00114$:
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
00106$:
;../powf.c:40: return expf(logf(x) * y);
	lda	(_powf_PARM_1 + 3)
	psha
	lda	(_powf_PARM_1 + 2)
	psha
	lda	(_powf_PARM_1 + 1)
	psha
	lda	_powf_PARM_1
	psha
	jsr	_logf
	sta	(___fsmul_PARM_1 + 3)
	stx	(___fsmul_PARM_1 + 2)
	lda	*__ret2
	sta	(___fsmul_PARM_1 + 1)
	lda	*__ret3
	sta	___fsmul_PARM_1
	ais	#4
	lda	_powf_PARM_2
	sta	___fsmul_PARM_2
	lda	(_powf_PARM_2 + 1)
	sta	(___fsmul_PARM_2 + 1)
	lda	(_powf_PARM_2 + 2)
	sta	(___fsmul_PARM_2 + 2)
	lda	(_powf_PARM_2 + 3)
	sta	(___fsmul_PARM_2 + 3)
	jsr	___fsmul
	sta	(_expf_PARM_1 + 3)
	stx	(_expf_PARM_1 + 2)
	lda	*__ret2
	sta	(_expf_PARM_1 + 1)
	lda	*__ret3
	sta	_expf_PARM_1
	jsr	_expf
	sta	*(_powf_sloc1_1_0 + 3)
	stx	*(_powf_sloc1_1_0 + 2)
	mov	*__ret2,*(_powf_sloc1_1_0 + 1)
	mov	*__ret3,*_powf_sloc1_1_0
	mov	*_powf_sloc1_1_0,*__ret3
	mov	*(_powf_sloc1_1_0 + 1),*__ret2
	ldx	*(_powf_sloc1_1_0 + 2)
	lda	*(_powf_sloc1_1_0 + 3)
00107$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
