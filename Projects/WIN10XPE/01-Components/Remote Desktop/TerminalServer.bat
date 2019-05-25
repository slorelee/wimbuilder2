rem couldn't work yet
goto :EOF

rem Remote Desktop (service)

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
;drivers\rdbss.sys

rdp*.exe
rdp*.dll
rdvvmtransport.dll
rfxvmt.dll
tlscsp.dll

;v1803
CertProp.dll

;v1809
CertPropSvc.dll
wwancfg.dll

:end_files

call AddDrivers "rdpbus.inf,rdlsbuscbs.inf,termkbd.inf,termmou.inf"
call AddDrivers "monitor.inf"
call AddDrivers "tsprint.inf,tsusbhub.inf,tsusbhubfilter.inf,tsgenericusbdriver.inf"

call DoAddFiles

rem ==========update registry==========

if not "x%opt[build.registry.software]%"=="xfull" (
  call RegCopy "HKLM\Software\Microsoft\Terminal Server"
)

call RegCopy "HKLM\System\ControlSet001\Control\Terminal Server"
call ACLRegKey "HKLM\System\ControlSet001\Control\Terminal Server\RCM"

call RegCopy "HKLM\System\ControlSet001\Control\NetworkProvider"
call RegCopy "HKLM\System\ControlSet001\Control\Video"
call RegCopy "HKLM\System\ControlSet001\Control\SecurePipeServers"

reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

call RegCopyEx Services "TermService,terminpt,UmRdpService,sessionEnv"
call RegCopyEx Services "RDPBUS,RDPDR,RDPNP,RDPUDD"
call RegCopyEx Services "TsUsbGD,tsusbhub"
call RegCopyEx Services "Appinfo,WindowsTrustedRTProxy"
call RegCopyEx Services rdbss
call RegCopyEx Services "RdpVideoMiniport,CertPropSvc"
call RegCopyEx Services "ipHlpSvc,ipFilterdriver"

reg import TerminalServer_RegSystem.txt
