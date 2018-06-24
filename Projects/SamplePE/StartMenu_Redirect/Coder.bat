@echo off

echo MACRO:Coder
echo    Run %3 block in %2
echo    as %1 code
echo.
rem remove the program language argument
IF /I "x%1"=="xVBS" (SHIFT && GOTO :EOF)
IF /I "x%1"=="xJS" (GOTO :EOF)
GOTO :EOF

:VBS
cscript //nologo coder.vbs %*
GOTO :EOF

:JS
cscript //nologo coder.js %*
GOTO :EOF
