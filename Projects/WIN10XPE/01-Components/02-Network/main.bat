goto :main
Title=Network
Type=XPEPlugin
Description=Network
Author=ChriSR
Date=2019.04.09
Version=002

:main
rem ==========update filesystem==========
call AddFiles %0 :end_files
goto :end_files

\Windows\INF\netlldp.inf
\Windows\INF\ndiscap.inf
\Windows\INF\netnwifi.inf
;\Windows\INF\vwifibus.sys

@\Windows\System32\drivers\
ipfltdrv.sys,lltdio.sys,mrxsmb10.sys,rspndr.sys,tcpipreg.sys,vwififlt.sys,WdiWiFi.sys
+mui
http.sys,ipnat.sys,mslldp.sys,ndiscap.sys,ndisimplatform.sys,nwifi.sys,tunnel.sys,wfplwfs.sys
-mui

@\Windows\System32\DriverStore\FileRepository\
netlldp.inf*,netnwifi.inf*
netvwifibus.inf*,netvwififlt.inf*,netvwifimp.inf*

; Folder
\ProgramData\Microsoft\WwanSvc
\Windows\L2Schemas
\Windows\schemas
\Windows\System32\icsxml
;
; Firewall (inWinre.wim: bfe.dll,mpssvc.dll,sscore.dll,firewallapi.dll,fwpuclnt.dll,fwremotesvr.dll,cmifw.dll,wfapigp.dll)
@\Windows\System32\
authfwcfg.dll,authfwgp.dll,authfwwizfwk.dll,Firewall.cpl,firewallcontrolpanel.dll
fwcfg.dll,sscoreext.dll,wfhc.dll

; netsh (fwcfg.dll,HNetMon.dll,NshHttp.dll,NshIpsec.dll,P2PNetsh.dll,P2P.dll,RpcNsh.dll,WcnNetsh.dll,WhHelper.dll,PeerDistSh.dll,MDMRegistration.dll,DMCmnutils.dll)
P2P.dll,p2pnetsh.dll,mdmregistration.dll,dmcmnutils.dll

; CoreMessaging Browser (in winre.wim: mi.dll,fwbase.dll,fwpolicyiomgr.dll)
browser.dll,CoreMessaging.dll

; Share folder (in Winre: gpapi.dll,gpsvc.dll,nlaapi.dll,smbwmiv2.dll,wmiclnt.dll - additional)
comsvcs.dll,gptext.dll,shacct.dll,shpafact.dll,shrpubw.exe,SMBHelperClass.dll

; password (in winre.wim DWrite.dll,credui.dll,credprovhost.dll,credprovs.dll)
credssp.dll

; dot3svc (additional: dot3gpui.dll,dot3ui.dll,onexui.dll,Dot3Conn.dll)
dot3api.dll,dot3cfg.dll,dot3dlg.dll,dot3gpclnt.dll,dot3hc.dll,dot3mm.dll
dot3msm.dll,dot3svc.dll,l2gpstore.dll,l2nacp.dll,onex.dll

; Control
IEAdvpack.dll,ieframe.dll,shwebsvc.dll,mshtml.dll

; Misc
fdWNet.dll,inetcomm.dll,iphlpsvc.dll,msi.dll,msvfw32.dll,networkitemfactory.dll
prnfldr.dll,puiapi.dll,TSpkg.dll,Windows.UI.Cred.dll

; Map a network drive
netplwiz.dll

; Control Pannel
inetcpl.cpl,netid.dll

; Windows Firewall/Internet Connection Sharing s (ICS) ervice
ipnathlp.dll,icsigd.dll,icsunattend.exe

; Network Diagnostic
ndfapi.dll,ndfetw.dll,NdfEventView.xml,ndfhcdiscovery.dll

; File Sharing (in winre.wim rtutils.dll,mpr.dll,mprapi.dll,mprmsg.dll) - optional netplwiz.dll,Netplwiz.exe)
iprtprio.dll,iprtrmgr.dll,mprddm.dll,mprdim.dll,networkexplorer.dll,NetworkStatus.dll,rtm.dll

; smb (in winre.wim wkssvc.dll,wkscli.dll)
wkspbrokerax.dll,wksprtps.dll

; NlaSvc (in Winre.wim: nlaapi.dll,nlasvc.dll,rasapi32.dll,tapi32.dll)
nlahc.dll
; Ndis
ndishc.dll
; Security Components
Keymgr.dll,Msaudite.dll
; Service Control
sc.exe
; service logon
seclogon.dll
; TCPIP support (in winre.wim: esent.dll,scecli.dll)
ubpm.dll
; Van NetStatus
VAN.dll
WlanRadioManager.dll
; Airplane mode
RMapi.dll
;
; WcmSvc (in Winre.wim: nlaapi.dll)
wcmapi.dll,wcmcsp.dll,wcmsvc.dll,NetworkUXBroker.dll
;
; WcncSvc
WcnApi.dll,wcncsvc.dll,WcnEapAuthProxy.dll,WcnEapPeerProxy.dll,WcnNetsh.dll,wcnwiz.dll
;
; EapHost (in Winre.wim Eap3Host.exe,eapp3hst.dll,eappcfg.dll,eappgnui.dll,eapphost.dll,eappprxy.dll,eapprovp.dll,eapsvc.dll,keyiso.dll,ttlsauth.dll,ttlscfg.dll)
cngcredui.dll,cngprovider.dll
;
; Wlan (additional: wlangpui.dll,wlandlg.dll,WLanConn.dll,wlanpref.dll,wlanutil.dll,provcore.dll)
mobilenetworking.dll,wlanapi.dll,wlancfg.dll,WLanConn.dll,wlandlg.dll,wlanext.exe,WLanHC.dll,wlanhlp.dll
WlanMediaManager.dll,WlanMM.dll,wlanmsm.dll,wlanpref.dll,wlansec.dll,wlansvc.dll,wlansvcpal.dll,wlanui.dll,wlanutil.dll
; Wlan password (additional: fdProxy.dll,webcheck.dll)
fdWCN.dll,fontext.dll,fundisc.dll,Windows.Globalization.dll,winhttp.dll
;
; Net event
netevent.dll
;
wbem\nlasvc.mof
wbem\wlan.mof
\Windows\SystemResources\Windows.UI.Cred\Windows.UI.Cred.pri
\Windows\SystemResources\Windows.UI.Cred\pris\Windows.UI.Cred*

:end_files

rem ==========update registry==========
rem call RegCopy HKLM\System\ControlSet001\Services\BDESVC
rem [Network_Registry]
if not "x%opt[build.registry.software]%"=="xfull" (
  call RegCopy HKLM\Software\Microsoft\wcmsvc
  call RegCopy HKLM\Software\Policies\Microsoft\Windows\WcmSvc
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SettingSync\WindowsSettingHandlers\Tethering
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{01578f96-c270-4602-ade0-578d9c29fc0c}
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{017ba13c-9a55-4f1f-8200-323055aac810}
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{67d07935-283a-4791-8f8d-fa9117f3e6f2}
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{9580d7dd-0379-4658-9870-d5be7d52d6de}
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{b92cf7fd-dc10-4c6b-a72d-1613bf25e597}
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{c100becc-d33a-4a4b-bf23-bbef4663d017}
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{c100becf-d33a-4a4b-bf23-bbef4663d017}
  call RegCopy HKLM\Software\Microsoft\WlanSvc
  rem //call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\XWizards
  rem //If,%Architecture%,Equal,x64,call RegCopy HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\XWizards
  rem //Network Places to see network in file explorer (Default ParsingName,::{F02C1A0D-BE21-4350-88B0-7367FC96EF3C})
  rem //reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{D20BEEC4-5CA8-4905-AE3B-BF251EA09B53} /v ParsingName /f::{208D2C60-3AEA-1069-A2D7-08002B30309D}
)

rem //-
rem //call RegCopy HKLM\System\ControlSet001\control\lsa\CredSSP
rem //reg add HKLM\Tmp_System\ControlSet001\Control\SecurityProviders /v SecurityProviders /fcredssp.dll
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f
rem //RegWrite,HKLM,0x7,Tmp_System\ControlSet001\Control\Lsa\OSConfig,"Security Packages",tspkg
call RegCopy HKLM\System\ControlSet001\Services\LanmanWorkstation
reg add HKLM\Tmp_System\ControlSet001\Services\LanmanWorkstation\Parameters /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f
call RegCopy HKLM\System\ControlSet001\Control\NetTrace\Scenarios\WLAN
call RegCopy HKLM\System\ControlSet001\Services\WlanSvc

reg add HKLM\Tmp_System\ControlSet001\Services\WlanSvc /v DependOnService /t REG_MULTI_SZ /d nativewifip\0RpcSs\0Ndisuio\0wcmsvc /f

if %VER[3]% GTR 17000 (
  reg add HKLM\Tmp_System\ControlSet001\Services\WlanSvc /v ErrorControl /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\WlanSvc /v ImagePath /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\Svchost.exe -k LocalSystemNetworkRestricted -p" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\WlanSvc /v Start /t REG_DWORD /d 2 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\WlanSvc /v Type /t REG_DWORD /d 32 /f
)
rem // wfplwfs
call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{3BFD7820-D65C-4C1B-9FEA-983A019639EA}
call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{B70D6460-3635-4D42-B866-B8AB1A24454C}
if "%WB_PE_ARCH%"=="x64" (
  call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{E7C3B2F0-F3C5-48DF-AF2B-10FED6D72E7A}
)
call RegCopy HKLM\System\ControlSet001\Services\WFPLWFS
rem //
call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{E475CF9A-60CD-4439-A75F-0079CE0E18A1}
rem // Holger: Fix WFPLWFS and both services nativewifip, wlanscv.
reg add HKLM\Tmp_System\ControlSet001\Control\NetworkSetup2\Filters\{3BFD7820-D65C-4C1B-9FEA-983A019639EA}\Kernel /v FilterClass /d ms_medium_converter_top /f
reg add HKLM\Tmp_System\ControlSet001\Control\NetworkSetup2\Filters\{B70D6460-3635-4D42-B866-B8AB1A24454C}\Kernel /v FilterClass /d ms_medium_converter_top /f
reg add HKLM\Tmp_System\ControlSet001\Control\NetworkSetup2\Filters\{E475CF9A-60CD-4439-A75F-0079CE0E18A1}\Kernel /v FilterClass /d ms_medium_converter_top /f

rem //-
call RegCopy HKLM\System\ControlSet001\Control\RadioManagement
call RegCopy HKLM\System\ControlSet001\Control\VAN
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Control\wcncsvc
call RegCopy HKLM\System\ControlSet001\Control\Winlogon\Notifications\Components\Dot3svc
call RegCopy HKLM\System\ControlSet001\Control\Winlogon\Notifications\Components\Wlansvc
rem //-
call RegCopy HKLM\System\ControlSet001\Services\bowser
call RegCopy HKLM\System\ControlSet001\Services\Browser
call RegCopy HKLM\System\ControlSet001\Services\dot3svc
rem //reg add HKLM\Tmp_System\ControlSet001\Services\dot3svc /v Start /t REG_DWORD /d 2 /f
call RegCopy HKLM\System\ControlSet001\Services\EapHost
call RegCopy HKLM\System\ControlSet001\Services\EventLog\System\Browser
call RegCopy HKLM\System\ControlSet001\Services\EventLog\System\Microsoft-Windows-WLAN-AutoConfig
call RegCopy HKLM\System\ControlSet001\Services\IPNAT
call RegCopy HKLM\System\ControlSet001\Services\IpFilterDriver
rem //Partial in Winre.wim call RegCopy HKLM\System\ControlSet001\Services\HTTP
call RegCopy HKLM\System\ControlSet001\Services\HTTP\Parameters\UrlAclInfo
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\NativeWifiP
rem //-
call RegCopy HKLM\System\ControlSet001\Services\NdisCap
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\NlaSvc
call RegCopy HKLM\System\ControlSet001\Services\SharedAccess
call RegCopy HKLM\System\ControlSet001\Services\tcpipreg
reg add HKLM\Tmp_System\ControlSet001\Services\TCPIPTUNNEL /v NdisMajorVersion /t REG_DWORD /d 6 /f
reg add HKLM\Tmp_System\ControlSet001\Services\TCPIPTUNNEL /v NdisMinorVersion /t REG_DWORD /d 40 /f
reg add HKLM\Tmp_System\ControlSet001\Services\TCPIPTUNNEL /v DriverMajorVersion /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\ControlSet001\Services\TCPIPTUNNEL /v DriverMinorVersion /t REG_DWORD /d 0 /f
rem // Telephony service
call RegCopy HKLM\System\ControlSet001\Services\TapiSrv
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\tdx
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\vwifibus
reg add HKLM\Tmp_System\ControlSet001\Services\vwifibus /v Owners /t REG_MULTI_SZ /d netvwifibus.inf /f
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\vwififlt
call RegCopy HKLM\System\ControlSet001\Services\Wcmsvc
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\wcncsvc
rem //In Winre.wim call RegCopy HKLM\System\ControlSet001\Services\wdiwifi
rem //Partial in Winre.wim call RegCopy HKLM\System\ControlSet001\Services\WinSock
rem //Partial in Winre.wim call RegCopy HKLM\System\ControlSet001\Services\WinSock2
rem // SMB v1.0 service.
call _mrxsmb10.bat
if exist "%X%\Windows\System32\drivers\mrxsmb10.sys" (
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v DependOnService /t REG_MULTI_SZ /d mrxsmb /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Description /d "@%%systemroot%%\system32\wkssvc.dll,-1005" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v DisplayName /d "@%%systemroot%%\system32\wkssvc.dll,-1004" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v ErrorControl /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Group /d Network /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v ImagePath /t REG_EXPAND_SZ /d system32\DRIVERS\mrxsmb10.sys /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Start /t REG_DWORD /d 2 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Tag /t REG_DWORD /d 6 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\mrxsmb10 /v Type /t REG_DWORD /d 2 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\LanmanWorkstation /v DependOnService /t REG_MULTI_SZ /d Bowser\0MRxSmb10\0MRxSmb20\0NSI /f
)
reg add HKLM\Tmp_System\Setup\AllowStart\dnscache /f
reg add HKLM\Tmp_System\Setup\AllowStart\nlasvc /f
reg add HKLM\Tmp_System\Setup\AllowStart\wcmsvc /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3 /v Settings /t REG_BINARY /d 30000000feffffff02000000030000003e0000002800000000000000f2030000900600001a0400006000000001000000 /f

rem // netprofm service is required for wlansvc and wcmsvc service in 1903! even disabled and not started.
call RegCopyEx Services netprofm
reg add HKLM\Tmp_System\ControlSet001\Services\netprofm /v Start /t REG_DWORD /d 4 /f

if "x%opt[network.networklist_and_sharecenter]%"=="xtrue" (
    set opt[network.networklist]=true
    set opt[network.sharecenter]=true
)
call _networklist.bat
call _discovery.bat
call _netcenter.bat

rem built-in network drivers
if not "x%opt[network.builtin_drivers]%"=="xtrue" goto :EOF

set AddFiles_Mode=merge

if "%WB_PE_ARCH%"=="x64" (
  call AddDrivers "athw8x.inf,netathr10x.inf,netathrx.inf,netbc63a.inf"
  call AddDrivers "netwbw02.inf,netwew00.inf,netwew01.inf,netwlv64.inf,netwns64.inf,netwsw00.inf,netwtw04.inf"
) else (
  call AddDrivers "athw8.inf,netathr.inf,netathr10.inf,netbc63.inf"
  call AddDrivers "netwbn02.inf,netwen00.inf,netwen01.inf,netwlv32.inf,netwns32.inf,netwsn00.inf,netwtn04.inf"
)
call AddDrivers "netbc64.inf,netrtwlane.inf,netrtwlane_13.inf,netrtwlanu.inf"

if %VER[3]% LEQ 17700 goto :EOF

if "%WB_PE_ARCH%"=="x64" (
  call AddDrivers "netwtw02,netwtn06.inf"
) else (
  call AddDrivers netwtn02.inf
)
call DoAddFiles
