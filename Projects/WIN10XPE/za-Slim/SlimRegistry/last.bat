if "x%V%"=="x" (
rem test_setup
set V=D:\WimBuilder2\vendor
set WB_ARCH=x64
)

rem reg delete "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\AppX" /f

set "WINXSHELL=%V%\WinXShell\X_PF\WinXShell\WinXShell_%WB_ARCH%.exe"

pushd "%cd%"
set "dp0=%~dp0"
cd /d "%dp0%"

call :CLEANUP_SOFTWARE

set dp0=
popd

if not exist "%X_SYS%\wow64.dll" goto :EOF
rem Computer Management Command
reg add HKLM\Tmp_software\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\Manage\command /ve /d "mmc.exe compmgmt.msc /s /64" /f
reg add "HKLM\Tmp_SOFTWARE\Classes\mscfile\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mmc.exe \"%%1\" %%* /64" /f
reg add "HKLM\Tmp_SOFTWARE\Classes\mscfile\shell\RunAs\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mmc.exe \"%%1\" %%* /64" /f
goto :EOF


:CLEANUP_SOFTWARE
if not "x%opt[slim.software]%"=="xtrue" goto :EOF

set "WINXSHELL=%V%\WinXShell\X_PF\WinXShell\WinXShell_%WB_ARCH%.exe"
if not exist "%WINXSHELL%" goto :EOF

set opt[registry.software.compress]=true
if exist RemoveInvaildItems_Reg.txt del /q RemoveInvaildItems_Reg.txt
if exist RemoveInvaildRegItems.lua (
    "%WINXSHELL%" -console -script "%dp0%RemoveInvaildRegItems.lua"
) else (
    "%WINXSHELL%" -console -script "%dp0%RemoveInvaildRegItems.bin"
)
reg import RemoveInvaildItems_Reg.txt
goto :EOF
