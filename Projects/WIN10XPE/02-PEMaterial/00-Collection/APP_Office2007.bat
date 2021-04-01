set "_Dir=%PEM.Loc%\Installers\Office2007"
if not exist "%_Dir%" goto :EOF
set "f0=%~f0"
call :Requirements "%_Dir%\X"
set _Dir=
goto :EOF

:Requirements
set AddFiles_Mode=batch
call AddFiles "%f0%" :end_files
goto :end_files
@\Windows\%SysWOW64%\
advpack.dll
atlthunk.dll
CoreMessaging.dll
CoreUIComponents.dll
d3d10warp.dll
d3d11.dll
DataExchange.dll
davhlpr.dll
dcomp.dll
DXCore.dll
dxgi.dll
msi.dll
msiexec.exe
msimtf.dll
msvbvm60.dll
msvcp110_win.dll
netprofm.dll
npmproxy.dll
rasapi32.dll
rasman.dll
regedt32.exe
riched32.dll
rmclient.dll
sfc.dll
sfc_os.dll
shellstyle.dll
spfileq.dll
spinf.dll
srpapi.dll
stdole2.tlb
sxs.dll
TextInputFramework.dll
twinapi.appcore.dll
UIAnimation.dll
winnlsres.dll
winsta.dll
wldp.dll
:end_files

if exist "%~1" rd /s /q "%~1"
call DoAddFiles "%~1"

if exist "%_Dir%\Windows.7z" del /f /q "%_Dir%\Windows.7z"
7z a -r "%_Dir%\Windows.7z" "%_Dir%\X\Windows\*"
rd /s /q "%~1"

goto :EOF

