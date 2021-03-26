rem Call this by Projects\[ProjectName]\prepare.bat
if "x%~1"=="x" goto :EOF
call %1
goto :EOF

:BEFORE_WIM_BUILD
rem ===================================
if "x%opt[custom.cmd_mode]%"=="xtrue" (
    rem dummy line - DON'T DELETE THIS LINE
    %opt[custom.cmd_mode_code]%
)

set "_CUSTOMFILES_=%WB_PROJECT_PATH%\_CustomFiles_"
set "WB_USER_PROJECT_PATH=%WB_ROOT%\%APPDATA_DIR%\Projects\%WB_PROJECT%"
set "_USER_CUSTOMFILES_=%WB_USER_PROJECT_PATH%\_CustomFiles_"
call "%WB_PROJECT_PATH%\shared\CheckUserFiles.bat"

if exist "%_USER_CUSTOMFILES_%\_Prepare_.bat" (
    pushd "%_USER_CUSTOMFILES_%\"
    call _Prepare_.bat :BEFORE_WIM_BUILD
    popd
)
rem ===================================
goto :EOF

:BEFORE_WIM_MOUNT
rem ===================================

rem ===================================
goto :EOF

:BEFORE_HIVE_LOAD
rem ===================================

rem ===================================
goto :EOF
