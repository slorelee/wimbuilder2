if not exist "%X_WIN%\Inf\ks.inf" (
    pushd "..\03-Audio"
    call main.bat
    popd
)

rem ks.inf,kscaptur.inf,ksfilter.inf was added by 03-Audio\main.bat

call AddDrivers "c_camera.inf,c_image.inf,usbvideo.inf"

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\

;Universal Serial Bus Camera Driver
drivers\USBCAMD2.sys

;Windows Driver Model (WDM) driver
drivers\WdmCompanionFilter.sys

CameraCaptureUI.dll
CameraSettingsUIHost.exe
;cdd.dll
devenum.dll
fundisc.dll
ksproxy.ax
kstvtune.ax
Kswdmcap.ax
ksxbar.ax
WebcamUi.dll

;Xeoma

;add for boot.wim
d3d9.dll

opengl32.dll
glu32.dll
dsound.dll
pdh.dll

+ver > 19000
RESAMPLEDMO.DLL

+ver >= 22000
\Windows\WMSysPr9.prx

CaptureService.dll
CapabilityAccessManagerClient.dll
CapabilityAccessHandlers.dll
FrameServerMonitorClient.dll
mapi32.dll
mfcore.dll
mfksproxy.dll
mfsensorgroup.dll
vfwwdm32.dll
WindowManagementAPI.dll
Windows.Internal.CapturePicker.Desktop.dll
Windows.Media.MediaControl.dll
Windows.System.Launcher.dll
SettingsHandlers_Camera.dll

+syswow64
; record
mfplat.dll
qasf.dll
COLORCNV.DLL
VIDRESZR.DLL
WMADMOE.DLL
WMASF.DLL
WMVCORE.DLL
WMVENCOD.DLL

; recording timing
Kswdmcap.ax

; non-core
msyuv.dll
l3codeca.acm
msg711.acm
msgsm32.acm
-syswow64

+ver*

;ECap, webcam 7
@\Windows\SysWOW64\
ksproxy.ax,ksuser.dll

+ver >= 22000
CapabilityAccessManagerClient.dll
FrameServerMonitorClient.dll
usermgrcli.dll
UserMgrProxy.dll
Windows.Media.MediaControl.dll
+ver >= 26100
atl.dll
mfksproxy.dll
mfsensorgroup.dll
vfwwdm32.dll
RTWorkQ.dll
+ver*

@\Windows\%System32OrSysWOW64%\
qcap.dll,qedit.dll,qedwipes.dll

:end_files

; output file(s) setting for recording
call RegCopyEx Classes "SAPI_OneCore.SpAudioFormat,SAPI_OneCore.SpAudioFormat.1"
call RegCopyEx Classes "SAPI_OneCore.SpMMAudioEnum,SAPI_OneCore.SpMMAudioEnum.1"
call RegCopyEx Classes "SAPI_OneCore.SpMMAudioIn,SAPI_OneCore.SpMMAudioIn.1"
call RegCopyEx Classes "SAPI_OneCore.SpMMAudioOut,SAPI_OneCore.SpMMAudioOut.1"
call RegCopyEx Classes "Stack.Audio,Stack.System.Music,Stack.Video"
call RegCopyEx Classes "Stack.System.Music.AlbumTitle,Stack.System.Music.AlbumID,Stack.System.Music.Artist"
call RegCopyEx Classes "Stack.System.Music.DisplayArtist,Stack.System.Music.Genre,Stack.System.Photo"
call RegCopyEx Classes "WiaDevMgr,WiaDevMgr.1"
call RegCopy "HKLM\SOFTWARE\Classes\Windows Media"

call RegCopyEx Services "WdmCompanionFilter"
call RegCopy HKLM\SYSTEM\ControlSet001\Control\Class\{ca3e7ab9-b4c3-4ae6-8251-579ef933890f}

call RegCopy HKLM\SOFTWARE\Classes\Interface\{877E4352-6FEA-11d0-B863-00AA00A216A1}
call RegCopy HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{877E4352-6FEA-11d0-B863-00AA00A216A1}

if %VER[3]% GEQ 22000 (
  call AddDrivers image.inf

  call RegCopyEx Services "FrameServer,FrameServerMonitor"
  call RegCopyEx Services CaptureService
  reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CaptureService /f
)
