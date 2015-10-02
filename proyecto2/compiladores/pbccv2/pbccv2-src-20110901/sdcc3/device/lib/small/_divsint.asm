;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:23 2015
;--------------------------------------------------------
	.module _divsint
	.optsdcc -mmcs51 --model-small
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	.area OSEG    (OVR,DATA)
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function '_divsint_dummy'
;------------------------------------------------------------
;------------------------------------------------------------
;	_divsint.c:57: _divsint_dummy (void) __naked
;	-----------------------------------------
;	 function _divsint_dummy
;	-----------------------------------------
__divsint_dummy:
;	naked function: no prologue.
;	_divsint.c:117: subb	a,xl
	
	
	
	
	
	 .globl __divsint
;	# 75 "_divsint.c"
	__divsint:
    ; dph in dph
    ; (__divsint_PARM_2 + 1) in (__divsint_PARM_2 + 1)
	
	 clr F0 ; Flag 0 in PSW
    ; available to user for general purpose
	 mov a,dph
	 jnb acc.7,a_not_negative
	
	 setb F0
	
	 clr a
	 clr c
	 subb a,dpl
	 mov dpl,a
	 clr a
	 subb a,dph
	 mov dph,a
	
	a_not_negative:
	
	 mov a,(__divsint_PARM_2 + 1)
	 jnb acc.7,b_not_negative
	
	 cpl F0
	
	 clr a
	 clr c
	 subb a,(__divsint_PARM_2)
	 mov (__divsint_PARM_2),a
	 clr a
	 subb a,(__divsint_PARM_2 + 1)
	 mov (__divsint_PARM_2 + 1),a
	
	b_not_negative:
	
	 lcall __divuint
	
	 jnb F0,not_negative
	
	 clr a
	 clr c
	 subb a,dpl
	 mov dpl,a
	 clr a
	 subb a,dph
	 mov dph,a
	
	not_negative:
	 ret
	
	 
;	naked function: no epilogue.
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
