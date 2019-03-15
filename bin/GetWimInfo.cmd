@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set exe=Dism
set BIN_ARCH=x86
if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" set BIN_ARCH=x64
if exist %~dp0%BIN_ARCH%\wimlib-imagex.exe (
    set exe=wimlib-imagex.exe
)
rem wimlib-imagex.exe can't show some characters

set WIM_DESC=Unknown
set WIM_VER=
set WIM_ARCH=
set WIM_LANG=
for /f "tokens=1,2 delims=:(" %%i in ('DismX /Get-WimInfo /WimFile:"%~1" /Index:%~2 /English') do (
  if "%%i"=="Description " set WIM_DESC=%%j
  if "%%i"=="Architecture " set WIM_ARCH=%%j
  if "%%i"=="Version " set WIM_VER=%%j
  if "x!LANG_FLAG!"=="x1" (
    set WIM_LANG=%%i
    set LANG_FLAG=
  )
  if "%%i"=="Languages " set LANG_FLAG=1
)

set "WIM_ARCH=%WIM_ARCH: =%"
set "WIM_VER=%WIM_VER: =%"
rem here is TAB, not SPACE 
set "WIM_LANG=%WIM_LANG:	=%"
set "WIM_LANG=%WIM_LANG: =%"

echo %WIM_DESC% (%WIM_VER%,%WIM_ARCH%,%WIM_LANG%)
