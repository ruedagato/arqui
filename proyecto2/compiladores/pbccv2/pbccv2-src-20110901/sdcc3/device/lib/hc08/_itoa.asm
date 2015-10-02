;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module _itoa
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
	.globl __itoa
	.globl __uitoa
	.globl __itoa_PARM_3
	.globl __itoa_PARM_2
	.globl __uitoa_PARM_3
	.globl __uitoa_PARM_2
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
__uitoa_sloc0_1_0:
	.ds 1
__uitoa_sloc1_1_0:
	.ds 2
__uitoa_sloc2_1_0:
	.ds 2
__uitoa_sloc3_1_0:
	.ds 2
__uitoa_sloc4_1_0:
	.ds 2
__itoa_sloc0_1_0:
	.ds 2
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
__uitoa_PARM_2:
	.ds 2
__uitoa_PARM_3:
	.ds 1
__uitoa_value_1_1:
	.ds 2
__uitoa_index_1_1:
	.ds 1
__uitoa_tmp_2_3:
	.ds 1
__itoa_PARM_2:
	.ds 2
__itoa_PARM_3:
	.ds 1
__itoa_value_1_1:
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
;Allocation info for local variables in function '_uitoa'
;------------------------------------------------------------
;sloc0                     Allocated with name '__uitoa_sloc0_1_0'
;sloc1                     Allocated with name '__uitoa_sloc1_1_0'
;sloc2                     Allocated with name '__uitoa_sloc2_1_0'
;sloc3                     Allocated with name '__uitoa_sloc3_1_0'
;sloc4                     Allocated with name '__uitoa_sloc4_1_0'
;string                    Allocated with name '__uitoa_PARM_2'
;radix                     Allocated with name '__uitoa_PARM_3'
;value                     Allocated with name '__uitoa_value_1_1'
;index                     Allocated with name '__uitoa_index_1_1'
;i                         Allocated to registers 
;tmp                       Allocated with name '__uitoa_tmp_2_3'
;------------------------------------------------------------
;../_itoa.c:40: void _uitoa(unsigned int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _uitoa
;	-----------------------------------------
__uitoa:
	sta	(__uitoa_value_1_1 + 1)
	stx	__uitoa_value_1_1
;../_itoa.c:45: do {
	clr	*__uitoa_sloc0_1_0
00103$:
;../_itoa.c:46: string[index] = '0' + (value % radix);
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc0_1_0
	sta	*(__uitoa_sloc1_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc1_1_0
	lda	__uitoa_PARM_3
	sta	(__moduint_PARM_2 + 1)
	clra
	sta	__moduint_PARM_2
	ldx	__uitoa_value_1_1
	lda	(__uitoa_value_1_1 + 1)
	jsr	__moduint
	sta	*(__uitoa_sloc2_1_0 + 1)
	stx	*__uitoa_sloc2_1_0
	lda	*(__uitoa_sloc2_1_0 + 1)
	add	#0x30
	ldhx	*__uitoa_sloc1_1_0
	sta	,x
;../_itoa.c:47: if (string[index] > '9')
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc0_1_0
	sta	*(__uitoa_sloc2_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc2_1_0
	ldhx	*__uitoa_sloc2_1_0
	lda	,x
	cmp	#0x39
	ble	00102$
00118$:
;../_itoa.c:48: string[index] += 'A' - '9' - 1;
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc0_1_0
	sta	*(__uitoa_sloc2_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc2_1_0
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc0_1_0
	sta	*(__uitoa_sloc1_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc1_1_0
	ldhx	*__uitoa_sloc1_1_0
	lda	,x
	add	#0x07
	ldhx	*__uitoa_sloc2_1_0
	sta	,x
00102$:
;../_itoa.c:49: value /= radix;
	lda	__uitoa_PARM_3
	sta	(__divuint_PARM_2 + 1)
	clra
	sta	__divuint_PARM_2
	ldx	__uitoa_value_1_1
	lda	(__uitoa_value_1_1 + 1)
	jsr	__divuint
	sta	(__uitoa_value_1_1 + 1)
	stx	__uitoa_value_1_1
;../_itoa.c:50: ++index;
	inc	*__uitoa_sloc0_1_0
;../_itoa.c:51: } while (value != 0);
	lda	(__uitoa_value_1_1 + 1)
	ora	__uitoa_value_1_1
	beq	00119$
	jmp	00103$
00119$:
;../_itoa.c:54: string[index--] = '\0';
	lda	*__uitoa_sloc0_1_0
	sub	#0x01
	sta	__uitoa_index_1_1
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc0_1_0
	sta	*(__uitoa_sloc2_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc2_1_0
	ldhx	*__uitoa_sloc2_1_0
	clra
	sta	,x
;../_itoa.c:57: while (index > i) {
	clr	*__uitoa_sloc2_1_0
	lda	__uitoa_index_1_1
	sta	*__uitoa_sloc1_1_0
00106$:
	lda	*__uitoa_sloc1_1_0
	cmp	*__uitoa_sloc2_1_0
	ble	00109$
00120$:
;../_itoa.c:58: char tmp = string[i];
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc2_1_0
	sta	*(__uitoa_sloc3_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc3_1_0
	ldhx	*__uitoa_sloc3_1_0
	lda	,x
	sta	__uitoa_tmp_2_3
;../_itoa.c:59: string[i] = string[index];
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc2_1_0
	sta	*(__uitoa_sloc3_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc3_1_0
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc1_1_0
	sta	*(__uitoa_sloc4_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc4_1_0
	ldhx	*__uitoa_sloc4_1_0
	lda	,x
	ldhx	*__uitoa_sloc3_1_0
	sta	,x
;../_itoa.c:60: string[index] = tmp;
	lda	(__uitoa_PARM_2 + 1)
	add	*__uitoa_sloc1_1_0
	sta	*(__uitoa_sloc4_1_0 + 1)
	lda	__uitoa_PARM_2
	adc	#0x00
	sta	*__uitoa_sloc4_1_0
	ldhx	*__uitoa_sloc4_1_0
	lda	__uitoa_tmp_2_3
	sta	,x
;../_itoa.c:61: ++i;
	inc	*__uitoa_sloc2_1_0
;../_itoa.c:62: --index;
	dec	*__uitoa_sloc1_1_0
	bra	00106$
00109$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function '_itoa'
;------------------------------------------------------------
;sloc0                     Allocated with name '__itoa_sloc0_1_0'
;string                    Allocated with name '__itoa_PARM_2'
;radix                     Allocated with name '__itoa_PARM_3'
;value                     Allocated with name '__itoa_value_1_1'
;------------------------------------------------------------
;../_itoa.c:66: void _itoa(int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _itoa
;	-----------------------------------------
__itoa:
	sta	(__itoa_value_1_1 + 1)
	stx	__itoa_value_1_1
;../_itoa.c:68: if (value < 0 && radix == 10) {
	lda	__itoa_value_1_1
	sub	#0x00
	bge	00102$
00108$:
	lda	__itoa_PARM_3
	cmp	#0x0A
	bne	00102$
00109$:
;../_itoa.c:69: *string++ = '-';
	lda	__itoa_PARM_2
	sta	*__itoa_sloc0_1_0
	lda	(__itoa_PARM_2 + 1)
	sta	*(__itoa_sloc0_1_0 + 1)
	ldhx	*__itoa_sloc0_1_0
	lda	#0x2D
	sta	,x
	lda	*(__itoa_sloc0_1_0 + 1)
	add	#0x01
	sta	(__itoa_PARM_2 + 1)
	lda	*__itoa_sloc0_1_0
	adc	#0x00
	sta	__itoa_PARM_2
;../_itoa.c:70: value = -value;
	clra
	sub	(__itoa_value_1_1 + 1)
	sta	(__itoa_value_1_1 + 1)
	clra
	sbc	__itoa_value_1_1
	sta	__itoa_value_1_1
00102$:
;../_itoa.c:72: _uitoa(value, string, radix);
	lda	__itoa_PARM_2
	sta	__uitoa_PARM_2
	lda	(__itoa_PARM_2 + 1)
	sta	(__uitoa_PARM_2 + 1)
	lda	__itoa_PARM_3
	sta	__uitoa_PARM_3
	ldx	__itoa_value_1_1
	lda	(__itoa_value_1_1 + 1)
	jsr	__uitoa
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
