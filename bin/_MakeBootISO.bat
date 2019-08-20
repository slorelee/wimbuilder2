@echo off

set WB_ISO_LABEL=BOOTPE
set WB_ISO_NAME=%WB_ISO_LABEL%
if "x%ISO_DIR%"=="x" (
  echo Can't find the ISO_DIR.
  goto :ON_ERROR
)


rem call _PreISO_
set "WB_PROJECT_PATH=Projects\%WB_PROJECT%"
if exist "%WB_PROJECT_PATH%\_CustomFiles_\_PreISO_.bat" (
  pushd "%WB_PROJECT_PATH%\_CustomFiles_\"
  call _PreISO_.bat
  popd
)


rem auto create the _ISO_

call :MKPATH "%ISO_DIR%\sources\"
if not exist "%ISO_DIR%\bootmgr" (
  if exist "%WB_SRC_FOLDER%\boot" (
    xcopy /E /Y "%WB_SRC_FOLDER%\boot" "%ISO_DIR%\boot\"
    xcopy /E /Y "%WB_SRC_FOLDER%\efi" "%ISO_DIR%\efi\"
    copy /y "%WB_SRC_FOLDER%\bootmgr" "%ISO_DIR%\"
    copy /y "%WB_SRC_FOLDER%\bootmgr.efi" "%ISO_DIR%\"
  )
)

call :MKPATH "%ISO_DIR%\boot\"
if not exist "%ISO_DIR%\boot\etfsboot.com" (
  copy /y "%WB_ROOT%\bin\etfsboot.com" "%ISO_DIR%\boot\"
)

copy /y "%Factory%\target\%WB_PROJECT%\build\boot.wim" "%ISO_DIR%\sources\boot.wim"
if exist "%ISO_DIR%\efi\Microsoft\boot\efisys.bin" (
  oscdimg.exe -bootdata:2#p0,e,b"%ISO_DIR%\boot\etfsboot.com"#pEF,e,b"%ISO_DIR%\efi\Microsoft\boot\efisys.bin" -h -l"%WB_ISO_LABEL%" -m -u2 -udfver102 "%ISO_DIR%" "%Factory%\%WB_ISO_NAME%.iso"
) else (
  oscdimg.exe -b"%ISO_DIR%\boot\etfsboot.com" -h -l"%WB_ISO_LABEL%" -m -u2 -udfver102 "%ISO_DIR%" "%Factory%\%WB_ISO_NAME%.iso"
)
echo \033[96mISO Created -* %Factory%\%WB_ISO_NAME%.iso | cmdcolor.exe
if ERRORLEVEL 1 (
  echo make boot iso failed.
) else (
  echo make boot iso successfully.
)
if "x%_WB_EXEC_MODE%"=="x1" goto :EOF
pause
goto :EOF

:MKPATH
if not exist "%~dp1" mkdir "%~dp1"
goto :EOF

:ON_ERROR
if "x%_WB_EXEC_MODE%"=="x1" goto :EOF
pause
