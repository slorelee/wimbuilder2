if not exist "%X_SYS%\drivers\fvevol.sys" goto :EOF
echo Extra-Sliming...

reg import Reg_SYSTEM.txt

call :DEL_FONTS "seguisym.ttf,msyh.ttc"
call :DEL_FONTS "consola.ttf,micross.ttf,segoeuib.ttf,seguisbi.ttf"
call :DEL_FONTS "tahoma.ttf"

if "x%opt[slim.small_imageresdll]%"=="xtrue" (
   copy /Y "%V%\CustomResources\SmallDlls\imageres.dll" "%X_SYS%\imageres.dll"
)
copy /Y "%V%\CustomResources\SmallDlls\shell32.dll.mun" "%X_WIN%\SystemResources\"


rd /s /q "%X_WIN%\INF\PERFLIB"
rd /s /q "%X_WIN%\INF\RemoteAccess"
rd /s /q "%X_WIN%\schemas\EAPHost"

del /a /f /q "%X_WIN%\Vss\Writers\System\0bada1de-01a9-4625-8278-69e735f39dd2.xml"
del /a /f /q "%X_WIN%\hh.exe"

call :DEL_SYSFILES "Dism\CbsProvider.dll,Dism\DismHost.dll,Dism\DismHost.exe,Dism\DmiProvider.dll,Dism\GenericProvider.dll"
call :DEL_SYSFILES "Dism\IntlProvider.dll,Dism\OfflineSetupProvider.dll,Dism\OSProvider.dll"
call :DEL_SYSFILES "Dism\PEProvider.dll"
rd /s /q "%X_SYS%\Dism\en-US"
rd /s /q "%X_SYS%\Dism\%WB_PE_LANG%"
call :DEL_SYSFILES "Dism\ProvProvider.dll,Dism\SmiProvider.dll,Dism\UnattendProvider.dll"


rd /s /q "%X_SYS%\wbem"

set "X_DRV=%X_SYS%\drivers"
del /a /f /q "%X_DRV%\asyncmac.sys"
del /a /f /q "%X_DRV%\bowser.sys"
del /a /f /q "%X_DRV%\bttflt.sys"
del /a /f /q "%X_DRV%\cht4vfx.sys"
del /a /f /q "%X_DRV%\cht4vx64.sys"
del /a /f /q "%X_DRV%\dfsc.sys"
del /a /f /q "%X_DRV%\dmvsc.sys"
del /a /f /q "%X_DRV%\dumpfve.sys"
del /a /f /q "%X_DRV%\fdc.sys"
del /a /f /q "%X_DRV%\filetrace.sys"
del /a /f /q "%X_DRV%\flpydisk.sys"
del /a /f /q "%X_DRV%\fvevol.sys"
del /a /f /q "%X_DRV%\hvsocket.sys"
del /a /f /q "%X_DRV%\hyperkbd.sys"

del /a /f /q "%X_DRV%\HyperVideo.sys"
del /a /f /q "%X_DRV%\mrxsmb.sys"
del /a /f /q "%X_DRV%\mrxsmb20.sys"
del /a /f /q "%X_DRV%\msiscsi.sys"
del /a /f /q "%X_DRV%\mup.sys"
del /a /f /q "%X_DRV%\ndistapi.sys"
del /a /f /q "%X_DRV%\ndisuio.sys"
del /a /f /q "%X_DRV%\ndiswan.sys"
del /a /f /q "%X_DRV%\ndproxy.sys"
del /a /f /q "%X_DRV%\netbios.sys"
del /a /f /q "%X_DRV%\netbt.sys"
del /a /f /q "%X_DRV%\rasacd.sys"
del /a /f /q "%X_DRV%\rdbss.sys"
del /a /f /q "%X_DRV%\sfloppy.sys"

del /a /f /q "%X_DRV%\srv2.sys"
del /a /f /q "%X_DRV%\srvnet.sys"
del /a /f /q "%X_DRV%\storqosflt.sys"
del /a /f /q "%X_DRV%\storvsc.sys"
del /a /f /q "%X_DRV%\tape.sys"
del /a /f /q "%X_DRV%\tpm.sys"
del /a /f /q "%X_DRV%\usbser.sys"

del /a /f /q "%X_DRV%\vmbkmcl.sys"
del /a /f /q "%X_DRV%\vmbus.sys"
del /a /f /q "%X_DRV%\VMBusHID.sys"
del /a /f /q "%X_DRV%\vmstorfl.sys"
del /a /f /q "%X_DRV%\winhv.sys"

call :DEL_DRVSTORES "b57nd60a,b57nd60x,cht4vx64,c_61883,c_apo,c_avc,c_biometric,c_bluetooth,c_camera,c_dot4print"
call :DEL_DRVSTORES "c_infrared,c_mcx,c_modem,c_netdriver,c_netservice,c_proximity,c_securitydevices,c_tapedrive"
call :DEL_DRVSTORES "dc21x4vm,e2xw10%WB_PE_ARCH%,ehstortcgdrv,elxfcoe,elxstor,fdc,flpydiskfdc,flpydisk,HalExtIntcUartDma,hdaudss,iscsi"
call :DEL_DRVSTORES "kdnic,lltdio,msux86w10,NdisImPlatform,NdisImPlatformMp,ndisuio,itsas35i,lsi_sss,kdnic,lltdio,lsi_sas,lsi_sas2i"

call :DEL_DRVSTORES "net1i32,net1y32,net44x32"
call :DEL_DRVSTORES "net7400" "*"
call :DEL_DRVSTORES "NETAX88179_178a,NETAX88772,nete1e32,nete1g32,netefe32,netgb6,netimm,netip6,netjme,netk57x,netl160x,netl1c63x86,netl1e86,netl260x"
call :DEL_DRVSTORES "netloop,netmscli,netmyk32,netnb,netnvm32,netnvmx,netnwifi,netrass,netrast,netrtl32,Netserv,,netvf63,netvg63"
call :DEL_DRVSTORES "nettcpip"

call :DEL_DRVSTORES "rspndr,rtux%_V8664%w10,tape,tpm"
call :DEL_DRVSTORES "wdmvsc,whyperkbd,wstorflt,wstorvsc,wvmbus,wvmbushid,wvmbusvideo"

rem INF files ONLY
call :DEL_DRVSTORES "net1i%WB_PE_ARCH%,net1y%WB_PE_ARCH%,net40i68,net44amd" INF
call :DEL_DRVSTORES "net7400-%WB_PE_ARCH%-n650,net7500-%WB_PE_ARCH%-n650f,net7800-%WB_PE_ARCH%-n650f,net9500-%WB_PE_ARCH%-n650f" INF
call :DEL_DRVSTORES "netbnad8,netbxnda,nete1e3e,nete1g3e,netefe3e,netelx,netg664,netk57a,netl1c63%WB_PE_ARCH%,netl1e64" INF
call :DEL_DRVSTORES "netl160a,netl260a,netmlx4eth63,netmlx5,netmyk64,netnvm64,netnvma,netqenda" INF
call :DEL_DRVSTORES "netrtl64,nett4%WB_PE_ARCH%,netvf63a,netvg63a,netxe%WB_PE_ARCH%,netxi%WB_PE_ARCH%" INF

del /a /f /q "%X_SYS%\*_RuntimeDeviceInstall.dll"
del /a /f /q "%X_SYS%\@VpnToastIcon.png"

call :DEL_SYSFILES "activeds.tlb,adsldpc.dll,advapi32res.dll,AppxPackaging.dll,atmlib.dll,avicap32.dll"
call :DEL_SYSFILES "BCP47Langs.DLL,BCP47mrm.dll,blbres.dll,blb_ps.dll,BootRec.exe,bootstr.dll,browcli.dll,browseui.dll"

call :DEL_SYSFILES "CompMgmtLauncher.exe,CoreMas.dll,cryptcatsvc.dll,cryptsvc.dll"
call :DEL_SYSFILES "C_G18030.DLL,c_GSM7.dll,C_IS2022.dll,C_ISCII.dll"

call :DEL_SYSFILES "chartv.dll,chkntfs.exe,cnvfat.dll,compact.exe,console.dll,fms.dll,gpapi.dll,input.dll"
call :DEL_SYSFILES "mfc42u.dll,netprovfw.dll,nsisvc.dll,regapi.dll,sti.dll,umpo.dll,umpoext.dll,wkssvc.dll"

call :DEL_SYSFILES "d2d1.dll,d3d10warp.dll,D3D12.dll,D3DCompiler_47.dll"
call :DEL_SYSFILES "davhlpr.dll,dbghelp.dll,dciman32.dll"
call :DEL_SYSFILES "defragproxy.dll,defragres.dll,defragsvc.dll"
call :DEL_SYSFILES "diagnosticdataquery.dll,directmanipulation.dll,diskraid.dll,diskraid.exe,DismApi.dll,dispex.dll,doskey.exe"
call :DEL_SYSFILES "drvsetup.dll,dskquota.dll,dssenh.dll,dtdump.exe,DWrite.dll,DXCore.dll,esent.dll,eventcls.dll"
call :DEL_SYSFILES "Facilitator.dll,fbwflib.dll,fcon.dll,filemgmt.dll,FirewallAPI.dll,fltMC.exe"
call :DEL_SYSFILES "framedynos.dll,fsmgmt.msc,fvecerts.dll,fwbase.dll,GdiPlus.dll"
call :DEL_SYSFILES "HalExtIntcPseDMA.dll,HalExtIntcUartDMA.dll,hbaapi.dll,hhsetup.dll,hidserv.dll"
call :DEL_SYSFILES "icmp.dll,IESettingSync.exe,ifmon.dll,ifsutilx.dll"
call :DEL_SYSFILES "IKEEXT.DLL,imaadp32.acm,imagesp1.dll,imapi.dll,imapi.exe,imapi2.dll,imapi2fs.dll,imgutil.dll,iscsidsc.dll"
call :DEL_SYSFILES "kdcom.dll,KerbClientShared.dll,kmddsp.tsp,ksuser.dll,ktmw32.dll,lpk.dll,lz32.dll"
call :DEL_SYSFILES "mfc42.dll,mlang.dat,mlang.dll,mode.com,msacm32.dll,mscpxl32.dll,msctf.dll,msftedit.dll,msieftp.dll"
call :DEL_SYSFILES "msscript.ocx,msvcp110_win.dll,msvcp60.dll,msvcrt40.dll,MSWB70804.dll,msxml6.dll"
rem net.exe: control services
call :DEL_SYSFILES "ncobjapi.dll,net1.exe,netcfgx.dll,netmsg.dll,newdev.dll,NL7Data0804.dll,NL7Lexicons0804.dll,NL7Models0804.dll,NOISE.CHS,odbcint.dll"
call :DEL_SYSFILES "oleacchooks.dll,olepro32.dll,OnDemandConnRouteHelper.dll,OneCoreCommonProxyStub.dll,OneCoreUAPCommonProxyStub.dll,OpenWith.exe,pcwum.dll,PING.EXE"
call :DEL_SYSFILES "pnpdiag.dll,pnppropmig.dll,pnpui.dll,pnputil.exe,powercfg.cpl,prfc0804.dat,prfd0804.dat,prfh0804.dat,prfi0804.dat,regedt32.exe,riched20.dll,riched32.dll"
call :DEL_SYSFILES "rshx32.dll,scrrun.dll,sdhcinst.dll,SensApi.dll,shwebsvc.dll,SmiEngine.dll,smphost.dll,snmpapi.dll,spaceutil.exe,spfileq.dll,srvsvc.dll,sscore.dll"
call :DEL_SYSFILES "stdole2.tlb,streamci.dll,svsvc.dll,swprv.dll,sxshared.dll,syssetup.dll,systemcpl.dll,systray.exe,tdhres.dll,tzres.dll,UIAutomationCore.dll,ureg.dll,uudf.dll,vbscript.dll"
rem vdmdbg.dll: taskmgr.exe 
call :DEL_SYSFILES "VhfUm.dll,wbemcomn.dll,WerEnc.dll,wimserv.exe,vmbuspipe.dll,vsstrace.dll,vss_ps.dll"
call :DEL_SYSFILES "wincorlib.dll,Windows.Devices.HumanInterfaceDevice.dll,winhttp.dll,winnlsres.dll,WinSCard.dll,WinTypes.dll,WMALFXGFXDSP.dll,WofUtil.dll,wowreg32.exe"


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
  call :DEL_DRVSTORE "%%i" %2
)
goto :EOF

:DEL_DRVSTORE
del /a /f /q "%X_WIN%\Inf\%~1.inf"
del /a /f /q "%X_SYS%\DriverStore\%WB_PE_LANG%\%~1.inf_loc"
if /i "x%2"=="xINF" goto :EOF
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
