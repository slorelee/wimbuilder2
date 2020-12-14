@echo off
cd /d "%~dp0"
cd ..

if not exist tests\tmp\RegCopyDeviceIds md tests\tmp\RegCopyDeviceIds
set "WB_TMP_PATH=%~dp0tmp\RegCopyDeviceIds"

copy /y tests\Src_DRIVERS tests\tmp\RegCopyDeviceIds\Src_DRIVERS
copy /y tests\Tmp_DRIVERS tests\tmp\RegCopyDeviceIds\Tmp_DRIVERS

reg load HKLM\Src_DRIVERS tests\tmp\RegCopyDeviceIds\Src_DRIVERS
reg load HKLM\Tmp_DRIVERS tests\tmp\RegCopyDeviceIds\Tmp_DRIVERS
rem reg delete HKLM\Tmp_DRIVERS\DriverDatabase /f

echo %date%%time%
call RegCopyDeviceIds USB wpdmtp.inf
call RegCopyDeviceIds USB wpdmtphw.inf
call RegCopyDeviceIds USB wudfusbcciddriver.inf
echo %date%%time%

reg unload HKLM\Src_DRIVERS
reg unload HKLM\Tmp_DRIVERS

rd /s /q tests\tmp\RegCopyDeviceIds

pause