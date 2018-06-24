@echo off

rem MACRO:AddFiles
rem analyze syntax, create _AddFiles.txt for wimlib

echo [MACRO]AddFiles %*
if "x%_WB_TMP_DIR%"=="x" goto :EOF

rem CALL AddFiles.vbs
cscript //nologo  "%~dp0\AddFiles.vbs" %* "%_WB_TMP_DIR%\_AddFiles.txt"
call DoAddFiles
