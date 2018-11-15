@echo off

rem MACRO:RegCopy
rem replace KEY_PATH to Src_XXX, Tmp_XXX and call reg.exe COPY
rem Usage:
rem       RegCopy HKLM\System\ControlSet001\Services\NlaSvc
rem       RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners *_microsoft.vc90.crt_*

set "param_key=%~1"
if "%param_key:~0,5%"=="HKLM\" set "param_key=%param_key:~5%"
set "src_key=HKLM\Src_%param_key%"
set "tmp_key=HKLM\Tmp_%param_key%"

set "chk_key=%src_key:HKLM\Src_Software\=%"
if "x%REGCOPY_SKIP_SOFTWARE%"=="x1" (
  if not "%chk_key%"=="%src_key%" goto :EOF
)


echo [MACRO]RegCopy %*

if "x%~2"=="x" goto :_SimpleCopy
set "find_key=%~2"
for /f "delims=" %%A IN ('Reg Query "%src_key%" /s /f "%find_key%"') Do Call :_RegCopy "%%A"
goto :EOF

:_SimpleCopy
reg copy "%src_key%" "%tmp_key%" /s /f
goto :EOF

:_RegCopy
Set "found_key=%~1"
if "%found_key:~0,23%" neq "HKEY_LOCAL_MACHINE\Src_" goto :EOF
set "tmp_key=HKEY_LOCAL_MACHINE\Tmp_%found_key:~23%"
rem Reg Query "%found_key%" >nul 2>nul
::If Not ErrorLevel 1 Echo Reg Copy "%HKeyOrg%" "%HKeyNew%" /S /F
reg copy "%found_key%" "%tmp_key%" /S /F
goto :EOF

