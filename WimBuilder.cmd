@echo off
cd /d "%~dp0"
title WimBuilder(%cd%)

set "WB_ROOT=%cd%"
if "x%WB_ROOT:~-1%"=="x\" set WB_ROOT=%WB_ROOT:~0,-1%

set "PATH_ORG=%PATH%"
rem ======set bin PATH======
set "PATH=%WB_ROOT%\bin;%PATH%"

set WB_ARCH=x86
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
  set WB_ARCH=x64
  set "PATH=%WB_ROOT%\bin\x64;%WB_ROOT%\bin\x86;%PATH%"
) else (
  set "PATH=%WB_ROOT%\bin\x86;%PATH%"
)
rem ========================

rem run with Administrators right
IsAdmin.exe

if not ERRORLEVEL 1 (
  if not "x%~1"=="xrunas" (
    set ElevateMe=1
    set "PATH=%PATH_ORG%"
    bin\ElevateMe.vbs "%~0" "runas" %*
  )
  goto :EOF
)
if "x%~1"=="xrunas" (SHIFT)

call DisAutoRun

rem init i18n file
set "I18N_SCRIPT=%~dp0i18n\i18n_.wsf"

set findcmd=findstr
if not exist "%windir%\System32\findstr.exe" set findcmd=find
for /f "tokens=2 delims=='; " %%i in ('%findcmd% "$lang" config.js') do (
  set LocaleID=%%i
)
if not "x%LocaleID%"=="x" goto :SKIP_AUTO_LANG
set LocaleID=0
for /f "delims=" %%i in ('cscript.exe //nologo "%I18N_SCRIPT%" init') do set LocaleID=%%i
if "x%LocaleID%"=="x" set LocaleID=0

:SKIP_AUTO_LANG
set I18N_LCID=%LocaleID%
set WB_UI_LANG=%LocaleID%
if not exist i18n\%LocaleID%.vbs (
    set I18N_LCID=0
    goto :MAIN_ENTRY
)

set "I18N_SCRIPT=%~dp0i18n\i18n.wsf"
if not exist i18n\0.vbs goto :UPDATE_I18NRES
fc /b i18n\%LocaleID%.vbs i18n\0.vbs>nul
if not ERRORLEVEL 1 goto :MAIN_ENTRY

:UPDATE_I18NRES
copy /y i18n\%LocaleID%.vbs i18n\0.vbs

:MAIN_ENTRY
set "Factory=_Factory_"
set "ISO_DIR=_ISO_"

rem ======set macros PATH======
set "PATH=%WB_ROOT%\lib\macros;%PATH%"
rem ========================

set "V=%WB_ROOT%\vendor"

rem mount winre.wim/boot.wim with wimlib, otherwise dism
set USE_WIMLIB=0
if not "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto :Normal_Start
if exist "%windir%\SysWOW64\mshta.exe" goto :Normal_Start
start mshta "%~dp0WimBuilder_UI.hta" %*
goto :EOF

:Normal_Start
start WimBuilder_UI.hta %*
