;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:18 2015
;--------------------------------------------------------
	.module memcpyx
	.optsdcc -mds390 --model-flat24
	
;--------------------------------------------------------
; CPU specific extensions
;--------------------------------------------------------
.flat24 on		; 24 bit flat addressing
dpl1	=	0x84
dph1	=	0x85
dps	=	0x86
dpx	=	0x93
dpx1	=	0x95
esp	=	0x9B
ap	=	0x9C
_ap	=	0x9C
mcnt0	=	0xD1
mcnt1	=	0xD2
ma	=	0xD3
mb	=	0xD4
mc	=	0xD5
F1	=	0xD1	; user flag
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpyx_PARM_3
	.globl _memcpyx_PARM_2
	.globl _memcpyx
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
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
_memcpyx_PARM_2:
	.ds 3
_memcpyx_PARM_3:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
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
;Allocation info for local variables in function 'memcpyx'
;------------------------------------------------------------
;src                       Allocated with name '_memcpyx_PARM_2'
;count                     Allocated with name '_memcpyx_PARM_3'
;dst                       Allocated to registers 
;------------------------------------------------------------
;	memcpyx.c:31: void __xdata * memcpyx (
;	-----------------------------------------
;	 function memcpyx
;	-----------------------------------------
_memcpyx:
;	naked function: no prologue.
;	memcpyx.c:111: #ifdef AUTO_TOGGLE
	
    ; Destination is in DPTR. Save it on stack so we can return it at end.
	
	    push dpx
	    push dph
	    push dpl
	
	    mov dps, #0x1 ; Alternate DPTR.
	
    ; count is in _memcpyx_PARM_3
	    mov dptr, #_memcpyx_PARM_3
	    movx a, @dptr
	    inc dptr
	    mov r2, a
	    movx a, @dptr
	    mov r3, a
	
    ; src is in _memcpyx_PARM_2
	    mov dptr, #_memcpyx_PARM_2
	    movx a, @dptr
	    inc dptr
	    push acc
	    movx a, @dptr
	    inc dptr
	    push acc
	    movx a, @dptr
	    mov dpx1, a
	    pop dph1
	    pop dpl1
	
	
	    mov dps, #0x21 ; Current DPTR is alt DPTR, toggle after each op.
	
	
	
	
    ; src is in alt DPTR, dst is in normal DPTR, count is in r2/r3.
	
    ; If we have zero bytes to copy, quick out.
	    mov a, r2
	    orl a, r3
	    jz _memcpy_done
	
    ; increment r3 if r2 != 0 (makes djnz end-of-loop sequence possible).
	    inc r3
	    cjne r2, #0x0, _memcpyx_loopTop
	    dec r3
	
	_memcpyx_loopTop:
	
	
	    movx a, @dptr
	    movx @dptr, a
	    inc dptr
	    inc dptr
;	# 106 "memcpyx.c"
	    djnz r2, _memcpyx_loopTop
	    djnz r3, _memcpyx_loopTop
	
	_memcpy_done:
	
	
	    mov dps, #0x0
	
	
	    pop dpl
	    pop dph
	    pop dpx
	    ret
00101$:
;	naked function: no epilogue.
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
