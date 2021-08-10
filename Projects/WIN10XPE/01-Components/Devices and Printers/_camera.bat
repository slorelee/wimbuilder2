call AddDrivers "c_camera.inf,c_image.inf,dshowext.inf,ks.inf,kscaptur.inf,ksfilter.inf,usbvideo.inf,WSDScDrv.inf"

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\

;Universal Serial Bus Camera Driver
drivers\USBCAMD2.sys

;Windows Driver Model (WDM) driver
drivers\WdmCompanionFilter.sys

CameraCaptureUI.dll
CameraSettingsUIHost.exe
cdd.dll
devenum.dll
fundisc.dll
ksproxy.ax
kstvtune.ax
Kswdmcap.ax
ksxbar.ax
WebcamUi.dll

:end_files

call RegCopyEx Services "WdmCompanionFilter"
call RegCopy HKLM\SYSTEM\ControlSet001\Control\Class\{ca3e7ab9-b4c3-4ae6-8251-579ef933890f}
