if not exist "%WB_PROJECT_PATH%\shared" goto :EOF
if "x%~1"=="x" goto :EOF
if not exist "%WB_PROJECT_PATH%\shared\%~1" goto :EOF

set _SP_DONE=
call set "_SP_DONE=%%_SP[%~1_%_WB_WALK_CMD%]%%"
if "x%_SP_DONE%"=="x1" (
    echo \033[96mSkipping Shared Patch:%cd%\%_WB_WALK_CMD% | cmdcolor.exe
    goto :EOF
)

pushd "%WB_PROJECT_PATH%\shared\%~1"
echo \033[96mApplying Shared Patch:%cd%\%_WB_WALK_CMD% | cmdcolor.exe
set "_SP[%~1_%_WB_WALK_CMD%]=1"
if exist %_WB_WALK_CMD% call %_WB_WALK_CMD%
popd
