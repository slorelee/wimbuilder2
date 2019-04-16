@echo off
if "x%~1"=="x" goto :EOF
start notepad.exe "%~1"
