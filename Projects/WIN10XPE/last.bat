rem display startmenu folders/shortcuts name with language
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo"
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories"
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools"

rem New Menu
if %VER[3]% LSS 18300 (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v Classes /t REG_MULTI_SZ /d .library-ms\0.txt\0Folder /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v ~reserved~ /t REG_BINARY /d 0800000000000600 /f
)

rem incompatible with StartIsBack(SYSTEM account)
if exist "%X%\Program Files\StartIsBack\" ( 
    del /q "%X_SYS%\windows.immersiveshell.serviceprovider.dll"
    del /q "%X_SYS%\%WB_PE_LANG%\windows.immersiveshell.serviceprovider.dll.mui"
)

if not exist "%X_SYS%\dwm.exe" ( 
    reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM /t REG_DWORD /d 1 /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v Composition /t REG_DWORD /d 0 /f
)

rem delete useless files
call :DELEX /q "%X_SYS%\edgehtml.dll"
call :DELEX /q "%X_SYS%\%WB_PE_LANG%\edgehtml.dll.mui"
call :DELEX /q "%X%\Windows\SystemResources\edgehtml.dll.mun"

rem startup with pecmd.exe
:PECMD_ENTRY
if not exist "%X%\Windows\System32\pecmd.exe" goto :STARTNET_ENTRY
if not "x%PECMDINI%"=="x" (
    reg add HKLM\Tmp_System\Setup /v CmdLine /d "Pecmd.exe Main %%Windir%%\System32\%PECMDINI%" /f
) else (
    reg add HKLM\Tmp_System\Setup /v CmdLine /d "Pecmd.exe Main %%Windir%%\System32\Pecmd.ini" /f
)
goto :STARTUP_ENTRY_END

:STARTNET_ENTRY
rem startup shell

call AddFiles %0 :end_files
goto :end_files
windows\system32\taskkill.exe
:end_files


set "X32=%X%\Windows\System32"
del /q "%X%\setup.exe"
del /q "%X32%\winpeshl.ini"
del /q "%X32%\WallpaperHost.exe"

rem update startnet.cmd
call OpenTextFile JS %X32%\startnet.cmd %0 :end_startnet_edit
goto :end_startnet_edit

TXT.before('wpeinit').insert('set USERPROFILE=X:\\Users\\Default');
TXT.append('\r\n\
if exist %SystemRoot%\\System32\\IME_Cmd.cmd (\r\n\
    call %SystemRoot%\\System32\\IME_Cmd.cmd\r\n\
    @echo on\r\n\
)\r\n\
');
TXT.append('\r\nstart explorer.exe\r\n');

:end_startnet_edit


if "x%opt[shell.app]%"=="xwinxshell" (
    call TextReplace "%X32%\startnet.cmd" "start explorer.exe" "start #qShell#q #q#pProgramFiles#p\WinXShell\WinXShell.exe#q -winpe"
)

if not "x%opt[shell.app]%"=="xwinxshell" (
    echo ping -n 2 127.1 1^>nul>>"%X32%\startnet.cmd"
    echo taskkill /f /im explorer.exe>>"%X32%\startnet.cmd"
    echo explorer.exe>>"%X32%\startnet.cmd"
)
echo cmd.exe>>"%X32%\startnet.cmd"

:STARTUP_ENTRY_END

rem use prepared HIVE files
call PERegPorter.bat Tmp UNLOAD 1>nul

call :FULLREG DEFAULT
call :FULLREG SOFTWARE
call :FULLREG SYSTEM
call :FULLREG COMPONENTS
call :FULLREG DRIVERS
goto :EOF

:FULLREG
if exist "%~dp0%1" (
   xcopy /E /Y "%~dp0%1" %X%\Windows\System32\Config\
)
goto :EOF

:DELEX
if exist "%~2" (
    del %~1 "%~2"
)
goto :EOF