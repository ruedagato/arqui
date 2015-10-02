@REM copy %1 ..\..\bin_vc
@REM cd ..\..\bin_vc
..\..\bin_vc\sdcc.exe %1 -mpicoBlaze --json --json-file=%1.json -c -I"..\..\device\include\picoBlaze"
@REM copy %1.json ..\tests\42
@REM cd ..\tests\42
@REM -I..\..\device\include\picoBlaze