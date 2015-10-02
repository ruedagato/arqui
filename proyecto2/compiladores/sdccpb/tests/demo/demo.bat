@copy %1 ..\sdcc\bin_vc\%1
@cd ..\sdcc\bin_vc
CALL pbccf.bat %1
@pause

move /Y %1.json ..\..\pbcc\%1.json
@cd ..\..\pbcc
CALL pbcc.bat %1.json kcpsm3
@type pbcc.log

move /Y %1.json.asm ..\KCPSM3\Assembler\demo.psm
@pause

@cd ..\KCPSM3\Assembler
KCPSM3.EXE demo.psm

move /Y demo.hex ..\..\demo\%1.hex
@cd ..\..\demo