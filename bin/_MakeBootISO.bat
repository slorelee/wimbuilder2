@echo off

set WB_ISO_LABEL=BOOTPE
set WB_ISO_NAME=%WB_ISO_LABEL%
if "x%ISO_DIR%"=="x" (
  echo Can't find the ISO_DIR.
  goto :ON_ERROR
)
copy /y "%Factory%\target\%WB_PROJECT%\build\boot.wim" "%ISO_DIR%\sources\boot.wim"
"%~dp0oscdimg.exe" -b"%ISO_DIR%\boot\etfsboot.com" -h -l"%WB_ISO_LABEL%" -m -u2 "%ISO_DIR%" "%Factory%\%WB_ISO_NAME%.iso"
echo \033[96mISO Created -* %Factory%\%WB_ISO_NAME%.iso | cmdcolor.exe
If ERRORLEVEL 1 (
  echo make boot iso failed.
) else (
  echo make boot iso successfully.
)
pause
goto :EOF

:ON_ERROR
if "x%_WB_EXEC_MODE%"=="x1" goto :EOF
pause
