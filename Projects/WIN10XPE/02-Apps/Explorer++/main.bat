set APP_NAME=Explorer++
call App pull https://explorerplusplus.com/software/explorer++_1.3.5_x%_V8664%.zip
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%X_PF%\%APP_NAME%\"
del /f /q /a "%X_PF%\%APP_NAME%\*.txt"
call LinkToDesktop "%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
call LinkToStartMenu "%APP_NAME%\%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
call PinToTaskbar "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
call PinToStartmenu "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"

rem ---- Language Selection. ----
if "%WB_PE_LANG%"=="cs-CZ" (
    set APP_LANG=explorer++_1.3.5_CS.zip
    set LNG_VALUE=0x05
    goto LANG
)
if "%WB_PE_LANG%"=="da-DK" (
    set APP_LANG=explorer++_1.3.5_DA.zip
    set LNG_VALUE=0x06
    goto LANG
)
if "%WB_PE_LANG%"=="de-DE" (
    set APP_LANG=explorer++_1.3.5_DE.zip
    set LNG_VALUE=0x07
    goto LANG
)
if "%WB_PE_LANG%"=="es-ES" (
    set APP_LANG=explorer++_1.3.5_ES.zip
    set LNG_VALUE=0x0a
    goto LANG
)
if "%WB_PE_LANG%"=="fr-FR" (
    set APP_LANG=explorer++_1.3.5_FR.zip
    set LNG_VALUE=0x0c
    goto LANG
)
if "%WB_PE_LANG%"=="hu-HU" (
    set APP_LANG=explorer++_1.3.5_HU.zip
    set LNG_VALUE=0x0e
    goto LANG
)
if "%WB_PE_LANG%"=="it-IT" (
    set APP_LANG=explorer++_1.3.5_IT.zip
    set LNG_VALUE=0x10
    goto LANG
)
if "%WB_PE_LANG%"=="ja-jp" (
    set APP_LANG=explorer++_1.3.5_JA.zip
    set LNG_VALUE=0x11
    goto LANG
)
if "%WB_PE_LANG%"=="ko-KR" (
    set APP_LANG=explorer++_1.3.5_KO.zip
    set LNG_VALUE=0x12
    goto LANG
)
if "%WB_PE_LANG%"=="nb-NO" (
    set APP_LANG=explorer++_1.3.5_NO.zip
    set LNG_VALUE=0x14
    goto LANG
)
if "%WB_PE_LANG%"=="nl-NL" (
    set APP_LANG=explorer++_1.3.5_NL.zip
    set LNG_VALUE=0x13
    goto LANG
)
if "%WB_PE_LANG%"=="pl-PL" (
    set APP_LANG=explorer++_1.3.5_PL.zip
    set LNG_VALUE=0x15
    goto LANG
)
if "%WB_PE_LANG%"=="pt-PT" (
    set APP_LANG=explorer++_1.3.5_PT.zip
    set LNG_VALUE=0x16
    goto LANG
)
if "%WB_PE_LANG%"=="ro-RO" (
    set APP_LANG=explorer++_1.3.5_RO.zip
    set LNG_VALUE=0x18
    goto LANG
)
if "%WB_PE_LANG%"=="ru-RU" (
    set APP_LANG=explorer++_1.3.5_RU.zip
    set LNG_VALUE=0x19
    goto LANG
)
if "%WB_PE_LANG%"=="sv-SE" (
    set APP_LANG=explorer++_1.3.5_SV.zip
    set LNG_VALUE=0x1d
    goto LANG
)
if "%WB_PE_LANG%"=="tr-TR" (
    set APP_LANG=explorer++_1.3.5_TR.zip
    set LNG_VALUE=0x1f
    goto LANG
)
if "%WB_PE_LANG%"=="uk-UA" (
    set APP_LANG=explorer++_1.3.5_UK.zip
    set LNG_VALUE=0x22
    goto LANG
)
if "%WB_PE_LANG%"=="zh-CN" (
    set APP_LANG=explorer++_1.3.5_ZH.zip
    set LNG_VALUE=0x04
    goto LANG
)
goto MANUAL

:LANG
call App pull https://explorerplusplus.com/software/translations/%APP_LANG%
call V2X "%APP_CACHE%" -extract "%APP_LANG%" "%X_PF%\%APP_NAME%\"
reg add "HKLM\Tmp_Default\Software\Explorer++\Settings" /v "Language" /t REG_DWORD /d "%LNG_VALUE%" /f
goto eof

:MANUAL
rem If your language can not detect automaticaly,
rem uncomment it below, if it exist.
rem Catalan (ca-ES), avaiable in LangPacks only:
rem call App pull https://explorerplusplus.com/software/translations/explorer++_1.3.5_CA.zip
rem call V2X "%APP_CACHE%" -extract "explorer++_1.3.5_CA.zip" "%X_PF%\%APP_NAME%\"
rem reg add "HKLM\Tmp_Default\Software\Explorer++\Settings" /v "Language" /t REG_DWORD /d 0x03 /f
rem Farsi, in Microsoft docs i not found it:
rem call App pull https://explorerplusplus.com/software/translations/explorer++_1.3.5_FA.zip
rem call V2X "%APP_CACHE%" -extract "explorer++_1.3.5_FA.zip" "%X_PF%\%APP_NAME%\"
rem reg add "HKLM\Tmp_Default\Software\Explorer++\Settings" /v "Language" /t REG_DWORD /d 0x29 /f
rem Sinhala (si-LK), avaiable in LangPacks only:
rem call App pull https://explorerplusplus.com/software/translations/explorer++_1.3.5_SI.zip
rem call V2X "%APP_CACHE%" -extract "explorer++_1.3.5_SI.zip" "%X_PF%\%APP_NAME%\"
rem reg add "HKLM\Tmp_Default\Software\Explorer++\Settings" /v "Language" /t REG_DWORD /d 0x5b /f
goto eof
