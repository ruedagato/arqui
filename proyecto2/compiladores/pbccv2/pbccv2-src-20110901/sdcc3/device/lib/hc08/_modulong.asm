;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _modulong
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
	.globl __modulong_PARM_2
	.globl __modulong_PARM_1
	.globl __modulong
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
__modulong_sloc0_1_0::
	.ds 1
__modulong_sloc1_1_0::
	.ds 1
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
__modulong_PARM_1:
	.ds 4
__modulong_PARM_2:
	.ds 4
__modulong_count_1_1:
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
;Allocation info for local variables in function '_modulong'
;------------------------------------------------------------
;a                         Allocated with name '__modulong_PARM_1'
;b                         Allocated with name '__modulong_PARM_2'
;count                     Allocated with name '__modulong_count_1_1'
;sloc0                     Allocated with name '__modulong_sloc0_1_0'
;sloc1                     Allocated with name '__modulong_sloc1_1_0'
;------------------------------------------------------------
;../_modulong.c:340: _modulong (unsigned long a, unsigned long b)
;	-----------------------------------------
;	 function _modulong
;	-----------------------------------------
__modulong:
;../_modulong.c:342: unsigned char count = 0;
	clra
	sta	__modulong_count_1_1
;../_modulong.c:344: while (!MSB_SET(b))
	clr	*__modulong_sloc0_1_0
00103$:
	lda	__modulong_PARM_2
	rola
	clra
	rola
	tsta
	bne	00117$
00120$:
;../_modulong.c:346: b <<= 1;
	lda	(__modulong_PARM_2 + 3)
	ldx	(__modulong_PARM_2 + 2)
	lsla
	rolx
	sta	(__modulong_PARM_2 + 3)
	stx	(__modulong_PARM_2 + 2)
	lda	(__modulong_PARM_2 + 1)
	ldx	__modulong_PARM_2
	rola
	rolx
	sta	(__modulong_PARM_2 + 1)
	stx	__modulong_PARM_2
;../_modulong.c:347: if (b > a)
	lda	(__modulong_PARM_1 + 3)
	sub	(__modulong_PARM_2 + 3)
	lda	(__modulong_PARM_1 + 2)
	sbc	(__modulong_PARM_2 + 2)
	lda	(__modulong_PARM_1 + 1)
	sbc	(__modulong_PARM_2 + 1)
	lda	__modulong_PARM_1
	sbc	__modulong_PARM_2
	bcc	00102$
00121$:
;../_modulong.c:349: b >>=1;
	lda	(__modulong_PARM_2 + 1)
	ldx	__modulong_PARM_2
	lsrx
	rora
	sta	(__modulong_PARM_2 + 1)
	stx	__modulong_PARM_2
	lda	(__modulong_PARM_2 + 3)
	ldx	(__modulong_PARM_2 + 2)
	rorx
	rora
	sta	(__modulong_PARM_2 + 3)
	stx	(__modulong_PARM_2 + 2)
;../_modulong.c:350: break;
	bra	00117$
00102$:
;../_modulong.c:352: count++;
	inc	*__modulong_sloc0_1_0
	lda	*__modulong_sloc0_1_0
	sta	__modulong_count_1_1
	jmp	00103$
;../_modulong.c:354: do
00117$:
	lda	__modulong_count_1_1
	sta	*__modulong_sloc0_1_0
00108$:
;../_modulong.c:356: if (a >= b)
	lda	(__modulong_PARM_1 + 3)
	sub	(__modulong_PARM_2 + 3)
	lda	(__modulong_PARM_1 + 2)
	sbc	(__modulong_PARM_2 + 2)
	lda	(__modulong_PARM_1 + 1)
	sbc	(__modulong_PARM_2 + 1)
	lda	__modulong_PARM_1
	sbc	__modulong_PARM_2
	bcs	00107$
00122$:
;../_modulong.c:357: a -= b;
	lda	(__modulong_PARM_1 + 3)
	sub	(__modulong_PARM_2 + 3)
	sta	(__modulong_PARM_1 + 3)
	lda	(__modulong_PARM_1 + 2)
	sbc	(__modulong_PARM_2 + 2)
	sta	(__modulong_PARM_1 + 2)
	lda	(__modulong_PARM_1 + 1)
	sbc	(__modulong_PARM_2 + 1)
	sta	(__modulong_PARM_1 + 1)
	lda	__modulong_PARM_1
	sbc	__modulong_PARM_2
	sta	__modulong_PARM_1
00107$:
;../_modulong.c:358: b >>= 1;
	lda	(__modulong_PARM_2 + 1)
	ldx	__modulong_PARM_2
	lsrx
	rora
	sta	(__modulong_PARM_2 + 1)
	stx	__modulong_PARM_2
	lda	(__modulong_PARM_2 + 3)
	ldx	(__modulong_PARM_2 + 2)
	rorx
	rora
	sta	(__modulong_PARM_2 + 3)
	stx	(__modulong_PARM_2 + 2)
;../_modulong.c:360: while (count--);
	mov	*__modulong_sloc0_1_0,*__modulong_sloc1_1_0
	dec	*__modulong_sloc0_1_0
	tst	*__modulong_sloc1_1_0
	bne	00108$
00123$:
;../_modulong.c:362: return a;
	lda	__modulong_PARM_1
	sta	*__ret3
	lda	(__modulong_PARM_1 + 1)
	sta	*__ret2
	ldx	(__modulong_PARM_1 + 2)
	lda	(__modulong_PARM_1 + 3)
00111$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
