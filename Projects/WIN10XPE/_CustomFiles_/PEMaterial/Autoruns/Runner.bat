@echo off
pushd "%~dp0"
if "x%~1"=="x" goto :RUN_END
if not exist "%~1" goto :RUN_END
cd /d "%~1"

for /f %%i in ('dir /b *.*') do (
  call :ExecDispatcher "%%~i"
)

:RUN_END
popd

goto :EOF

:ExecDispatcher
if /i "%~x1"==".reg" reg import "%~1"
if /i "%~x1"==".bat" call "%~1"
if /i "%~x1"==".cmd" call "%~1"
if /i "%~x1"==".exe" start "%~n1" "%~1"
goto :EOF
