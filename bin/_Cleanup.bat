@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
title WimBuilder(%cd%)

if "x%WB_PROJECT%"=="x" goto :EOF
if "x%_WB_MNT_DIR%"=="x" (
  set "_WB_MNT_DIR=%Factory%\target\%WB_PROJECT%\mounted"
)

call PERegPorter.bat Src UNLOAD 1>nul
call PERegPorter.bat Tmp UNLOAD 1>nul

set UNMNT_OPT=/discard
if "x%1"=="x0" (
  rem cleanup REGISTRY log files
  del /f /q /a X:\Windows\System32\config\*.LOG* 1>nul 2>nul
  del /f /q /a X:\Windows\System32\config\*{*}* 1>nul 2>nul
  del /f /q /a X:\Windows\System32\SMI\Store\Machine\*.LOG* 1>nul 2>nul
  del /f /q /a X:\Windows\System32\SMI\Store\Machine\*{*}* 1>nul 2>nul
  set UNMNT_OPT=/commit
)

if exist "%_WB_MNT_DIR%\Windows" (
  call WIM_UnMounter.bat "%_WB_MNT_DIR%" %UNMNT_OPT% base_wim_mounted
)

if exist X:\ SUBST X: /D

echo Cleanup finished.
