rem ==========update filesystem==========

rem already added in Build\main.bat
rem call RegCopy SYSTEM\DriverDatabase

if "x%opt[audio.win_events]%"=="x" set opt[audio.win_events]=base

set AddFiles_Mode=merge
rem ;In Winre.wim \Windows\INF\AudioEndpoint.inf,hdaudbus.inf,hdaudio.inf,hdaudss.inf,wdma_usb.inf,wdmaudio.inf
call AddDrivers "bda.inf,c_media.inf,gameport.inf,ks.inf,kscaptur.inf,ksfilter.inf,modemcsa.inf,usbvideo.inf,wave.inf"

call AddFiles %0 :end_files
goto :end_files

@windows\system32\
;In Winre.wim \System32\drivers\drmk.sys,ks.sys(.mui),mmcss.sys,mskssrv.sys,mspclock.sys,mspqm.sys,mstee.sys,portcls.sys
drivers\beep.sys

;In Winre.wim \System32\audiodg.exe,AudioEndpointBuilder.dll,AudioEng.dll,AUDIOKSE.dll,AudioSes.dll,audiosrv.dll,AudioSrvPolicyManager.dll,avrt.dll,coreaudiopolicymanagerext.dll,dciman32.dll,DWrite.dll,hidserv.dll,imaadp32.acm,ksuser.dll,linkinfo.dll,lz32.dll,MMDevAPI.dll,msacm32.dll,msadp32.acm,msg711.acm,msgsm32.acm,umpo.dll,utildll.dll,wdmaud.drv,Windows.Media.Devices.dll,winmm.dll,winmmbase.dll,WinTypes.dll,wsock32.dll
avicap32.dll,bdaplgin.ax,control.exe,ddraw.dll,ddrawex.dll,deviceaccess.dll
dsound.dll,dxtrans.dll,iyuv_32.dll,l3codeca.acm
midimap.dll,mmci.dll,mmcico.dll,mmcndmgr.dll,mmcshext.dll,mmres.dll,mmsys.cpl
msacm32.drv,MSDvbNP.ax,msrle32.dll,msvfw32.dll,msvidc32.dll,msyuv.dll
psisdecd.dll,psisrndr.ax,quartz.dll
SndVol.exe,SndVolSSO.dll,stobject.dll,tsbyuv.dll,WMADMOD.DLL,WMADMOE.DLL,WMASF.DLL
; some characters in volume mixer dialog need malgun.ttf, but origin malgun.ttf is too big
; \Windows\Fonts\malgun.ttf

+ver > 18300
SysFxUI.dll
WMALFXGFXDSP.dll
+ver*

+if "x%opt[audio.win_events]%"="xall"
\Windows\Media\*.wav
-if

+if "x%opt[audio.win_events]%"="xbase"
\Windows\Media\Windows Background.wav
\Windows\Media\Windows Foreground.wav
-if

+if "x%opt[audio.win_events]%"<>"xnone"
+if "x%opt[build.wow64support]%"="xtrue"
\Windows\SysWOW64\mmres.dll
-if
-if

:end_files

call DoAddFiles

rem ==========update registry==========

rem SSM class(Steam Streaming Microphone)
rem already in WinRE.wim
rem call RegCopy SYSTEM\\ControlSet001\Control\Class\{C166523C-FE0C-4A94-A586-F1A80CFBBF3E}

if not "x%opt[build.registry.software]%"=="xfull" (
  rem //Complete winre.wim audio registry
  call RegCopy HKLM\Software\Classes\AudioEngine
  rem //In WinRE.wim call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\Audio
  call RegCopy "HKLM\Software\Microsoft\Windows\CurrentVersion\Media Center"
  call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\MMDevices
  rem ACLRegKey,Tmp_Software\Microsoft\Windows\CurrentVersion\MMDevices
  rem //MMDevices has special rights required, Audiosrv & AudioEndpointBuilder. It can be FullControl
  rem //-
  call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\drivers.desc"
  call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Drivers32"
  call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\MCI Extensions"
  call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\MCI32"
  rem //In WinRE.wim call RegCopy "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Multimedia"
)
rem // Sound Volume Bar
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" /v EnableMtcUvc /t REG_DWORD /d 0 /f

rem add services
rem AudioEndpointBuilder,HDAudBus,MMCSS,volmgr services (already in WinRE.wim)
call RegCopyEx Services Beep

if not "x%opt[audio.win_events]%"=="xnone" (
  reg copy HKLM\Src_NTUSER.DAT\AppEvents HKLM\Tmp_Default\AppEvents /s /f
)

rem // Associate .mp3 with mpg123.exe
if 0 EQU 1 (
  reg add HKLM\Tmp_Software\Classes\.mp3 /ve /d mpg123 /f
  reg add HKLM\Tmp_Software\Classes\mpg123\DefaultIcon /ve /d "%%SystemRoot%%\Windows\shell32.dll /f,-16824"
  reg add HKLM\Tmp_Software\Classes\mpg123\Shell\Open /ve /d "&Play with mpg123" /f
  reg add HKLM\Tmp_Software\Classes\mpg123\Shell\Open /v Icon /d "%%SystemRoot%%\Windows\shell32.dll /f,-16824"
  reg add HKLM\Tmp_Software\Classes\mpg123\Shell\Open\Command /ve /d "hiderun.exe mpg123.exe -q #$q%%1#$q" /f
)

rem // Microphone (Identified by noelBlanc)
call RegCopyEx Services camsvc
call AddFiles "@\Windows\System32\#nCapabilityAccessManager.dll,CapabilityAccessManagerClient.dll"
