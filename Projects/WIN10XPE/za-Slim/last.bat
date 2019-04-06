if exist "%X_SYS%\pecmd.ini" call :UPDATE_PECMD

if "x%opt[slim.ultra]%"=="xtrue" (
    call TextReplace "%X_SYS%\winpeshl.ini" "wpeinit.exe" "cmd.exe,/c"
)

if "x%opt[system.workgroup]%"=="x" (
    del /a /f /q "%X_SYS%\startnet.exe"
)

goto :EOF

:UPDATE_PECMD
if not "x%opt[support.audio]%"=="xtrue" (
    call TextReplace "%X_SYS%\pecmd.ini" "CALL AudioInit" "#// CALL AudioInit"
)
if not "x%opt[support.network]%"=="xtrue" (
    call TextReplace "%X_SYS%\pecmd.ini" "CALL NetInit" "#// CALL NetInit"
)
goto :EOF
