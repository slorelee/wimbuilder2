if "x%opt[slim.ultra]%"=="xtrue" (
    call TextReplace "%X_SYS%\winpeshl.ini" "wpeinit.exe" "cmd.exe,/c"
    call TextReplace "%X_PEMaterial%\winpeshl.ini" "wpeinit.exe" "cmd.exe,/c"
)

if "x%opt[system.workgroup]%"=="x" (
    rem del /a /f /q "%X_SYS%\startnet.exe"
)
