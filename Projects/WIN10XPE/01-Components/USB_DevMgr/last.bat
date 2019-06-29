rem DsmSvc Patch Feature
binmay.exe -u "%X_SYS%\DeviceSetupManager.dll" -s u:SystemSetupInProgress -r u:DisableDeviceSetupMgr
fc /b "%X_SYS%\DeviceSetupManager.dll.org" "%X_SYS%\DeviceSetupManager.dll"
del /f /q "%X_SYS%\DeviceSetupManager.dll.org"
