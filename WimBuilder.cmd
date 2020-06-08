@echo off
cd /d "%~dp0"
title %~n0(%cd%)

set "APP_NAME=%~n0"

set APP_OPT_HELP=
call :PARSE_OPTIONS %*
rem set APP_OPT_
if /i "x%APP_OPT_HELP%"=="x1" goto :SHOW_HELP

set "APP_ROOT=%cd%"
if "x%APP_ROOT:~-1%"=="x\" set APP_ROOT=%APP_ROOT:~0,-1%

set "PATH_ORG=%PATH%"
rem ======set bin PATH======
set "PATH=%APP_ROOT%\bin;%PATH%"

set PROCESSOR_ARCHITECTURE=AMD64
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 (
  set PROCESSOR_ARCHITECTURE=x86
)

set APP_ARCH=x86
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
  set APP_ARCH=x64
  set "PATH=%APP_ROOT%\bin\x64;%APP_ROOT%\bin\x86;%PATH%"
) else (
  set "PATH=%APP_ROOT%\bin\x86;%PATH%"
)
rem ========================

call EnvCheck.bat

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
set APP_HOST_WIN=UNKNOWN
if exist "%windir%\SystemResources\" set APP_HOST_WIN=10

rem init i18n file
set "I18N_SCRIPT=%~dp0i18n\i18n_.wsf"

set findcmd=findstr
if not exist "%windir%\System32\findstr.exe" set findcmd=find
for /f "tokens=1,2 delims==';[] " %%i in ('%findcmd% "$lang" config.js') do (
  set LocaleID[%%i]=%%j
)
set LocaleID=%LocaleID[$lang]%
for /f "delims=" %%i in ('cscript.exe //nologo "%I18N_SCRIPT%" init') do set APP_HOST_LANG=%%i
if "x%APP_HOST_LANG%"=="x" set APP_HOST_LANG=en-US

if not "x%LocaleID%"=="x" goto :SKIP_AUTO_LANG
set LocaleID=%APP_HOST_LANG%

:SKIP_AUTO_LANG
set I18N_LCID=%LocaleID%
set APP_UI_LANG=%LocaleID%
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

call :APP_ENV

rem ======set macros PATH======
set "PATH=%APP_ROOT%\lib\macros;%PATH%"
rem ========================

if not "%PROCESSOR_ARCHITECTURE%"=="AMD64" goto :Normal_Start
if exist "%windir%\SysWOW64\mshta.exe" goto :Normal_Start
start %APP_START_OPT% mshta "%~dp0%APP_NAME%.hta" %*
goto :EOF

:Normal_Start
start %APP_START_OPT% %APP_NAME%.hta %*
goto :EOF


:SHOW_HELP
echo Usage: %~nx0 [-h^|--help] [^<Options^>...]
echo.
echo ^<Options^>
echo    --verbose
echo    --build^|--build-with-log
echo    --source-folder FOLDER^|DRIVE
echo    --source-wim SOURCE_WIM_FILE
echo    --source-index INDEX
echo    --base-wim BASE_WIM_FILE
echo    --base-index INDEX
echo    --project PROJECT
echo    --preset PRESET
echo    --make-iso
echo    --close-ui (the option will append --wait option by default)
echo    --wait
echo    --nowait
echo.
echo Examples:
echo.
echo    %~nx0 --build --make-iso --close-ui
echo    %~nx0 --source-folder I: --source-index 1 --build --preset full --make-iso --close-ui
echo    %~nx0 --source-wim "D:\win10v1903\sources\install.wim" --source-index 4 --build --preset full --make-iso --close-ui
echo    %~nx0 --source-folder H: --source-index 1 --base-wim "D:\BOOTPE\boot.wim" --preset lite --build-with-log --make-iso
goto :EOF

:PARSE_OPTIONS

if /i "x%1"=="x" goto :EOF
if /i "x%1"=="x-h" (
  set APP_OPT_HELP=1
  goto :EOF
) else if /i "x%1"=="x--help" (
  set APP_OPT_HELP=1
  goto :EOF
) else if /i "x%1"=="x--build" (
  set WB_OPT_BUILD=CMD
) else if /i "x%1"=="x--build-with-log" (
  set WB_OPT_BUILD=LOG
) else if /i "x%1"=="x--verbose" (
  set WB_OPT_VERBOSE=1
) else if /i "x%1"=="x--source-driver" (
  set "WB_SRC_FOLDER=%~2"
  SHIFT
) else if /i "x%1"=="x--source-folder" (
  set "WB_SRC_FOLDER=%~2"
  SHIFT
) else if /i "x%1"=="x--source-wim" (
  set "WB_SRC_WIM=%~2"
  SHIFT
) else if /i "x%1"=="x--source-index" (
  set WB_SRC_INDEX=%2
  SHIFT
) else if /i "x%1"=="x--base-wim" (
  set "WB_BASE_WIM=%~2"
  SHIFT
) else if /i "x%1"=="x--base-index" (
  set WB_BASE_INDEX=%2
  SHIFT
) else if /i "x%1"=="x--project" (
  set WB_OPT_PROJECT=%2
  SHIFT
) else if /i "x%1"=="x--preset" (
  set WB_OPT_PRESET=%2
  SHIFT
) else if /i "x%1"=="x--make-iso" (
  set WB_OPT_MAKE_ISO=1
) else if /i "x%1"=="x--close-ui" (
  set WB_OPT_CLOSE_UI=1
  set APP_START_OPT=/wait
) else if /i "x%1"=="x--wait" (
  set APP_START_OPT=/wait
) else if /i "x%1"=="x--nowait" (
  set APP_START_OPT=
)
SHIFT
goto :PARSE_OPTIONS
goto :EOF


:APP_ENV
set "Factory=_Factory_"
set "ISO_DIR=_ISO_"

set "V=%APP_ROOT%\vendor"

rem mount winre.wim/boot.wim with wimlib, otherwise dism
set USE_WIMLIB=0
goto :EOF

