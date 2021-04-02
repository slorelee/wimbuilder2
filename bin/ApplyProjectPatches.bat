
if "x%~1"=="x" goto :EOF
set "project_path=%~1"

set _WB_WALK_CMD=main.bat
call :apply_patch "%project_path%\main.bat"

if not exist "%WB_TMP_PATH%\_patches_selected.txt" goto :EOF

for /f "usebackq delims=" %%i in ("%WB_TMP_PATH%\_patches_selected.txt") do (
    call :apply_link_patch "%project_path%\%%i"
)

set _WB_WALK_CMD=last.bat
for /f "usebackq delims=" %%i in ("%WB_TMP_PATH%\_patches_selected.txt") do (
    call :apply_link_patch "%project_path%\%%i"
)

call :apply_patch "%project_path%\last.bat"

goto :EOF

:apply_link_patch
set "_pt_path=%~1"
if not "x%_pt_path:~-5%"=="x.LINK" (
    call :apply_patch "%_pt_path%\%_WB_WALK_CMD%"
    goto :EOF
)
set "_pt_path=%_pt_path:~0,-5%"
call set "_pt_path=%%_pt_path:\Projects\=\%APPDATA_DIR%\Projects\%%"
call :apply_patch "%_pt_path%\%_WB_WALK_CMD%"
goto :EOF

:apply_patch
if "x%WB_LEAVE_PATCH%"=="x" goto :end_leave_patch
set "_patch_path=%~dp1"
call set "_not_sub_path=%%_patch_path:%WB_LEAVE_PATCH%=%%"
if "x%_not_sub_path%"=="x%_patch_path%" (
    if exist "%WB_LEAVE_PATCH%leave_%~nx1" (
        pushd "%WB_LEAVE_PATCH%"
        echo \033[96mApplying Patch: %WB_LEAVE_PATCH%leave_%~nx1 | cmdcolor.exe
        call "leave_%~nx1"
        popd
    )
    set WB_LEAVE_PATCH=
)
set _not_sub_path=
set _patch_path=
:end_leave_patch
if not exist "%~1" goto :EOF
pushd "%~dp1"
echo \033[96mApplying Patch: %~dpnx1 | cmdcolor.exe
call "%~1"
popd
