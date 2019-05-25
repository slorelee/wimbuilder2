if "x%~1"=="x" goto :EOF
set GetLastError=1
set "BUILD_WIM=%~dp1build\boot.wim"
if exist "%BUILD_WIM%" del /q "%BUILD_WIM%"
call :MKPATH "%BUILD_WIM%"
call WB_LOG "[%WB_PROJECT%] --- EXPORT [%~1:%WB_BASE_INDEX%] -%%gt:%% [%_WB_TAR_DIR%\build\boot.wim]"

if "x%USE_WIMLIB%"=="x1" (
    wimlib-imagex.exe capture "%_WB_MNT_DIR%" "%BUILD_WIM%" "%WB_PROJECT%" "%WB_PROJECT%" --boot --flags=9 --compress=XPRESS --verbose
    goto :EOF
)

rem use imagex for building on Windows 7
if not exist "%windir%\System32\findstr.exe" set findcmd=find
ver|%findcmd% " 6.1." >nul
if not ERRORLEVEL 1 (
  if "x%PROCESSOR_ARCHITECTURE%"=="xAMD64" (
    wimexport.cmd "%~1" %WB_BASE_INDEX% "%BUILD_WIM%" --boot
  ) else (
    imagex.exe /Export "%~1" %WB_BASE_INDEX% "%BUILD_WIM%" /boot
  )
) else (
  call DismX /Export-Image /SourceImageFile:"%~1" /SourceIndex:%WB_BASE_INDEX% /DestinationImageFile:"%BUILD_WIM%" /Bootable
)
if "%errorlevel%"=="0" (
  del /q "%~1"
  set GetLastError=0
)

goto :EOF

:MKPATH
if not exist "%~dp1" mkdir "%~dp1"
goto :EOF