
if "x%~1"=="x" goto :EOF
set "project_path=%~1"

call :apply_patch "%project_path%\main.bat"

if not exist "%_WB_TMP_DIR%\_patches_selected.txt" goto :EOF

set _WB_WALK_CMD=main.bat
for /f "usebackq delims=" %%i in ("%_WB_TMP_DIR%\_patches_selected.txt") do (
    call :apply_patch "%project_path%\%%i\main.bat"
)

set _WB_WALK_CMD=last.bat
for /f "usebackq delims=" %%i in ("%_WB_TMP_DIR%\_patches_selected.txt") do (
    call :apply_patch "%project_path%\%%i\last.bat"
)

call :apply_patch "%project_path%\last.bat"

goto :EOF

:apply_patch
if not exist "%~1" goto :EOF
pushd "%~dp1"
echo \033[96mApplying Patch:%~dpnx1 | cmdcolor.exe
call "%~1"
popd
