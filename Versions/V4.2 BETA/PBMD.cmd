echo off
color f
mode 27,6
set counter=0
set counterb=000
set core=
set "valuecore=               "
:start
cls
echo.‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
echo.€%valuecore:~0,15%€
echo.€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€
if %counter% GEQ 15 set msg=complete& set counterb=10000& goto exit
echo. %counterb:~0,-2%%%
set /a counter=counter+1
set /a counterb=counterb+666
set valuecore=%%core:~0,%counter%%%
for /f "usebackq tokens=*"  %%i in (`echo."%valuecore%"`) do set "valuecore=%%~i               "
set delay=0
:delay
if %delay%==1 goto start
set /a delay=delay+1
goto delay
:exit
echo. %counterb:~0,-2%%% %msg%
if exist MD.cmd (MD.cmd) else (MD.exe)