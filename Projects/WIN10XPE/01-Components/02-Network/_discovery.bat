if not "x%opt[network.function_discovery]%"=="xtrue" goto :EOF

rem // Function Discovery Provider Host and Publication and SSDP Discovery services
call RegCopyEx Services "fdPHost,FDResPub,SSDPSRV"

call AddFiles %0 :end_files
goto :end_files
@\Windows\System32\
; Core
fdPHost.dll,fdProxy.dll,FDResPub.dll,fdSSDP.dll,fdWSD.dll,WSDApi.dll

; More
;fdBth.dll,fdBthProxy.dll,FdDevQuery.dll,fde.dll,fdeploy.dll,fdPnp.dll,fdprint.dll,fdWCN.dll,fdWNet.dll

; SSDP Discovery services
ssdpapi.dll,ssdpsrv.dll
:end_files
