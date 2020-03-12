@echo off

set MISSING_FILES=0

if not exist "%APP_ROOT%\bin\x64\7za.exe" (
    copy "%APP_ROOT%\vendor\7za\7za_x64.exe" "%APP_ROOT%\bin\x64\7za.exe"
)
if not exist "%APP_ROOT%\bin\x86\7za.exe" (
    copy "%APP_ROOT%\vendor\7za\7za_x86.exe" "%APP_ROOT%\bin\x86\7za.exe"
)

call :CHECK_FILE 7za.exe x64
call :CHECK_FILE 7za.exe x86

if %MISSING_FILES% NEQ 0 (
    echo \033[97;104m Some files are missing. Please download them by yourself,|cmdcolor.exe
    echo \033[97;104m or download the full released package.                   |cmdcolor.exe
    sleep.exe 5
)
set MISSING_FILES=
goto :EOF

:CHECK_FILE
set "chkfile=%APP_ROOT%\bin\%2\%1"
if not exist "%chkfile%" (
    echo \033[91m Missing: %chkfile%|cmdcolor.exe
    set MISSING_FILES=1
)
