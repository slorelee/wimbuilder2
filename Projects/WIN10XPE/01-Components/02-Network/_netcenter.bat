if not "x%opt[network.sharecenter]%"=="xtrue" goto :EOF

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\

;Network and Sharing Center Service
; UPnP Device Host
upnphost.dll,upnp.dll,upnpcont.exe,upnpui.dll

; Control Panel Applets
netcenter.dll,netdiagfx.dll,hgcpl.dll

; Firewall
hnetmon.dll,nettrace.dll,nshhttp.dll,nshipsec.dll,PeerDistSh.dll,rpcnsh.dll,whhelper.dll,wwancfg.dll
PortableDeviceApi.dll

:end_files

rem Network and Sharing Center Service
call RegCopyEx Services upnphost
rem //-- Add Network Icon To File Explorer Navagation Pane
call RegCopy HKLM\SOFTWARE\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}
