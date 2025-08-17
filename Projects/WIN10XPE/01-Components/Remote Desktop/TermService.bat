if not "x%opt[component.termservice]%"=="xtrue" goto :EOF

rem Remote Desktop Service

rem ==========update filesystem==========

set AddFiles_Mode=merge

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Microsoft-Windows-CoreSystem-RemoteFS-Client-Package~*.cat
CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\Microsoft-Windows-TerminalServices-*-Package~*.cat

;termservice
termsrv.dll,remotepg.dll,lsmproxy.dll
clbcatq.dll

;UmRdpService,sessionEnv
drprov.dll,rdsdwmdr.dll,umrdp.dll,umb.dll,sessenv.dll

;iphlpsvc
iphlpsvc.dll

;drivers
drivers\terminpt.sys
drivers\rdpbus.sys
drivers\rdpdr.sys
drivers\rdbss.sys
drivers\rdpvideominiport.sys
drivers\ipFltdrv.sys

rdp*.exe
rdp*.dll
rdvvmtransport.dll
rfxvmt.dll
tlscsp.dll

UIAnimation.dll
windowsudk.shellcommon.dll

;logon screen background(optional)
windows.immersiveshell.serviceprovider.dll
WorkFoldersShell.dll

;v1803
CertProp.dll

;v1809
CertPropSvc.dll
wwancfg.dll

;v1903(optional), v21H2(required)
+ver >= 22000
\Windows\WinSxS\*rdpidd*
drivers\IndirectKmd.sys
WppRecorderUM.dll

;for DWM
DispBroker.dll
DispBroker.Desktop.dll
+ver*

:end_files

call AddDrivers "rdpbus.inf,rdlsbuscbs.inf,termkbd.inf,termmou.inf"
call AddDrivers "monitor.inf"
call AddDrivers "tsprint.inf,tsusbhub.inf,tsusbhubfilter.inf,tsgenericusbdriver.inf"
if %VER[3]% GEQ 22000 (
  call AddDrivers "rdpidd.inf"
)
call DoAddFiles

if %VER[3]% GEQ 22000 (
  rem rdpidd needs WUDF
  call ApplyPatch "..\MTP_Support"
)

rem ==========update registry==========

if not "x%opt[build.registry.software]%"=="xfull" (
  call RegCopy "HKLM\Software\Microsoft\Terminal Server"
)

if %VER[3]% GEQ 22000 (
  call RegCopyEx Services "IndirectKmd"
) else (
  rem Disable WDDM Driver for win10 v1903 and later ^(posted by smine^)
  rem http://bbs.wuyou.net/forum.php?mod=redirect&goto=findpost&ptid=411399&pid=4304128
  reg add "HKLM\Tmp_Software\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableWddmDriver /t REG_DWORD /d 0 /f
)

call RegCopy "HKLM\System\ControlSet001\Control\Terminal Server"
call ACLRegKey "HKLM\System\ControlSet001\Control\Terminal Server\RCM"

call _ACLRegKey "Tmp_SYSTEM\ControlSet001\Control\Terminal Server\RCM" S-1-1-0 -
call _ACLRegKey "Tmp_SYSTEM\ControlSet001\Control\Terminal Server\RCM" "NT SERVICE\termservice" -
reg add "HKLM\Tmp_SYSTEM\ControlSet001\Control\Terminal Server\RCM\secrets" /f
call _ACLRegKey "Tmp_SYSTEM\ControlSet001\Control\Terminal Server\RCM\secrets" "Network Service" -

icacls "%X%\ProgramData\Microsoft\Crypto\RSA\MachineKeys" /grant *S-1-1-0:(OI)(CI)(F)

call RegCopy "HKLM\System\ControlSet001\Control\NetworkProvider"
call RegCopy "HKLM\System\ControlSet001\Control\Video"
call RegCopy "HKLM\System\ControlSet001\Control\SecurePipeServers"

reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server" /v SecurityLayer /t REG_DWORD /d 1 /f
rem Disable Network Level Authentication(NLA)
reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f

call RegCopyEx Services "TermService,terminpt,UmRdpService,sessionEnv"
call RegCopyEx Services "RDPBUS,RDPDR,RDPNP,RDPUDD"
call RegCopyEx Services "TsUsbGD,tsusbhub"
call RegCopyEx Services "Appinfo,WindowsTrustedRTProxy"
call RegCopyEx Services rdbss
call RegCopyEx Services "RdpVideoMiniport,CertPropSvc"
call RegCopyEx Services "ipHlpSvc,ipFilterdriver"

rem disable the service
reg add HKLM\Tmp_System\ControlSet001\Services\TermService /v Start /t REG_DWORD /d 4 /f

rem Contextmenu for computers in Network
call RegCopyEx Classes NetServer

reg import TermService_RegSystem.txt
rem reg import TermService_ProductOptions.txt

rem EnableTermServiceFeature
if 1==1 (
  echo sc config TermService start= demand
  echo reg add HKLM\SYSTEM\Setup /v SystemSetupInProgress /t REG_DWORD /d 0 /f
  echo net start TermService
)>"%X_PEMaterial%\EnableTermServiceFeature.bat"

call LinkToDesktop -paramlist "%i18n.t[EnableTermServiceFeature]%.lnk" "[[%X_PEMaterial%\EnableTermServiceFeature.bat]], '', 'shell32.dll', 17"
