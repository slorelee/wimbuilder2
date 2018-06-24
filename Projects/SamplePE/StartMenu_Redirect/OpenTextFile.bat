@echo off

echo MACRO:OpenTextFile
echo    I will open %2 and modify it with %4@%3 section
echo    using BAT/VBS/JS/POWERSHELL/AUTOIT/PYTHON/RUBY/C/C++...
echo.
echo we can read %%3's %%4 section macro code like:
echo MoveTo("exit"),Add("test"),Append("code") or eval(normal code)

echo.
echo.
if /i not "x%1"=="xJS" (goto :EOF)

rem CALL OpenTextFile.js
cscript //nologo OpenTextFile.js %2 %3 %4

