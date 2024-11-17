if "x%opt[build.wim]%"=="xwinre" goto :EOF

call AddFiles %0 :[WinRE-Builtin-Packages]
call RegCopyEx Services "MSiSCSI"

call _WinPE-WiFi-Package.bat
goto :EOF

:[WinRE-Builtin-Packages]
;WinPE-EnhancedStorage, WinPE-WMI, WinPE-HTA ...
@\Windows\System32\
d3d*.dll
fmapi.dll
mlang.dat,mlang.dll,mshta.exe,mshtml*.*,msimtf.dll,msoert2.dll,msrating.dll,oledlg.dll,pngfilt.dll
pnppropmig.dll,ReserveManager.dll,storagewmi.dll,storagewmi_passthru.dll,unbcl.dll
wdsutil.dll,webplatstorageserver.dll,wfdprov.dll


;iscsi
iscsi*.dll,iscsicli.exe,iscsicpl.exe
goto :EOF
