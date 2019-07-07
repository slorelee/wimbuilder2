@echo off
cd /d "%~dp0"
if "x%~1"=="x" goto :EOF
if not exist "%~1" goto :EOF
cd /d "%~1"

for /f %%i in ('dir /b *.*') do (
  call :ExecDispatcher "%%~i"
)
goto :EOF

:ExecDispatcher
if /i "%~x1"==".reg" reg import "%~1"
if /i "%~x1"==".bat" call "%~1"
if /i "%~x1"==".cmd" call "%~1"
if /i "%~x1"==".exe" start "%~n1" "%~1"

goto :EOF

:LOG
goto :EOF
