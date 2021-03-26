@echo off
if "x%~1"=="x" goto :EOF

if exist "%APP_ROOT%\%APPDATA_DIR%\editor.cmd" (
    "%APP_ROOT%\%APPDATA_DIR%\editor.cmd" %*
)

start notepad.exe "%~1"
