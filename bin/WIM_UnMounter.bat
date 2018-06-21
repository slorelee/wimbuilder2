call WB_LOG "[%WB_PROJECT%] --- UNMOUNT [%~1] %~2"
if /i "%~2"=="/commit" (
  rem if not exist "%~dp1tmp" mkdir "%~dp1tmp"
  rem DismX /Cleanup-Image /Image="%~1" /StartComponentCleanup /ResetBase /ScratchDir:"%~dp1tmp"
  rem if ERRORLEVEL 1 goto :EOF
)
DismX /unmount-wim /MountDir:"%~1" %~2

if "x%~3"=="x" goto :EOF
if "%errorlevel%"=="0" set %~3=
