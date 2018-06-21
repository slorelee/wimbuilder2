@echo off

rem MACRO:ACLRegKey
rem call SetACL.exe to set the registry's ACL
echo [MACRO]ACLRegKey %*

call :GRANT_REG_RIGHT "HKLM\%~1"
goto :EOF

:GRANT_REG_RIGHT
SetACL.exe -on "%~1" -ot reg -actn setowner -ownr "n:Administrators" -rec yes 1>nul
if ERRORLEVEL 1 set GetLastError=1
if not "%GetLastError%"=="0" goto :EOF
SetACL.exe -on "%~1" -ot reg -actn ace -ace "n:Administrators;p:full" -rec yes 1>nul
if ERRORLEVEL 1 set GetLastError=1
goto :EOF


