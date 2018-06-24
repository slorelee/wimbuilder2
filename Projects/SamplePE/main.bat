@echo off
echo %cd%
ping -n 3 127.1 >nul
echo xcopy file(s)...
dir /b "%windir%"
ping -n 3 127.1 >nul
pause