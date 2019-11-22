rem delete useless files
call :DELEX /q "%X_SYS%\edgehtml.dll"

if not exist "%X_SYS%\MdSched.exe" (
    call :DELEX /q "%X%\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Memory Diagnostics Tool.lnk"
)

set Check_SysWOW64=0
if exist "%X_WIN%\SysWOW64\wow32.dll" set Check_SysWOW64=1

rem remove usless mui & mun files
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

rem cleanup registry
if %Check_SysWOW64% EQU 0 call :REMOVE_WOW64_REG

set Check_SysWOW64=
goto :EOF


:REMOVE_WOW64_REG
if "x%opt[build.registry.software]%"=="xfull" (
    reg delete HKLM\Tmp_Software\Classes\Wow6432Node /f
    reg delete HKLM\Tmp_Software\Wow6432Node /f
    rem HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86;wow64
)
goto :EOF

:DELEX
if exist "%~2" (
    if not "x%~3"=="x" echo %~3%~2
    del %~1 "%~2"
)
goto :EOF

