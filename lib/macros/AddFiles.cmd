@echo off

rem MACRO:AddFiles
rem analyze syntax, create _AddFiles.txt for wimlib

rem AddFiles with one line
rem        call AddFiles \Windows\System32\config\SOFTWARE
rem        call AddFiles \Windows\System32\dm*.dll

rem AddFiles with mutil lines
rem        call AddFiles %0 :end_files
rem        goto :end_files
rem        ; Explorer
rem       \Windows\explorer.exe
rem       \Windows\??-??\explorer.exe.mui
rem       ; ...
rem       :end_files

echo [MACRO]AddFiles %*
if "x%_WB_TMP_DIR%"=="x" goto :EOF

rem *.mun files present from 19H1
if "x%ADDFILES_INITED%"=="x" (
    wimlib-imagex.exe dir "%WB_SRC%" %WB_SRC_INDEX% --path=\Windows\SystemResources\ >"%_WB_TMP_DIR%\_AddFiles_SYSRES.txt"
    set ADDFILES_INITED=1
)

type nul>"%_WB_TMP_DIR%\_AddFiles.txt"

rem CALL AddFiles.vbs
cscript //nologo  "%~dp0\AddFiles.vbs" %* "%_WB_TMP_DIR%\_AddFiles.txt"

if "x%AddFiles_Mode%"=="xbatch" goto :EOF
if "x%AddFiles_Mode%"=="xmerge" goto :EOF
call DoAddFiles
