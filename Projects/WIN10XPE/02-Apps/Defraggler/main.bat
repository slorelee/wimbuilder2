set APP_NAME=Defraggler
call App pull https://download.ccleaner.com/dfsetup222.exe
call V2X "%APP_CACHE%" -extract "dfsetup222.exe" "%X_WIN%\%APP_NAME%\"
md "%X_PF%\%APP_NAME%"
call :copy-%_Vx8664%
reg import "Defraggler%_Vx8664%.reg"
call :COPYLANGFILE "%~nx0"
if exist "Defraggler.%WB_PE_LANG%.reg" reg import "Defraggler.%WB_PE_LANG%.reg"
if "%WB_PE_ARCH%"=="x64" (
    call LinkToStartMenu "System Tools\%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%64.exe"
) else (
    call LinkToStartMenu "System Tools\%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%.exe"
)
rd /s /q "%X_WIN%\%APP_NAME%"
goto :EOF

:copy-x86
copy /y "%X_WIN%\%APP_NAME%\%APP_NAME%.exe" "%X_PF%\%APP_NAME%\"
copy /y "%X_WIN%\%APP_NAME%\DefragglerShell.dll.new" "%X_PF%\%APP_NAME%\DefragglerShell.dll"
copy /y "%X_WIN%\%APP_NAME%\df.exe" "%X_PF%\%APP_NAME%\"
goto :EOF

:copy-x64
copy /y "%X_WIN%\%APP_NAME%\%APP_NAME%64.exe" "%X_PF%\%APP_NAME%\"
copy /y "%X_WIN%\%APP_NAME%\DefragglerShell64.dll.new" "%X_PF%\%APP_NAME%\DefragglerShell64.dll"
copy /y "%X_WIN%\%APP_NAME%\df64.exe" "%X_PF%\%APP_NAME%\"
goto :EOF

:COPYLANGFILE
if %WB_PE_LANG%=="en-US" goto :EOF
for /f "tokens=2,3 delims=,=" %%i in ('%findcmd% "LangFile[%WB_PE_LANG%" "%~1"') do (
    set app_langfile=%%i
)
if "x%app_langfile%"=="x" (
    echo [INFO] No "%WB_PE_LANG%" translation available for "%APP_NAME%". 
    reg import "Defraggler.en-US.reg"
    goto :EOF
)
md "%X_PF%\%APP_NAME%\Lang"
copy /y "%X_WIN%\%APP_NAME%\Lang\%app_langfile%" "%X_PF%\%APP_NAME%\Lang\"
set app_langfile=
goto :EOF

:LangFile_INFO
LangFile[ar-SA]=lang-1025.dll
LangFile[be-BY]=lang-1059.dll
LangFile[bg-BG]=lang-1026.dll
LangFile[ca-ES]=lang-1027.dll
LangFile[cs-CZ]=lang-1029.dll
LangFile[da-DK]=lang-1030.dll
LangFile[de-DE]=lang-1031.dll
LangFile[el-GR]=lang-1032.dll
LangFile[es-ES]=lang-1034.dll
LangFile[et-EE]=lang-1061.dll
LangFile[fa-IR]=lang-1065.dll
LangFile[fi-FI]=lang-1035.dll
LangFile[fr-FR]=lang-1036.dll
LangFile[he-IL]=lang-1037.dll
LangFile[hr-HR]=lang-1050.dll
LangFile[hu-HU]=lang-1038.dll
LangFile[hy-AM]=lang-1067.dll
LangFile[id-ID]=lang-1057.dll
LangFile[it-IT]=lang-1040.dll
LangFile[ja-jp]=lang-1041.dll
LangFile[ka-GE]=lang-1079.dll
LangFile[lt-LT]=lang-1063.dll
LangFile[lv-LV]=lang-1062.dll
LangFile[mk-MK]=lang-1071.dll
LangFile[nb-NO]=lang-1044.dll
LangFile[nl-NL]=lang-1043.dll
LangFile[pl-PL]=lang-1045.dll
LangFile[pt-BR]=lang-1046.dll
LangFile[pt-PT]=lang-2070.dll
LangFile[ro-RO]=lang-1048.dll
LangFile[ru-RU]=lang-1049.dll
LangFile[sk-SK]=lang-1051.dll
LangFile[sl-SI]=lang-1060.dll
LangFile[sq-AL]=lang-1052.dll
LangFile[sv-SE]=lang-1053.dll
LangFile[tr-TR]=lang-1055.dll
LangFile[uk-UA]=lang-1058.dll
LangFile[vi-VN]=lang-1066.dll
LangFile[zh-CN]=lang-2052.dll
LangFile[zh-TW]=lang-1028.dll
