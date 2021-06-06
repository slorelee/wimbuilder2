@echo off
if "x%APP_ROOT%"=="x" goto :EOF

IsAdmin.exe
if not ERRORLEVEL 1 (
    ElevateMe.vbs "%~0" "%~fs1"
    goto :EOF
)
call :MAIN "%~f1"
goto :EOF


:MAIN
cd /d "%~dp1"
set key=%~n1
reg load HKLM\Tmp_%key% "%~1"
reg export HKLM\Tmp_%key% Tmp_%key%.reg /y
reg unload HKLM\Tmp_%key%
pause