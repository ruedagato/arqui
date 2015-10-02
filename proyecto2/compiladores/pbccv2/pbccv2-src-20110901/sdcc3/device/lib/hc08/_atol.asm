;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _atol
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
	.globl _atol
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_atol_rv_1_1:
	.ds 4
_atol_sign_1_1:
	.ds 1
_atol_sloc0_1_0:
	.ds 2
_atol_sloc1_1_0:
	.ds 4
_atol_sloc2_1_0:
	.ds 2
_atol_sloc3_1_0:
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
_atol_s_1_1:
	.ds 2
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
;Allocation info for local variables in function 'atol'
;------------------------------------------------------------
;rv                        Allocated with name '_atol_rv_1_1'
;sign                      Allocated with name '_atol_sign_1_1'
;sloc0                     Allocated with name '_atol_sloc0_1_0'
;sloc1                     Allocated with name '_atol_sloc1_1_0'
;sloc2                     Allocated with name '_atol_sloc2_1_0'
;sloc3                     Allocated with name '_atol_sloc3_1_0'
;s                         Allocated with name '_atol_s_1_1'
;------------------------------------------------------------
;../_atol.c:29: long atol(char * s)
;	-----------------------------------------
;	 function atol
;	-----------------------------------------
_atol:
	sta	(_atol_s_1_1 + 1)
	stx	_atol_s_1_1
;../_atol.c:31: register long rv=0; 
	clr	*_atol_rv_1_1
	clr	*(_atol_rv_1_1 + 1)
	clr	*(_atol_rv_1_1 + 2)
	clr	*(_atol_rv_1_1 + 3)
;../_atol.c:35: while (*s) {
	lda	_atol_s_1_1
	sta	*_atol_sloc0_1_0
	lda	(_atol_s_1_1 + 1)
	sta	*(_atol_sloc0_1_0 + 1)
00107$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	beq	00133$
00135$:
;../_atol.c:36: if (*s <= '9' && *s >= '0')
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x39
	bgt	00102$
00136$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x30
	bge	00133$
00137$:
;../_atol.c:37: break;
00102$:
;../_atol.c:38: if (*s == '-' || *s == '+') 
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x2D
	beq	00133$
00138$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x2B
	beq	00133$
00139$:
;../_atol.c:40: s++;
	ldhx	*_atol_sloc0_1_0
	aix	#1
	sthx	*_atol_sloc0_1_0
	bra	00107$
00133$:
	lda	*_atol_sloc0_1_0
	sta	_atol_s_1_1
	lda	*(_atol_sloc0_1_0 + 1)
	sta	(_atol_s_1_1 + 1)
;../_atol.c:43: sign = (*s == '-');
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x2D
	beq	00141$
	clra
	bra	00140$
00141$:
	lda	#0x01
00140$:
	sta	*_atol_sign_1_1
;../_atol.c:44: if (*s == '-' || *s == '+') s++;
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x2D
	beq	00110$
00142$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x2B
	bne	00131$
00143$:
00110$:
	lda	(_atol_s_1_1 + 1)
	inca
	sta	(_atol_s_1_1 + 1)
	bne	00144$
	lda	_atol_s_1_1
	inca
	sta	_atol_s_1_1
00144$:
;../_atol.c:46: while (*s && *s >= '0' && *s <= '9') {
00131$:
	lda	_atol_s_1_1
	sta	*_atol_sloc0_1_0
	lda	(_atol_s_1_1 + 1)
	sta	*(_atol_sloc0_1_0 + 1)
00115$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	bne	00145$
	jmp	00117$
00145$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x30
	bge	00146$
	jmp	00117$
00146$:
	ldhx	*_atol_sloc0_1_0
	lda	,x
	cmp	#0x39
	ble	00147$
	jmp	00117$
00147$:
;../_atol.c:47: rv = (rv * 10) + (*s - '0');
	clra
	sta	__mullong_PARM_1
	sta	(__mullong_PARM_1 + 1)
	sta	(__mullong_PARM_1 + 2)
	lda	#0x0A
	sta	(__mullong_PARM_1 + 3)
	lda	*_atol_rv_1_1
	sta	__mullong_PARM_2
	lda	*(_atol_rv_1_1 + 1)
	sta	(__mullong_PARM_2 + 1)
	lda	*(_atol_rv_1_1 + 2)
	sta	(__mullong_PARM_2 + 2)
	lda	*(_atol_rv_1_1 + 3)
	sta	(__mullong_PARM_2 + 3)
	jsr	__mullong
	sta	*(_atol_sloc1_1_0 + 3)
	stx	*(_atol_sloc1_1_0 + 2)
	mov	*__ret2,*(_atol_sloc1_1_0 + 1)
	mov	*__ret3,*_atol_sloc1_1_0
	ldhx	*_atol_sloc0_1_0
	lda	,x
	aix	#1
	sthx	*_atol_sloc0_1_0
	sta	*(_atol_sloc2_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_atol_sloc2_1_0
	lda	*(_atol_sloc2_1_0 + 1)
	sub	#0x30
	sta	*(_atol_sloc2_1_0 + 1)
	lda	*_atol_sloc2_1_0
	sbc	#0x00
	sta	*_atol_sloc2_1_0
	mov	*(_atol_sloc2_1_0 + 1),*(_atol_sloc3_1_0 + 3)
	mov	*_atol_sloc2_1_0,*(_atol_sloc3_1_0 + 2)
	lda	*_atol_sloc2_1_0
	rola	
	clra	
	sbc	#0x00
	sta	*(_atol_sloc3_1_0 + 1)
	sta	*_atol_sloc3_1_0
	lda	*(_atol_sloc1_1_0 + 3)
	add	*(_atol_sloc3_1_0 + 3)
	sta	*(_atol_rv_1_1 + 3)
	lda	*(_atol_sloc1_1_0 + 2)
	adc	*(_atol_sloc3_1_0 + 2)
	sta	*(_atol_rv_1_1 + 2)
	lda	*(_atol_sloc1_1_0 + 1)
	adc	*(_atol_sloc3_1_0 + 1)
	sta	*(_atol_rv_1_1 + 1)
	lda	*_atol_sloc1_1_0
	adc	*_atol_sloc3_1_0
	sta	*_atol_rv_1_1
;../_atol.c:48: s++;
	jmp	00115$
00117$:
;../_atol.c:51: return (sign ? -rv : rv);
	tst	*_atol_sign_1_1
	beq	00120$
00148$:
	clra
	sub	*(_atol_rv_1_1 + 3)
	sta	*(_atol_sloc3_1_0 + 3)
	clra
	sbc	*(_atol_rv_1_1 + 2)
	sta	*(_atol_sloc3_1_0 + 2)
	clra
	sbc	*(_atol_rv_1_1 + 1)
	sta	*(_atol_sloc3_1_0 + 1)
	clra
	sbc	*_atol_rv_1_1
	sta	*_atol_sloc3_1_0
	bra	00121$
00120$:
	mov	*_atol_rv_1_1,*_atol_sloc3_1_0
	mov	*(_atol_rv_1_1 + 1),*(_atol_sloc3_1_0 + 1)
	mov	*(_atol_rv_1_1 + 2),*(_atol_sloc3_1_0 + 2)
	mov	*(_atol_rv_1_1 + 3),*(_atol_sloc3_1_0 + 3)
00121$:
	mov	*_atol_sloc3_1_0,*__ret3
	mov	*(_atol_sloc3_1_0 + 1),*__ret2
	ldx	*(_atol_sloc3_1_0 + 2)
	lda	*(_atol_sloc3_1_0 + 3)
00118$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
