@echo off
if "x%~1"=="x" goto :EOF

if exist "%APP_ROOT%\AppData\editor.cmd" (
    "%APP_ROOT%\AppData\editor.cmd" %*
)

start notepad.exe "%~1"
