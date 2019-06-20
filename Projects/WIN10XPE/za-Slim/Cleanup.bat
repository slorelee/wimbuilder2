rem delete useless files
call :DELEX /q "%X_SYS%\edgehtml.dll"

rem remove usless mui & mun files
set Check_SysWOW64=0
if "x%opt[support.wow64]%"=="xtrue" set Check_SysWOW64=1
if not exist "%X_WIN%\SystemResources" goto :END_DEL_MUN

for /f %%i in ('dir /a-d /b "%X_WIN%\SystemResources"') do (
    if not exist "%X_SYS%\%%~ni" (
        if %Check_SysWOW64% EQU 0 (
            call :DELEX "/f /a /q" "%X_WIN%\SystemResources\%%i" "Remove orphan "
        ) else (
            if not exist "%X_WIN%\SysWOW64\%%~ni" (
                call :DELEX "/f /a /q" "%X_WIN%\SystemResources\%%i" "Remove orphan "
            )
        )
    )
)
:END_DEL_MUN
rem ignore *.msc files
for /f %%i in ('dir /a-d /b "%X_SYS%\%WB_PE_LANG%\*.mui"') do (
    if not exist "%X_SYS%\%%~ni" (
        call :DELEX "/f /a /q" "%X_SYS%\%WB_PE_LANG%\%%i" "Remove orphan "
    )
)

if %Check_SysWOW64% EQU 0 goto :END_DEL_MUI

for /f %%i in ('dir /a-d /b "%X_WIN%\SysWOW64\%WB_PE_LANG%\*.mui"') do (
    if not exist "%X_WIN%\SysWOW64\%%~ni" (
        call :DELEX "/f /a /q" "%X_WIN%\SysWOW64\%WB_PE_LANG%\%%i" "Remove orphan "
    )
)

:END_DEL_MUI
set Check_SysWOW64=
goto :EOF

:DELEX
if exist "%~2" (
    if not "x%~3"=="x" echo %~3%~2
    del %~1 "%~2"
)
goto :EOF

