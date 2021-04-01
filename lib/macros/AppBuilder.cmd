
if "x%WB_ROOT%"=="x" goto :EOF
set "_Loc=%PEM.Loc%"
set "_wd=%cd%"
for /f "delims=" %%i in ('dir /b APP_*.bat') do call :build %%i
goto :EOF

:build
set APP_FILE=&set APP_VER=&set APP_URL=
set "APP_NAME=%~n1"
set APP_NAME=%APP_NAME:~4%
call "%_wd%\%1"
goto :EOF
