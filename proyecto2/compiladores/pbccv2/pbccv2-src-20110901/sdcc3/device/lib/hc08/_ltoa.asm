;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:22 2015
;--------------------------------------------------------
	.module _ltoa
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
	.globl __ltoa
	.globl __ultoa
	.globl __ltoa_PARM_3
	.globl __ltoa_PARM_2
	.globl __ltoa_PARM_1
	.globl __ultoa_PARM_3
	.globl __ultoa_PARM_2
	.globl __ultoa_PARM_1
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
__ultoa_sloc0_1_0:
	.ds 1
__ultoa_sloc1_1_0:
	.ds 4
__ultoa_sloc2_1_0:
	.ds 2
__ltoa_sloc0_1_0:
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
__ultoa_PARM_1:
	.ds 4
__ultoa_PARM_2:
	.ds 2
__ultoa_PARM_3:
	.ds 1
__ultoa_buffer_1_1:
	.ds 32
__ultoa_c_2_2:
	.ds 1
__ltoa_PARM_1:
	.ds 4
__ltoa_PARM_2:
	.ds 2
__ltoa_PARM_3:
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
;Allocation info for local variables in function '_ultoa'
;------------------------------------------------------------
;sloc0                     Allocated with name '__ultoa_sloc0_1_0'
;sloc1                     Allocated with name '__ultoa_sloc1_1_0'
;sloc2                     Allocated with name '__ultoa_sloc2_1_0'
;value                     Allocated with name '__ultoa_PARM_1'
;string                    Allocated with name '__ultoa_PARM_2'
;radix                     Allocated with name '__ultoa_PARM_3'
;buffer                    Allocated with name '__ultoa_buffer_1_1'
;index                     Allocated to registers 
;c                         Allocated with name '__ultoa_c_2_2'
;------------------------------------------------------------
;../_ltoa.c:56: void _ultoa(unsigned long value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _ultoa
;	-----------------------------------------
__ultoa:
;../_ltoa.c:61: do {
	mov	#0x20,*__ultoa_sloc0_1_0
00103$:
;../_ltoa.c:62: unsigned char c = '0' + (value % radix);
	lda	__ultoa_PARM_3
	sta	(__modulong_PARM_2 + 3)
	clra
	sta	(__modulong_PARM_2 + 2)
	sta	(__modulong_PARM_2 + 1)
	sta	__modulong_PARM_2
	lda	__ultoa_PARM_1
	sta	__modulong_PARM_1
	lda	(__ultoa_PARM_1 + 1)
	sta	(__modulong_PARM_1 + 1)
	lda	(__ultoa_PARM_1 + 2)
	sta	(__modulong_PARM_1 + 2)
	lda	(__ultoa_PARM_1 + 3)
	sta	(__modulong_PARM_1 + 3)
	jsr	__modulong
	sta	*(__ultoa_sloc1_1_0 + 3)
	stx	*(__ultoa_sloc1_1_0 + 2)
	mov	*__ret2,*(__ultoa_sloc1_1_0 + 1)
	mov	*__ret3,*__ultoa_sloc1_1_0
	lda	*(__ultoa_sloc1_1_0 + 3)
	add	#0x30
	sta	__ultoa_c_2_2
;../_ltoa.c:63: if (c > (unsigned char)'9')
	lda	__ultoa_c_2_2
	cmp	#0x39
	bls	00102$
00117$:
;../_ltoa.c:64: c += 'A' - '9' - 1;
	lda	__ultoa_c_2_2
	add	#0x07
	sta	__ultoa_c_2_2
00102$:
;../_ltoa.c:65: buffer[--index] = c;
	dec	*__ultoa_sloc0_1_0
	ldx	*__ultoa_sloc0_1_0
	clrh
	lda	__ultoa_c_2_2
	sta	__ultoa_buffer_1_1,x
;../_ltoa.c:66: value /= radix;
	lda	__ultoa_PARM_3
	sta	(__divulong_PARM_2 + 3)
	clra
	sta	(__divulong_PARM_2 + 2)
	sta	(__divulong_PARM_2 + 1)
	sta	__divulong_PARM_2
	lda	__ultoa_PARM_1
	sta	__divulong_PARM_1
	lda	(__ultoa_PARM_1 + 1)
	sta	(__divulong_PARM_1 + 1)
	lda	(__ultoa_PARM_1 + 2)
	sta	(__divulong_PARM_1 + 2)
	lda	(__ultoa_PARM_1 + 3)
	sta	(__divulong_PARM_1 + 3)
	jsr	__divulong
	sta	(__ultoa_PARM_1 + 3)
	stx	(__ultoa_PARM_1 + 2)
	lda	*__ret2
	sta	(__ultoa_PARM_1 + 1)
	lda	*__ret3
	sta	__ultoa_PARM_1
;../_ltoa.c:67: } while (value);
	lda	(__ultoa_PARM_1 + 3)
	ora	(__ultoa_PARM_1 + 2)
	ora	(__ultoa_PARM_1 + 1)
	ora	__ultoa_PARM_1
	beq	00118$
	jmp	00103$
00118$:
;../_ltoa.c:69: do {
	lda	__ultoa_PARM_2
	sta	*__ultoa_sloc1_1_0
	lda	(__ultoa_PARM_2 + 1)
	sta	*(__ultoa_sloc1_1_0 + 1)
00106$:
;../_ltoa.c:70: *string++ = buffer[index];
	ldx	*__ultoa_sloc0_1_0
	clrh
	lda	__ultoa_buffer_1_1,x
	ldhx	*__ultoa_sloc1_1_0
	sta	,x
	aix	#1
	sthx	*__ultoa_sloc1_1_0
;../_ltoa.c:71: } while ( ++index != NUMBER_OF_DIGITS );
	inc	*__ultoa_sloc0_1_0
	lda	*__ultoa_sloc0_1_0
	cmp	#0x20
	bne	00106$
00119$:
;../_ltoa.c:73: *string = 0;  /* string terminator */
	ldhx	*__ultoa_sloc1_1_0
	clra
	sta	,x
00109$:
	rts
;------------------------------------------------------------
;Allocation info for local variables in function '_ltoa'
;------------------------------------------------------------
;sloc0                     Allocated with name '__ltoa_sloc0_1_0'
;value                     Allocated with name '__ltoa_PARM_1'
;string                    Allocated with name '__ltoa_PARM_2'
;radix                     Allocated with name '__ltoa_PARM_3'
;------------------------------------------------------------
;../_ltoa.c:76: void _ltoa(long value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _ltoa
;	-----------------------------------------
__ltoa:
;../_ltoa.c:78: if (value < 0 && radix == 10) {
	lda	__ltoa_PARM_1
	sub	#0x00
	bge	00102$
00108$:
	lda	__ltoa_PARM_3
	cmp	#0x0A
	bne	00102$
00109$:
;../_ltoa.c:79: *string++ = '-';
	lda	__ltoa_PARM_2
	sta	*__ltoa_sloc0_1_0
	lda	(__ltoa_PARM_2 + 1)
	sta	*(__ltoa_sloc0_1_0 + 1)
	ldhx	*__ltoa_sloc0_1_0
	lda	#0x2D
	sta	,x
	lda	*(__ltoa_sloc0_1_0 + 1)
	add	#0x01
	sta	(__ltoa_PARM_2 + 1)
	lda	*__ltoa_sloc0_1_0
	adc	#0x00
	sta	__ltoa_PARM_2
;../_ltoa.c:80: value = -value;
	clra
	sub	(__ltoa_PARM_1 + 3)
	sta	(__ltoa_PARM_1 + 3)
	clra
	sbc	(__ltoa_PARM_1 + 2)
	sta	(__ltoa_PARM_1 + 2)
	clra
	sbc	(__ltoa_PARM_1 + 1)
	sta	(__ltoa_PARM_1 + 1)
	clra
	sbc	__ltoa_PARM_1
	sta	__ltoa_PARM_1
00102$:
;../_ltoa.c:82: _ultoa(value, string, radix);
	lda	__ltoa_PARM_1
	sta	__ultoa_PARM_1
	lda	(__ltoa_PARM_1 + 1)
	sta	(__ultoa_PARM_1 + 1)
	lda	(__ltoa_PARM_1 + 2)
	sta	(__ultoa_PARM_1 + 2)
	lda	(__ltoa_PARM_1 + 3)
	sta	(__ultoa_PARM_1 + 3)
	lda	__ltoa_PARM_2
	sta	__ultoa_PARM_2
	lda	(__ltoa_PARM_2 + 1)
	sta	(__ultoa_PARM_2 + 1)
	lda	__ltoa_PARM_3
	sta	__ultoa_PARM_3
	jsr	__ultoa
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
