;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct 11 2015) (Linux)
; This file was generated Sun Oct 11 21:09:25 2015
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"coshf.c"
	list	p=16f877
	radix dec
	include "p16f877.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_sinf
	extern	_cosf
	extern	_tanf
	extern	_cotf
	extern	_asinf
	extern	_acosf
	extern	_atanf
	extern	_atan2f
	extern	_sinhf
	extern	_tanhf
	extern	_expf
	extern	_logf
	extern	_log10f
	extern	_powf
	extern	_sqrtf
	extern	_fabsf
	extern	_frexpf
	extern	_ldexpf
	extern	_ceilf
	extern	_floorf
	extern	_modff
	extern	_sincoshf

	extern PSAVE
	extern SSAVE
	extern WSAVE
	extern STK12
	extern STK11
	extern STK10
	extern STK09
	extern STK08
	extern STK07
	extern STK06
	extern STK05
	extern STK04
	extern STK03
	extern STK02
	extern STK01
	extern STK00
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_coshf

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_coshf_0	udata
r0x1003	res	1
r0x1002	res	1
r0x1001	res	1
r0x1000	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_coshf	code
;***
;  pBlock Stats: dbName = C
;***
;entry:  _coshf	;Function start
; 2 exit points
;has an exit
;functions called:
;   _sincoshf
;   _sincoshf
;9 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   STK01
;   r0x1002
;   STK02
;   r0x1003
;   STK04
;   STK03
;; Starting pCode block
;[ICODE] coshf.c:33:  _entry($2) :
;[ICODE] coshf.c:33: 	proc _coshf [k1 lr0:0 so:0]{ ia0 a2p0 re0 rm0 nos0 ru0 dp0}{float function    ( const-float fixed)  fixed}
_coshf	;Function start
; 2 exit points
;[ICODE] coshf.c:33: iTemp0 [k2 lr3:5 so:0]{ ia0 a2p0 re1 rm0 nos0 ru1 dp0}{const-float fixed}{ sir@ _coshf_x_1_1}[r0x1048 r0x1049 r0x104A r0x104B ] = recv _coshf [k1 lr0:0 so:0]{ ia0 a2p0 re0 rm0 nos0 ru0 dp0}{float function    ( const-float fixed)  fixed}
;	.line	33; "coshf.c"	float coshf(const float x) _MATH_REENTRANT
	BANKSEL	r0x1000
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
	MOVF	STK01,W
	MOVWF	r0x1002
	MOVF	STK02,W
	MOVWF	r0x1003
;[ICODE] coshf.c:35: 	send iTemp0 [k2 lr3:5 so:0]{ ia0 a2p0 re1 rm0 nos0 ru1 dp0}{const-float fixed}{ sir@ _coshf_x_1_1}[r0x1048 r0x1049 r0x104A r0x104B ]{argreg = 1}
;[ICODE] coshf.c:35: 	send 0x1 {const-int literal}{argreg = 1}
;[ICODE] coshf.c:35: 	iTemp1 [k7 lr6:7 so:0]{ ia0 a2p0 re0 rm0 nos0 ru1 dp0}{float fixed}[r0x1048 r0x1049 r0x104A r0x104B ] = call _sincoshf [k4 lr0:0 so:0]{ ia0 a2p0 re0 rm0 nos0 ru0 dp0}{float function    ( const-float fixed, const-int fixed)  fixed}
;	.line	35; "coshf.c"	return sincoshf(x, 1);
	MOVLW	0x01
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVF	r0x1003,W
	MOVWF	STK02
	MOVF	r0x1002,W
	MOVWF	STK01
	MOVF	r0x1001,W
	MOVWF	STK00
	MOVF	r0x1000,W
	PAGESEL	_sincoshf
	CALL	_sincoshf
	PAGESEL	$
	BANKSEL	r0x1000
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
	MOVF	STK01,W
	MOVWF	r0x1002
	MOVF	STK02,W
	MOVWF	r0x1003
	MOVWF	STK02
	MOVF	r0x1002,W
	MOVWF	STK01
	MOVF	r0x1001,W
	MOVWF	STK00
	MOVF	r0x1000,W
;[ICODE] coshf.c:35:  _return($1) :
;[ICODE] coshf.c:35: 	eproc _coshf [k1 lr0:0 so:0]{ ia0 a2p0 re0 rm0 nos0 ru0 dp0}{float function    ( const-float fixed)  fixed}
	RETURN	
; exit point of _coshf


;	code size estimation:
;	   33+    4 =    37 instructions (   82 byte)

	end
