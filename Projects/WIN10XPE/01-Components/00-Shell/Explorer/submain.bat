@echo off
if not "x%opt[shell.app]%"=="xexplorer" goto :EOF

call AddFiles %0 :end_files
goto :end_files

\Windows\SystemResources\Windows.UI.ShellCommon
@\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo\
Compressed (zipped) Folder.zfsendtotarget
Desktop (create shortcut).DeskLink
desktop.ini

; Windows Trusted Runtime Interface Driver
\Windows\System32\drivers\WindowsTrustedRT.sys

; Explorer
\Windows\explorer.exe
\Windows\??-??\explorer.exe.mui

@\Windows\System32\
;comctl32.dll
AppHelp.dll,AppResolver.dll,atlthunk.dll,avifil32.dll,clip.exe,Clipc.dll
control.exe,comsvcs.dll,CoreMessaging.dll,CoreUIComponents.dll,cscapi.dll
ctfmon.exe,desk.cpl,edputil.dll
ELSCore.dll,IconCodecService.dll,imageres.dll,InfDefaultInstall.exe
InputSwitch.dll,mfperfhelper.dll
MrmCoreR.dll,mscories.dll,MsCtfMonitor.dll,msutb.dll,mycomput.dll,policymanager.dll,pdh.dll,PhotoMetadataHandler.dll,pnputil.exe
ProximityCommon.dll,ProximityCommonPal.dll,ProximityService.dll,ProximityServicePal.dll
rmclient.dll,sendmail.dll
SettingSyncCore.dll,SharedStartModel.dll,ShellCommonCommonProxyStub.dll,shfolder.dll,shutdown.exe
StartTileData.dll,sti.dll,stobject.dll,StorageUsage.dll,systemcpl.dll,TDLMigration.dll,TextInputFramework.dll,thumbcache.dll
twinapi.appcore.dll,twinapi.dll,twinui.appcore.dll,twinui.pcshell.dll,UIAnimation.dll,UIRibbon.dll,UIRibbonRes.dll
Windows.Gaming.Input.dll,Windows.Internal.Shell.Broker.dll,Windows.Networking.Connectivity.dll,WorkFoldersShell.dll,wpdshext.dll,zipfldr.dll
windows.immersiveshell.serviceprovider.dll
credssp.dll,mblctr.exe,TextShaping.dll
Windows.Globalization.dll

+ver > 17000
cdp.dll
coloradapterclient.dll
dsreg.dll
VEEventDispatcher.dll

+ver > 17700
+if "%opt[slim.extra]%" <> "true"
; dll for StateRepository (AppRepository). The StateRepository service is not registered in the Registry
StateRepository.core.dll,Windows.StateRepository.dll
Windows.StateRepositoryBroker.dll
Windows.StateRepositoryCore.dll
Windows.StateRepositoryClient.dll
-if

+ver >= 18885
CoreMessaging.dll,CoreUIComponents.dll,rmclient.dll,twinapi.appcore.dll,InputHost.dll,TextInputFramework.dll

WindowManagement.dll
WindowManagementAPI.dll
Windows.UI.dll

+ver >= 20150
dmenrollengine.dll

; remove ver check (add with any ver)
+ver*

+if "%VER[3]%" = "19041" Or "%VER[3]%" = "19042" Or "%VER[3]%" = "19043"
;+if %VER[4]% >= 450
shell32.dll
SHCore.dll
KernelBase.dll
;-if
-if

; Advanced system setting
sysdm.cpl,DeviceProperties.exe,SystemPropertiesAdvanced.exe,SystemPropertiesComputerName.exe
systempropertieshardware.exe,systempropertiesperformance.exe
systempropertiesremote.exe

; Device Manager cpl
hdwwiz.cpl,hdwwiz.exe

; Timedate Mouse Region, Language cpl 
timedate.cpl,main.cpl,intl.cpl

; Browse Folder
;ExplorerFrame.dll

; Previous version tab
twext.dll

; Shell extension for Windows Script Host
\Windows\System32\wshext.dll

; Eject usb
DeviceCenter.dll,DeviceEject.exe,StorageContextHandler.dll

; System Information (Optional)
msinfo32.exe

; Map a network drive also in network addition
netplwiz.dll,netplwiz.exe

; Sharing from explorer
dtsh.dll,shpafact.dll,networkexplorer.dll,provsvc.dll

; Password Notification from event-log
kdcpw.dll

; Addional Cmds
cacls.exe,Comp.exe,choice.exe,Fc.exe,findstr.exe
Help.exe,Label.exe,Makecab.exe,sc.exe,Sort.exe
taskkill.exe

; ShellHWDetection
shsvcs.dll

; DLNA Namespace
dlnashext.dll

; Taking Ownership (Appinfo and ProfSvc services). ProfSvc services already here (profsvc.dll,profsvcext.dll,provsvc.dll,objsel.dll)
appinfo.dll,appinfoext.dll,objsel.dll

; Version Info
winver.exe

:end_files

rem display folders/shortcuts name with language
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo"

call SharedPatch NewBrowseDlg

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
)

call REGCOPY HKLM\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\Themes
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\WindowsTrustedRT
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\Themes /f
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CoreMessagingRegistrar /f

:Reg_Explorer

rem =====================Reg_Explorer=====================
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\CloudStore

reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v shell /d explorer.exe /f

rem =====================Reg_ShellHWDetection=====================
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\ShellHWDetection


