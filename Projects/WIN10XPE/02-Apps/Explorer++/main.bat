set app_ver=1.3.5
set APP_NAME=Explorer++
call App pull https://explorerplusplus.com/software/explorer++_%app_ver%_x%_V8664%.zip
call :BUILD
call :GETLANGPACKS "%~nx0"
call :SHORTCUTS

set app_ver=
goto :EOF

:BUILD
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%X_PF%\%APP_NAME%\"
del /f /q /a "%X_PF%\%APP_NAME%\*.txt"
goto :EOF

:GETLANGPACKS
if not "x%app_ver%"=="x1.3.5" goto :EOF
for /f "tokens=2,3 delims=,=" %%i in ('%findcmd% "LangPacks[%WB_PE_LANG%" "%~1"') do (
    set app_langpack=explorer++_%app_ver%_%%i.zip
    set app_langid=%%j
)
if "x%app_langpack%"=="x" (
    echo [INFO] No "%WB_PE_LANG%" translation available for Explorer++ %app_ver%. 
    goto :EOF
)
call App pull https://explorerplusplus.com/software/translations/%app_langpack%
call V2X "%APP_CACHE%" -extract "%app_langpack%" "%X_PF%\%APP_NAME%\"
reg add "HKLM\Tmp_Default\Software\Explorer++\Settings" /v "Language" /t REG_DWORD /d %app_langid% /f
set app_langpack=
set app_langid=
goto :EOF

:SHORTCUTS
call LinkToDesktop "%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
call LinkToStartMenu "%APP_NAME%\%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
call PinToTaskbar "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
call PinToStartmenu "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
goto :EOF

:LANGPACKS_INFO
rem 1.3.5
rem https://explorerplusplus.com/translations
LangPacks[ca-ES]=CA,0x03
LangPacks[cs-CZ]=CS,0x05
LangPacks[da-DK]=DA,0x06
LangPacks[de-DE]=DE,0x07
LangPacks[es-ES]=ES,0x0a
LangPacks[fa-IR]=FA,0x29
LangPacks[fr-FR]=FR,0x0c
LangPacks[hu-HU]=HU,0x0e
LangPacks[it-IT]=IT,0x10
LangPacks[ja-jp]=JA,0x11
LangPacks[ko-KR]=KO,0x12
LangPacks[nl-NL]=NL,0x13
LangPacks[nb-NO]=NO,0x14
LangPacks[pl-PL]=PL,0x15
LangPacks[pt-PT]=PT,0x16
LangPacks[ro-RO]=RO,0x18
LangPacks[ru-RU]=RU,0x19
LangPacks[si-LK]=SI,0x5b
LangPacks[sv-SE]=SV,0x1d
LangPacks[tr-TR]=TR,0x1f
LangPacks[uk-UA]=UK,0x22
LangPacks[zh-CN]=ZH,0x04
rem 1.4.0
rem https://github.com/derceg/explorerplusplus/tree/master/Translations
LangPacks140[fi-FI]=FI,0x40b
LangPacks140[he-IL]=HE,0x40d
LangPacks140[vi-VN]=VI,0x42a
LangPacks140[zh-CN]=ZH_CN,0x804
LangPacks140[zh-TW]=ZH_TW,0x404
goto :EOF
