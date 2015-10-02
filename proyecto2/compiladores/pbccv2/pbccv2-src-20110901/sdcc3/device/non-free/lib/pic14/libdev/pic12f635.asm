;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6064 (Nov 21 2010) (Linux)
; This file was generated Sun Nov 21 16:03:10 2010
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"pic12f635.c"
	list	p=12f635
	radix dec
	include "p12f635.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------

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
	global	_CMCON0_bits
	global	_CMCON1_bits
	global	_CRCON_bits
	global	_EECON1_bits
	global	_GPIO_bits
	global	_INTCON_bits
	global	_IOCA_bits
	global	_LVDCON_bits
	global	_OPTION_REG_bits
	global	_OSCCON_bits
	global	_OSCTUNE_bits
	global	_PCON_bits
	global	_PIE1_bits
	global	_PIR1_bits
	global	_PORTA_bits
	global	_STATUS_bits
	global	_T1CON_bits
	global	_VRCON_bits
	global	_WDA_bits
	global	_WDTCON_bits
	global	_WPUDA_bits
	global	_INDF
	global	_TMR0
	global	_PCL
	global	_STATUS
	global	_FSR
	global	_PORTA
	global	_GPIO
	global	_PCLATH
	global	_INTCON
	global	_PIR1
	global	_TMR1L
	global	_TMR1H
	global	_T1CON
	global	_WDTCON
	global	_CMCON0
	global	_CMCON1
	global	_OPTION_REG
	global	_TRISA
	global	_TRISIO
	global	_PIE1
	global	_PCON
	global	_OSCCON
	global	_OSCTUNE
	global	_LVDCON
	global	_WPUDA
	global	_IOCA
	global	_WDA
	global	_VRCON
	global	_EEDAT
	global	_EEDATA
	global	_EEADR
	global	_EECON1
	global	_EECON2
	global	_CRCON
	global	_CRDAT0
	global	_CRDAT1
	global	_CRDAT2
	global	_CRDAT3

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
UD_abs_pic12f635_0	udata_ovr	0x0000
_INDF
	res	1
UD_abs_pic12f635_1	udata_ovr	0x0001
_TMR0
	res	1
UD_abs_pic12f635_2	udata_ovr	0x0002
_PCL
	res	1
UD_abs_pic12f635_3	udata_ovr	0x0003
_STATUS_bits
_STATUS
	res	1
UD_abs_pic12f635_4	udata_ovr	0x0004
_FSR
	res	1
UD_abs_pic12f635_5	udata_ovr	0x0005
_GPIO_bits
_PORTA_bits
_PORTA
_GPIO
	res	1
UD_abs_pic12f635_a	udata_ovr	0x000a
_PCLATH
	res	1
UD_abs_pic12f635_b	udata_ovr	0x000b
_INTCON_bits
_INTCON
	res	1
UD_abs_pic12f635_c	udata_ovr	0x000c
_PIR1_bits
_PIR1
	res	1
UD_abs_pic12f635_e	udata_ovr	0x000e
_TMR1L
	res	1
UD_abs_pic12f635_f	udata_ovr	0x000f
_TMR1H
	res	1
UD_abs_pic12f635_10	udata_ovr	0x0010
_T1CON_bits
_T1CON
	res	1
UD_abs_pic12f635_18	udata_ovr	0x0018
_WDTCON_bits
_WDTCON
	res	1
UD_abs_pic12f635_19	udata_ovr	0x0019
_CMCON0_bits
_CMCON0
	res	1
UD_abs_pic12f635_1a	udata_ovr	0x001a
_CMCON1_bits
_CMCON1
	res	1
UD_abs_pic12f635_81	udata_ovr	0x0081
_OPTION_REG_bits
_OPTION_REG
	res	1
UD_abs_pic12f635_85	udata_ovr	0x0085
_TRISA
_TRISIO
	res	1
UD_abs_pic12f635_8c	udata_ovr	0x008c
_PIE1_bits
_PIE1
	res	1
UD_abs_pic12f635_8e	udata_ovr	0x008e
_PCON_bits
_PCON
	res	1
UD_abs_pic12f635_8f	udata_ovr	0x008f
_OSCCON_bits
_OSCCON
	res	1
UD_abs_pic12f635_90	udata_ovr	0x0090
_OSCTUNE_bits
_OSCTUNE
	res	1
UD_abs_pic12f635_94	udata_ovr	0x0094
_LVDCON_bits
_LVDCON
	res	1
UD_abs_pic12f635_95	udata_ovr	0x0095
_WPUDA_bits
_WPUDA
	res	1
UD_abs_pic12f635_96	udata_ovr	0x0096
_IOCA_bits
_IOCA
	res	1
UD_abs_pic12f635_97	udata_ovr	0x0097
_WDA_bits
_WDA
	res	1
UD_abs_pic12f635_99	udata_ovr	0x0099
_VRCON_bits
_VRCON
	res	1
UD_abs_pic12f635_9a	udata_ovr	0x009a
_EEDAT
_EEDATA
	res	1
UD_abs_pic12f635_9b	udata_ovr	0x009b
_EEADR
	res	1
UD_abs_pic12f635_9c	udata_ovr	0x009c
_EECON1_bits
_EECON1
	res	1
UD_abs_pic12f635_9d	udata_ovr	0x009d
_EECON2
	res	1
UD_abs_pic12f635_110	udata_ovr	0x0110
_CRCON_bits
_CRCON
	res	1
UD_abs_pic12f635_111	udata_ovr	0x0111
_CRDAT0
	res	1
UD_abs_pic12f635_112	udata_ovr	0x0112
_CRDAT1
	res	1
UD_abs_pic12f635_113	udata_ovr	0x0113
_CRDAT2
	res	1
UD_abs_pic12f635_114	udata_ovr	0x0114
_CRDAT3
	res	1
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
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
code_pic12f635	code

;	code size estimation:
;	    0+    0 =     0 instructions (    0 byte)

	end
