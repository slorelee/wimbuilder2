rem fix issue that the audio driver can not work for 17134.1845(RS4), 17763.1577, 17763.1613(RS5)

if not exist "%X_SYS%\drivers\portcls.sys" goto :EOF

set DrvFolder=
for /f "delims=" %%i in ('dir /b %X_SYS%\DriverStore\FileRepository\wdmaudio.inf_*') do set DrvFolder=%%i
if "x%DrvFolder%"=="x" goto :EOF

fc /b "%X_SYS%\DriverStore\FileRepository\%DrvFolder%\portcls.sys" "%X_SYS%\drivers\portcls.sys" 1>nul
if %errorlevel% EQU 0 goto :END
echo [Mismatched] Copy %DrvFolder%\portcls.sys to drivers\portcls.sys
copy /y "%X_SYS%\DriverStore\FileRepository\%DrvFolder%\portcls.sys" "%X_SYS%\drivers\"

:END
set DrvFolder=
