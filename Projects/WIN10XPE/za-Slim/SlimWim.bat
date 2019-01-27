rem this called by prepare.bat before wim mounted

if "x%_WB_TMP_DIR%"=="x" goto :EOF

rem check if test\boot.wim
set _slim_wim_check=%WB_BASE:test\boot.wim=%
if not "%_slim_wim_check%"=="%WB_BASE%" (
  echo INFO:Skipping SlimWim for test\boot.wim
  set _slim_wim_check=
  goto :EOF
)

call CheckPatch "za-Slim"
if %errorlevel% NEQ 0 goto :EOF



echo.>"%_WB_TMP_DIR%\SlimPatch.txt"

if not "x%opt[build.wow64support]%"=="xtrue" (
   (echo delete "\Program Files (x86)" --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
   (echo delete "\Windows\SysWOW64" --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
)

if "x%opt[slim.speech]%"=="xtrue" (
   (echo delete "\Windows\Speech" --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
)

if "x%opt[slim.font.mingliu]%"=="xtrue" (
   (echo delete "\Windows\Fonts\mingliu.ttc" --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
)

call SlimWinSxS.bat

if "x%opt[slim.mui]%"=="xfalse" goto :SLIM_COMMIT
call :REMOVE_MUI \Windows\Boot\EFI
call :REMOVE_MUI \Windows\Boot\PCAT
call :REMOVE_MUI \Windows\Boot\PXE
call :REMOVE_MUI \Windows\System32

:SLIM_COMMIT
rem update wim with SlimPatch.txt

echo Wimlib Cleanup and reduce Winre.wim
wimlib-imagex.exe update "%_WB_PE_WIM%" %WB_BASE_INDEX%  < "%_WB_TMP_DIR%\SlimPatch.txt"
goto :EOF

:REMOVE_MUI
rem always keep en-US
call :_REMOVE_MUI "%~1" "ar-SA bg-BG cs-CZ da-DK de-DE el-GR en-GB es-ES es-MX et-EE fi-FI fr-CA fr-FR"
call :_REMOVE_MUI "%~1" "he-IL hr-HR hu-HU it-IT ja-JP ko-KR lt-LT lv-LV nb-NO nl-NL pl-PL pt-BR pt-PT"
call :_REMOVE_MUI "%~1" "qps-ploc ro-RO ru-RU sk-SK sl-SI sr-Latn-RS sv-SE th-TH tr-TR uk-UA zh-CN zh-TW"
goto :EOF

:_REMOVE_MUI
for %%i in (%~2) do (
  if not "x%%i"=="x%WB_PE_LANG%" (
    (echo delete "%~1\%%i" --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
  )
)
