if not exist "%X_SYS%\DeviceSetupManager.dll" goto :EOF

rem DsmSvc Patch Feature
binmay.exe -u "%X_SYS%\DeviceSetupManager.dll" -s u:SystemSetupInProgress -r u:DisableDeviceSetupMgr
fc /b "%X_SYS%\DeviceSetupManager.dll.org" "%X_SYS%\DeviceSetupManager.dll"
del /f /q "%X_SYS%\DeviceSetupManager.dll.org"

if "%WB_PE_ARCH%"=="x64" (
    binmay.exe -u "%X_SYS%\DeviceSetupManager.dll" -s "81 FE 20 03 00 00" -r "81 FE 02 00 00 00"
) else (
    binmay.exe -u "%X_SYS%\DeviceSetupManager.dll" -s "45 F8 3D 20 03 00 00" -r "45 F8 3D 02 00 00 00"
)
fc /b "%X_SYS%\DeviceSetupManager.dll.org" "%X_SYS%\DeviceSetupManager.dll"
del /f /q "%X_SYS%\DeviceSetupManager.dll.org"
