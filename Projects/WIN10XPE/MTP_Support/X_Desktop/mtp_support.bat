@echo off
set DrvRepo=%SystemRoot%\System32\DriverStore\FileRepository
call :InstDriver wpdmtp.inf
pause
goto :EOF

:InstDriver
set DrvFolder=
for /f "delims=" %%i in ('dir /b %DrvRepo%\%1_*') do set DrvFolder=%%i
if "x%DrvFolder%"=="x" goto :EOF
drvload %DrvRepo%\%DrvFolder%\%1

