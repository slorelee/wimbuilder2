@echo off

call AddFiles %0 :end_files
goto :end_files

; Explorer
\Windows\explorer.exe
\Windows\??-??\explorer.exe.mui

@\Windows\System32\
+mui
actxprxy.dll,AppHelp.dll,AppResolver.dll,atlthunk.dll,clip.exe,Clipc.dll
compmgmt.msc,CompMgmtLauncher.exe,comsvcs.dll,control.exe
CoreMessaging.dll,CoreUIComponents.dll,cscapi.dll
ctfmon.exe,devmgmt.msc,devmgr.dll,edputil.dll
ELSCore.dll,filemgmt.dll,IconCodecService.dll,imageres.dll,InfDefaultInstall.exe
MrmCoreR.dll,mscories.dll,msutb.dll,mycomput.dll,pdh.dll,PhotoMetadataHandler.dll
pnputil.exe,rmclient.dll,rshx32.dll,sendmail.dll,services.msc
SettingSyncCore.dll,SharedStartModel.dll,shellstyle.dll,shfolder.dll,shutdown.exe
stobject.dll,systemcpl.dll,TextInputFramework.dll,thumbcache.dll,twinapi.appcore.dll
twinapi.dll,twinui.pcshell.dll,UIAnimation.dll,UIRibbon.dll,UIRibbonRes.dll,VEEventDispatcher.dll,zipfldr.dll

+ver>17000
cdp.dll
+ver*

; Advanced system setting
sysdm.cpl,SystemPropertiesAdvanced.exe,SystemPropertiesComputerName.exe
systempropertieshardware.exe,systempropertiesperformance.exe
systempropertiesremote.exe,DeviceProperties.exe

; Device Manager cpl
hdwwiz.cpl,hdwwiz.exe

; Timedate Mouse Region, Language cpl 
timedate.cpl,main.cpl,intl.cpl

; Browse Folder
ExplorerFrame.dll

; DragAndDrop (Winre.wim d2d1.dll,ksuser.dll already in Winre.wim)
DataExchange.dll,dcomp.dll,d3d11.dll,dxgi.dll,d2d1.dll,ksuser.dll

; CopyProgress
-mui
chartv.dll,OneCoreUAPCommonProxyStub.dll

; Eject usb
+mui
DeviceCenter.dll,DeviceEject.exe,StorageContextHandler.dll

:end_files

rem ==========update registry==========

call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
reg import "%~dp0Explorer_RegDefault.reg"
reg import "%~dp0Explorer_RegSoftware.reg"
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v shell /d explorer.exe /f
