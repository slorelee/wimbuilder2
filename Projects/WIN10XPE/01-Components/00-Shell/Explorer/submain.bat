@echo off

call AddFiles %0 :end_files
goto :end_files

\Windows\SystemResources\Windows.UI.ShellCommon
@\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo\
Compressed (zipped) Folder.zfsendtotarget
Desktop (create shortcut).DeskLink
desktop.ini

; Windows Trusted Runtime Interface Driver
\Windows\System32\drivers\WindowsTrustedRT.sys

; Computer Management shortcut
\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Computer Management.lnk

; Explorer
\Windows\explorer.exe
\Windows\??-??\explorer.exe.mui

; typo?
\Windows\System32\xx-xx\comctl32.dll.mui

@\Windows\System32\
+mui
actxprxy.dll,AppHelp.dll,AppResolver.dll,atlthunk.dll,avifil32.dll,clip.exe,Clipc.dll,comctl32.dll
control.exe,comsvcs.dll,CoreMessaging.dll,CoreUIComponents.dll,cscapi.dll
ctfmon.exe,desk.cpl,edputil.dll
ELSCore.dll,IconCodecService.dll,imageres.dll,InfDefaultInstall.exe
InputSwitch.dll,mfperfhelper.dll
MrmCoreR.dll,mscories.dll,MsCtfMonitor.dll,msutb.dll,mycomput.dll,policymanager.dll,pdh.dll,PhotoMetadataHandler.dll,pnputil.exe
ProximityCommon.dll,ProximityCommonPal.dll,ProximityService.dll,ProximityServicePal.dll
rmclient.dll,rshx32.dll,sendmail.dll
SettingSyncCore.dll,SharedStartModel.dll,ShellCommonCommonProxyStub.dll,shfolder.dll,shutdown.exe
StartTileData.dll,stobject.dll,systemcpl.dll,TDLMigration.dll,TextInputFramework.dll,thumbcache.dll
twinapi.appcore.dll,twinapi.dll,twinui.appcore.dll,twinui.pcshell.dll,UIAnimation.dll,UIRibbon.dll,UIRibbonRes.dll
VEEventDispatcher.dll,Windows.Internal.Shell.Broker.dll,Windows.Networking.Connectivity.dll,WorkFoldersShell.dll,zipfldr.dll

+ver > 17000
cdp.dll,dsreg.dll,VEEventDispatcher.dll

+ver >17700
; shellstyle.dll(.mui) is now in \Windows\resources\themes\aero\shell\normalcolor
\Windows\resources\Themes\aero\shell

; dll for StateRepository (AppRepository). The StateRepository service is not registered in the Registry
StateRepository.core.dll,Windows.StateRepository.dll
Windows.StateRepositoryBroker.dll,Windows.StateRepositoryClient.dll

+ver <= 17700
shellstyle.dll

; remove ver check (add with any ver)
+ver*

; Advanced system setting
sysdm.cpl,DeviceProperties.exe,SystemPropertiesAdvanced.exe,SystemPropertiesComputerName.exe
systempropertieshardware.exe,systempropertiesperformance.exe
systempropertiesremote.exe

; Device Manager cpl
hdwwiz.cpl,hdwwiz.exe

; Timedate Mouse Region, Language cpl 
timedate.cpl,main.cpl,intl.cpl

; Browse Folder
ExplorerFrame.dll

; DragAndDrop (d2d1.dll,ksuser.dll already in Winre.wim)
DataExchange.dll,dcomp.dll,d3d11.dll,dxgi.dll,d2d1.dll,ksuser.dll

; CopyProgress
-mui
chartv.dll,OneCoreUAPCommonProxyStub.dll

; Eject usb
+mui
DeviceCenter.dll,DeviceEject.exe,StorageContextHandler.dll

; System Information (Optional)
msinfo32.exe

; Map a network drive also in network addition
netplwiz.dll,netplwiz.exe

; Sharing from explorer
dtsh.dll,shpafact.dll,networkexplorer.dll,provsvc.dll

; Addional Cmds
cacls.exe,Comp.exe,choice.exe,Fc.exe,findstr.exe
Help.exe,Label.exe,Makecab.exe,sc.exe,Sort.exe

; Search
\Windows\INF\wsearchidxpi
esent.dll,NaturalLanguage6.dll,NOISE.DAT,MSWB7.dll
mssph.dll,mssprxy.dll,mssrch.dll,mssvp.dll,mssitlb.dll
query.exe,query.dll,SearchFilterHost.exe,SearchFolder.dll,SearchIndexer.exe,SearchProtocolHost.exe
srchadmin.dll,StructuredQuery.dll,tquery.dll
Windows.Shell.Search.UriHandler.dll,Windows.Storage.Search.dll,wsepno.dll
prm*.dll,MLS*.dll

; ShellHWDetection
shsvcs.dll

; Taking Ownership (Appinfo and ProfSvc services). ProfSvc services already here (profsvc.dll,profsvcext.dll,provsvc.dll,objsel.dll)
appinfo.dll,appinfoext.dll,objsel.dll

; Version Info
winver.exe

:end_files

rem ==========update registry==========

rem =====================Reg_Theme=====================
reg import "%~dp0Themes_RegDefault.reg"
if not "x%opt[build.registry.software]%"=="xfull" (
  call REGCOPY HKLM\Software\Microsoft\Direct3D
  call REGCOPY HKLM\Software\Microsoft\DirectDraw
  call REGCOPY HKLM\Software\Microsoft\DirectInput
  call REGCOPY HKLM\Software\Microsoft\DirectMusic
  call REGCOPY HKLM\Software\Microsoft\DirectPlay
  call REGCOPY HKLM\Software\Microsoft\DirectPlay8
  call REGCOPY HKLM\Software\Microsoft\DirectPlayNATHelp
  call REGCOPY HKLM\Software\Microsoft\DirectShow
  call REGCOPY HKLM\Software\Microsoft\DirectX

  call REGCOPY HKLM\Software\Microsoft\RADAR
  call REGCOPY "HKLM\Software\Microsoft\Windows\CurrentVersion\Control Panel"
  call REGCOPY "HKLM\Software\Microsoft\Windows\CurrentVersion\Controls Folder"
  call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Themes
  call REGCOPY HKLM\Software\Microsoft\Windows\DWM
)

call REGCOPY HKLM\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\Themes
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\WindowsTrustedRT
reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM  /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\Themes /f
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CoreMessagingRegistrar /f

:Reg_Explorer

rem =====================Reg_Explorer=====================
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\CloudStore

reg import "%~dp0Explorer_RegDefault.reg"
reg import "%~dp0Explorer_RegSoftware.reg"
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v shell /d explorer.exe /f

rem =====================Reg_ShellHWDetection=====================
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\ShellHWDetection


