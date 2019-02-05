@echo off
rem needs Administrator privileges
rem TrustedInstaller -> Administrator
if "x%THIS_RUNAS_ADMIN%"=="x" (
    set THIS_RUNAS_ADMIN=1
    NSudoC.exe -WAIT -U:P "%~0" %*
    goto :EOF
)
cd /d "%~dp0"
powershell "%cd%\HyperV.ps1" %*
pause
