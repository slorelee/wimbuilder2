@echo off
pushd "%~dp0"
set Autoruns_Runner=1
set "RUNLOG=%Temp%\Runner.log"
if "x%~1"=="x" goto :RUN_END
if not exist "%~1" goto :RUN_END

set "_f1=%~dp0%~1"
cd /d "%~1"

for /f %%i in ('dir /b *.*') do (
  call :ExecDispatcher "%%~i"
)

:RUN_END
popd

goto :EOF

:ExecDispatcher
if "x%SYSTEM_LOADER%"=="x1" (
  echo ExecDispatcher "%~1"
)
echo ExecDispatcher "%~1" >> "%RUNLOG%"
set RunOnce=0
cd /d "%_f1%"
if /i "%~x1"==".reg" reg import "%~1"
if /i "%~x1"==".bat" call "%~1"
if /i "%~x1"==".cmd" call "%~1"
if /i "%~x1"==".exe" start "%~n1" "%~1"
if %RunOnce% EQU 1 (
  ren "%_f1%\%~1" "%~nx1.done"
)
goto :EOF
