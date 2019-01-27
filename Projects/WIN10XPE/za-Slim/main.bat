rem replace small files

if "x%opt[slim.small_fonts]%"=="xtrue" (
    if exist "%~dp0SmallFonts\" xcopy  /E /Y "%~dp0SmallFonts\*.*"  %X_WIN%\Fonts\
)

if "x%opt[slim.small_imageresdll]%"=="xtrue" (
    if exist "%~dp0small_imageres.dll" xcopy  /E /Y "%~dp0SmallFonts\small_imageres.dll"  %X_SYS%\imageres.dll
)

rem already removed in _pre_wim.bat
goto :EOF

call :REMOVE_MUI Windows\Boot\EFI
call :REMOVE_MUI Windows\Boot\PCAT
call :REMOVE_MUI Windows\System32
goto :EOF

:REMOVE_MUI
rem always keep en-US
call :_REMOVE_MUI "%~1" "ar-SA bg-BG cs-CZ da-DK de-DE el-GR en-GB es-ES es-MX et-EE fi-FI fr-CA fr-FR"
call :_REMOVE_MUI "%~1" "he-IL hr-HR hu-HU it-IT ja-JP ko-KR  lt-LT lv-LV nb-NO nl-NL pl-PL pt-BR pt-PT"
call :_REMOVE_MUI "%~1" "qps-ploc ro-RO ru-RU sk-SK sl-SI sr-Latn-RS sv-SE th-TH tr-TR uk-UA zh-CN zh-TW"
goto :EOF

:_REMOVE_MUI
for %%i in (%~2) do (
 if not "x%%i"=="x%WB_PE_LANG%" (if exist "%X%\%~1\%%i" rd /s /q "%X%\%~1\%%i")
)
