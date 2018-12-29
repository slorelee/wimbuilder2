@echo off

rem sc start WPDBusEnum

set DrvRepo=%SystemRoot%\System32\DriverStore\FileRepository

call :CopyDriver wpdcomp.inf
call :CopyDriver wpdfs.inf
call :CopyDriver wpdmtp.inf

copy /y %SystemRoot%\INF\WpdMtp.dll %SystemRoot%\System32\
copy /y %SystemRoot%\INF\WpdMtpUS.dll %SystemRoot%\System32\
copy /y %SystemRoot%\INF\WpdMtpDr.dll %SystemRoot%\System32\drivers\UMDF\
copy /y %SystemRoot%\INF\WpdFs.dll %SystemRoot%\System32\drivers\UMDF\

drvload %SystemRoot%\INF\winusb.inf
drvload %SystemRoot%\INF\wpdcomp.inf
drvload %SystemRoot%\INF\wpdfs.inf
drvload %SystemRoot%\INF\wpdmtphw.inf
drvload %SystemRoot%\INF\wpdmtp.inf
pause
goto :EOF

:CopyDriver
set DrvFolder=
for /f "delims=" %%i in ('dir /b %DrvRepo%\%1_*') do (
    set DrvFolder=%%i
)
if "x%DrvFolder%"=="x" goto :EOF
xcopy /y %DrvRepo%\%DrvFolder%\*.* %SystemRoot%\INF\

