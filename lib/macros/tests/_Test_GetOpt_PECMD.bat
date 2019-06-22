@echo off

call :GetOpt_PECMD
echo "Exec %_ExecOpt%APP.exe"
call :GetOpt_PECMD /wait
echo "Exec %_ExecOpt%APP.exe"
call :GetOpt_PECMD  /hide
echo "Exec %_ExecOpt%APP.exe"
call :GetOpt_PECMD /wait /hide
echo "Exec %_ExecOpt%APP.exe"
call :GetOpt_PECMD /hide /wait
echo "Exec %_ExecOpt%APP.exe"
pause

:GetOpt_PECMD
set _ExecOpt=
if "x%1"=="x" goto :EOF
if /i "%1"=="/wait" set _ExecOpt=%_ExecOpt%=
if /i "%1"=="/hide" set _ExecOpt=!%_ExecOpt%

if /i "%2"=="/wait" set _ExecOpt=%_ExecOpt%=
if /i "%2"=="/hide" set _ExecOpt=!%_ExecOpt%
goto :EOF
