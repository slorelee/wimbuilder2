@echo off

set MISSING_FILES=0
if not exist "%APP_ROOT%\bin\x64\7z.exe" set MISSING_FILES=1
if not exist "%APP_ROOT%\bin\x86\7z.exe" set MISSING_FILES=1

if %MISSING_FILES% NEQ 0 (
    xcopy /e /y "%APP_ROOT%\vendor\7za\*.*" "%APP_ROOT%\bin\"
)
set MISSING_FILES=0

if not exist "%APP_ROOT%\bin\x64\aria2c.exe" (
    copy "%APP_ROOT%\vendor\aria2\aria2c_x64.exe" "%APP_ROOT%\bin\x64\aria2c.exe"
)
if not exist "%APP_ROOT%\bin\x86\aria2c.exe" (
    copy "%APP_ROOT%\vendor\aria2\aria2c_x86.exe" "%APP_ROOT%\bin\x86\aria2c.exe"
)

call :CHECK_FILE 7z.exe x64
call :CHECK_FILE 7z.exe x86

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
