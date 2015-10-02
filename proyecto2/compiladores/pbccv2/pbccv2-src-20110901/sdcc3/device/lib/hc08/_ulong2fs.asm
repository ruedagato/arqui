;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _ulong2fs
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
	.globl ___ulong2fs_PARM_1
	.globl ___ulong2fs
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
___ulong2fs_sloc0_1_0::
	.ds 2
___ulong2fs_sloc1_1_0::
	.ds 4
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
___ulong2fs_PARM_1:
	.ds 4
___ulong2fs_exp_1_1:
	.ds 2
___ulong2fs_fl_1_1:
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
;Allocation info for local variables in function '__ulong2fs'
;------------------------------------------------------------
;a                         Allocated with name '___ulong2fs_PARM_1'
;exp                       Allocated with name '___ulong2fs_exp_1_1'
;fl                        Allocated with name '___ulong2fs_fl_1_1'
;sloc0                     Allocated with name '___ulong2fs_sloc0_1_0'
;sloc1                     Allocated with name '___ulong2fs_sloc1_1_0'
;------------------------------------------------------------
;../_ulong2fs.c:83: float __ulong2fs (unsigned long a )
;	-----------------------------------------
;	 function __ulong2fs
;	-----------------------------------------
___ulong2fs:
;../_ulong2fs.c:88: if (!a)
	lda	(___ulong2fs_PARM_1 + 3)
	ora	(___ulong2fs_PARM_1 + 2)
	ora	(___ulong2fs_PARM_1 + 1)
	ora	___ulong2fs_PARM_1
	bne	00115$
00121$:
;../_ulong2fs.c:90: return 0.0;
	clr	*__ret3
	clr	*__ret2
	clrx
	clra
	rts
;../_ulong2fs.c:93: while (a & NORM) 
00115$:
	clr	*___ulong2fs_sloc0_1_0
	mov	#0x96,*(___ulong2fs_sloc0_1_0 + 1)
00103$:
	lda	___ulong2fs_PARM_1
	beq	00117$
00122$:
;../_ulong2fs.c:96: a >>= 1;
	lda	(___ulong2fs_PARM_1 + 1)
	ldx	___ulong2fs_PARM_1
	lsrx
	rora
	sta	(___ulong2fs_PARM_1 + 1)
	stx	___ulong2fs_PARM_1
	lda	(___ulong2fs_PARM_1 + 3)
	ldx	(___ulong2fs_PARM_1 + 2)
	rorx
	rora
	sta	(___ulong2fs_PARM_1 + 3)
	stx	(___ulong2fs_PARM_1 + 2)
;../_ulong2fs.c:97: exp++;
	ldhx	*___ulong2fs_sloc0_1_0
	aix	#1
	sthx	*___ulong2fs_sloc0_1_0
	bra	00103$
;../_ulong2fs.c:100: while (a < HIDDEN)
00117$:
00106$:
	lda	(___ulong2fs_PARM_1 + 1)
	sub	#0x80
	lda	___ulong2fs_PARM_1
	sbc	#0x00
	bcc	00120$
00123$:
;../_ulong2fs.c:102: a <<= 1;
	lda	(___ulong2fs_PARM_1 + 3)
	ldx	(___ulong2fs_PARM_1 + 2)
	lsla
	rolx
	sta	(___ulong2fs_PARM_1 + 3)
	stx	(___ulong2fs_PARM_1 + 2)
	lda	(___ulong2fs_PARM_1 + 1)
	ldx	___ulong2fs_PARM_1
	rola
	rolx
	sta	(___ulong2fs_PARM_1 + 1)
	stx	___ulong2fs_PARM_1
;../_ulong2fs.c:103: exp--;
	lda	*(___ulong2fs_sloc0_1_0 + 1)
	sub	#0x01
	sta	*(___ulong2fs_sloc0_1_0 + 1)
	lda	*___ulong2fs_sloc0_1_0
	sbc	#0x00
	sta	*___ulong2fs_sloc0_1_0
	bra	00106$
00120$:
	lda	*___ulong2fs_sloc0_1_0
	sta	___ulong2fs_exp_1_1
	lda	*(___ulong2fs_sloc0_1_0 + 1)
	sta	(___ulong2fs_exp_1_1 + 1)
;../_ulong2fs.c:107: if ((a&0x7fffff)==0x7fffff) {
	lda	(___ulong2fs_PARM_1 + 3)
	sta	*(___ulong2fs_sloc1_1_0 + 3)
	lda	(___ulong2fs_PARM_1 + 2)
	sta	*(___ulong2fs_sloc1_1_0 + 2)
	lda	(___ulong2fs_PARM_1 + 1)
	and	#0x7F
	sta	*(___ulong2fs_sloc1_1_0 + 1)
	clr	*___ulong2fs_sloc1_1_0
	lda	*(___ulong2fs_sloc1_1_0 + 3)
	cmp	#0xFF
	bne	00124$
	lda	*(___ulong2fs_sloc1_1_0 + 2)
	cmp	#0xFF
	bne	00124$
	lda	*(___ulong2fs_sloc1_1_0 + 1)
	cmp	#0x7F
	bne	00124$
	lda	*___ulong2fs_sloc1_1_0
	cmp	#0x00
	beq	00125$
00124$:
	bra	00110$
00125$:
;../_ulong2fs.c:108: a=0;
	clra
	sta	___ulong2fs_PARM_1
	sta	(___ulong2fs_PARM_1 + 1)
	sta	(___ulong2fs_PARM_1 + 2)
	sta	(___ulong2fs_PARM_1 + 3)
;../_ulong2fs.c:109: exp++;
	lda	*(___ulong2fs_sloc0_1_0 + 1)
	add	#0x01
	sta	(___ulong2fs_exp_1_1 + 1)
	lda	*___ulong2fs_sloc0_1_0
	adc	#0x00
	sta	___ulong2fs_exp_1_1
00110$:
;../_ulong2fs.c:113: a &= ~HIDDEN ;
	lda	(___ulong2fs_PARM_1 + 1)
	and	#0x7F
	sta	(___ulong2fs_PARM_1 + 1)
;../_ulong2fs.c:115: fl.l = PACK(0,(unsigned long)exp, a);
	lda	(___ulong2fs_exp_1_1 + 1)
	sta	*(___ulong2fs_sloc1_1_0 + 3)
	lda	___ulong2fs_exp_1_1
	sta	*(___ulong2fs_sloc1_1_0 + 2)
	lda	___ulong2fs_exp_1_1
	rola	
	clra	
	sbc	#0x00
	sta	*(___ulong2fs_sloc1_1_0 + 1)
	sta	*___ulong2fs_sloc1_1_0
	lda	*(___ulong2fs_sloc1_1_0 + 3)
	ldx	*(___ulong2fs_sloc1_1_0 + 2)
	lsrx
	rora
	tax
	clra
	rora
	sta	*(___ulong2fs_sloc1_1_0 + 1)
	stx	*___ulong2fs_sloc1_1_0
	clr	*(___ulong2fs_sloc1_1_0 + 3)
	clr	*(___ulong2fs_sloc1_1_0 + 2)
	lda	*(___ulong2fs_sloc1_1_0 + 3)
	ora	(___ulong2fs_PARM_1 + 3)
	sta	*(___ulong2fs_sloc1_1_0 + 3)
	lda	*(___ulong2fs_sloc1_1_0 + 2)
	ora	(___ulong2fs_PARM_1 + 2)
	sta	*(___ulong2fs_sloc1_1_0 + 2)
	lda	*(___ulong2fs_sloc1_1_0 + 1)
	ora	(___ulong2fs_PARM_1 + 1)
	sta	*(___ulong2fs_sloc1_1_0 + 1)
	lda	*___ulong2fs_sloc1_1_0
	ora	___ulong2fs_PARM_1
	sta	*___ulong2fs_sloc1_1_0
	lda	*___ulong2fs_sloc1_1_0
	sta	___ulong2fs_fl_1_1
	lda	*(___ulong2fs_sloc1_1_0 + 1)
	sta	(___ulong2fs_fl_1_1 + 1)
	lda	*(___ulong2fs_sloc1_1_0 + 2)
	sta	(___ulong2fs_fl_1_1 + 2)
	lda	*(___ulong2fs_sloc1_1_0 + 3)
	sta	(___ulong2fs_fl_1_1 + 3)
;../_ulong2fs.c:117: return (fl.f);
	lda	___ulong2fs_fl_1_1
	sta	*___ulong2fs_sloc1_1_0
	lda	(___ulong2fs_fl_1_1 + 1)
	sta	*(___ulong2fs_sloc1_1_0 + 1)
	lda	(___ulong2fs_fl_1_1 + 2)
	sta	*(___ulong2fs_sloc1_1_0 + 2)
	lda	(___ulong2fs_fl_1_1 + 3)
	sta	*(___ulong2fs_sloc1_1_0 + 3)
	mov	*___ulong2fs_sloc1_1_0,*__ret3
	mov	*(___ulong2fs_sloc1_1_0 + 1),*__ret2
	ldx	*(___ulong2fs_sloc1_1_0 + 2)
	lda	*(___ulong2fs_sloc1_1_0 + 3)
00111$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
