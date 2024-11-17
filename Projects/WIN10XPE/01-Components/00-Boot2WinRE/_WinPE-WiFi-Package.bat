call AddFiles %0 :[WinPE-WiFi-Package-Files]

call RegCopy "HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{5CBF81BF-5055-47CD-9055-A76B2B4E3698}"
call RegCopy "HKLM\System\ControlSet001\Control\WMI\Autologger\WiFiSession"
call RegCopyEx Services "vwifibus,vwififlt,wcncsvc,wdiwifi,WFPLWFS,WlanSvc,NativeWifiP"

goto :EOF

:[WinPE-WiFi-Package-Files]
@\Windows\System32\
mlang.dat,mlang.dll
WiFiConfigSP.dll,WiFiDisplay.dll

;WLAN
wlan*.dll

;vwifi
drivers\vwifibus.sys
drivers\vwifimp.sys
goto :EOF
