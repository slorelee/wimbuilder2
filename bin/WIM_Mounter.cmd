if "x%3"=="x" goto :EOF
if not "x%~4"=="x" set %~4=

call WB_LOG "[%WB_PROJECT%] --- MOUNT [%~1:%2] -%%gt:%% [%~3]"
if not exist "%~3" mkdir "%~3"
call DismX /mount-wim /wimfile:"%~1" /index:%2 /mountdir:"%~3"

if "x%~4"=="x" goto :EOF
if "%errorlevel%"=="0" set %~4=1
