rem ==========Startup Entry==========

call :DELEX "/f /q /a" "%X_SYS%\WallpaperHost.exe"

if "x%PE_LOADER%"=="xLUA" goto :LUA_ENTRY
if "x%PE_LOADER%"=="xPECMD" goto :PECMD_ENTRY
goto :STARTNET_ENTRY

rem startup with LUA
:LUA_ENTRY

copy /y "%X_PEMaterial%\winpeshl.ini" "%X_SYS%\"
echo .>"%X_SYS%\startnet.cmd"

reg add HKLM\Tmp_System\Setup /v CmdLine /d "X:\Program Files\WinXShell\WinXShell.exe -regist -script %X_PEMaterial%\Pecmd.lua" /f
goto :STARTUP_ENTRY_END

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

call :DELEX "/f /q /a" "%X%\setup.exe"
call :DELEX "/f /q /a" "%X_SYS%\winpeshl.ini"

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
    call TextReplace "%X_SYS%\startnet.cmd" "start explorer.exe" "start #qShell#q #q#pProgramFiles#p\WinXShell\WinXShell.exe#q -regist -winpe"
)

if "x%opt[slim.ultra]%"=="xtrue" (
    call TextReplace "%X_SYS%\startnet.cmd" "wpeinit" "rem wpeinit"
)

if not "x%opt[shell.app]%"=="xwinxshell" (
    echo ping -n 2 127.1 1^>nul>>"%X_SYS%\startnet.cmd"
    echo taskkill /f /im explorer.exe>>"%X_SYS%\startnet.cmd"
    echo explorer.exe>>"%X_SYS%\startnet.cmd"
)
echo cmd.exe>>"%X_SYS%\startnet.cmd"

:STARTUP_ENTRY_END
goto :EOF

:DELEX
if exist "%~2" (
    if not "x%~3"=="x" echo %~3%~2
    del %~1 "%~2"
)
goto :EOF
