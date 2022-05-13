if not "x%opt[shell.app]%"=="xexplorer" goto :EOF

if %VER[3]% GEQ 22610 goto :EOF
if exist "%X_PF%\StartAllBack\" goto :EOF

rem Windows 11 Preview
if %VER[3]% GEQ 22000 (
    call V2X Explorer -copy "explorer_%_Vx8664%.exe" "%X_WIN%\explorer.exe"
)
