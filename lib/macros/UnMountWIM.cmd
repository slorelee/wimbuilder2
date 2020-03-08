@echo off
if "x%WB_PROJECT%"=="x" goto :EOF

if "x%_WB_PE_WIM%"=="x" (
    set "_WB_TAR_DIR=%Factory%\target\%WB_PROJECT%"
    set "_WB_MNT_DIR=%_WB_TAR_DIR%\mounted"

    call :GETNAME "%WB_BASE%"
    set "_WB_PE_WIM=%_WB_TAR_DIR%\%RET_GETNAME%"
    set _KEEP_CONSOLE=1
)

call _Cleanup 0
call WIM_Exporter "%_WB_PE_WIM%"

echo \033[96mWIM Exported:%_WB_TAR_DIR%\build\boot.wim | cmdcolor.exe

if "x%_KEEP_CONSOLE%"=="x1" pause

goto :EOF

:GETNAME
set "RET_GETPATH=%~dp1"
set "RET_GETNAME=%~nx1"
goto :EOF
