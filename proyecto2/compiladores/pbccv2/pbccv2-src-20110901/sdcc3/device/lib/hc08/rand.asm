;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module rand
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
	.globl _rand
	.globl _srand
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
_rand_sloc0_1_0:
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
_next:
	.ds 4
;--------------------------------------------------------
; extended address mode data
;--------------------------------------------------------
	.area XSEG
_srand_seed_1_1:
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
;Allocation info for local variables in function 'rand'
;------------------------------------------------------------
;sloc0                     Allocated with name '_rand_sloc0_1_0'
;------------------------------------------------------------
;../rand.c:33: int rand(void)
;	-----------------------------------------
;	 function rand
;	-----------------------------------------
_rand:
;../rand.c:35: next = next * 1103515245UL + 12345;
	lda	#0x41
	sta	__mullong_PARM_1
	lda	#0xC6
	sta	(__mullong_PARM_1 + 1)
	lda	#0x4E
	sta	(__mullong_PARM_1 + 2)
	lda	#0x6D
	sta	(__mullong_PARM_1 + 3)
	lda	_next
	sta	__mullong_PARM_2
	lda	(_next + 1)
	sta	(__mullong_PARM_2 + 1)
	lda	(_next + 2)
	sta	(__mullong_PARM_2 + 2)
	lda	(_next + 3)
	sta	(__mullong_PARM_2 + 3)
	jsr	__mullong
	sta	*(_rand_sloc0_1_0 + 3)
	stx	*(_rand_sloc0_1_0 + 2)
	mov	*__ret2,*(_rand_sloc0_1_0 + 1)
	mov	*__ret3,*_rand_sloc0_1_0
	lda	*(_rand_sloc0_1_0 + 3)
	add	#0x39
	sta	(_next + 3)
	lda	*(_rand_sloc0_1_0 + 2)
	adc	#0x30
	sta	(_next + 2)
	lda	*(_rand_sloc0_1_0 + 1)
	adc	#0x00
	sta	(_next + 1)
	lda	*_rand_sloc0_1_0
	adc	#0x00
	sta	_next
;../rand.c:36: return (unsigned int)(next/65536) % (RAND_MAX + 1U);
	lda	(_next + 1)
	ldx	_next
	sta	*(_rand_sloc0_1_0 + 3)
	stx	*(_rand_sloc0_1_0 + 2)
	clr	*(_rand_sloc0_1_0 + 1)
	clr	*_rand_sloc0_1_0
	mov	*(_rand_sloc0_1_0 + 3),*(_rand_sloc0_1_0 + 1)
	mov	*(_rand_sloc0_1_0 + 2),*_rand_sloc0_1_0
	bclr	#7,*_rand_sloc0_1_0
	ldx	*_rand_sloc0_1_0
	lda	*(_rand_sloc0_1_0 + 1)
00101$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function 'srand'
;------------------------------------------------------------
;seed                      Allocated with name '_srand_seed_1_1'
;------------------------------------------------------------
;../rand.c:39: void srand(unsigned int seed)
;	-----------------------------------------
;	 function srand
;	-----------------------------------------
_srand:
	sta	(_srand_seed_1_1 + 1)
	stx	_srand_seed_1_1
;../rand.c:41: next = seed;
	lda	(_srand_seed_1_1 + 1)
	sta	(_next + 3)
	lda	_srand_seed_1_1
	sta	(_next + 2)
	clra
	sta	(_next + 1)
	sta	_next
00101$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
__xinit__next:
	.byte #0x00,#0x00,#0x00,#0x01	; 1
	.area CABS    (ABS,CODE)
