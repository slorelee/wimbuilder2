call V2X yong -Extract "yong-win-*-0.7z" "%X_PF%\"
if not exist "%X_PF%\yong\" goto :EOF

rem config
if exist "%V%\yong\.yong\" xcopy /E /Y "%V%\yong\.yong\*.*" "%X_PF%\yong\.yong\"

if "%WB_PE_ARCH%"=="x64" (
    call RunBeforeShell "#qX:\Program Files\yong\w64\yong.exe#q"
) else (
    call RunBeforeShell "#qX:\Program Files\yong\yong.exe#q"
)
