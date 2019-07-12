goto :main
[Main]
Title=Internet Explorer
Description=Internet Explorer 11 for Windows 10
Author=windowsforum
Date=2018.10.11
History002=Registry - Removed WoW64 Support Requirement
History003=Add DXCore.dll for 19H1(from yamingw)

:main
rem ==========update filesystem==========

if not "x%WB_PE_ARCH%"=="xx64" set opt[IE.x64_component]=x64
if not "x%opt[build.wow64support]%"=="xtrue" (
    set opt[IE.x64_component]=x64
)

rem Only IE(x86) [WOW64] // never
if "x%WB_PE_ARCH%"=="xx64" (
    if "x%opt[IE.x64_component]%"=="xx86" (
        goto :end_files
    )
)

call AddFiles %0 :end_files
goto :end_files

;---------------------------------------------------
;              Internet Explorer
;---------------------------------------------------
\Program Files\Internet Explorer

;Catalog
@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-InternetExplorer-inetcore-Package~*.cat
Microsoft-Windows-InternetExplorer-onecoreuap-Package~*.cat

@windows\system32\
Macromed\Flash\activex.vch
Macromed\Flash\Flash.ocx

actxprxy.dll
apphelp.dll
apprepapi.dll
atlthunk.dll
browser.dll
clbcatq.dll
coloradapterclient.dll
CoreMessaging.dll
CoreUIComponents.dll
cscapi.dll
DataExchange.dll
dcomp.dll
ddraw.dll
dinput8.dll
dsound.dll
dxtmsft.dll
dxtrans.dll
ELSCore.dll
ExplorerFrame.dll
hlink.dll
ie4uinit.exe
ieadvpack.dll
ieapfltr.dll
iedkcs32.dll
iepeers.dll
ieproxy.dll
iernonce.dll
iesetup.dll
iesysprep.dll
ieui.dll
ieuinit.inf
inetcpl.cpl
spool\drivers\color\
mf.dll
mfcore.dll
MFMediaEngine.dll
mfmp4srcsnk.dll
mfnetcore.dll
mfnetsrc.dll
mfperfhelper.dll
mfplat.dll
mfsvr.dll
MSAudDecMFT.dll
mscms.dll
mscories.dll
msctfuimanager.dll
msfeeds.dll
mskeyprotcli.dll
msmpeg2vdec.dll
msvproc.dll
netprofm.dll
npmproxy.dll
occache.dll
OnDemandConnRouteHelper.dll
pcpksp.dll
policymanager.dll
profprov.dll
profsvcext.dll
RESAMPLEDMO.DLL
seclogon.dll
Sens.dll
SettingSyncCore.dll
sqmapi.dll
srpapi.dll
StructuredQuery.dll
sxsstore.dll
tsdiscon.exe
twinapi.appcore.dll
UIAnimation.dll
url.dll
VaultCli.dll
Windows.Gaming.Input.dll
Windows.Globalization.dll
Windows.Media.dll
Windows.Media.MediaControl.dll
Windows.UI.dll
WindowsCodecsExt.dll

+ver > 18300
DXCore.dll
+ver*

:end_files

if "x%WB_PE_ARCH%"=="xx64" goto :end_x86_files

call AddFiles %0 :end_x86_files
goto :end_x86_files
;---------------------------------------------------
;              Internet Explorer (x86)
;---------------------------------------------------
@windows\system32\

;atl.dll
CoreMessaging.dll
dcomp.dll
;ddrawex.dll
;imgutil.dll
mf.dll
mfcore.dll
MFMediaEngine.dll
mfmp4srcsnk.dll
mfnetcore.dll
mfnetsrc.dll
mfperfhelper.dll
mfplat.dll
mfsvr.dll
MSAudDecMFT.dll
msmpeg2vdec.dll
RESAMPLEDMO.DLL
Sens.dll
srpapi.dll
sxsstore.dll
Windows.Media.dll
Windows.Media.MediaControl.dll
Windows.UI.dll

:end_x86_files
if not "x%opt[build.wow64support]%"=="xtrue" goto :end_wow64_files
if "x%opt[IE.x64_component]%"=="xx64" goto :end_wow64_files

if exist "%X_SYS%\Macromed\Flash\activex.vch" del /q "%X_SYS%\Macromed\Flash\activex.vch"
if exist "%X_SYS%\Macromed\Flash\Flash.ocx" del /q "%X_SYS%\Macromed\Flash\Flash.ocx"

call AddFiles %0 :end_wow64_files
goto :end_wow64_files
;---------------------------------------------------
;         Internet Explorer (SysWOW64)
;---------------------------------------------------
\Program Files (x86)\Internet Explorer

@windows\SysWOW64\
comdlg32.dll
%WB_PE_LANG%\comdlg32.dll.mui
Macromed\Flash\activex.vch
Macromed\Flash\Flash.ocx

aclui.dll
Activeds.tlb
actxprxy.dll
adsldpc.dll
advapi32.dll
;atl.dll
audiodev.dll
AudioSes.dll
avrt.dll
bcrypt.dll
cabinet.dll
cfgmgr32.dll
;clbcatq.dll
coloradapterclient.dll
combase.dll
;comdlg32.dll
CompPkgSup.dll
CoreMessaging.dll
CoreUIComponents.dll
crypt32.dll
cryptbase.dll
cryptnet.dll
cryptsp.dll
cryptui.dll
cryptxml.dll
cscapi.dll
d2d1.dll
d3d10warp.dll
d3d11.dll
DataExchange.dll
dciman32.dll
dcomp.dll
ddraw.dll
;ddrawex.dll
devobj.dll
dhcpcsvc.dll
dhcpcsvc6.dll
;dinput8.dll
directmanipulation.dll
dnsapi.dll
dpapi.dll
dsound.dll
dsrole.dll
dui70.dll
duser.dll
dwmapi.dll
DWrite.dll
dxgi.dll
;dxtmsft.dll
;dxtrans.dll
efswrt.dll
ExplorerFrame.dll
FWPUCLNT.DLL
gdi32.dll
gpapi.dll
;hlink.dll
ieadvpack.dll
ieapfltr.dll
iedkcs32.dll
ieframe.dll
iepeers.dll
ieproxy.dll
iernonce.dll
iertutil.dll
iesetup.dll
ieui.dll
;imgutil.dll
imm32.dll
inetcomm.dll
INETRES.dll
IPHLPAPI.DLL
jscript.dll
jscript9.dll
kernel.appcore.dll
kernel32.dll
ksuser.dll
linkinfo.dll
mf.dll
mfcore.dll
MFMediaEngine.dll
mfmp4srcsnk.dll
mfnetcore.dll
mfnetsrc.dll
mfperfhelper.dll
mfplat.dll
mfsvr.dll
mlang.dll
MMDevAPI.dll
msasn1.dll
MSAudDecMFT.dll
mscms.dll
msctf.dll
msctfuimanager.dll
msdmo.dll
MsftEdit.dll
mshtml.dll
mshtml.tlb
msimg32.dll
msimtf.dll
msIso.dll
mskeyprotect.dll
msls31.dll
msmpeg2vdec.dll
msoert2.dll
msvcp_win.dll
msvcrt.dll
msvproc.dll
mswsock.dll
msxml3.dll
msxml3r.dll
msxml6.dll
msxml6r.dll
ncrypt.dll
ncryptsslp.dll
NetworkExplorer.dll
ninput.dll
ntasn1.dll
ntdll.dll
ntmarta.dll
ntshrui.dll
occache.dll
ole32.dll
oleacc.dll
oleaccrc.dll
oleaut32.dll
OnDemandConnRouteHelper.dll
PlayToDevice.dll
profapi.dll
propsys.dll
psapi.dll
rasadhlp.dll
rasapi32.dll
rasman.dll
RESAMPLEDMO.DLL
rpcrt4.dll
rsaenh.dll
RTWorkQ.dll
samcli.dll
schannel.dll
sechost.dll
secur32.dll
Sens.dll
SensApi.dll
SHCore.dll
Shell32.dll
shlwapi.dll
srpapi.dll
srvcli.dll
sspicli.dll
StructuredQuery.dll
sxs.dll
sxsstore.dll
Tokenbinding.dll
twinapi.appcore.dll
ucrtbase.dll
UIAnimation.dll
UIAutomationCore.dll
urlmon.dll
user32.dll
userenv.dll
uxtheme.dll
VaultCli.dll
vbscript.dll
version.dll
webio.dll
;Windows.ApplicationModel.dll
Windows.Globalization.dll
;Windows.Media.Devices.dll
Windows.Media.dll
Windows.Media.MediaControl.dll
windows.storage.dll
Windows.Storage.Search.dll
Windows.UI.dll
WindowsCodecs.dll
WindowsCodecsExt.dll
winhttp.dll
wininet.dll
winmm.dll
winmmbase.dll
winnlsres.dll
WinTypes.dll
Wldap32.dll
wldp.dll
wpdshext.dll
ws2_32.dll
xmllite.dll

+ver > 18300
DXCore.dll
+ver*

:end_wow64_files

rem ==========update registry==========

rem [IE11_Registry]

call RegCopy HKLM\Software\Classes\MediaFoundation
call RegCopy HKLM\Software\Macromedia
call RegCopy "HKLM\Software\Microsoft\Internet Explorer"
call RegCopy "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

if exist "%X%\Program Files (x86)\Internet Explorer\" goto :_IE_CustomReg
if "x%WB_PE_ARCH%"=="xx64" (
    rem Removed WoW64 Support Requirement(add TabProcGrowth option)
    rem Thanks To noelBlanc, Bob.Omb For Registry Trick For Pure IE11_x64
    reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v TabProcGrowth /t REG_DWORD /d 0 /f
    reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v x86AppPath /d "X:\Program Files\Internet Explorer\IEXPLORE.EXE" /f
)

:_IE_CustomReg
reg add "HKLM\Tmp_Software\Policies\Microsoft\Internet Explorer\Main" /v DisableFirstRunCustomize /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v EnableAutoUpgrade /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v Default_Page_URL /d https://www.google.com/ /f
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v Default_Search_URL /d https://www.google.com /f
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v "Search Page" /d https://www.google.com /f
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d https://www.google.com/ /f
::-
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /d https://www.google.com /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d https://www.google.com/ /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v AlwaysShowMenus /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v CompatibilityFlags /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /d yes /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v Window_Placement /t REG_BINARY /d 2c0000000200000003000000ffffffffffffffffffffffffffffffff000000000000000000040000d8020000 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\BrowserEmulation" /v AllSitesCompatibilityMode /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\DomainSuggestion" /v NextUpdateDate /t REG_DWORD /d 230571383 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_LOCALMACHINE_LOCKDOWN" /v iexplore.exe /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Privacy" /v ClearBrowsingHistoryOnExit /t REG_DWORD /d 1 /f
::-
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v WarnOnClose /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v OpenAllHomePages /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v OpenInForeground /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v Groups /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v ThumbnailBehavior /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v NewTabPageShow /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v PopupsUseNewWindow /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v ShortcutBehavior /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v NTPMigrationVer /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\TabbedBrowsing" /v NTPFirstRun /t REG_DWORD /d 1 /f
::-
reg add "HKLM\Tmp_Default\Software\Policies\Microsoft\Internet Explorer\Restrictions" /v NoHelpItemSendFeedback /t REG_DWORD /d 1 /f
::-
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes" /v DefaultScope /d {977F4D41-E110-4942-A68B-B4BD47C460DD} /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v DisplayName /d Google /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v OSDFileURL /d https://www.microsoft.com/cms/api/am/binary/RWiNsg /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v FaviconPath /d "%%USERPROFILE%%\AppData\LocalLow\Microsoft\Internet Explorer\Services\search_{977F4D41-E110-4942-A68B-B4BD47C460DD}.ico" /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v FaviconURL /d http://www.google.com/favicon.ico /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v ShowSearchSuggestions /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v URL /d https://www.google.com/search?q={searchTerms}^&sourceid=ie7^&rls=com.microsoft:{language}:{referrer:source}^&ie={inputEncoding?}^&oe={outputEncoding?} /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v SortIndex /t REG_DWORD /d 1 /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\SearchScopes\{977F4D41-E110-4942-A68B-B4BD47C460DD}" /v SuggestionsURL /d https://www.google.com/complete/search?q={searchTerms}^&client=ie8^&mw={ie:maxWidth}^&sh={ie:sectionHeight}^&rh={ie:rowHeight}^&inputencoding={inputEncoding}^&outputencoding={outputEncoding} /f
::-
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu /v {871C5380-42A0-1069-A2EA-08002B30309D} /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel /v {871C5380-42A0-1069-A2EA-08002B30309D} /t REG_DWORD /d 0 /f
::-
if "x%opt[build.wow64support]%"=="xtrue" (
    call RegCopy HKLM\Software\Classes\WOW6432Node\MediaFoundation
    call RegCopy HKLM\Software\WOW6432Node\Macromedia
    call RegCopy "HKLM\Software\WOW6432Node\Microsoft\Internet Explorer"
    call RegCopy "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings"
)

if "x%opt[IE.custom_settings]%"=="xtrue" (
    if exist "%WB_PROJECT_PATH%\_CustomFiles_\IE_Settings.bat" (
        pushd
        call "%WB_PROJECT_PATH%\_CustomFiles_\IE_Settings.bat"
        popd
    )
)

if not "x%opt[IE.home_page]%"=="x" (
    call :_IE_HomePage "%opt[IE.home_page]%"
)

goto :EOF

:_IE_HomePage
::-
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v Default_Page_URL /d "%~1" /f
reg add "HKLM\Tmp_Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "%~1" /f
reg add "HKLM\Tmp_Default\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "%~1" /f
::-
goto :EOF

