rem minimum required
rem call AddFiles "@\Windows\System32\#nDeviceSetupManager.dll,DevPropMgr.dll"

rem more related files
call AddFiles %0 :end_files
goto :end_files
@windows\system32\
DDOres.dll
;DeviceCenter.dll,DeviceEject.exe
DeviceSetupManager.dll,DeviceSetupManagerAPI.dll,DeviceSetupStatusProvider.dll
DevPropMgr.dll
;StorageContextHandler.dll
:end_files

call RegCopy HKLM\SYSTEM\ControlSet001\Services\DsmSvc
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\DsmSvc /f
