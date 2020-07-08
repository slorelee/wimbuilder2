@echo off
if "x%TMP_UPDATER%"=="x1" goto :UPDATE_MAIN
cd /d "%~dp0..\"
set "APP_ROOT=%cd%"
set TMP_UPT=_Factory_\tmp
if not exist "%TMP_UPT%\" md "%TMP_UPT%"
if "x%TMP_UPDATER%"=="x1" goto :UPDATE_MAIN

copy /y "%~0" "%TMP_UPT%\" 1>nul
copy /y "%~dpn0.vbs" "%TMP_UPT%\" 1>nul

del /f /a /q "%TMP_UPT%\local.md5"
del /f /a /q "%TMP_UPT%\fciv.err"
del /f /a /q "%TMP_UPT%\updatefile.list"

set TMP_UPDATER=1
"%TMP_UPT%\%~nx0" %*

:UPDATE_MAIN

set APP_ARCH=x64
if /i %PROCESSOR_IDENTIFIER:~0,3%==x86 set APP_ARCH=x86
set "PATH=%APP_ROOT%\bin\%APP_ARCH%;%APP_ROOT%\bin;%PATH%"

set "TMP_UPT=%APP_ROOT%\%TMP_UPT%"
cd /d "%TMP_UPT%"
title Updater
echo Updating ...
echo.
echo PHASE 1:Create local.MD5 mainifest ...
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
echo PHASE 2:Download remote.MD5 mainifest ...

if exist "%TMP_UPT%\remote.md5" goto :END_REMOTE_MD5
set remote_md5=https://github.com/slorelee/wimbuilder2/releases/download/update/remote.md5

aria2c.exe -c "%remote_md5%" -d "%TMP_UPT%" -o remote.md5
:END_REMOTE_MD5

pause
