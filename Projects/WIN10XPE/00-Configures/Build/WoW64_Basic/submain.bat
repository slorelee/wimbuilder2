@echo off

goto :main
[Main]
Title=WoW64 basic
Type=XPEPlugin
Description=WoW64 basic
Author=ChriSR
Date=2018.10.11
HistoryNotes=Be Free to Customize
HistoryNotes01=slore modified, add 17763.107 missing WinSxS

:main
if not "x%WB_PE_ARCH%"=="xx64" goto :EOF
if not "x%opt[build.wow64support]%"=="xtrue" goto :EOF

rem ==========update filesystem==========

set SxSArch=x86
call AddFiles %0 :end_files
goto :end_files

; //- Language without fallback language should be enough for WinSxS
\Windows\WinSxS\%SxSArch%_microsoft.windows.c..-controls.resources_*_%WB_PE_LANG%*\*.*
\Windows\WinSxS\%SxSArch%_microsoft.windows.common-controls*\*.*
\Windows\WinSxS\%SxSArch%_microsoft.windows.gdiplus.systemcopy_*\*.*
\Windows\WinSxS\%SxSArch%_microsoft.windows.gdiplus_*\*.*
\Windows\WinSxS\%SxSArch%_microsoft.windows.isolationautomation_*\*.*
\Windows\WinSxS\%SxSArch%_microsoft.windows.i..utomation.proxystub_*\*.*
\Windows\WinSxS\%SxSArch%_microsoft-windows-servicingstack_*\*.*
; //-
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.c..-controls.resources_*_%WB_PE_LANG%*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.common-controls*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.gdiplus.systemcopy_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.gdiplus_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.isolationautomation_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.i..utomation.proxystub_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft-windows-comdlg32_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft-windows-comctl32-v5.resources_*_%WB_PE_LANG%*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft-windows-comdlg32.resources_*_%WB_PE_LANG%*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.systemcompatible_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft-windows-a..core-base.resources_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft-windows-blb-engine-main_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.s...smart_card_library_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.s..rt_driver.resources_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft.windows.s..se.scsi_port_driver_*.manifest
\Windows\WinSxS\manifests\%SxSArch%_microsoft-windows-servicingstack_*.manifest
; //\Windows\WinSxS\manifests\x86_microsoft.windows.s..ation.badcomponents_*.manifest


@windows\system32\
; Not required with build 16299 \Windows\System32\SetWoW64.exe(loadWoW64.exe)
wow64.dll,wow64cpu.dll,wow64win.dll,wowreg32.exe

@windows\SysWOW64\
C_*.NLS,KBD*.dll

; comctl32.dll.mui,comdlg32.dll.mui and mlang.dll.mui exist in all Language folders
+mui(en-US,%WB_PE_LANG%)
comctl32.dll,comdlg32.dll,mlang.dll

+mui
aclui.dll,actxprxy.dll,adsldp.dll,adsldpc.dll,advapi32.dll,apphelp.dll,asycfilt.dll,atlthunk.dll,authz.dll,avifil32.dll,avrt.dll
bcrypt.dll,Bcp47Langs.dll,bcp47mrm.dll,cabinet.dll,cfgmgr32.dll,clb.dll,clip.exe,cmd.exe,cmdext.dll,combase.dll
Coremessaging.dll,CoreUIComponents.dll
crypt32.dll,cryptbase.dll,cryptdll.dll,cryptnet.dll,cryptsp.dll,cscapi.dll
d2d1.dll,d3d9.dll,d3d10warp.dll,d3d11.dll,d3d12.dll,DataExchange.dll,davhlpr.dll,dbgcore.dll,dbghelp.dll
dcomp.dll,ddraw.dll,devobj.dll,dhcpcsvc.dll,dhcpcsvc6.dll,directmanipulation.dll,dllhost.exe,dlnashext.dll,dnsapi.dll,dpapi.dll
drvstore.dll,dsrole.dll,dui70.dll,duser.dll,dwmapi.dll,Dwrite.dll,dxgi.dll,edputil.dll,ExplorerFrame.dll
FirewallAPI.dll,fltlib.dll,fwbase.dll,fwpolicyiomgr.dll,FWPUCLNT.DLL,gdi32.dll,gdi32full.dll,GdiPlus.dll,gpapi.dll,hid.dll
iertutil.dll,imm32.dll,InputHost.dll,iphlpapi.dll,kernel.appcore.dll,kernel32.dll,kernelbase.dll,linkinfo.dll,logoncli.dll
mfperfhelper.dll,mfc42.dll,mpr.dll,msacm32.dll,msacm32.drv,msasn1.dll,mscms.dll,mscories.dll,ncryptsslp.dll
msctf.dll,msi.dll,msimg32.dll,msIso.dll,mskeyprotect.dll,msls31.dll,msv1_0.dll,msvbvm60.dll,msvcp60.dll,msvcp_win.dll,msvcp110_win.dll,msvcrt.dll,msvcrt40.dll
msvfw32.dll,mswsock.dll,msxml3.dll,msxml3r.dll,msxml6.dll,msxml6r.dll,ncrypt.dll,netapi32.dll,netutils.dll,normaliz.dll,ntasn1.dll,ntdll.dll
ntdsapi.dll,ntlanman.dll,ntmarta.dll,ntshrui.dll,odbc32.dll,ole32.dll,oleacc.dll,oleaccrc.dll,oleaut32.dll,oledlg.dll,olepro32.dll
OnDemandConnRouteHelper.dll,OneCoreUAPCommonProxyStub.dll,pdh.dll,policymanager.dll,powrprof.dll,profapi.dll,propsys.dll,psapi.dll
rasadhlp.dll,rasapi32.dll,reg.exe,regedt32.exe,regsvr32.exe,riched20.dll,riched32.dll,rmclient.dll,rpcrt4.dll,rsaenh.dll
run64.exe,rundll32.exe,samcli.dll,samlib.dll,schannel.dll,sechost.dll,secur32.dll,SensApi.dll,setupapi.dll,SHCore.dll,shell32.dll
+ver <= 17700
shellstyle.dll
+ver*
shfolder.dll,shlwapi.dll,slc.dll,spfileq.dll,SPInf.dll,srvcli.dll,sspicli.dll,stdole2.tlb,stdole32.tlb,StructuredQuery.dll
svchost.exe,sxs.dll,sxsstore.dll,sxstrace.exe,TextInputFramework.dll,thumbcache.dll,twinapi.dll,twinapi.appcore.dll,tzres.dll
ulib.dll,ucrtbase.dll,UIAnimation.dll,UIAutomationCore.dll,urlmon.dll,user32.dll,userenv.dll,usp10.dll,uxtheme.dll,vbscript.dll,version.dll
webio.dll,wimgapi.dll,winbrand.dll,WindowsCodecs.dll,Windows.Globalization.dll,windows.storage.dll,wininet.dll,winmm.dll,winmmbase.dll
winnlsres.dll,winnsi.dll,winspool.drv,winsta.dll,WinTypes.dll,wintrust.dll,wkscli.dll,wldap32.dll,wow32.dll,ws2_32.dll,wsock32.dll,wtsapi32.dll,xmllite.dll

; Multimedia
AudioSes.dll,devenum.dll,dsound.dll,MMDevAPI.dll,msdmo.dll,quartz.dll

; Network
winhttp.dll

; 32 bit Web-Based Enterprise Management \Windows\SysWOW64\wbem (Optional). wmi.dll is in winre.wim
;wbem\
;wbemcomn.dll,framedynos.dll,ncobjapi.dll,wmiclnt.dll

; WB Dependencies addition
ieframe.dll,mshtml.dll
-mui

:end_files

if exist "%X%\windows\system32\imageres.dll" (
  copy /y "%X%\windows\system32\imageres.dll" "%X%\windows\syswow64\"
)

rem ==========update registry==========

rem [Reg_WoW64]
rem //RegImportFile,%ScriptDir%\WoW64_RegSoftware.txt
call RegCopy HKLM\Software\Classes\Wow6432Node\CLSID
call RegCopy HKLM\Software\Classes\Wow6432Node\Interface
::-
call RegCopy HKLM\Software\Classes\WOW6432Node\DirectShow
call RegCopy "HKLM\Tmp_Software\Classes\WOW6432Node\Media Type"
call RegCopy HKLM\Software\Classes\WOW6432Node\MediaFoundation
::-
call RegCopy HKLM\Software\Wow6432Node
::-
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SMI
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft.windows.c..-controls.resources_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft.windows.common-controls_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,wow64_microsoft.windows.gdiplus.systemcopy_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft.windows.gdiplus_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft.windows.i..utomation.proxystub_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft.windows.isolationautomation_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft.windows.systemcompatible_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86_microsoft-windows-m..tion-isolationlayer_*

goto :EOF

rem [Reg_WoW64_Bigger_Classes]
call RegCopy HKLM\Software\Classes\Wow6432Node

rem [Reg_WoW64_Mini_Software]
call RegCopy HKLM\Software\Wow6432Node\Microsoft\CTF
call RegCopy HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Authentication
call RegCopy HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer
call RegCopy HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Themes
call RegCopy "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Svchost"
call RegCopy "HKLM\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Winlogon"
