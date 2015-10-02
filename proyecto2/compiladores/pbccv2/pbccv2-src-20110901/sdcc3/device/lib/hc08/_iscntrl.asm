;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:21 2015
;--------------------------------------------------------
	.module _iscntrl
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
	.globl _iscntrl
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
_iscntrl_c_1_1:
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
;Allocation info for local variables in function 'iscntrl'
;------------------------------------------------------------
;c                         Allocated with name '_iscntrl_c_1_1'
;------------------------------------------------------------
;../_iscntrl.c:31: char iscntrl (unsigned char c)
;	-----------------------------------------
;	 function iscntrl
;	-----------------------------------------
_iscntrl:
	sta	_iscntrl_c_1_1
;../_iscntrl.c:33: if  ( c <= 0x1F || c == 0x7f )
	lda	_iscntrl_c_1_1
	cmp	#0x1F
	bls	00101$
00107$:
	lda	_iscntrl_c_1_1
	cmp	#0x7F
	bne	00102$
00108$:
00101$:
;../_iscntrl.c:34: return 1;
	lda	#0x01
	rts
00102$:
;../_iscntrl.c:35: return 0;
	clra
00104$:
	rts
	.area CSEG (CODE)
	.area CONST   (CODE)
	.area XINIT
	.area CABS    (ABS,CODE)