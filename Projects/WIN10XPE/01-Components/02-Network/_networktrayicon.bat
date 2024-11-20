if not "x%opt[network.trayicon]%"=="xtrue" goto :EOF
if "x%opt[network.full_functional]%"=="xtrue" goto :EOF

rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files
@\Windows\System32\drivers\
tcpipreg.sys,vwififlt.sys
+mui
tunnel.sys,wfplwfs.sys
-mui

; add cat files for driver files
@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
+ver >= 17763
Microsoft-Windows-Client-Desktop-Required-Package*.cat
+ver >= 16299 and ver < 17763
Microsoft-Windows-Client-Features-Package*.cat
+ver >= 14393 and ver < 16299
Microsoft-Windows-NetIO-Package~*.cat
+ver*

@\Windows\System32\
+ver < 22621
authfwcfg.dll,CoreMessaging.dll,dmcmnutils.dll,fdWNet.dll,mdmregistration.dll,mprddm.dll
ndfapi.dll,netevent.dll,networkexplorer.dll,NetworkStatus.dll
p2pnetsh.dll,sc.exe,sscoreext.dll,VAN.dll,wfhc.dll,Windows.Globalization.dll,winhttp.dll
+ver >= 26100
NetworkIcon.dll
+ver*

; WcmSvc
wcmapi.dll,wcmcsp.dll,wcmsvc.dll,NetworkUXBroker.dll
; WcncSvc
WcnApi.dll,wcncsvc.dll,WcnEapAuthProxy.dll,WcnEapPeerProxy.dll,WcnNetsh.dll

+if "x%opt[network.trayicon_wlan]%"="xtrue"
; Wlan
mobilenetworking.dll,wlanapi.dll,wlancfg.dll,WLanConn.dll,wlandlg.dll,wlanhlp.dll
wlanmsm.dll,wlanpref.dll,wlansvc.dll,wlansvcpal.dll

WlanMediaManager.dll
-if

:end_files

:update_registry
rem ==========update registry==========
call RegCopy HKLM\Software\Microsoft\wcmsvc
call RegCopy HKLM\Software\Policies\Microsoft\Windows\WcmSvc
call RegCopy HKLM\Software\Microsoft\WlanSvc

rem // wfplwfs
call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{3BFD7820-D65C-4C1B-9FEA-983A019639EA}
call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{B70D6460-3635-4D42-B866-B8AB1A24454C}
if "%WB_PE_ARCH%"=="x64" (
  call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{E7C3B2F0-F3C5-48DF-AF2B-10FED6D72E7A}
)
call RegCopy HKLM\System\ControlSet001\Services\WFPLWFS

call RegCopy HKLM\System\ControlSet001\Control\Network\{4d36e974-e325-11ce-bfc1-08002be10318}\{E475CF9A-60CD-4439-A75F-0079CE0E18A1}
call RegCopy HKLM\System\ControlSet001\Control\VAN

call RegCopyEx Services netprofm

set opt[network.networklist]=true
call _networklist.bat

