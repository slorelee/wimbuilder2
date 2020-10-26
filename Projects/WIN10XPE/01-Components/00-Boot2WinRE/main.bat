if "x%opt[build.wim]%"=="xwinre" goto :EOF

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
d3d*.dll
fmapi.dll
mlang.dat,mlang.dll,mshta.exe,mshtml*.*,msimtf.dll,msoert2.dll,msrating.dll,oledlg.dll,pngfilt.dll
pnppropmig.dll,ReserveManager.dll,storagewmi.dll,storagewmi_passthru.dll,unbcl.dll
wdsutil.dll,webplatstorageserver.dll,wfdprov.dll,WiFiConfigSP.dll,WiFiDisplay.dll

;vwifi
drivers\vwifibus.sys
drivers\vwifimp.sys

:end_files

call RegCopy "HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{5CBF81BF-5055-47CD-9055-A76B2B4E3698}"
call RegCopy "HKLM\System\ControlSet001\Control\WMI\Autologger\WiFiSession"
call RegCopyEx Services "vwifibus,vwififlt,wcncsvc,wdiwifi,WFPLWFS,NativeWifiP,MSiSCSI"
