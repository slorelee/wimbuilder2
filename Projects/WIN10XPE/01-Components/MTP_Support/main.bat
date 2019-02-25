rem install mtpHelper

rem use yamingw's ring0 kernel driver
if exist "mtpHelper_%WB_PE_ARCH%.sys" (
  copy mtpHelper_%WB_PE_ARCH%.sys %X_SYS%\Drivers\mtpHelper.sys
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v ImagePath /t REG_EXPAND_SZ /d "System32\Drivers\mtpHelper.sys" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v Start /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v ErrorControl /t REG_DWORD /d 0 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v Type /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mtpHelper /v DisplayName /t REG_SZ /d "mtpHelper" /f
) else (
  rem use mtpHelper.dll hook
  copy mtpHelper_%WB_PE_ARCH%.dll %X_SYS%\mtpHelper.dll
  reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Windows" /v AppInit_DLLs /d mtpHelper.dll /f
  reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Windows" /v LoadAppInit_DLLs /t REG_DWORD /d 1 /f
  reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Windows" /v RequireSignedAppInit_DLLs /t REG_DWORD /d 0 /f
)

rem hook requirement(or BSOD)
call RegCopy "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF"
rem call AddFiles WUDFPlatform.dll MUI

rem ==========update filesystem==========

set AddFiles_Mode=merge

call AddDrivers winusb.inf
call AddDrivers "wpd*.inf,wudf*.inf" FILE

call AddFiles %0 :end_files
goto :end_files
@windows\system32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-Client-Desktop-Required-Package*
;Microsoft-Windows-WPD*

@windows\system32\
drivers\UMDF\
+mui
winusb*,wpd*,WUDF*,PortableDevice*
:end_files

call DoAddFiles

rem ==========update registry==========
rem WPD class(Portable Devices)
call RegCopy SYSTEM\ControlSet001\Control\Class\{EEC5AD98-8080-425F-922A-DABF3DE3F69A}

rem add services
call RegCopyEx Services "WINUSB,WPDBusEnum,WpdUpFltr,WudfPf,WUDFRd"

rem winusb.inf (already added by AddDrivers macro, only two items in <1KB)
rem has high cost performance to copy all DriverDatabase items, just 4MB SYSTEM size(608KB compressed)
rem call RegCopy SYSTEM\DriverDatabase

rem explorer Portable device
rem Portable Devices ::{35786D3C-B075-49b9-88DD-029876E11C01}
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\DelegateFolders
rem [optional]call SharedPatch NewBrowseDlg
rem put mtp_support.bat on Desktop
call X2X
