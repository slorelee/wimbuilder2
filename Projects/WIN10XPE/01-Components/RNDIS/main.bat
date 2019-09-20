
rem ==========update file system==========
set SxSArch=%WB_PE_ARCH%
if "%SxSArch%"=="x64" set SxSArch=amd64

call AddFiles %0 :end_files
goto :end_files
@\Windows\WinSxS\
%SxSArch%_dual_netrndis.inf_*
%SxSArch%_dual_rndiscmp.inf_*
%SxSArch%_microsoft-windows-rndis-*
%SxSArch%_netrndis.inf.resources_*
%SxSArch%_rndiscmp.inf.resources_*

@\Windows\WinSxS\Manifests\
%SxSArch%_dual_netrndis.inf_*
%SxSArch%_dual_rndiscmp.inf_*
%SxSArch%_microsoft-windows-rndis-*
%SxSArch%_netrndis.inf.resources_*
%SxSArch%_rndiscmp.inf.resources_*

@\Windows\System32\DriverStore\%WB_PE_LANG%
netrndis.inf_loc,rndiscmp.inf_loc

@\Windows\System32\drivers\
RNDISMP.sys,usb8023.sys
rndismp6.sys,usb80236.sys
:end_files

call AddDrivers "netrndis.inf,rndiscmp.inf"

rem ==========update registry==========
call RegCopy "HKLM\SOFTWARE\Microsoft\Windows Media Device Manager\KnownDeviceClasses\Windows CE RNDIS"
call RegCopy "HKLM\SOFTWARE\Microsoft\Windows Media Device Manager\KnownDevices\WinCEDeviceRNDIS"

if "x%opt[support.wow64]%"=="xtrue" (
  call RegCopy "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Media Device Manager\KnownDeviceClasses\Windows CE RNDIS"
  call RegCopy "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Media Device Manager\KnownDevices\WinCEDeviceRNDIS"
)
rem maybe good to have RegCopyEx WOW64?

call :RegCopyEx_SideBySide  dual_netrndis.inf
call :RegCopyEx_SideBySide  dual_rndiscmp.inf
call :RegCopyEx_SideBySide  microsoft-windows-rndis-*
call :RegCopyEx_SideBySide  netrndis.inf.resources
call :RegCopyEx_SideBySide  rndiscmp.inf.resources
goto :EOF



:RegCopyEx_SideBySide 
rem will improve RegCopyEx macro later
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%SxSArch%_%~1_*
goto :EOF