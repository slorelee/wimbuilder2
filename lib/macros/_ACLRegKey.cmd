@echo off

rem MACRO:ACLRegKey RegKey [user] [owner]
rem call SetACL.exe to set the registry's ACL

echo [MACRO]ACLRegKey %*

call :GRANT_REG_RIGHT "HKLM\%~1" "%~2" "%~3"
goto :EOF

:GRANT_REG_RIGHT
set "_ACL_User=%~2"
set "_ACL_Owner=%~3"
if "x%_ACL_User%"=="x" set _ACL_User=Administrators
if "x%_ACL_Owner%"=="x"  set _ACL_Owner=Administrators
set GetLastError=0
if not "%_ACL_Owner%"=="-" (
  SetACL.exe -on "%~1" -ot reg -actn setowner -ownr "n:%_ACL_Owner%" -rec yes
  if ERRORLEVEL 1 set GetLastError=1
)
if not "%GetLastError%"=="0" goto :EOF

if not "%_ACL_User%"=="-" (
  SetACL.exe -on "%~1" -ot reg -actn ace -ace "n:%_ACL_User%;p:full" -rec yes
  if ERRORLEVEL 1 set GetLastError=1
)
goto :EOF
