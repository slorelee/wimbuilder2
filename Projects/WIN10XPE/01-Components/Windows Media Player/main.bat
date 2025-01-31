goto :main
[Main]
Title=MS Windows Media Player
Type=Plugin
Author=oscar
Description=(Win10PE - Win10 1809 x86 x64 // Win8.1) Windows Media Player
Credits=James
Version=008
Download_Level=2
Level=3
Selected=False
Mandatory=False
NoWarning=False
Contact=http://TheOven.org
Date=2020.01.13
Depend=
Disable=
Web1=http://yomi.cwcodes.net/Yomi/ComponentsY/MSMediaPlayer.Script
Web2=http://win10se.cwcodes.net/Projects/Win10PESE/Components/MSMediaPlayer.Script
CertifiedBy=
Certification=
HistoryNotes01=Oscar: Sometimes media players need DirectX plugin enabled to work properly. Oscar Reply 39 http://TheOven.org/index.php?topic=1359.msg31611#msg31611
HistoryNotes02=Tested with Win10 1809 x86 x64
History001=Oscar 2019.02.13 Plugin shared Reply 19 http://TheOven.org/index.php?topic=1359.msg31568#msg31568
History002=Lancelot add to Win10PESE server - Date:2019.02.20
History003=Lancelot Added Components_PluginCache_Extract - Date:2019.02.20
History004=Oscar Added .mui files Date:2019.02.21 - Date:2019.02.22
History005=Lancelot Added Oscar Plugin info to support Win81 - Oscar: My old wmplayer win8.1SE x86 and old builds of win10 x86 plugin. Oscar Reply 53 http://TheOven.org/index.php?topic=1359.msg31846#msg31846 - Date:2019.02.27
History006=Oscar fixed "class not registered" error (fail opening media formats) - Date:2019.03.02
History007=Oscar fixed Win8.1 Lines - Oscar Reply 69 http://TheOven.org/index.php?topic=1359.msg31970#msg31970 - Date:2019.03.03
History008=Lancelot Add to Yomi - Date:2020.01.13
:main

call AddFiles %0 :end_files
goto :end_files

;\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows Media Player.lnk

;[Require_FileList]
\Program Files\Windows Media Player\
@\Windows\System32\
drivers\mmcss.sys
drivers\monitor.sys
wbem\WmiPrvSE.exe

aepic.dll
amcompat.tlb
amsi.dll
apphelp.dll
AppXDeploymentClient.dll
asferror.dll
atl.dll
avicap32.dll
bcrypt.dll
cewmdm.dll
clbcatq.dll
cldapi.dll
CloudNotifications.exe
COLORCNV.DLL
CompPkgSup.dll
CoreMessaging.dll
CoreMmRes.dll
CoreUIComponents.dll
credssp.dll
cscui.dll
DDORes.dll
DevDispItemProvider.dll
devenum.dll
dllhost.exe
dlnashext.dll
DMRServer.dll
DolbyDecMFT.dll
dsound.dll
dwmapi.dll
dwmghost.dll
dxmasf.dll
dxva2.dll
edputil.dll
EhStorAPI.dll
EhStorShell.dll
evr.dll
FirewallControlPanel.dll
gnsdk_fp.dll
HelpPaneProxy.dll
iccvid.dll
IEAdvpack.dll
imaadp32.acm
imageres.dll
InputSwitch.dll
iyuv_32.dll
l3codeca.acm
l3codecp.acm
LAPRXY.DLL
logagent.exe
MDEServer.exe
mf.dll
mfAACEnc.dll
mfasfsrcsnk.dll
mfaudiocnv.dll
MFCaptureEngine.dll
mfcore.dll
mfds.dll
mfdvdec.dll
mferror.dll
mfh263enc.dll
mfh264enc.dll
MFMediaEngine.dll
mfmjpegdec.dll
mfmkvsrcsnk.dll
mfmp4srcsnk.dll
mfmpeg2srcsnk.dll
mfnetcore.dll
mfnetsrc.dll
mfperfhelper.dll
mfplat.dll
MFPlay.dll
mfpmp.exe
mfps.dll
mfreadwrite.dll
mfsrcsnk.dll
mfsvr.dll
mftranscode.dll
mfvdsp.dll
mfvfw.dll
MFWMAAEC.DLL
midimap.dll
MP3DMOD.DLL
MP4SDECD.DLL
MP43DECD.DLL
Mpeg2Data.ax
mpg2splt.ax
MPG4DECD.DLL
MSAC3ENC.DLL
msadp32.acm
MSAlacEncoder.dll
MSAMRNBDecoder.dll
MSAMRNBEncoder.dll
MSAMRNBSink.dll
MSAMRNBSource.dll
MSAudDecMFT.dll
msdmo.dll
msdxm.tlb
MSFlacDecoder.dll
MSFlacEncoder.dll
msg711.acm
msgsm32.acm
msimg32.dll
msmpeg2adec.dll
MSMPEG2ENC.DLL
msmpeg2vdec.dll
MSOpusDecoder.dll
MSPhotography.dll
msrle32.dll
msvidc32.dll
MSVideoDSP.dll
MSVP9DEC.dll
msvproc.dll
MSVPXENC.dll
mswmdm.dll
msyuv.dll
netprofm.dll
ngcrecovery.dll
npmproxy.dll
OEMDefaultAssociations.dll
oleacc.dll
oleaccrc.dll
OnDemandConnRouteHelper.dll
PlayToDevice.dll
playtomenu.dll
PlayToReceiver.dll
PortableDeviceApi.dll
PortableDeviceClassExtension.dll
PortableDeviceConnectApi.dll
PortableDeviceStatus.dll
PortableDeviceTypes.dll
PortableDeviceWiaCompat.dll
propsys.dll
qasf.dll
quartz.dll
RESAMPLEDMO.DLL
ResourcePolicyClient.dll
rmclient.dll
rpcss.dll
rrinstaller.exe
RTWorkQ.dll
rundll32.exe
shell32.dll
spwmp.dll
sqmapi.dll
ssdpapi.dll
sspicli.dll
StorageUsage.dll
taskschd.dll

+ver < 22000
TileDataRepository.dll
+ver*

tsbyuv.dll
twinapi.dll
unregmp2.exe
upnp.dll
upnphost.dll
userenv.dll
uxtheme.dll
VIDRESZR.DLL
wdmaud.drv
WebcamUi.dll
Windows.ApplicationModel.dll
Windows.Globalization.dll
Windows.Media.Audio.dll
Windows.Media.dll
Windows.Media.Editing.dll
Windows.Media.Renewal.dll
Windows.Media.Streaming.dll
Windows.Media.Streaming.ps.dll
Windows.Security.Authentication.OnlineId.dll
Windows.UI.dll
Windows.UI.Xaml.Controls.dll
Windows.Web.dll
wininet.dll
winmde.dll
winmmbase.dll
WMADMOD.DLL
WMADMOE.DLL
WMASF.DLL
wmcodecdspps.dll
wmdmlog.dll
wmdmps.dll
wmdrmsdk.dll
wmerror.dll
wmidx.dll
WMNetMgr.dll
wmp.dll
WMPDMC.exe
WmpDui.dll
wmpdxm.dll
wmpeffects.dll
wmploc.DLL
wmpps.dll
wmpshell.dll
WMSPDMOD.DLL
WMSPDMOE.DLL
WMVCORE.DLL
WMVDECOD.DLL
wmvdspa.dll
WMVENCOD.DLL
WMVSDECD.DLL
WMVSENCD.DLL
wpd_ci.dll
wpdbusenum.dll
wpdshext.dll
WPDShextAutoplay.exe
WPDShServiceObj.dll
WPDSp.dll
wtsapi32.dll
wuaueng.dll

:end_files

rem ==========update registry==========

call RegCopy HKLM\Software\Microsoft\MediaPlayer
call RegCopyEx Classes "WMP11.AssocFile.WAV,WMP11.AssocFile.MP3"
call RegCopyEx Classes "WMP11.AssocFile.AVI,WMP11.AssocFile.MOV,WMP11.AssocFile.MP4"
call RegCopyEx Classes "WMP11.AssocFile.MKV,WMP11.AssocFile.WMA,WMP11.AssocFile.WMV"
reg import MSMediaPlayer.reg

rem link to X:\ProgramFiles\Windows Media Player\wmplayer.exe
call LuaLink -paramlist "[[X:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows Media Player.lnk]], [[#pProgramFiles#p\Windows Media Player\wmplayer.exe]], '/prefetch:1'"
