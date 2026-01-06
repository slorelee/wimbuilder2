rem update policy
rem built-in support since November 21, 2024 update (OS Build 26100.2454)
binmay.exe -i "%X_SYS%\services.exe" -s u:UMDF-WINPE-ENABLED | %findcmd% ":55"
if ERRORLEVEL 1 goto :INSTALL_MTPHELPER

"%WINXSHELL%" -code "App:Call('exitcode', Reg.PolicySet == nil or 1)"
if not ERRORLEVEL 1 goto :INSTALL_MTPHELPER
"%WINXSHELL%" -code "Reg:PolicySet([[HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions]],'ProductPolicy', 'UMDF-WINPE-ENABLED', 1)"
goto :MTP_SUPPORT

:INSTALL_MTPHELPER
rem install mtpHelper

set mtphelper_sysfile=mtpHelper_%WB_PE_ARCH%.sys

if not exist "%mtpHelper_sysfile%" (
    set opt[MTP.mtpHelper]=mtpHelper.dll
)

if "%opt[MTP.mtpHelper]%"=="mtpHelper.sys" (
  rem use yamingw's ring0 kernel driver
  copy %mtphelper_sysfile% %X_SYS%\Drivers\mtpHelper.sys
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v ImagePath /t REG_EXPAND_SZ /d "System32\Drivers\mtpHelper.sys" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v Start /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v ErrorControl /t REG_DWORD /d 0 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v Type /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v DisplayName /t REG_SZ /d "mtpHelper" /f
  reg import mtpHelper_EVRootCA.reg.txt
) else (
  rem use mtpHelper.dll hook
  copy mtpHelper_%WB_PE_ARCH%.dll %X_SYS%\mtpHelper.dll
  reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs /d mtpHelper.dll /f
  reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Windows" /v LoadAppInit_DLLs /t REG_DWORD /d 1 /f
  reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Windows" /v RequireSignedAppInit_DLLs /t REG_DWORD /d 0 /f
)
set mtphelper_sysfile=

:MTP_SUPPORT
rem hook requirement(or BSOD)
call RegCopy "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF"
rem call AddFiles WUDFPlatform.dll MUI

rem ==========update filesystem==========

reg query HKLM\Tmp_DRIVERS\DriverDatabase\DriverInfFiles\wpdmtp.inf 1>nul 2>nul
if %errorlevel% EQU 0 set _regdriver_done=1

set AddFiles_Mode=merge

call SharedPatch WINUSB

call AddDrivers "wpdcomp.inf,wpdfs.inf,wpdmtp.inf,wpdmtphw.inf,wudfusbcciddriver.inf"
rem Digital Still Camera
rem call AddDrivers ts_wpdmtp.inf

call AddFiles %0 :end_files
goto :end_files
@windows\system32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
;Microsoft-Windows-WPD*
Microsoft-Windows-WPD-UltimatePortableDeviceFeature-Feature-Package~*.cat
+ver > 19000
Microsoft-Windows-Portable-Devices-merged-Package~*.cat
+ver*

@windows\system32\
drivers\UMDF\
drivers\WpdUpFltr.sys
drivers\WUDFPf.sys
drivers\WUDFRd.sys
wpd*,WUDF*,PortableDevice*

; copy file(s) (PC -> Phone)
vaultcli.dll
efswrt.dll

:end_files

call DoAddFiles

rem ==========update registry==========

if "x%_regdriver_done%"=="x" (
    rem add DriverDatabase\DeviceIds
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\{50dd5230-ba8a-11d1-bf5d-0000f805f530}
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\{eec5ad98-8080-425f-922a-dabf3de3f69a}
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\COMP\WPD
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\wpdbusenum\fs
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\BthMtpEnum\{9518e5ca-f6af-464b-9907-a97433641968}]
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\UMB\urn:microsoft-com:device:mtp:1

    rem call RegCopyDeviceIds USB wpdmtp.inf
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\USB\MS_COMP_MTP

    call RegCopyDeviceIds USB wpdmtphw.inf
    call RegCopyDeviceIds USB wudfusbcciddriver.inf

    rem Digital Still Camera
    rem call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\TS_USB
)
set _regdriver_done=

rem WPD class(Portable Devices)
call RegCopy SYSTEM\ControlSet001\Control\Class\{EEC5AD98-8080-425F-922A-DABF3DE3F69A}

rem add services
call RegCopyEx Services "WPDBusEnum,WpdUpFltr,WudfPf,WUDFRd"


rem explorer Portable device
rem Portable Devices ::{35786D3C-B075-49b9-88DD-029876E11C01}
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\DelegateFolders
rem [optional]call SharedPatch NewBrowseDlg

