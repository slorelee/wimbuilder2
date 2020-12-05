
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
set "_pt_path=%_pt_path:\Projects\=\AppData\Projects\%"
call :apply_patch "%_pt_path%\%_WB_WALK_CMD%"
goto :EOF

:apply_patch
if not exist "%~1" goto :EOF
pushd "%~dp1"
echo \033[96mApplying Patch:%~dpnx1 | cmdcolor.exe
call "%~1"
popd
