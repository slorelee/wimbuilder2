@echo off

rem MACRO:RegCopy
rem replace KEY_PATH to Src_XXX, Tmp_XXX and call reg.exe COPY

echo [MACRO]RegCopy %*

set "param_key=%~1"
set "src_key=%param_key:HKLM\Software\=HKLM\Src_Software\%"
set "tmp_key=%param_key:HKLM\Software\=HKLM\Tmp_Software\%"

set "src_key=%src_key:HKLM\SYSTEM\=HKLM\Src_SYSTEM\%"
set "tmp_key=%tmp_key:HKLM\SYSTEM\=HKLM\Tmp_SYSTEM\%"

reg copy "%src_key%" "%tmp_key%"
