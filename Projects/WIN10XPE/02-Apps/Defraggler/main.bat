set APP_NAME=Defraggler
call App pull https://download.ccleaner.com/dfsetup222.exe
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%X_WIN%\%APP_NAME%\"
md "%X_PF%\%APP_NAME%"
copy /y "%X_WIN%\%APP_NAME%\%APP_NAME%%_V64%.exe" "%X_PF%\%APP_NAME%\"
copy /y "%X_WIN%\%APP_NAME%\DefragglerShell%_V64%.dll.new" "%X_PF%\%APP_NAME%\DefragglerShell%_V64%.dll"
copy /y "%X_WIN%\%APP_NAME%\df%_V64%.exe" "%X_PF%\%APP_NAME%\"
call :MainReg
if not "%WB_PE_LANG%"=="en-US" call :COPYLANGFILE
call LinkToStartMenu "Defraggler\%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%%_V64%.exe"
rd /s /q "%X_WIN%\%APP_NAME%"
goto :EOF

:MainReg
reg import "Defraggler_x64.reg"
if "%WB_PE_ARCH%"=="x64" goto :EOF

rem update paths for x86
reg add "HKLM\Tmp_Software\Classes\CLSID\{4380C993-0C43-4E02-9A7A-0D40B6EA7590}\InprocServer32" /ve /d "X:\Program Files\Defraggler\DefragglerShell%_V64%.dll" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\App Paths\defraggler.exe" /ve /d "X:\Program Files\Defraggler\Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\DefragPath" /ve /d "X:\Program Files\Defraggler\Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Default\Software\Classes\Software\Piriform\Defraggler" /v "Executable" /d "Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "Executable" /d "Defraggler%_V64%.exe" /f
goto :EOF

:COPYLANGFILE
call GetLocaleId %WB_PE_LANG%
set app_langid=%GetLocaleId_Ret%
if "%WB_PE_LANG%"=="ku-ARAB-IQ" (
    set app_langid=9999
) else if "%WB_PE_LANG%"=="es-ES" (
    set app_langid=1034
)
set app_langfile=lang-%app_langid%.dll
if not exist "%X_WIN%\%APP_NAME%\Lang\%app_langfile%" (
    echo [INFO] No "%WB_PE_LANG%" translation available for "%APP_NAME%".
    goto :COPYLANGFILE_DONE
)
echo [INFO] Found %app_langfile% resource for "%APP_NAME%".
md "%X_PF%\%APP_NAME%\Lang"
copy /y "%X_WIN%\%APP_NAME%\Lang\%app_langfile%" "%X_PF%\%APP_NAME%\Lang\"
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "Language" /d "%app_langid%" /f
if not "%APP_HOST_LANG%"=="%WB_PE_LANG%" (
    copy /y DefragglerContextMenuUpdater.bat "%X_Startup%\"
    call TextReplace "%X_Startup%\DefragglerContextMenuUpdater.bat" APP_LANGFILE %app_langfile% g
) else (
    "%WINXSHELL%" -code "reg_write([[HKEY_LOCAL_MACHINE\Tmp_Default\Software\Piriform\Defraggler]], 'AnalyzeContextString', app:call('resstr', [[#{@%X_PF%\%APP_NAME%\Lang\%app_langfile%,505}]]))"
    "%WINXSHELL%" -code "reg_write([[HKEY_LOCAL_MACHINE\Tmp_Default\Software\Piriform\Defraggler]], 'DefragContextString', app:call('resstr', [[#{@%X_PF%\%APP_NAME%\Lang\%app_langfile%,504}]]))"
)

:COPYLANGFILE_DONE
set app_langfile=
set app_langid=
goto :EOF

