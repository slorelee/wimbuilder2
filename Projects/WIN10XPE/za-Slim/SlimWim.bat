rem this called by prepare.bat before wim mounted

if "x%WB_TMP_PATH%"=="x" goto :EOF

rem check if test\boot.wim
set _slim_wim_check=%WB_BASE:test\boot.wim=%
if not "%_slim_wim_check%"=="%WB_BASE%" (
  echo INFO:Skipping SlimWim for test\boot.wim
  set _slim_wim_check=
  goto :EOF
)


echo.>"%WB_TMP_PATH%\SlimPatch.txt"
call SlimWinSxS.bat

call CheckPatch "za-Slim"
if %errorlevel% EQU 0 (
  if not "x%opt[build.source]%"=="xlight" (
    goto :EOF
  ) else (
    goto :SLIM_COMMIT
  )
)

if not "x%opt[build.wow64support]%"=="xtrue" (
  (echo delete "\Program Files (x86)" --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt"
  (echo delete "\Windows\SysWOW64" --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt"
)

if "x%opt[slim.extra]%"=="xtrue" (
  set opt[build.catalog]=light
  (echo delete "\Windows\DiagTrack" --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt"
  (echo delete "\Windows\servicing" --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt"
  (echo delete "\Windows\System32\downlevel" --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt
)

if "x%opt[slim.mui]%"=="xfalse" goto :SLIM_COMMIT
call :REMOVE_MUI \Windows\Boot\EFI
call :REMOVE_MUI \Windows\Boot\PCAT
call :REMOVE_MUI \Windows\Boot\PXE
call :REMOVE_MUI \Windows\System32

:SLIM_COMMIT
rem update wim with SlimPatch.txt

echo Wimlib Cleanup and reduce Winre.wim
wimlib-imagex.exe update "%WB_BASE_PATH%" %WB_BASE_INDEX% < "%WB_TMP_PATH%\SlimPatch.txt"
goto :EOF

:REMOVE_MUI
rem always keep en-US
call :_REMOVE_MUI "%~1" "ar-SA bg-BG ca-ES cs-CZ da-DK de-DE el-GR en-GB es-ES eu-ES es-MX et-EE fi-FI fr-CA fr-FR"
call :_REMOVE_MUI "%~1" "gl-ES he-IL hr-HR hu-HU id-ID it-IT ja-JP ko-KR lt-LT lv-LV nb-NO nl-NL pl-PL pt-BR pt-PT"
call :_REMOVE_MUI "%~1" "qps-ploc ro-RO ru-RU sk-SK sl-SI sr-Latn-RS sv-SE th-TH tr-TR uk-UA vi-VN zh-CN zh-TW"
goto :EOF

:_REMOVE_MUI
for %%i in (%~2) do (
  if not "x%%i"=="x%WB_PE_LANG%" (
    (echo delete "%~1\%%i" --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt"
  )
)
goto :EOF
