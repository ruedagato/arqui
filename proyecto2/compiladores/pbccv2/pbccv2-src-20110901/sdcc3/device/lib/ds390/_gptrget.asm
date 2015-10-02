;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.0.1 #6227 (Oct  2 2015) (Linux)
; This file was generated Fri Oct  2 17:15:17 2015
;--------------------------------------------------------
	.module _gptrget
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
	.globl __gptrgetWord
	.globl __gptrget
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_B_7	=	0x00f7
_B_6	=	0x00f6
_B_5	=	0x00f5
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
;Allocation info for local variables in function '_gptrget'
;------------------------------------------------------------
;gptr                      Allocated to registers 
;------------------------------------------------------------
;	_gptrget.c:167: _gptrget (char *gptr) __naked
;	-----------------------------------------
;	 function _gptrget
;	-----------------------------------------
__gptrget:
;	naked function: no prologue.
;	_gptrget.c:214: __endasm;
	
    ;
    ; depending on the pointer type acc. to SDCCsymt.h
    ;
	        jb _B_7,codeptr$ ; >0x80 code ; 3
	        jnb _B_6,xdataptr$ ; <0x40 far ; 3
	
	        mov dph,r0 ; save r0 independant of regbank ; 2
	        mov r0,dpl ; use only low order address ; 2
	
	        jb _B_5,pdataptr$ ; >0x60 pdata ; 3
    ;
    ; Pointer to data space
    ;
	        mov a,@r0 ; 1
	 dataptrrestore$:
	        mov r0,dph ; restore r0 ; 2
	        mov dph,#0 ; restore dph ; 2
	        ret ; 1
    ;
    ; pointer to xternal stack or pdata
    ;
	 pdataptr$:
	        movx a,@r0 ; 1
	        sjmp dataptrrestore$ ; 2
    ;
    ; pointer to code area, max 16 bits
    ;
	 codeptr$:
	        clr a ; 1
	        movc a,@a+dptr ; 1
	        ret ; 1
    ;
    ; pointer to xternal data, max 16 bits
    ;
	 xdataptr$:
	        movx a,@dptr ; 1
	        ret ; 1
                                                        ;===
                                                        ;27 bytes
	     
00101$:
;	naked function: no epilogue.
;------------------------------------------------------------
;Allocation info for local variables in function '_gptrgetWord'
;------------------------------------------------------------
;gptr                      Allocated to registers 
;------------------------------------------------------------
;	_gptrget.c:224: _gptrgetWord (unsigned *gptr)
;	-----------------------------------------
;	 function _gptrgetWord
;	-----------------------------------------
__gptrgetWord:
	ar2 = 0x02
	ar3 = 0x03
	ar4 = 0x04
	ar5 = 0x05
	ar6 = 0x06
	ar7 = 0x07
	ar0 = 0x00
	ar1 = 0x01
;	_gptrget.c:284: __endasm;
	
    ;
    ; depending on the pointer type acc. to SDCCsymt.h
    ;
	        jb _B_7,00003$ ; >0x80 code
	        jnb _B_6,00002$ ; <0x40 far
	
	        mov dph,r0 ; save r0 independant of regbank
	        mov r0,dpl ; use only low order address
	
	        jb _B_5,00004$ ; >0x60 pdata
    ;
    ; Pointer to data space
    ;
	        mov _ap,@r0
	        inc r0
	        mov a,@r0
	        inc dpl
	        sjmp 00005$
    ;
    ; pointer to xternal data
    ;
	 00002$:
	        movx a,@dptr
	        mov _ap,a
	        inc dptr
	        movx a,@dptr
	        sjmp 00006$
;
; pointer to code area
;
	 00003$:
	        clr a
	        movc a,@a+dptr
	        mov _ap,a
	        clr a
	        inc dptr
	        movc a,@a+dptr
	        sjmp 00006$
;
; pointer to xternal stack
;
	 00004$:
	        movx a,@r0
	        mov _ap,a
	        inc r0
	        movx a,@r0
	        inc dpl
;
; restore and return
;
	 00005$:
	        mov r0,dph ; restore r0
	        mov dph,#0 ; restore dph
	 00006$:
	        xch a,_ap
	    
00101$:
	ret
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
