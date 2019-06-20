rem //TODO _ExecOpt

set "_ExecOpt=="
if not "x%~2"=="x" set "_ExecOpt=%~2"

echo [MACRO]RunBeforeShell %*
if "x%PE_LOADER%"=="xPECMD" call :PECMD_RUNBEFORESHELL %*
if "x%PE_LOADER%"=="xLUA" call :LUA_RUNBEFORESHELL %*
goto :EOF

:PECMD_RUNBEFORESHELL
call TextReplace "%X_SYS%\pecmd.ini" "_SUB LoadShell" "_SUB LoadShell#r#nEXEC =%~1"
goto :EOF

:LUA_RUNBEFORESHELL
call TextReplace "%X_PEMaterial%\pecmd.lua" "-- RunBeforeShell" "-- RunBeforeShell#r#n  exec([[%~1]])"
goto :EOF
