rem MACRO:AddFiles
rem analyze syntax, create _AddFiles.txt for wimlib

rem AddFiles with one line
rem        call AddFiles \Windows\System32\config\SOFTWARE
rem        call AddFiles \Windows\System32\dm*.dll
rem        call AddFiles "@windows\system32\#ndevmgmt.msc,devmgr.dll"

rem AddFiles with mutil lines
rem        call AddFiles %0 :end_files
rem        goto :end_files
rem        ; Explorer
rem       \Windows\explorer.exe
rem       \Windows\??-??\explorer.exe.mui
rem       ; ...
rem       :end_files

echo [MACRO]AddFiles %*
if "x%WB_TMP_PATH%"=="x" goto :EOF

if "x%ADDFILES_SYSRES%"=="x" (
    set ADDFILES_SYSRES=0
    if exist "%X%\Windows\SystemResources\shell32.dll.mun" set ADDFILES_SYSRES=1
)

if "x%ADDFILES_INITED%"=="x" (
    wimlib-imagex.exe dir "%WB_SRC%" %WB_SRC_INDEX% --path=\Windows\System32\%WB_PE_LANG%\ >"%WB_TMP_PATH%\_AddFiles_SYSMUI.txt"
    if "x%WB_PE_ARCH%"=="xx64" (
        wimlib-imagex.exe dir "%WB_SRC%" %WB_SRC_INDEX% --path=\Windows\SysWOW64\%WB_PE_LANG%\ >>"%WB_TMP_PATH%\_AddFiles_SYSMUI.txt"
    )
    rem *.mun files present from 19H1
    if %ADDFILES_SYSRES% EQU 1 (
        wimlib-imagex.exe dir "%WB_SRC%" %WB_SRC_INDEX% --path=\Windows\SystemResources\ >"%WB_TMP_PATH%\_AddFiles_SYSRES.txt"
    )
    set ADDFILES_INITED=1
)

if "x%AddFiles_Mode%"=="xbatch" goto :_AppendFiles
if "x%AddFiles_Mode%"=="xmerge" goto :_AppendFiles
type nul>"%WB_TMP_PATH%\_AddFiles.txt"

:_AppendFiles
rem CALL AddFiles.vbs
cscript //nologo  "%~dp0\AddFiles.vbs" %* "%WB_TMP_PATH%\_AddFiles.txt"

if "x%AddFiles_Mode%"=="xbatch" goto :EOF
if "x%AddFiles_Mode%"=="xmerge" goto :EOF
call DoAddFiles
