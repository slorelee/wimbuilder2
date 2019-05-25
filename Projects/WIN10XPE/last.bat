
rem incompatible with StartIsBack(SYSTEM account)
if exist "%X%\Program Files\StartIsBack\" ( 
    del /q "%X_SYS%\windows.immersiveshell.serviceprovider.dll"
)

rem delete useless files
call :DELEX /q "%X_SYS%\edgehtml.dll"

rem remove usless mui & mun files
set Check_SysWOW64=0
if "x%opt[support.wow64]%"=="xtrue" set Check_SysWOW64=1
if not exist "%X_WIN%\SystemResources" goto :END_DEL_MUN

for /f %%i in ('dir /a-d /b "%X_WIN%\SystemResources"') do (
    if not exist "%X_SYS%\%%~ni" (
        if %Check_SysWOW64% EQU 0 (
            call :DELEX "/f /a /q" "%X_WIN%\SystemResources\%%i" "Remove orphan "
        ) else (
            if not exist "%X_WIN%\SysWOW64\%%~ni" (
                call :DELEX "/f /a /q" "%X_WIN%\SystemResources\%%i" "Remove orphan "
            )
        )
    )
)
:END_DEL_MUN
rem ignore *.msc files
for /f %%i in ('dir /a-d /b "%X_SYS%\%WB_PE_LANG%\*.mui"') do (
    if not exist "%X_SYS%\%%~ni" (
        call :DELEX "/f /a /q" "%X_SYS%\%WB_PE_LANG%\%%i" "Remove orphan "
    )
)

if %Check_SysWOW64% EQU 0 goto :END_DEL_MUI

for /f %%i in ('dir /a-d /b "%X_WIN%\SysWOW64\%WB_PE_LANG%\*.mui"') do (
    if not exist "%X_WIN%\SysWOW64\%%~ni" (
        call :DELEX "/f /a /q" "%X_WIN%\SysWOW64\%WB_PE_LANG%\%%i" "Remove orphan "
    )
)

:END_DEL_MUI
set Check_SysWOW64=

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

if not exist "%X_SYS%\dwm.exe" ( 
    reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM /t REG_DWORD /d 1 /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v Composition /t REG_DWORD /d 0 /f
)

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
call :DELEX "/f /q /a" "%X%\setup.exe"
call :DELEX "/f /q /a" "%X32%\winpeshl.ini"
call :DELEX "/f /q /a" "%X32%\WallpaperHost.exe"

rem update startnet.cmd
call OpenTextFile JS %X32%\startnet.cmd %0 :end_startnet_edit
goto :end_startnet_edit

TXT.before('wpeinit').insert('set USERPROFILE=X:\\Users\\Default');
TXT.append('\r\n\
if exist %SystemRoot%\\System32\\SetWG.exe (\r\n\
    start SetWG.exe WORKGROUP\r\n\
)\r\n\
');
TXT.append('\r\n\
if exist %SystemRoot%\\System32\\IME_Cmd.cmd (\r\n\
    call %SystemRoot%\\System32\\IME_Cmd.cmd\r\n\
    @echo on\r\n\
)\r\n\
');
TXT.append('\r\n\
start explorer.exe\r\n\
if exist "%windir%\\explorer.exe" (\r\n\
  if exist "%ProgramFiles%\\WinXShell\\WinXShell.exe" (\r\n\
    start "Daemon" "%ProgramFiles%\\WinXShell\\WinXShell.exe" -regist -daemon\r\n\
  )\r\n\
)\r\n\
');
TXT.append('\r\n');

:end_startnet_edit


if "x%opt[shell.app]%"=="xwinxshell" (
    call TextReplace "%X32%\startnet.cmd" "start explorer.exe" "start #qShell#q #q#pProgramFiles#p\WinXShell\WinXShell.exe#q -regist -winpe"
)

if "x%opt[slim.ultra]%"=="xtrue" (
    call TextReplace "%X32%\startnet.cmd" "wpeinit" "rem wpeinit"
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


if exist "_CustomFiles_\final.bat" (
    call "_CustomFiles_\final.bat"
)
goto :EOF

:FULLREG
if exist "%~dp0%1" (
   xcopy /E /Y "%~dp0%1" %X%\Windows\System32\Config\
)
goto :EOF

:DELEX
if exist "%~2" (
    if not "x%~3"=="x" echo %~3%~2
    del %~1 "%~2"
)
goto :EOF
