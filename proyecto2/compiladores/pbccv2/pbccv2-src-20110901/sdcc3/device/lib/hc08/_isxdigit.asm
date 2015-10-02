;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _isxdigit
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
	.globl _isxdigit
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
_isxdigit_c_1_1:
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
;Allocation info for local variables in function 'isxdigit'
;------------------------------------------------------------
;c                         Allocated with name '_isxdigit_c_1_1'
;------------------------------------------------------------
;../_isxdigit.c:33: char isxdigit (unsigned char c)
;	-----------------------------------------
;	 function isxdigit
;	-----------------------------------------
_isxdigit:
	sta	_isxdigit_c_1_1
;../_isxdigit.c:35: if ( ( c >= UC('0') && c <= UC('9')) ||
	lda	_isxdigit_c_1_1
	cmp	#0x30
	bcs	00105$
00113$:
	lda	_isxdigit_c_1_1
	cmp	#0x39
	bls	00101$
00114$:
00105$:
;../_isxdigit.c:36: ( c >= UC('a') && c <= UC('f')) ||
	lda	_isxdigit_c_1_1
	cmp	#0x61
	bcs	00107$
00115$:
	lda	_isxdigit_c_1_1
	cmp	#0x66
	bls	00101$
00116$:
00107$:
;../_isxdigit.c:37: ( c >= UC('A') && c <= UC('F')) )
	lda	_isxdigit_c_1_1
	cmp	#0x41
	bcs	00102$
00117$:
	lda	_isxdigit_c_1_1
	cmp	#0x46
	bhi	00102$
00118$:
00101$:
;../_isxdigit.c:38: return 1;
	lda	#0x01
	rts
00102$:
;../_isxdigit.c:39: return 0;
	clra
00108$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)
