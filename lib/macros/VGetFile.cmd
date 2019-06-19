set "_V_Pat=%~1"

if "x%_V_Ver%"=="x*" (
  call :_GetLatestFile
) else (
  set "_V_File=%_V_Pat%"
)
goto :EOF

:_GetLatestFile
for /f "delims=" %%i in ('dir /b /on "%_V_Pat%"') do (
    set "_V_File=%%i"
)
