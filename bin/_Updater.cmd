@echo off
set updater_url=https://github.com/slorelee/wimbuilder2/releases/download/update
set source_url=https://github.com/slorelee/wimbuilder2/raw/master

cd /d "%~dp0"
if "x%TMP_UPDATER%"=="x1" goto :UPDATE_MAIN

if exist "x64\" (
  rem bin\
  cd /d "%~dp0..\"
) else (
  rem _Factory_\tmp\
  cd /d "%~dp0..\..\"
  set TMP_UPDATER=1
)

set "APP_ROOT=%cd%"
set TMP_UPT=_Factory_\tmp
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
  aria2c.exe -c "%updater_url%/fciv.zip" -d bin
)
7z.exe e bin\fciv.zip fciv.exe -obin
:END_FCIV

if not exist "bin\%~n0.vbs" (
  echo Downloading^(%~n0.vbs^) ...
  aria2c.exe -c "%updater_url%/%~n0.vbs" -d bin
)

if not exist "bin\fciv.exe" set ERROR_EXIT=1
if not exist "bin\%~n0.vbs" set ERROR_EXIT=1
if "x%ERROR_EXIT%"=="x1" (
    echo ERROR: Failed to download fciv.exe or %~n0.vbs, please try later.
    pause
    goto :EOF
)

copy /y "%~0" "%TMP_UPT%\" 1>nul
copy /y "%~dpn0.vbs" "%TMP_UPT%\" 1>nul

del /f /a /q "%TMP_UPT%\local.md5"
del /f /a /q "%TMP_UPT%\remote.md5"
del /f /a /q "%TMP_UPT%\fciv.err"

rem execute _Factory_\tmp\%~nx0
set TMP_UPDATER=1
"%TMP_UPT%\%~nx0" %*

:UPDATE_MAIN

set "TMP_UPT=%APP_ROOT%\%TMP_UPT%"
cd /d "%TMP_UPT%"
title Updater
echo Updating ...
echo.
echo PHASE 1:Create local.MD5 manifest ...
echo %TMP_UPT%
if exist "%TMP_UPT%\local.md5" goto :END_LOCAL_MD5
echo Detect Projects ...
fciv.exe -add "%APP_ROOT%\Projects" -r -bp "%APP_ROOT%" > "%TMP_UPT%\local.md5"
echo Detect assets ...
fciv.exe -add "%APP_ROOT%\assets" -r -bp "%APP_ROOT%" >> "%TMP_UPT%\local.md5"
echo Detect bin ...
fciv.exe -add "%APP_ROOT%\bin" -r -bp "%APP_ROOT%" >> "%TMP_UPT%\local.md5"
echo Detect macros ...
fciv.exe -add "%APP_ROOT%\lib\macros" -bp "%APP_ROOT%" >> "%TMP_UPT%\local.md5"
fciv.exe -add "%APP_ROOT%\config.js" -wp >> "%TMP_UPT%\local.md5"
fciv.exe -add "%APP_ROOT%\WimBuilder.cmd" -wp >> "%TMP_UPT%\local.md5"

:END_LOCAL_MD5
echo PHASE 2:Download remote.MD5 manifest ...

if exist "%TMP_UPT%\remote.md5" goto :END_REMOTE_MD5
set "remote_md5=%updater_url%/remote.md5"
echo.
echo Download: %remote_md5%
aria2c.exe -c "%remote_md5%" -d "%TMP_UPT%" -o remote.md5
:END_REMOTE_MD5
if not exist "%TMP_UPT%\remote.md5" (
    echo ERROR: Failed to download remote.md5 manifest, please try later.
    pause
    goto :EOF
)

echo PHASE 3:Get update file list ...
del /f /a /q "%TMP_UPT%\updatefile.list"
cscript //nologo "%TMP_UPT%\%~n0.vbs" %*
echo.
echo Update File(s):
type "%TMP_UPT%\updatefile.list"
echo.

echo PHASE 4:Donwload updated file(s) ...
for /f "usebackq delims=" %%i in ("%TMP_UPT%\updatefile.list") do (
    echo Download: %%i
    aria2c.exe -c "%source_url%/%%i" -d "%APP_ROOT%" -o "%%i" --allow-overwrite=true 
)
pause
