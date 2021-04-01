set Downloads

if not "%PEM.Loc%"=="%X%\PEMaterial" goto :EOF
if not exist "%PEM.Loc%\Program Files\" goto :EOF

move /y "%PEM.Loc%\Program Files\*.*" "%X%\Program Files\"
for /f "delims=" %%i in ('dir /ad /b "%PEM.Loc%\Program Files\"') do (
  move /y "%PEM.Loc%\Program Files\%%i" "%X%\Program Files\"
)

rd /s /q "%PEM.Loc%\Program Files\"
