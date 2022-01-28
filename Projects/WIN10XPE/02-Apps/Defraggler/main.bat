set APP_NAME=Defraggler
call App pull https://download.ccleaner.com/dfsetup222.exe
call V2X "%APP_CACHE%" -extract "%APP_FILE%" "%X_WIN%\%APP_NAME%\"
md "%X_PF%\%APP_NAME%"
copy /y "%X_WIN%\%APP_NAME%\%APP_NAME%%_V64%.exe" "%X_PF%\%APP_NAME%\"
copy /y "%X_WIN%\%APP_NAME%\DefragglerShell%_V64%.dll.new" "%X_PF%\%APP_NAME%\DefragglerShell%_V64%.dll"
copy /y "%X_WIN%\%APP_NAME%\df%_V64%.exe" "%X_PF%\%APP_NAME%\"
call :MainReg
if not %WB_PE_LANG%=="en-US" call :COPYLANGFILE
call LinkToStartMenu "System Tools\%APP_NAME%.lnk" "#pProgramFiles#p\%APP_NAME%\%APP_NAME%%_V64%.exe"
rd /s /q "%X_WIN%\%APP_NAME%"
goto :EOF

:MainReg
reg add "HKLM\Tmp_Software\Classes\*\shellex\ContextMenuHandlers\DefragglerShellExtension" /ve /d "{4380C993-0C43-4E02-9A7A-0D40B6EA7590}" /f
reg add "HKLM\Tmp_Software\Classes\CLSID\{4380C993-0C43-4E02-9A7A-0D40B6EA7590}" /ve /d "DefragglerShellExtension Class" /f
reg add "HKLM\Tmp_Software\Classes\CLSID\{4380C993-0C43-4E02-9A7A-0D40B6EA7590}\InprocServer32" /ve /d "X:\Program Files\Defraggler\DefragglerShell%_V64%.dll" /f
reg add "HKLM\Tmp_Software\Classes\CLSID\{4380C993-0C43-4E02-9A7A-0D40B6EA7590}\InprocServer32" /v "ThreadingModel" /d "Apartment" /f
reg add "HKLM\Tmp_Software\Classes\folder\ShellEx\ContextMenuHandlers\DefragglerShellExtension" /ve /d "{4380C993-0C43-4E02-9A7A-0D40B6EA7590}" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\App Paths\defraggler%_V64%.exe" /ve /d "X:\Program Files\Defraggler\Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\App Paths\defraggler%_V64%.exe" /v "Path" /d "X:\Program Files\Defraggler" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\DefragPath" /ve /d "X:\Program Files\Defraggler\Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Extensions\Approved\{4380C993-0C43-4E02-9A7A-0D40B6EA7590}" /ve /d "DefragglerShellExtension" /f
reg add "HKLM\Tmp_Software\Piriform\Defraggler" /v "PreviousDefragPath" /d "%%systemroot%%\system32\dfrgui.exe" /f
reg add "HKLM\Tmp_Software\Piriform\Defraggler" /v "ReplaceWindowsDefrag" /t REG_DWORD /d 0x1 /f
reg add "HKLM\Tmp_Software\Piriform\Defraggler" /v "UpdateCheck" /d "0" /f
reg add "HKLM\Tmp_Software\Piriform\Defraggler" /ve /d "X:\Program Files\Defraggler" /f
reg add "HKLM\Tmp_Default\Software\Classes\Software\Piriform\Defraggler" /v "Executable" /d "Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Default\Software\Classes\Software\Piriform\Defraggler" /v "InstallPath" /d "X:\Program Files\Defraggler" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "AnalyzeContextString" /d "&Check Fragmentation" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "DefragContextString" /d "&Defragment" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "DisableShellExtension" /t REG_DWORD /d 0x0 /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "Executable" /d "Defraggler%_V64%.exe" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "InstallPath" /d "X:\Program Files\Defraggler" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "Language" /d "1033" /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "UpdateBackground" /t REG_DWORD /d 0x0 /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "UpdateCheck" /t REG_DWORD /d 0x0 /f
reg add "HKLM\Tmp_Default\Software\Piriform\Defraggler" /v "WasRunManualSilentUpdate" /t REG_DWORD /d 0x0 /f
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
    goto :EOF
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
set app_langfile=
set app_langid=
goto :EOF
