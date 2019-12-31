@echo off

if "x%_WB_EXEC_MODE%"=="x1" (
  title WimBuilder^(%~nx0^) - Don't Close this console window while building
)

set WB_ISO_LABEL=BOOTPE
set WB_ISO_NAME=%WB_ISO_LABEL%
if "x%ISO_DIR%"=="x" (
  echo Can't find the ISO_DIR.
  goto :ON_ERROR
)

if "x%WB_PROJECT%"=="x" (
  echo Can't find the WB_PROJECT.
  goto :ON_ERROR
)

if "x%_WB_TMP_DIR%"=="x" (
  set "_WB_TMP_DIR=%WB_ROOT%\%Factory%\tmp\%WB_PROJECT%"
)

rem load patches options
if exist "%_WB_TMP_DIR%\_patches_opt.bat" (
  call "%_WB_TMP_DIR%\_patches_opt.bat"
)

rem call _CustomISO_
set "WB_PROJECT_PATH=Projects\%WB_PROJECT%"
if "x%_CustomISO_FILE%"=="x" set _CustomISO_FILE=_CustomISO_.bat
if exist "%WB_PROJECT_PATH%\_CustomFiles_\%_CustomISO_FILE%" (
  pushd "%WB_PROJECT_PATH%\_CustomFiles_\"
  call %_CustomISO_FILE% PreISO
  popd
) else (
  set _CustomISO_FILE=
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

set EFI_BIN=efisys.bin
if not "x%_CustomISO_FILE%"=="x" (
  pushd "%WB_PROJECT_PATH%\_CustomFiles_\"
  call %_CustomISO_FILE% MakeISO
  popd
)

if exist "%ISO_DIR%\efi\Microsoft\boot\%EFI_BIN%" (
  oscdimg.exe -bootdata:2#p0,e,b"%ISO_DIR%\boot\etfsboot.com"#pEF,e,b"%ISO_DIR%\efi\Microsoft\boot\%EFI_BIN%" -h -l"%WB_ISO_LABEL%" -m -u2 -udfver102 "%ISO_DIR%" "%Factory%\%WB_ISO_NAME%.iso"
) else (
  oscdimg.exe -b"%ISO_DIR%\boot\etfsboot.com" -h -l"%WB_ISO_LABEL%" -m -u2 -udfver102 "%ISO_DIR%" "%Factory%\%WB_ISO_NAME%.iso"
)
echo \033[96mISO Created -* %Factory%\%WB_ISO_NAME%.iso | cmdcolor.exe
set "WB_ISO_PATH=%WB_ROOT%\%Factory%\%WB_ISO_NAME%.iso"
if ERRORLEVEL 1 (
  set WB_ISO_PATH=
  echo make boot iso failed.
) else (
  echo make boot iso successfully.
)

if not "x%_CustomISO_FILE%"=="x" (
  pushd "%WB_PROJECT_PATH%\_CustomFiles_\"
  call %_CustomISO_FILE% PostISO "%WB_ISO_PATH%"
  popd
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
