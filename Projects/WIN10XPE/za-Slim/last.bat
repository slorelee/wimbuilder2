if exist "%X_SYS%\pecmd.ini" call :UPDATE_PECMD
goto :EOF

:UPDATE_PECMD
if not "x%opt[support.audio]%"=="xtrue" (
call TextReplace "%X_SYS%\pecmd.ini" "CALL AudioInit" "#// CALL AudioInit"
)
if not "x%opt[support.network]%"=="xtrue" (
call TextReplace "%X_SYS%\pecmd.ini" "CALL NetInit" "#// CALL NetInit"
)
goto :EOF
