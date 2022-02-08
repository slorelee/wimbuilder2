echo MACRO:Coder
echo    Run %3 block in %2
echo    as %1 code
echo.
IF /I "x%1"=="xVBS" (GOTO :VBS)
IF /I "x%1"=="xJS" (GOTO :JS)
echo UNKNOWN Coder
GOTO :EOF

:VBS
echo VBS Coder
cscript //nologo "%~dp0\coder.vbs" %*
GOTO :EOF

:JS
echo JS Coder
cscript //nologo "%~dp0\coder.js" %*
GOTO :EOF
