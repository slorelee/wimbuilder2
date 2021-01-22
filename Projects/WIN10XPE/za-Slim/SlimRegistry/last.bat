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

call :CLEANUP_DRIVERS
call :CLEANUP_SYSTEM
call :CLEANUP_SOFTWARE

set dp0=
popd

if not exist "%X_SYS%\wow64.dll" goto :EOF
rem Computer Management Command
reg add HKLM\Tmp_software\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\Manage\command /ve /d "mmc.exe compmgmt.msc /s /64" /f
reg add "HKLM\Tmp_SOFTWARE\Classes\mscfile\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mmc.exe \"%%1\" %%* /64" /f
reg add "HKLM\Tmp_SOFTWARE\Classes\mscfile\shell\RunAs\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\mmc.exe \"%%1\" %%* /64" /f
goto :EOF


:CLEANUP_DRIVERS
if not "x%opt[slim.hive_drivers]%"=="xtrue" goto :EOF

rem CleanupDeviceIds.vbs
if exist _RemoveDriversDeviceIds.reg del /q _RemoveDriversDeviceIds.reg
reg export HKLM\Tmp_DRIVERS\DriverDatabase\DeviceIds _RegDriversDeviceIds.reg /y
cscript //nologo CleanupDeviceIds.vbs "%X%" Drivers
reg import _RemoveDriversDeviceIds.reg

call CleanupDriverFiles.cmd
goto :EOF

:CLEANUP_SYSTEM

rem DriverDatabase
if not "x%opt[slim.hive_drivers]%"=="xtrue" goto :EOF

rem CleanupDeviceIds.vbs
if exist _RemoveSystemDeviceIds.reg del /q _RemoveSystemDeviceIds.reg
reg export HKLM\Tmp_SYSTEM\DriverDatabase\DeviceIds _RegSystemDeviceIds.reg /y
cscript //nologo CleanupDeviceIds.vbs "%X%" System
reg import _RemoveSystemDeviceIds.reg

if not "x%opt[slim.hive_system]%"=="xtrue" goto :EOF

goto :EOF

:CLEANUP_SOFTWARE
if not "x%opt[slim.hive_software]%"=="xtrue" goto :EOF

reg delete "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /f

set "WINXSHELL=%V%\WinXShell\X_PF\WinXShell\WinXShell_%WB_ARCH%.exe"
if not exist "%WINXSHELL%" goto :EOF
if exist _RemoveInvaildItems_Reg.txt del /q _RemoveInvaildItems_Reg.txt
if exist _WinSxS_Manifests.txt del /q _WinSxS_Manifests.txt
dir /b "%X_WIN%\WinSxS\Manifests\*.manifest" > _WinSxS_Manifests.txt

if exist RemoveInvaildRegItems.lua (
    "%WINXSHELL%" -console -script "%dp0%RemoveInvaildRegItems.lua"
) else (
    "%WINXSHELL%" -console -script "%dp0%RemoveInvaildRegItems.bin"
)
reg import _RemoveInvaildItems_Reg.txt

rem hide "IE History and Feeds Shell Data Source for Windows Search" folder on Desktop
reg add "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {11016101-E366-4D22-BC06-4ADA335C892B} /t REG_DWORD /d 1 /f
goto :EOF
