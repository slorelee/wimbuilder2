@echo off
if "x%REMOTE_URL%"=="x" set REMOTE_URL=https://github.com/slorelee/wimbuilder2/releases/download/update
if "x%SOURCE_URL%"=="x" set SOURCE_URL=https://github.com/slorelee/wimbuilder2/raw/master

if "x%1"=="x--help" set UPT_HELP=1
if "x%1"=="x-h" set UPT_HELP=1
if not "x%UPT_HELP%"=="x1" goto :END_HELP

echo.
echo Usage:
echo   %~n0 [OPTIONS] [--file ^<file^>^|--dir ^<dir^>]
echo OPTIONS
echo   -h,--help    show help
echo   --silent     update silently
echo   --local      create local.md5 only
echo   --dryrun     check only
pause
goto :EOF
:END_HELP

goto :END_OPT_PARSER

:OPT_PARSER
if "x%~1"=="x" goto :EOF
if /i "%~1"=="--file" set "UPT_FILE=%~2" & shift
if /i "%~1"=="--dir" set "UPT_DIR=%~2" & shift
if /i "%~1"=="--silent" set UPT_SILENT=1
if /i "%~1"=="--local" set UPT_LOCAL=1
if /i "%~1"=="--dryrun" set UPT_DRYRUN=1
shift
goto :OPT_PARSER

:END_OPT_PARSER

cd /d "%~dp0"
set "TMP_UPT=%FACTORY_PATH%\tmp"
if "x%TMP_UPDATER%"=="x1" goto :UPDATE_MAIN

if exist "x64\" (
  rem bin\
  cd /d "%~dp0..\"
) else (
  rem %FACTORY_PATH%\tmp\
  cd /d "%~dp0..\..\"
  set TMP_UPDATER=1
)

set "APP_ROOT=%cd%"
if not exist "%TMP_UPT%\" md "%TMP_UPT%"

set APP_ARCH=x64
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 set APP_ARCH=x86
set "PATH=%APP_ROOT%\bin\%APP_ARCH%;%APP_ROOT%\bin;%PATH%"

if "x%TMP_UPDATER%"=="x1" goto :UPDATE_MAIN

if exist "bin\fciv.exe" goto :END_FCIV
set PULL_ACTION=1
if exist "bin\fciv.zip" set PULL_ACTION=0
if exist "bin\fciv.zip.aria2" set PULL_ACTION=1
if "x%PULL_ACTION%"=="x1" (
  echo Downloading^(fciv.exe^) ...
  aria2c.exe -c "%REMOTE_URL%/fciv.zip" -d bin
)
7z.exe e bin\fciv.zip fciv.exe -obin
:END_FCIV

if not exist "bin\%~n0.vbs" (
  echo Downloading^(%~n0.vbs^) ...
  aria2c.exe -c "%REMOTE_URL%/%~n0.vbs" -d bin
)

if not exist "bin\fciv.exe" set ERROR_EXIT=1
if not exist "bin\%~n0.vbs" set ERROR_EXIT=1
if "x%ERROR_EXIT%"=="x1" (
    echo ERROR: Failed to download fciv.exe or %~n0.vbs, please try later.
    pause
    goto :EOF
)

copy /y "%~dpn0.cmd" "%TMP_UPT%\" 1>nul
copy /y "%~dpn0.vbs" "%TMP_UPT%\" 1>nul

del /f /a /q "%TMP_UPT%\local.md5"
del /f /a /q "%TMP_UPT%\remote.md5"
del /f /a /q "%TMP_UPT%\fciv.err"

rem execute %FACTORY_PATH%\tmp\%~nx0
set TMP_UPDATER=1
"%TMP_UPT%\%~nx0" %*

:UPDATE_MAIN

set "TMP_UPT=%FACTORY_PATH%\tmp"
cd /d "%TMP_UPT%"
title Updater

echo %TMP_UPT%
echo REMOTE_URL=%REMOTE_URL%
echo SOURCE_URL=%SOURCE_URL%
echo.

call :OPT_PARSER %*

echo Updating ...
echo.
echo PHASE 1:Create local.MD5 manifest ...

if exist "%TMP_UPT%\local.md5" goto :END_LOCAL_MD5

if not "x%UPT_FILE%"=="x" goto :END_LOCAL_MD5
if not "x%UPT_DIR%"=="x" goto :END_LOCAL_MD5

echo. > "%TMP_UPT%\local.md5"
call :UPDATE_DETECT_DIR Projects -r
call :UPDATE_DETECT_DIR assets -r
call :UPDATE_DETECT_DIR bin -r
call :UPDATE_DETECT_DIR lib\macros
call :UPDATE_DETECT_DIR test
call :UPDATE_DETECT config.js
call :UPDATE_DETECT WimBuilder.cmd

:END_LOCAL_MD5
if "x%UPT_LOCAL%%UPT_SILENT%"=="x11" goto :EOF
if "x%UPT_LOCAL%"=="x1" pause && goto :EOF

echo PHASE 2:Download remote.MD5 manifest ...

if exist "%TMP_UPT%\remote.md5" goto :END_REMOTE_MD5

if not "x%UPT_FILE%"=="x" goto :SKIP_REMOTE_MD5

set "remote_md5=%REMOTE_URL%/remote.md5"
echo.
echo Download: %remote_md5%
aria2c.exe -c "%remote_md5%" -d "%TMP_UPT%" -o remote.md5
:END_REMOTE_MD5
if not exist "%TMP_UPT%\remote.md5" (
    echo ERROR: Failed to download remote.md5 manifest, please try later.
    pause
    goto :EOF
)
:SKIP_REMOTE_MD5

echo PHASE 3:Get update file list ...
del /f /a /q "%TMP_UPT%\updatefile.list"

if not "x%UPT_FILE%"=="x" call :UPDATE_FILE
if not "x%UPT_DIR%"=="x" call :UPDATE_DIR

if not exist "%TMP_UPT%\updatefile.list" call :UPDATE_DIFF %*
echo.
echo Update File(s):
type "%TMP_UPT%\updatefile.list"
echo.

if "x%UPT_DRYRUN%"=="x1" (
    pause
    goto :EOF
)

if not "x%UPT_SILENT%"=="x1" (
    echo Press any key to update ...
    pause > nul
)

echo PHASE 4:Donwload updated file(s) ...
for /f "usebackq delims=" %%i in ("%TMP_UPT%\updatefile.list") do (
    echo Download: %%i
    aria2c.exe -c "%SOURCE_URL%/%%i" -d "%APP_ROOT%" -o "%%i" --allow-overwrite=true 
)
pause
goto :EOF

:UPDATE_DETECT_DIR
echo Detect %~1 ...
fciv.exe -add "%APP_ROOT%\%~1" %~2 -bp "%APP_ROOT%" >> "%TMP_UPT%\local.md5"
goto :EOF

:UPDATE_DETECT
echo Detect %~1 ...
fciv.exe -add "%APP_ROOT%\%~1" -wp >> "%TMP_UPT%\local.md5"
goto :EOF

:UPDATE_FILE
(echo %UPT_FILE%) > "%TMP_UPT%\updatefile.list"
goto :EOF

:UPDATE_DIR
cscript //nologo "%TMP_UPT%\%~n0.vbs" --dir "%UPT_DIR%"
goto :EOF

:UPDATE_DIFF
cscript //nologo "%TMP_UPT%\%~n0.vbs" %*
goto :EOF

