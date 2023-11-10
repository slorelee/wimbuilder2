rem delete useless files
if not exist "%X_SYS%\AppxSysprep.dll" call :DELEX /q "%X_SYS%\edgehtml.dll"

if not exist "%X_SYS%\MdSched.exe" (
    call :DELEX /q "%X%\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Memory Diagnostics Tool.lnk"
)

set Check_SysWOW64=0
if exist "%X_WIN%\SysWOW64\wow32.dll" set Check_SysWOW64=1

rem remove usless mui & mun files
if not exist "%X_WIN%\SystemResources" goto :END_DEL_MUN

for /f %%i in ('dir /a-d /b "%X_WIN%\SystemResources"') do (
    if not exist "%X_SYS%\%%~ni" (
        if %Check_SysWOW64% EQU 0 (
            call :DELEX "/f /a /q" "%X_WIN%\SystemResources\%%i" "Remove orphan "
        ) else (
            if not exist "%X_WIN%\SysWOW64\%%~ni" (
                call :DELEX "/f /a /q" "%X_WIN%\SystemResources\%%i" "Remove orphan "
            )
        )
    )
)
:END_DEL_MUN
rem ignore *.msc files
for /f %%i in ('dir /a-d /b "%X_SYS%\%WB_PE_LANG%\*.mui"') do (
    if not exist "%X_SYS%\%%~ni" (
        call :DELEX "/f /a /q" "%X_SYS%\%WB_PE_LANG%\%%i" "Remove orphan "
    )
)

if %Check_SysWOW64% EQU 0 goto :END_DEL_MUI

for /f %%i in ('dir /a-d /b "%X_WIN%\SysWOW64\%WB_PE_LANG%\*.mui"') do (
    if not exist "%X_WIN%\SysWOW64\%%~ni" (
        call :DELEX "/f /a /q" "%X_WIN%\SysWOW64\%WB_PE_LANG%\%%i" "Remove orphan "
    )
)

:END_DEL_MUI

rem cleanup registry
if not exist "%X_SYS%\AppxSysprep.dll" (
    rem reg delete "HKLM\Tmp_Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\PackageRepository\Packages" /f
    reg delete "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\AppX\AppxAllUserStore" /f
)

if %Check_SysWOW64% EQU 0 call :REMOVE_WOW64_REG

call :REMOVE_SERV_REG AudioEndpointBuilder AudioEndpointBuilder.dll
rem call :REMOVE_SERV_REG Audiosrv audiosrv.dll
call :REMOVE_SERV_REG Dhcp dhcpcore.dll
call :REMOVE_SERV_REG diagnosticshub.standardcollector.service DiagSvcs\DiagnosticsHub.StandardCollector.Service.exe
call :REMOVE_SERV_REG DiagTrack diagtrack.dll
call :REMOVE_SERV_REG Dnscache dnsapi.dll
call :REMOVE_SERV_REG Eaphost eapsvc.dll
call :REMOVE_SERV_REG Netlogon netlogon.dll
call :REMOVE_SERV_REG Netman netman.dll
rem call :REMOVE_SERV_REG netprofm netprofmsvc.dll
call :REMOVE_SERV_REG NetSetupSvc NetSetupSvc.dll
call :REMOVE_SERV_REG RasAuto rasauto.dll
call :REMOVE_SERV_REG RasMan rasman.dll
call :REMOVE_SERV_REG TimeBrokerSvc TimeBrokerServer.dll
call :REMOVE_SERV_REG TrustedInstaller ..\servicing\TrustedInstaller.exe
call :REMOVE_SERV_REG VSS vssvc.exe
call :REMOVE_SERV_REG wbengine wbengine.exe
call :REMOVE_SERV_REG wcncsvc wcncsvc.dll
call :REMOVE_SERV_REG wisvc flightsettings.dll
call :REMOVE_SERV_REG WlanSvc wlansvc.dll

call :REMOVE_SERV_REG Appinfo appinfo.dll
call :REMOVE_SERV_REG Audiosrv audiosrv.dll
call :REMOVE_SERV_REG BFE bfe.dll
call :REMOVE_SERV_REG EFS efssvc.dll
call :REMOVE_SERV_REG EventLog wevtsvc.dll
call :REMOVE_SERV_REG FontCache FntCache.dll
call :REMOVE_SERV_REG KeyIso keyiso.dll
call :REMOVE_SERV_REG lmhosts lmhsvc.dll

if VER[3] GTR 21000 (
    call :REMOVE_SERV_REG NlaSvc netprofmsvc.dll
) else (
    call :REMOVE_SERV_REG NlaSvc nlasvc.dll
)

call :REMOVE_SERV_REG PolicyAgent polstore.dll
call :REMOVE_SERV_REG ProfSvc profsvc.dll
call :REMOVE_SERV_REG sacsvr sacsvr.dll
call :REMOVE_SERV_REG SstpSvc sstpsvc.dll
call :REMOVE_SERV_REG W32Time w32time.dll
call :REMOVE_SERV_REG WerSvc wersvc.dll

call :REMOVE_SERV_REG bttflt drivers\bttflt.sys
call :REMOVE_SERV_REG cht4vbd drivers\cht4vx64.sys
call :REMOVE_SERV_REG dmvsc drivers\dmvsc.sys
call :REMOVE_SERV_REG Dnscache dnsapi.dll
call :REMOVE_SERV_REG fdc drivers\fdc.sys
call :REMOVE_SERV_REG Filetrace drivers\filetrace.sys
call :REMOVE_SERV_REG flpydisk drivers\flpydisk.sys
call :REMOVE_SERV_REG fvevol drivers\fvevol.sys
call :REMOVE_SERV_REG gpsvc gpapi.dll
call :REMOVE_SERV_REG hyperkbd drivers\hyperkbd.sys
call :REMOVE_SERV_REG HyperVideo drivers\HyperVideo.sys
call :REMOVE_SERV_REG IKEEXT ikeext.dll
call :REMOVE_SERV_REG iScsiPrt drivers\msiscsi.sys
call :REMOVE_SERV_REG kdnic drivers\kdnic.sys
call :REMOVE_SERV_REG LanmanServer srvsvc.dll
call :REMOVE_SERV_REG MSiSCSI iscsidsc.dll
call :REMOVE_SERV_REG NetBIOS drivers\netbios.sys
call :REMOVE_SERV_REG NetBT drivers\netbt.sys
call :REMOVE_SERV_REG netvsc drivers\netvsc.sys
call :REMOVE_SERV_REG PerfDisk perfdisk.dll
call :REMOVE_SERV_REG PerfNet perfnet.dll
call :REMOVE_SERV_REG PerfOS perfos.dll
call :REMOVE_SERV_REG PerfProc perfproc.dll
call :REMOVE_SERV_REG PolicyAgent polstore.dll
call :REMOVE_SERV_REG sfloppy drivers\sfloppy.sys
call :REMOVE_SERV_REG srv2 srvsvc.dll
call :REMOVE_SERV_REG srvnet drivers\srvnet.sys
call :REMOVE_SERV_REG storflt drivers\vmstorfl.sys
call :REMOVE_SERV_REG storqosflt drivers\storqosflt.sys
call :REMOVE_SERV_REG storvsc drivers\storvsc.sys
call :REMOVE_SERV_REG svsvc svsvc.dll
call :REMOVE_SERV_REG TPM drivers\tpm.sys
call :REMOVE_SERV_REG usbser drivers\usbser.sys
call :REMOVE_SERV_REG vmbus drivers\vmbus.sys
call :REMOVE_SERV_REG drivers\VMBusHID.sys

set Check_SysWOW64=
goto :EOF


:REMOVE_WOW64_REG
if "x%opt[build.registry.software]%"=="xfull" (
    reg delete HKLM\Tmp_Software\Classes\Wow6432Node /f
    reg delete HKLM\Tmp_Software\Wow6432Node /f
    rem HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,x86;wow64
)
goto :EOF

:REMOVE_SERV_REG
if not exist "%X_SYS%\%~2" reg delete "HKLM\Tmp_SYSTEM\ControlSet001\Services\%~1" /f
goto :EOF

:DELEX
if exist "%~2" (
    if not "x%~3"=="x" echo %~3%~2
    del %~1 "%~2"
)
goto :EOF

