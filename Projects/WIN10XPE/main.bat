@echo off
echo %cd%

set opt

cd /d "%~dp0"

if "x%opt[build.registry.software]%"=="xfull" (
  call PERegPorter.bat Tmp UNLOAD 1>nul
  call AddFiles \Windows\System32\config\SOFTWARE
  call PERegPorter.bat Tmp LOAD 1>nul
  set REGCOPY_SKIP_SOFTWARE=1
)

if "x%opt[build.wow64support]%"=="xtrue" (
  if not "x%WB_PE_LANG%"=="xx64" set opt[build.wow64support]=false
  set ADDFILES_SKIP_WOW64=1
)

rem call X2X macro
xcopy /E /Y X\*.* X:\
