;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _strstr
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
	.globl _strstr_PARM_2
	.globl _strstr
;--------------------------------------------------------
;  ram data
;--------------------------------------------------------
	.area DSEG
;--------------------------------------------------------
; overlayable items in  ram 
;--------------------------------------------------------
	.area	OSEG    (OVR)
_strstr_sloc0_1_0::
	.ds 2
_strstr_sloc1_1_0::
	.ds 2
_strstr_sloc2_1_0::
	.ds 2
_strstr_sloc3_1_0::
	.ds 2
_strstr_sloc4_1_0::
	.ds 2
_strstr_sloc5_1_0::
	.ds 2
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
_strstr_PARM_2:
	.ds 2
_strstr_str1_1_1:
	.ds 2
_strstr_cp_1_1:
	.ds 2
_strstr_s2_1_1:
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
;Allocation info for local variables in function 'strstr'
;------------------------------------------------------------
;str2                      Allocated with name '_strstr_PARM_2'
;str1                      Allocated with name '_strstr_str1_1_1'
;cp                        Allocated with name '_strstr_cp_1_1'
;s1                        Allocated to registers 
;s2                        Allocated with name '_strstr_s2_1_1'
;sloc0                     Allocated with name '_strstr_sloc0_1_0'
;sloc1                     Allocated with name '_strstr_sloc1_1_0'
;sloc2                     Allocated with name '_strstr_sloc2_1_0'
;sloc3                     Allocated with name '_strstr_sloc3_1_0'
;sloc4                     Allocated with name '_strstr_sloc4_1_0'
;sloc5                     Allocated with name '_strstr_sloc5_1_0'
;------------------------------------------------------------
;../_strstr.c:31: char * strstr (
;	-----------------------------------------
;	 function strstr
;	-----------------------------------------
_strstr:
	sta	(_strstr_str1_1_1 + 1)
	stx	_strstr_str1_1_1
;../_strstr.c:36: const char * cp = str1;
	lda	_strstr_str1_1_1
	sta	_strstr_cp_1_1
	lda	(_strstr_str1_1_1 + 1)
	sta	(_strstr_cp_1_1 + 1)
;../_strstr.c:40: if ( !*str2 )
	lda	_strstr_PARM_2
	sta	*_strstr_sloc0_1_0
	lda	(_strstr_PARM_2 + 1)
	sta	*(_strstr_sloc0_1_0 + 1)
	ldhx	*_strstr_sloc0_1_0
	lda	,x
	bne	00122$
00124$:
;../_strstr.c:41: return str1;
	ldx	_strstr_str1_1_1
	lda	(_strstr_str1_1_1 + 1)
	rts
;../_strstr.c:43: while (*cp)
00122$:
	lda	_strstr_str1_1_1
	sta	*_strstr_sloc1_1_0
	lda	(_strstr_str1_1_1 + 1)
	sta	*(_strstr_sloc1_1_0 + 1)
00110$:
	ldhx	*_strstr_sloc1_1_0
	lda	,x
	bne	00125$
	jmp	00112$
00125$:
;../_strstr.c:46: s2 = str2;
	lda	*_strstr_sloc0_1_0
	sta	_strstr_s2_1_1
	lda	*(_strstr_sloc0_1_0 + 1)
	sta	(_strstr_s2_1_1 + 1)
;../_strstr.c:48: while ( *s1 && *s2 && !(*s1-*s2) )
	mov	*_strstr_sloc1_1_0,*_strstr_sloc2_1_0
	mov	*(_strstr_sloc1_1_0 + 1),*(_strstr_sloc2_1_0 + 1)
	lda	_strstr_s2_1_1
	sta	*_strstr_sloc3_1_0
	lda	(_strstr_s2_1_1 + 1)
	sta	*(_strstr_sloc3_1_0 + 1)
00105$:
	ldhx	*_strstr_sloc2_1_0
	lda	,x
	beq	00107$
00126$:
	ldhx	*_strstr_sloc3_1_0
	lda	,x
	beq	00107$
00127$:
	ldhx	*_strstr_sloc2_1_0
	lda	,x
	sta	*(_strstr_sloc4_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_strstr_sloc4_1_0
	ldhx	*_strstr_sloc3_1_0
	lda	,x
	sta	*(_strstr_sloc5_1_0 + 1)
	rola	
	clra	
	sbc	#0x00
	sta	*_strstr_sloc5_1_0
	lda	*(_strstr_sloc4_1_0 + 1)
	sub	*(_strstr_sloc5_1_0 + 1)
	sta	*(_strstr_sloc5_1_0 + 1)
	lda	*_strstr_sloc4_1_0
	sbc	*_strstr_sloc5_1_0
	sta	*_strstr_sloc5_1_0
	lda	*(_strstr_sloc5_1_0 + 1)
	ora	*_strstr_sloc5_1_0
	bne	00107$
00128$:
;../_strstr.c:49: s1++, s2++;
	ldhx	*_strstr_sloc2_1_0
	aix	#1
	sthx	*_strstr_sloc2_1_0
	ldhx	*_strstr_sloc3_1_0
	aix	#1
	sthx	*_strstr_sloc3_1_0
	bra	00105$
00107$:
;../_strstr.c:51: if (!*s2)
	ldhx	*_strstr_sloc3_1_0
	lda	,x
	bne	00109$
00129$:
;../_strstr.c:52: return( (char*)cp );
	ldx	_strstr_cp_1_1
	lda	(_strstr_cp_1_1 + 1)
	rts
00109$:
;../_strstr.c:54: cp++;
	ldhx	*_strstr_sloc1_1_0
	aix	#1
	sthx	*_strstr_sloc1_1_0
	lda	*_strstr_sloc1_1_0
	sta	_strstr_cp_1_1
	lda	*(_strstr_sloc1_1_0 + 1)
	sta	(_strstr_cp_1_1 + 1)
	jmp	00110$
00112$:
;../_strstr.c:57: return (NULL) ;
	clrx
	clra
00113$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
