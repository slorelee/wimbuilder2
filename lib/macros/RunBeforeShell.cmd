rem RunBeforeShell cmdline [/wait|/hide|"/wait /hide"]

if not "x%~2"=="x" set "_ExecOpt=%~2"

echo [MACRO]RunBeforeShell %*
if "x%PE_LOADER%"=="xPECMD" call :PECMD_RUNBEFORESHELL %*
if "x%PE_LOADER%"=="xLUA" call :LUA_RUNBEFORESHELL %*

set _ExecOpt=
goto :EOF

:PECMD_RUNBEFORESHELL
call :GetOpt_PECMD %_ExecOpt%
call TextReplace "%X_SYS%\pecmd.ini" "_SUB LoadShell" "_SUB LoadShell#r#nEXEC % _ExecOpt%%~1"
goto :EOF

:LUA_RUNBEFORESHELL
if not "x%_ExecOpt%"=="x" set "_ExecOpt=#q%_ExecOpt%#q, "
call TextReplace "%X_PEMaterial%\pecmd.lua" "-- RunBeforeShell" "-- RunBeforeShell#r#n  exec(%_ExecOpt%[[%~1]])"
goto :EOF


:GetOpt_PECMD
if "x%1"=="x" goto :EOF
if /i "%1"=="/wait" set _ExecOpt=%_ExecOpt%=
if /i "%1"=="/hide" set _ExecOpt=%_ExecOpt%!

if /i "%2"=="/wait" set _ExecOpt=%_ExecOpt%=
if /i "%2"=="/hide" set _ExecOpt=%_ExecOpt%!
goto :EOF
