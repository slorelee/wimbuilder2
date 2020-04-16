call :%1 %*
goto :EOF

:PULL
shift
set "APP_URL=%~1"
if not "x%2"=="x" set "APP_FILE=%~2"
if "x%APP_FILE%"=="x" set "APP_FILE=%~nx1"
call :INFO "%APP_FILE%"

if exist "%V%\%APP_CACHE%\%APP_FILE%" (
    set Downloads[%APP_FILE%]=SKIP
    goto :EOF
)

aria2c.exe -c "%~1" -d "%V%\%APP_CACHE%" -o "%APP_FILE%"
if exist "%V%\%APP_CACHE%\%APP_FILE%" (
    set Downloads[%APP_FILE%]=OK
) else (
    set Downloads[%APP_FILE%]=FAILED
)
goto :EOF

:INFO
if /i "x%1"=="xINFO" shift
set "APP_FILE[dp]=%~dp1"
set "APP_FILE[n]=%~n1"
set "APP_FILE[x]=%~x1"
goto :EOF

:INIT
set "APP_CACHE=%~2"
goto :EOF

