echo Extra-Sliming...

rd /s /q "%X%\sources"
rd /s /q "%X%\Program Files\Common Files\Microsoft Shared\ink"

rd /s /q "%X_WIN%\AppCompat"
rd /s /q "%X_WIN%\CbsTemp"
rd /s /q "%X_WIN%\Help"
rd /s /q "%X_WIN%\L2Schemas"
rd /s /q "%X_WIN%\LiveKernelReports"
rd /s /q "%X_WIN%\Microsoft.NET"
rd /s /q "%X_WIN%\PLA"
rd /s /q "%X_WIN%\PolicyDefinitions"
rd /s /q "%X_WIN%\ServiceState"
rd /s /q "%X_WIN%\tracing"
rd /s /q "%X_WIN%\WaaS"

rd /s /q "%X_SYS%\0409"
rd /s /q "%X_SYS%\catroot2"
rd /s /q "%X_SYS%\DriverState"
rd /s /q "%X_SYS%\GroupPolicy"
rd /s /q "%X_SYS%\GroupPolicyUsers"
rd /s /q "%X_SYS%\LogFiles"
rd /s /q "%X_SYS%\MUI"
rd /s /q "%X_SYS%\oobe"
rd /s /q "%X_SYS%\ras"
rd /s /q "%X_SYS%\RasToast"
rd /s /q "%X_SYS%\restore"
rd /s /q "%X_SYS%\Recovery"
rd /s /q "%X_SYS%\setup"
rd /s /q "%X_SYS%\spp"
rd /s /q "%X_SYS%\Sysprep"
rd /s /q "%X_SYS%\WCN"
rd /s /q "%X_SYS%\winevt"

call :DEL_DRVSTORES "3ware,acpi,adp80xx,amdsata,amdsbs,arcsas,bcmdhd64,bcmwdidhdpcie,bfad,bfadfcoe,bnxtnd,bxfcoe,bxois"
call :DEL_DRVSTORES "c_fdc,c_floppydisk,c_nettrans,c_pnpprinters,c_printer,dc21x4vm,e2xw10x64,ehstortcgdrv,elxfcoe,elxstor,fdc,flpydisk"
call :DEL_DRVSTORES "hdaudio,hdaudss,hpsamd,iastorav,iastorv,ipoib6x,itsas35i,lsi_sss,kdnic,lltdio,lsi_sas,lsi_sas2i"
call :DEL_DRVSTORES "megas" "*"
call :DEL_DRVSTORES "mrvlpcie8897,mssmbios,msux64w10,mvumis,mwlu97w8x64,ndisimplatform,ndisimplatformmp,ndisuio,npsvctrig"
call :DEL_DRVSTORES "nvraid,pci,pcmcia,percsas2i,percsas3i,qefcoe,qeois,ql2300,ql40xx2i,qlfcoei,rspndr,rt640x64,rtux64w10,sbp2"
call :DEL_DRVSTORES "scmbus,sisraid2,sisraid4,smartsamd,spaceport,stexstor,stornvme,storufs,usbnet,vdrvroot,vhdmp,vsmraid,vstxraid"
call :DEL_DRVSTORES "wdmaudio,wdmaudiocoresystem,wdma_usb,wnetvsc,ykinx64"

del /a /f /q "%X_SYS%\adtschema.dll"
del /a /f /q "%X_SYS%\advpack.dll"
del /a /f /q "%X_SYS%\aepic.dll"
del /a /f /q "%X_SYS%\authui.dll"
del /a /f /q "%X_SYS%\avrt.dll"
del /a /f /q "%X_SYS%\bcdprov.dll"
del /a /f /q "%X_SYS%\bcdsrv.dll"
del /a /f /q "%X_SYS%\bderepair.dll"
del /a /f /q "%X_SYS%\bdeui.dll"
del /a /f /q "%X_SYS%\BFE.DLL"
del /a /f /q "%X_SYS%\bmrui.exe"
del /a /f /q "%X_SYS%\bootcfg.exe"
del /a /f /q "%X_SYS%\BootMenuUX.dll"
del /a /f /q "%X_SYS%\bootux.dll"
del /a /f /q "%X_SYS%\cabapi.dll"
del /a /f /q "%X_SYS%\capisp.dll"
del /a /f /q "%X_SYS%\certca.dll"
del /a /f /q "%X_SYS%\certcli.dll"
del /a /f /q "%X_SYS%\cfmifs.dll"
del /a /f /q "%X_SYS%\cfmifsproxy.dll"
del /a /f /q "%X_SYS%\chkwudrv.dll"
del /a /f /q "%X_SYS%\cmifw.dll"
del /a /f /q "%X_SYS%\comcat.dll"
del /a /f /q "%X_SYS%\comcat.dll"
del /a /f /q "%X_SYS%\CompPkgSup.dll"
del /a /f /q "%X_SYS%\comres.dll"
del /a /f /q "%X_SYS%\ConhostV1.dll"
del /a /f /q "%X_SYS%\ConsoleLogon.dll"
del /a /f /q "%X_SYS%\convertvhd.exe"
del /a /f /q "%X_SYS%\CredentialUIBroker.exe"
del /a /f /q "%X_SYS%\cryptdlg.dll"
del /a /f /q "%X_SYS%\cryptext.dll"
del /a /f /q "%X_SYS%\cryptnet.dll"
del /a /f /q "%X_SYS%\cryptui.dll"
del /a /f /q "%X_SYS%\cryptxml.dll"
del /a /f /q "%X_SYS%\cscript.exe"
del /a /f /q "%X_SYS%\CSystemEventsBrokerClient.dll"

call :KEEP_FILE \Windows\System32\d3d10warp.dll
del /a /f /q "%X_SYS%\d3d10*.dll"

del /a /f /q "%X_SYS%\d3d11on12.dll"
del /a /f /q "%X_SYS%\D3D12.dll"
del /a /f /q "%X_SYS%\d3d8thk.dll"
del /a /f /q "%X_SYS%\d3d9.dll"

del /a /f /q "%X_SYS%\dafWCN.dll"
del /a /f /q "%X_SYS%\dafWfdProvider.dll"
del /a /f /q "%X_SYS%\dcntel.dll"
del /a /f /q "%X_SYS%\DefaultQuestions.json"
del /a /f /q "%X_SYS%\delegatorprovider.dll"
del /a /f /q "%X_SYS%\DetailedReading-Default.xml"
del /a /f /q "%X_SYS%\DeviceCensus.exe"
del /a /f /q "%X_SYS%\devicengccredprov.dll"
del /a /f /q "%X_SYS%\DeviceUpdateAgent.dll"
rem del /a /f /q "%X_SYS%\Display.dll"
del /a /f /q "%X_SYS%\dllhst3g.exe"
del /a /f /q "%X_SYS%\dnscacheugc.exe"
del /a /f /q "%X_SYS%\dnsrslvr.dll"
del /a /f /q "%X_SYS%\dpapimig.exe"
rem del /a /f /q "%X_SYS%\dpapisrv.dll"    required for startup startnet.cmd
del /a /f /q "%X_SYS%\dpx.dll"
del /a /f /q "%X_SYS%\driverquery.exe"

del /a /f /q "%X_SYS%\dxgwdi.dll"
del /a /f /q "%X_SYS%\dxva2.dll"

if "x%opt[component.winphotoviewer]%"=="xtrue" (
  call :KEEP_FILE \Windows\System32\efswrt.dll
)
del /a /f /q "%X_SYS%\efs*.dll"

del /a /f /q "%X_SYS%\esentutl.exe"
del /a /f /q "%X_SYS%\esevss.dll"
del /a /f /q "%X_SYS%\ETWESEProviderResources.dll"

del /a /f /q "%X_SYS%\f3ahvoas.dll"
del /a /f /q "%X_SYS%\finger.exe"
del /a /f /q "%X_SYS%\fixmapi.exe"
del /a /f /q "%X_SYS%\fmapi.dll"
del /a /f /q "%X_SYS%\FntCache.dll"
del /a /f /q "%X_SYS%\fontsub.dll"
del /a /f /q "%X_SYS%\framedyn.dll"
del /a /f /q "%X_SYS%\ftp.exe"

call :KEEP_FILE \Windows\System32\fvecerts.dll
call :KEEP_FILE \Windows\System32\fwbase.dll
del /a /f /q "%X_SYS%\fv*.dll"
del /a /f /q "%X_SYS%\fw*.dll"

del /a /f /q "%X_SYS%\gmsaclient.dll"
del /a /f /q "%X_SYS%\gpsvc.dll"

del /a /f /q "%X_SYS%\HalExtIntcLpioDMA.dll"
del /a /f /q "%X_SYS%\HalExtPL080.dll"
rem del /a /f /q "%X_SYS%\hbaapi.dll"    required for startup startnet.cmd
del /a /f /q "%X_SYS%\hhctrl.ocx"

del /a /f /q "%X_SYS%\httpapi.dll"
del /a /f /q "%X_SYS%\HvSocket.dll"
del /a /f /q "%X_SYS%\hwcompat.dll"
del /a /f /q "%X_SYS%\hwcompat.txt"
del /a /f /q "%X_SYS%\hwexclude.txt"

del /a /f /q "%X_SYS%\icfupgd.dll"
if not "x%opt[component.winphotoviewer]%"=="xtrue" (
  del /a /f /q "%X_SYS%\icm32.dll"
)
del /a /f /q "%X_SYS%\idndl.dll"
del /a /f /q "%X_SYS%\iemigplugin.dll"
del /a /f /q "%X_SYS%\IndexedDbLegacy.dll"
del /a /f /q "%X_SYS%\inetcomm.dll"
del /a /f /q "%X_SYS%\inetmib1.dll"
del /a /f /q "%X_SYS%\INETRES.dll"
del /a /f /q "%X_SYS%\ipconfig.exe"
del /a /f /q "%X_SYS%\IPSECSVC.DLL"


call :KEEP_FILE \Windows\System32\iscsidsc.dll
del /a /f /q "%X_SYS%\iscsi*.dll"
del /a /f /q "%X_SYS%\iscsi*.exe"

del /a /f /q "%X_SYS%\joinproviderol.dll"
del /a /f /q "%X_SYS%\jsproxy.dll"
rem del /a /f /q "%X_SYS%\KerbClientShared.dll"    required for startup startnet.cmd
del /a /f /q "%X_SYS%\kerberos.dll"
del /a /f /q "%X_SYS%\KeyCredMgr.dll"
del /a /f /q "%X_SYS%\keyiso.dll"
del /a /f /q "%X_SYS%\kmddsp.dll"
del /a /f /q "%X_SYS%\l2nacp.dll"
del /a /f /q "%X_SYS%\lmhsvc.dll"
del /a /f /q "%X_SYS%\loadperf.dll"
del /a /f /q "%X_SYS%\lodctr.exe"
del /a /f /q "%X_SYS%\LogonController.dll"
del /a /f /q "%X_SYS%\luainstall.dll"

call :DEL_SYSFILES "manage-bde.exe,MBR2GPT.exe,mcbuilder.exe,MdSched.exe,mighost.exe,MRINFO.EXE"
call :DEL_SYSFILES "mapi32.dll,mapistub.dll,mcupdate_AuthenticAMD.dll,mcupdate_GenuineIntel.dll,mf3216.dll"

call :KEEP_FILE \Windows\System32\mintdh.dll
del /a /f /q "%X_SYS%\mi*.dll"

call :DEL_SYSFILES "mprext.dll,mprmsg.dll,mprapi.dll,MPSSVC.dll,MMDevAPI.dll"

del /a /f /q "%X_SYS%\msadp32.acm"
del /a /f /q "%X_SYS%\msafd.dll"
del /a /f /q "%X_SYS%\msaudite.dll"
del /a /f /q "%X_SYS%\mscat32.dll"
del /a /f /q "%X_SYS%\msdelta.dll"
del /a /f /q "%X_SYS%\msdmo.dll"
del /a /f /q "%X_SYS%\msg711.acm"
del /a /f /q "%X_SYS%\msgsm32.acm"
del /a /f /q "%X_SYS%\msiltcfg.dll"
del /a /f /q "%X_SYS%\msimtf.dll"
del /a /f /q "%X_SYS%\mskeyprotect.dll"
del /a /f /q "%X_SYS%\msobjs.dll"
del /a /f /q "%X_SYS%\msoert2.dll"
del /a /f /q "%X_SYS%\mspatcha.dll"
del /a /f /q "%X_SYS%\mspatchc.dll"
del /a /f /q "%X_SYS%\msrating.dll"
del /a /f /q "%X_SYS%\mssign32.dll"
del /a /f /q "%X_SYS%\mssip32.dll"
del /a /f /q "%X_SYS%\msvcirt.dll"
del /a /f /q "%X_SYS%\mtxdm.dll"

call :DEL_SYSFILES "muifontsetup.dll,MuiUnattend.exe,MXEAgent.dll"

del /a /f /q "%X_SYS%\nbtstat.exe"
call :KEEP_FILES \Windows\System32\ "ncobjapi.dll,ncrypt.dll"
del /a /f /q "%X_SYS%\nc*.dll"

call :KEEP_FILE \Windows\System32\normaliz.dll
del /a /f /q "%X_SYS%\nor*.*"

call :DEL_SYSFILES "newdev.exe,ngclocal.dll,nrpsrv.dll,nshwfp.dll"
call :DEL_SYSFILES "ntlanman.dll,ntprint.dll,ntprint.exe,odbccp32.dll,odbctrac.dll,onex.dll"
del /a /f /q "%X_SYS%\offline*.*"

del /a /f /q "%X_SYS%\ncpa.cpl"
del /a /f /q "%X_SYS%\ndadmin.exe"
del /a /f /q "%X_SYS%\nlaapi.dll"
del /a /f /q "%X_SYS%\nlasvc.dll"
del /a /f /q "%X_SYS%\Nlsdl.dll"

del /a /f /q "%X_SYS%\PkgMgr.exe"
del /a /f /q "%X_SYS%\pngfilt.dll"
del /a /f /q "%X_SYS%\pnpclean.dll"
del /a /f /q "%X_SYS%\pnppolicy.dll"
del /a /f /q "%X_SYS%\PnPUnattend.exe"
del /a /f /q "%X_SYS%\polstore.dll"
del /a /f /q "%X_SYS%\poqexec.exe"
del /a /f /q "%X_SYS%\powercfg.exe"
del /a /f /q "%X_SYS%\powercpl.dll"
del /a /f /q "%X_SYS%\prflbmsg.dll"
del /a /f /q "%X_SYS%\print.exe"
del /a /f /q "%X_SYS%\printui.dll"
del /a /f /q "%X_SYS%\profext.dll"
del /a /f /q "%X_SYS%\profsvc.dll"

del /a /f /q "%X_SYS%\provthrd.dll"
del /a /f /q "%X_SYS%\prvdmofcomp.dll"

del /a /f /q "%X_SYS%\PSModuleDiscoveryProvider.dll"
del /a /f /q "%X_SYS%\psmodulediscoveryprovider.mof"
del /a /f /q "%X_SYS%\rdrleakdiag.exe"
del /a /f /q "%X_SYS%\ReAgent.dll"
del /a /f /q "%X_SYS%\recdisc.exe"
del /a /f /q "%X_SYS%\recover.exe"
del /a /f /q "%X_SYS%\refsutil.exe"

del /a /f /q "%X_SYS%\Register-CimProvider.exe"
del /a /f /q "%X_SYS%\ReInfo.dll"
del /a /f /q "%X_SYS%\replace.exe"
del /a /f /q "%X_SYS%\repair-bde.exe"
del /a /f /q "%X_SYS%\resutils.dll"
del /a /f /q "%X_SYS%\ROUTE.EXE"
del /a /f /q "%X_SYS%\RpcRtRemote.dll"
del /a /f /q "%X_SYS%\rstrui.exe"
del /a /f /q "%X_SYS%\rtutils.dll"
del /a /f /q "%X_SYS%\RTWorkQ.dll"
del /a /f /q "%X_SYS%\runexehelper.exe"

call :DEL_SYSFILES "OpcServices.dll,oscomps.woa.xml,oscomps.xml,osfilter.inf,pacjsworker.exe,PATHPING.EXE"
del /a /f /q "%X_SYS%\perf*.*"

del /a /f /q "%X_SYS%\sacsess.exe"
del /a /f /q "%X_SYS%\sacsvr.dll"
del /a /f /q "%X_SYS%\scesrv.dll"
del /a /f /q "%X_SYS%\schannel.dll"
del /a /f /q "%X_SYS%\schedcli.dll"
del /a /f /q "%X_SYS%\scrobj.dll"

del /a /f /q "%X_SYS%\security.dll"
del /a /f /q "%X_SYS%\setbcdlocale.dll"
del /a /f /q "%X_SYS%\setupetw.dll"
del /a /f /q "%X_SYS%\sfc.dll"
del /a /f /q "%X_SYS%\sfc.exe"
del /a /f /q "%X_SYS%\sfc_os.dll"
del /a /f /q "%X_SYS%\smbwmiv2.dll"
del /a /f /q "%X_SYS%\softpub.dll"
del /a /f /q "%X_SYS%\spp.dll"
del /a /f /q "%X_SYS%\sppinst.dll"
del /a /f /q "%X_SYS%\sppnp.dll"
del /a /f /q "%X_SYS%\srclient.dll"
del /a /f /q "%X_SYS%\srcore.dll"
del /a /f /q "%X_SYS%\SSShim.dll"
del /a /f /q "%X_SYS%\sstpsvc.dll"
del /a /f /q "%X_SYS%\stdole32.tlb"
del /a /f /q "%X_SYS%\sxproxy.dll"
del /a /f /q "%X_SYS%\sxstrace.exe"


call :DEL_SYSFILES "tapi32.dll,tbs.dll,tcpipcfg.dll,tcpmib.dll,TCPSVCS.EXE,tokenbinding.dll,TpmCertResources.dll,TpmCoreProvisioning.dll"
call :DEL_SYSFILES "TRACERT.EXE,TrustedSignalCredProv.dll,TSSessionUX.dll,TtlsAuth.dll,TtlsCfg.dll"

del /a /f /q "%X_SYS%\ucsvc.exe"
del /a /f /q "%X_SYS%\userinit.exe"
del /a /f /q "%X_SYS%\userinitext.dll"
del /a /f /q "%X_SYS%\usermgr.dll"
del /a /f /q "%X_SYS%\UserMgrProxy.dll"
del /a /f /q "%X_SYS%\utcutil.dll"
del /a /f /q "%X_SYS%\verifier.dll"
del /a /f /q "%X_SYS%\verifier.exe"
del /a /f /q "%X_SYS%\verifiergui.exe"
del /a /f /q "%X_SYS%\vpnike.dll"
del /a /f /q "%X_SYS%\vpnikeapi.dll"
del /a /f /q "%X_SYS%\vssapi.dll"
del /a /f /q "%X_SYS%\w32time.dll"
del /a /f /q "%X_SYS%\w32topl.dll"
del /a /f /q "%X_SYS%\wbadmin.exe"

del /a /f /q "%X_SYS%\wdigest.dll"
del /a /f /q "%X_SYS%\wdmaud.drv"
del /a /f /q "%X_SYS%\webio.dll"
del /a /f /q "%X_SYS%\Websocket.dll"
del /a /f /q "%X_SYS%\wer.dll"
del /a /f /q "%X_SYS%\werdiagcontroller.dll"
del /a /f /q "%X_SYS%\weretw.dll"
del /a /f /q "%X_SYS%\wersvc.dll"
del /a /f /q "%X_SYS%\werui.dll"
del /a /f /q "%X_SYS%\wevtsvc.dll"
del /a /f /q "%X_SYS%\wevtutil.exe"
del /a /f /q "%X_SYS%\wfapigp.dll"
del /a /f /q "%X_SYS%\wfdprov.dll"
del /a /f /q "%X_SYS%\winbio.dll"
del /a /f /q "%X_SYS%\wincredui.dll"
del /a /f /q "%X_SYS%\windowsperformancerecordercontrol.dll"
del /a /f /q "%X_SYS%\winhttpcom.dll"
del /a /f /q "%X_SYS%\winipsec.dll"
del /a /f /q "%X_SYS%\winlogonext.dll"
del /a /f /q "%X_SYS%\winsku.dll"
del /a /f /q "%X_SYS%\winsockhc.dll"

call :KEEP_FILES \Windows\System32\ "Windows.Gaming.Input.dll,windows.storage.dll,Windows.UI.Immersive.dll"
rem keep for Search feature
call :KEEP_FILES \Windows\System32\ "Windows.Shell.Search.UriHandler.dll,Windows.Storage.Search.dll"
rem keep for IME
call :KEEP_FILES \Windows\System32\ "Windows.Devices.HumanInterfaceDevice.dll,Windows.Globalization.dll,Windows.UI.Core.TextInput.dll"
del /a /f /q "%X_SYS%\Windows.*.dll"

del /a /f /q "%X_SYS%\wosc.dll"

call :KEEP_FILES \Windows\System32\ "ws2_32.dll,wsock32.dll"
rem keep for Search feature
call :KEEP_FILE \Windows\System32\wsepno.dll
del /a /f /q "%X_SYS%\ws*.*"

:END_SLIM_FILES
rem restore [KEEP]
if not exist "%X%\[KEEP]" goto :EOF
xcopy /S /E /Q /H /K /Y "%X%\[KEEP]" "%X%\"
rd /s /q "%X%\[KEEP]"
goto :EOF

:DEL_FONTS
for %%i in (%~1) do (
  del /a /f /q "%X_WIN%\Fonts\%%i%~2"
)
goto :EOF

:DEL_DRIVERS
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\Drivers\%%i"
)
goto :EOF

:DEL_DRVSTORES
for %%i in (%~1) do (
  call :DEL_DRVSTORE "%%i"
)
goto :EOF

:DEL_DRVSTORE
for /f "delims=" %%i in ('dir /b /ad "%X_SYS%\DriverStore\FileRepository\%~1*"') do (
  echo rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
  rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
)
goto :EOF

:DEL_SYSFILES
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\%%i"
)
goto :EOF


:KEEP_FILES
echo move "%~1%~2" "%X%\[KEEP]%~1"
if not exist "%X%\[KEEP]%~1" mkdir "%X%\[KEEP]%~1"
for %%i in (%~2) do (
  move "%X%%~1%%i" "%X%\[KEEP]%~1"
)
goto :EOF

:KEEP_FILE
echo move "%~1" "%X%\[KEEP]%~p1"
if not exist "%X%\[KEEP]%~p1" mkdir "%X%\[KEEP]%~p1"
move "%X%%~1" "%X%\[KEEP]%~1"
goto :EOF
