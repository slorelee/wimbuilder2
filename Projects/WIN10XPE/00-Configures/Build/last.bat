if exist "%X_SYS%\AppxSysprep.dll" goto :UPDATE_SYSTEM_HIVE

rem set "RunAs"="Interactive User" -* "RunAs"=""
echo REGEDIT4 > "%WB_TMP_PATH%\RunAsUpdateTmp.reg"
echo. >> "%WB_TMP_PATH%\RunAsUpdateTmp.reg"
for /F %%i IN ('Reg Query HKLM\Tmp_Software\Classes\AppID /s /f "Interactive User" ^|%findcmd% Tmp_Software') do (
    echo [%%i]
    echo "RunAs"=""
) >> "%WB_TMP_PATH%\RunAsUpdateTmp.reg"
reg import "%WB_TMP_PATH%\RunAsUpdateTmp.reg"

:UPDATE_SYSTEM_HIVE
if not "x%opt[build.registry.system]%"=="xmerge" goto :EOF

rem useless drivers
call :REMOVE_SERV_REG iorate drivers\iorate.sys
call :REMOVE_SERV_REG rdyboost drivers\rdyboost.sys
call :REMOVE_SERV_REG WindowsTrustedRT drivers\WindowsTrustedRT.sys
call :REMOVE_SERV_REG WindowsTrustedRTProxy drivers\WindowsTrustedRTProxy.sys

rem BSOD
call :REMOVE_SERV_REG FileCrypt drivers\filecrypt.sys

rem desktop
call :REMOVE_SERV_REG StateRepository StateRepository.Core.dll
call :REMOVE_SERV_REG TokenBroker tokenbroker.dll

rem mouse
call :REMOVE_SERV_REG BrokerInfrastructure bisrv.dll

rem unused
call :REMOVE_SERV_REG AarSvc AarSvc.dll
call :REMOVE_SERV_REG afunix drivers\afunix.sys
call :REMOVE_SERV_REG AJRouter AJRouter.dll
call :REMOVE_SERV_REG AppID srpapi.dll
call :REMOVE_SERV_REG AppIDSvc appidsvc.dll
call :REMOVE_SERV_REG applockerfltr srpapi.dll
call :REMOVE_SERV_REG AppMgmt appmgmts.dll
call :REMOVE_SERV_REG AppVClient AppVClient.exe
call :REMOVE_SERV_REG AppvStrm drivers\AppvStrm.sys
call :REMOVE_SERV_REG AppvVemgr drivers\AppvVemgr.sys
call :REMOVE_SERV_REG AppvVfs drivers\\AppvVfs.sys
call :REMOVE_SERV_REG AssignedAccessManagerSvc assignedaccessmanagersvc.dll
call :REMOVE_SERV_REG autotimesvc autotimesvc.dll
call :REMOVE_SERV_REG bam drivers\bam.sys
call :REMOVE_SERV_REG BcastDVRUserService BcastDVRUserService.dll
call :REMOVE_SERV_REG bfs drivers\bfs.sys
call :REMOVE_SERV_REG BITS bitsperf.dll
call :REMOVE_SERV_REG BthA2dp drivers\BthA2dp.sys
call :REMOVE_SERV_REG BthEnum drivers\BthEnum.sys
call :REMOVE_SERV_REG BthHFAud drivers\BthHfAud.sys
call :REMOVE_SERV_REG BthHFEnum drivers\bthhfenum.sys
call :REMOVE_SERV_REG BthLEEnum drivers\Microsoft.Bluetooth.Legacy.LEEnumerator.sys
call :REMOVE_SERV_REG BthMini drivers\BTHMINI.sys
call :REMOVE_SERV_REG BTHMODEM drivers\bthmodem.sys
call :REMOVE_SERV_REG BthPan drivers\bthpan.sys
call :REMOVE_SERV_REG BTHPORT drivers\BTHport.sys
call :REMOVE_SERV_REG bthserv bthserv.dll
call :REMOVE_SERV_REG BTHUSB drivers\BTHUSB.sys
call :REMOVE_SERV_REG CAD drivers\CAD.sys
call :REMOVE_SERV_REG CaptureService CaptureService.dll
call :REMOVE_SERV_REG cbdhsvc cbdhsvc.dll
call :REMOVE_SERV_REG CDPSvc cdpsvc.dll
call :REMOVE_SERV_REG CDPUserSvc cdpusersvc.dll
call :REMOVE_SERV_REG CimFS unknown
call :REMOVE_SERV_REG circlass drivers\circlass.sys
call :REMOVE_SERV_REG cloudidsvc cloudidsvc.dll
call :REMOVE_SERV_REG cnghwassist drivers\cnghwassist.sys
call :REMOVE_SERV_REG CompositeBus ..\Inf\compositebus.inf 
call :REMOVE_SERV_REG COMSysApp COMSysApp
call :REMOVE_SERV_REG ConsentUxUserSvc ConsentUxClient.dll
call :REMOVE_SERV_REG CoreUI non-service.dll
call :REMOVE_SERV_REG CredentialEnrollmentManagerUserSvc CredentialEnrollmentManager.exe
call :REMOVE_SERV_REG CSC cscsvc.dll
call :REMOVE_SERV_REG CscService cscsvc.dll
call :REMOVE_SERV_REG dam drivers\dam.sys
call :REMOVE_SERV_REG dcsvc dcsvc.dll
call :REMOVE_SERV_REG DevicePickerUserSvc Windows.Devices.Picker.dll
call :REMOVE_SERV_REG DevicesFlowUserSvc DevicesFlowBroker.dll
call :REMOVE_SERV_REG DevQueryBroker DevQueryBroker.dll
call :REMOVE_SERV_REG diagsvc DiagSvc.dll
call :REMOVE_SERV_REG DialogBlockingService DialogBlockingService.dll
call :REMOVE_SERV_REG DispBrokerDesktopSvc dispbroker.desktop.dll
call :REMOVE_SERV_REG DmEnrollmentSvc Windows.Internal.Management.dll
call :REMOVE_SERV_REG dmwappushservice dmwappushsvc.dll
call :REMOVE_SERV_REG DoSvc dosvc.dll
call :REMOVE_SERV_REG DPS dps.dll
call :REMOVE_SERV_REG DsSvc dssvc.dll
call :REMOVE_SERV_REG DusmSvc dusmsvc.dll
call :REMOVE_SERV_REG edgeupdate "..\..\Program Files\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe"
call :REMOVE_SERV_REG embeddedmode embeddedmodesvc.dll
call :REMOVE_SERV_REG EntAppSvc EnterpriseAppMgmtSvc.dll
call :REMOVE_SERV_REG ESENT non-service.dll
call :REMOVE_SERV_REG fhsvc fhsvc.dll
call :REMOVE_SERV_REG FrameServer FrameServer.dll
call :REMOVE_SERV_REG FrameServerMonitor FrameServerMonitor.dll
call :REMOVE_SERV_REG gencounter drivers\vmgencounter.sys
call :REMOVE_SERV_REG GraphicsPerfSvc GraphicsPerfSvc.dll
call :REMOVE_SERV_REG HidBth drivers\hidbth.sys
call :REMOVE_SERV_REG HidIr drivers\hidir.sys
call :REMOVE_SERV_REG HvHost hvhostsvc.dll
call :REMOVE_SERV_REG hvservice drivers\hvservice.sys
call :REMOVE_SERV_REG HwNClx0101 Drivers\mshwnclx.sys
call :REMOVE_SERV_REG InstallService InstallService.dll
call :REMOVE_SERV_REG intelpep drivers\intelpep.sys
call :REMOVE_SERV_REG intelpmax drivers\intelpmax.sys
call :REMOVE_SERV_REG IntelPMT drivers\IntelPMTsys
call :REMOVE_SERV_REG InventorySvc inventorysvc.dll
call :REMOVE_SERV_REG IPT drivers\ipt.sys
call :REMOVE_SERV_REG IpxlatCfgSvc ipxlatcfg.dll
call :REMOVE_SERV_REG kbldfltr drivers\kbldfltr.sys
call :REMOVE_SERV_REG KtmRm msdtckrm.dll
call :REMOVE_SERV_REG lfsvc lfsvc.dll
call :REMOVE_SERV_REG LicenseManager licensemanagersvc.dll
call :REMOVE_SERV_REG lltdsvc lltdres.dll
call :REMOVE_SERV_REG luafv luafv.dll
call :REMOVE_SERV_REG LxpSvc LanguageOverlayServer.dll
call :REMOVE_SERV_REG MapsBroker moshost.dll
call :REMOVE_SERV_REG MbbCx drivers\MbbCx.sys
call :REMOVE_SERV_REG McpManagementService McpManagementService.dll
call :REMOVE_SERV_REG MessagingService MessagingService.dll
call :REMOVE_SERV_REG Microsoft_Bluetooth_AvrcpTransport drivers\Microsoft.Bluetooth.AvrcpTransport.sys
call :REMOVE_SERV_REG MixedRealityOpenXRSvc MixedRealityRuntime.dll
call :REMOVE_SERV_REG Modem drivers\modem.sys
call :REMOVE_SERV_REG MsBridge bridgeres.dll
call :REMOVE_SERV_REG MSDTC msdtc.exe
call :REMOVE_SERV_REG msgpiowin32 drivers\msgpiowin32.sys
call :REMOVE_SERV_REG MsKeyboardFilter KeyboardFilterSvc.dll
call :REMOVE_SERV_REG MSKSSRV drivers\MSKSSRV.sys
call :REMOVE_SERV_REG MSPCLOCK drivers\MSPCLOCK.sys
call :REMOVE_SERV_REG MSPQM drivers\MSPQM.sys
call :REMOVE_SERV_REG MsSecFlt drivers\mssecflt.sys
call :REMOVE_SERV_REG MSTEE drivers\MSTEE.sys
call :REMOVE_SERV_REG napagent tsgqec.dll
call :REMOVE_SERV_REG NaturalAuthentication NaturalAuth.dll
call :REMOVE_SERV_REG NcaSvc ncasvc.dll
call :REMOVE_SERV_REG NcbService ncbservice.dll
call :REMOVE_SERV_REG NcdAutoSetup NcdAutoSetup.dll
call :REMOVE_SERV_REG NdisCap drivers\ndiscap.sys
call :REMOVE_SERV_REG NDKPerf drivers\NDKPerf.sys
call :REMOVE_SERV_REG NDKPing drivers\NDKPing.sys
call :REMOVE_SERV_REG Ndu drivers\Ndu.sys
call :REMOVE_SERV_REG NetTcpPortSharing "..\Microsoft.NET\Framework64\v4.0.30319\SMSvcHost.exe"
call :REMOVE_SERV_REG NgcCtnrSvc NgcCtnrSvc.dll
call :REMOVE_SERV_REG NgcSvc ngcsvc.dll
call :REMOVE_SERV_REG NPSMSvc npsm.dll
call :REMOVE_SERV_REG OneSyncSvc APHostRes.dll
call :REMOVE_SERV_REG p2pimsvc pnrpsvc.dll
call :REMOVE_SERV_REG p2psvc p2psvc.dll
call :REMOVE_SERV_REG P9NP drivers\P9NP.sys
call :REMOVE_SERV_REG P9Rdr drivers\P9Rdr.sys
call :REMOVE_SERV_REG P9RdrService p9rdrservice.dll
call :REMOVE_SERV_REG PEAUTH drivers\peauth.sys
call :REMOVE_SERV_REG PeerDistSvc peerdistsvc.dll
call :REMOVE_SERV_REG PenService PenService.dll
call :REMOVE_SERV_REG perceptionsimulation PerceptionSimulation\PerceptionSimulationService.exe
call :REMOVE_SERV_REG PerfHost ..\SysWow64\perfhost.exe
call :REMOVE_SERV_REG PhoneSvc PhoneserviceRes.dll
call :REMOVE_SERV_REG PimIndexMaintenanceSvc UserDataAccessRes.dll
call :REMOVE_SERV_REG PktMon drivers\PktMon.sys
call :REMOVE_SERV_REG pla pla.dll
call :REMOVE_SERV_REG PNPMEM drivers\pnpmem.sys
call :REMOVE_SERV_REG PNRPAutoReg pnrpauto.dll
call :REMOVE_SERV_REG PNRPsvc pnrpsvc.dll
call :REMOVE_SERV_REG PrintWorkflowUserSvc PrintWorkflowService.dll
call :REMOVE_SERV_REG PushToInstall pushtoinstall.dll
call :REMOVE_SERV_REG QWAVE qwave.dll
call :REMOVE_SERV_REG QWAVEdrv drivers\qwavedrv.sys
call :REMOVE_SERV_REG RasMan\ThirdParty rascustom.dll
call :REMOVE_SERV_REG RemoteAccess mprdim.dll
call :REMOVE_SERV_REG RemoteRegistry regsvc.dll
call :REMOVE_SERV_REG RpcLocator Locator.exe
call :REMOVE_SERV_REG s3cap drivers\vms3cap.sys
call :REMOVE_SERV_REG sacsvr sacsvr.dll
call :REMOVE_SERV_REG SCardSvr SCardSvr.dll
call :REMOVE_SERV_REG ScDeviceEnum ScDeviceEnum.dll
call :REMOVE_SERV_REG scfilter drivers\scfilter.sys
call :REMOVE_SERV_REG SCPolicySvc certprop.dll
call :REMOVE_SERV_REG SDFRd drivers\SDFRd.sys
call :REMOVE_SERV_REG SDRSVC sdrsvc.dll
call :REMOVE_SERV_REG SecurityHealthService SecurityHealthAgent.dll
call :REMOVE_SERV_REG SEMgrSvc SEMgrSvc.dll
call :REMOVE_SERV_REG Sense "..\..\Program Files\Windows Defender Advanced Threat Protection\MsSense.exe"
call :REMOVE_SERV_REG SensorDataService SensorDataService.exe
call :REMOVE_SERV_REG SensorService sensorservice.dll
call :REMOVE_SERV_REG SensrSvc sensrsvc.dll
call :REMOVE_SERV_REG SgrmAgent drivers\SgrmAgent.sys
call :REMOVE_SERV_REG SgrmBroker Sgrm\SgrmBroker.exe
call :REMOVE_SERV_REG SharedRealitySvc SharedRealitySvc.dll
call :REMOVE_SERV_REG shpamsvc Windows.SharedPC.AccountManager.dll
call :REMOVE_SERV_REG smbdirect drivers\smbdirect.sys
call :REMOVE_SERV_REG SmsRouter SmsRouterSvc.dll
call :REMOVE_SERV_REG SNMPTrap snmptrap.exe
call :REMOVE_SERV_REG spaceparser drivers\spaceparser.sys
call :REMOVE_SERV_REG SpatialGraphFilter drivers\SpatialGraphFilter.sys
call :REMOVE_SERV_REG spectrum spectrum.exe
call :REMOVE_SERV_REG Spooler spoolsv.exe
call :REMOVE_SERV_REG ssh-agent OpenSSH\ssh-agent.exe
call :REMOVE_SERV_REG StorSvc StorSvc.dll
call :REMOVE_SERV_REG SysMain sysmain.dll
call :REMOVE_SERV_REG TrkWks trkwks.dll
call :REMOVE_SERV_REG TroubleshootingSvc MitigationClient.dll
call :REMOVE_SERV_REG tunnel drivers\tunnel.sys
call :REMOVE_SERV_REG tzautoupdate tzautoupdate.dll
call :REMOVE_SERV_REG UdkUserSvc windowsudkservices.shellcommon.dll
call :REMOVE_SERV_REG UevAgentDriver drivers\UevAgentDriver.sys
call :REMOVE_SERV_REG UevAgentService AgentService.exe
call :REMOVE_SERV_REG Ufx01000 drivers\ufx01000.sys
call :REMOVE_SERV_REG UGatherer non-service.dll
call :REMOVE_SERV_REG UGTHRSVC non-service.dll
call :REMOVE_SERV_REG UnistoreSvc UserDataAccessRes.dll
call :REMOVE_SERV_REG UrsChipidea ..\Inf\urschipidea.inf
call :REMOVE_SERV_REG UrsCx01000 drivers\urscx01000.sys
call :REMOVE_SERV_REG UrsSynopsys ..\Inf\urssynopsys.inf
call :REMOVE_SERV_REG usbaudio2 drivers\usbaudio2.sys
call :REMOVE_SERV_REG usbcir drivers\usbcir.sys
call :REMOVE_SERV_REG usbprint drivers\usbprint.sys
call :REMOVE_SERV_REG UserDataSvc UserDataAccessRes.dll
call :REMOVE_SERV_REG UsoSvc usosvc.dll
call :REMOVE_SERV_REG VacSvc vac.dll
call :REMOVE_SERV_REG Vid drivers\Vid.sys
call :REMOVE_SERV_REG VirtualRender ..\Inf\vrd.inf
call :REMOVE_SERV_REG vmgid drivers\vmgid.sys
call :REMOVE_SERV_REG vmicguestinterface icsvc.dll
call :REMOVE_SERV_REG vmicheartbeat icsvc.dll
call :REMOVE_SERV_REG vmickvpexchange icsvc.dll
call :REMOVE_SERV_REG vmicrdv icsvcext.dll
call :REMOVE_SERV_REG vmicshutdown icsvc.dll
call :REMOVE_SERV_REG vmictimesync icsvc.dll
call :REMOVE_SERV_REG vmicvmsession icsvc.dll
call :REMOVE_SERV_REG vmicvss icsvcvss.dll
call :REMOVE_SERV_REG WaaSMedicSvc WaaSMedicSvc.dll
call :REMOVE_SERV_REG WalletService WalletService.dll
call :REMOVE_SERV_REG WarpJITSvc Windows.WARP.JITService.dll
call :REMOVE_SERV_REG WbioSrvc wbiosrvc.dll
call :REMOVE_SERV_REG WdBoot "..\..\Program Files\Windows Defender\MpAsDesc.dll"
call :REMOVE_SERV_REG WdFilter "..\..\Program Files\Windows Defender\MpAsDesc.dll"
call :REMOVE_SERV_REG WdiServiceHost wdi.dll
call :REMOVE_SERV_REG WdiSystemHost wdi.dll
call :REMOVE_SERV_REG WdNisDrv "..\..\Program Files\Windows Defender\MpAsDesc.dll"
call :REMOVE_SERV_REG WdNisSvc "..\..\Program Files\Windows Defender\MpAsDesc.dll"
call :REMOVE_SERV_REG webthreatdefsvc webthreatdefsvc.dll
call :REMOVE_SERV_REG Wecsvc wecsvc.dll
call :REMOVE_SERV_REG WEPHOSTSVC wephostsvc.dll
call :REMOVE_SERV_REG wercplsupport wercplsupport.dll
call :REMOVE_SERV_REG WiaRpc wiarpc.dll
call :REMOVE_SERV_REG WinDefend "..\..\Program Files\Windows Defender\MpAsDesc.dll"
call :REMOVE_SERV_REG WinNat drivers\winnat.sys
call :REMOVE_SERV_REG WinRM wsmsvc.dll
call :REMOVE_SERV_REG wisvc flightsettings.dll
call :REMOVE_SERV_REG wlidsvc wlidsvc.dll
call :REMOVE_SERV_REG wlpasvc lpasvc.dll
call :REMOVE_SERV_REG WManSvc Windows.Management.Service.dll
call :REMOVE_SERV_REG WMPNetworkSvc "..\..\Program Files\Windows Media Player\wmpnetwk.exe"
call :REMOVE_SERV_REG workfolderssvc workfolderssvc.dll
call :REMOVE_SERV_REG WpcMonSvc WpcRefreshTask.dll
call :REMOVE_SERV_REG WpnService wpnservice.dll
call :REMOVE_SERV_REG wscsvc wscsvc.dll
call :REMOVE_SERV_REG wtd drivers\wtd.sys
call :REMOVE_SERV_REG wuauserv wuauserv.dll
call :REMOVE_SERV_REG WwanSvc wwansvc.dll
call :REMOVE_SERV_REG XblAuthManager XblAuthManager.dll
call :REMOVE_SERV_REG XblGameSave XblGameSave.dll
call :REMOVE_SERV_REG XboxNetApiSvc XboxNetApiSvc.dll

goto :EOF

:REMOVE_SERV_REG
if not exist "%X_SYS%\%~2" reg delete "HKLM\Tmp_SYSTEM\ControlSet001\Services\%~1" /f
goto :EOF
