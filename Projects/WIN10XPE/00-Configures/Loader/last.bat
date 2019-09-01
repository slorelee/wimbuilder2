rem ==========Startup Entry==========

call :DELEX "/f /q /a" "%X_SYS%\WallpaperHost.exe"

if "x%PE_LOADER%"=="xLUA" goto :LUA_ENTRY
if "x%PE_LOADER%"=="xPECMD" goto :PECMD_ENTRY
goto :STARTNET_ENTRY

rem startup with LUA
:LUA_ENTRY
echo.>"%X_SYS%\startnet.cmd"
reg add HKLM\Tmp_System\Setup /v CmdLine /d "X:\Program Files\WinXShell\WinXShell.exe -regist -script %X_PEMaterial%\Pecmd.lua" /f
goto :STARTUP_ENTRY_END

rem startup with pecmd.exe
:PECMD_ENTRY
if not exist "%X%\Windows\System32\pecmd.exe" goto :STARTNET_ENTRY
del /f /q "%X_PEMaterial%\startnet.cmd"

if not "x%PECMDINI%"=="x" (
    reg add HKLM\Tmp_System\Setup /v CmdLine /d "Pecmd.exe Main %%Windir%%\System32\%PECMDINI%" /f
) else (
    reg add HKLM\Tmp_System\Setup /v CmdLine /d "Pecmd.exe Main %%Windir%%\System32\Pecmd.ini" /f
)

set _pecmd_shell_head=EXP_
if "x%opt[shell.app]%"=="xwinxshell" set _pecmd_shell_head=WXS_
call TextReplace "%X_SYS%\pecmd.ini" #//%_pecmd_shell_head% "" g
set _pecmd_shell_head=

call TextReplace "%X_SYS%\pecmd.ini" #//ARCH_%WB_PE_ARCH%_ ""

if not "x%opt[support.audio]%"=="xtrue" (
    ren "%X_Startup%\AudioInit.bat" AudioInit.bat.skipped
)
if not "x%opt[support.network]%"=="xtrue" (
    ren "%X_Startup%\NetInit.bat" NetInit.bat.skipped
) else (
    rem init network on booting
    call TextReplace "%X_SYS%\unattend.xml" "EnableNetwork>false</EnableNetwork" "EnableNetwork>true</EnableNetwork"
)

goto :STARTUP_ENTRY_END

:STARTNET_ENTRY
rem startup with startnet.cmd

call :DELEX "/f /q /a" "%X%\setup.exe"
call :DELEX "/f /q /a" "%X_SYS%\winpeshl.ini"

if exist "%X_PEMaterial%\startnet.cmd" move /y "%X_PEMaterial%\startnet.cmd" "%X_SYS%\"

rem update startnet.cmd
if "x%opt[slim.ultra]%"=="xtrue" (
    call TextReplace "%X_SYS%\startnet.cmd" "wpeinit" "rem wpeinit"
)
:STARTUP_ENTRY_END
goto :EOF

:DELEX
if exist "%~2" (
    if not "x%~3"=="x" echo %~3%~2
    del %~1 "%~2"
)
goto :EOF
