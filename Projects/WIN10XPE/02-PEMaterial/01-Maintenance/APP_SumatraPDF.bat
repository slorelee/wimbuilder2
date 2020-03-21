rem SumatraPDF-3.2.zip
rem SumatraPDF-3.2-64.zip
rem SumatraPDF-3.2-32.exe
rem SumatraPDF-3.2-64.exe

call App pull https://www.sumatrapdfreader.org/dl2/SumatraPDF-3.2%_V-64%.zip
call :BUILD "%APP_FILE%"
goto :EOF

:BUILD
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%_Loc%\PortableApps\%APP_NAME%\"
if "x%_V-64%"=="x" set _V-32=-32
del /f /q "%_Loc%\PortableApps\%APP_NAME%\%APP_NAME%-%_V3264%.exe"
ren "%_Loc%\PortableApps\%APP_NAME%\%APP_FILE[n]%%_V-32%.exe" "%APP_NAME%-%_V3264%.exe"
goto :EOF
