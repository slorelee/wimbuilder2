@echo off
echo %cd%

set opt
rem Dism /Get-Packages /Image:"%_WB_MNT_DIR%"

cd /d "%~dp0"


set opt[build.wim]=customed
if "%WB_BASE%"=="winre.wim" (
  set opt[build.wim]=winre
)
if "x%opt[build.adk]%"=="xtrue" (
  set opt[build.wim]=winpe
)

if "x%opt[build.wow64support]%"=="xtrue" (
  if not "x%WB_PE_ARCH%"=="xx64" set opt[build.wow64support]=false
)

set opt[support.wow64]=%opt[build.wow64support]%
if "%opt[support.wow64]%"=="true" (
  set ADDFILES_SYSWOW64=1
)

rem call CheckPatch "01-Components\02-Network"
rem set opt[support.network]=%HasPatch%

call CheckPatch "01-Components\03-Audio"
set opt[support.audio]=%HasPatch%

if not "x%opt[build.main_filereg_disabled]%"=="xtrue" (
  call X2X
)

