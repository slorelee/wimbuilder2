call V2X yong -Extract "yong-win-*-0.7z" "%X_PF%\"
if not exist "%X_PF%\yong\" goto :EOF

rem config
if exist "%V%\yong\.yong\" xcopy /E /Y "%V%\yong\.yong\*.*" "%X_PF%\yong\.yong\"

if "%WB_PE_ARCH%"=="x64" (
    echo start "yong_ime" "%%ProgramFiles%%\yong\w64\yong.exe" > "%X_Startup%\StartYongIME.bat"
) else (
    echo start "yong_ime" "%%ProgramFiles%%\yong\yong.exe" > "%X_Startup%\StartYongIME.bat"
)
