if not "x%opt[slim.extra]%"=="xtrue" goto :EOF
echo Extra Sliming...

call SharedPatch CustomCompmgmt

for %%i in (DVD,EFI,Misc,PCAT,PXE) do (
  rd /q /s "%X_WIN%\Boot\%%i"
)

call :KEEP_FILES \Windows\Boot\Fonts\ "segoe_slboot.ttf,segoen_slboot.ttf"
del /a /f /q "%X_WIN%\Boot\Fonts\*.*"

rem for %%i in (chs_boot.ttf,cht_boot.ttf,jpn_boot.ttf,kor_boot.ttf) do (
rem   del /a /f /q "%X_WIN%\Boot\Fonts\%%i"
rem )

del /q "%X_SYS%\Boot\winresume.*"
del /q "%X_SYS%\Boot\%WB_PE_LANG%\winresume.*"

rem keep files
if "x%opt[support.network]%"=="xtrue" (
  call :KEEP_FILE \Windows\System32\eappprxy.dll
)

if "x%opt[support.admin]%"=="xtrue" (
  call :KEEP_FILES \Windows\System32\ "CredProv2faHelper.dll,CredProvDataModel.dll,credprovhost.dll,credprovs.dll,credprovslegacy.dll,Faultrep.dll,WerFault.exe"
)

rem del files
if not "x%opt[support.audio]%"=="xtrue" (
  del /a /f /q "%X_SYS%\*Audio*.*"
)

if not "x%opt[support.network]%"=="xtrue" (
  for /f "delims=" %%i in ('dir /b /ad "%X_SYS%\DriverStore\FileRepository\net*"') do (
    echo rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
    rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
  )
)

if not "x%opt[support.network]%"=="xtrue" (
  call :DEL_DRIVERS "agilevpn.sys,bxvbda.sys,evbda.sys,http.sys,kdnic.sys,NetAdapterCx.sys"
  call :DEL_DRIVERS "netvsc.sys,nwifi.sys,qevbda.sys,rasl2tp.sys,raspppoe.sys,raspptp.sys,rassstp.sys"
  call :DEL_DRIVERS "tcpip.sys,vwifibus.sys,vwififlt.sys,vwifimp.sys,wanarp.sys,WdiWiFi.sys"

  del /a /f /q "%X_SYS%\arp.exe"
  del /a /f /q "%X_SYS%\dhcp*.*"

  call :KEEP_FILES \Windows\System32\ "net.exe,net1.exe,netapi32.dll,netjoin.dll,netmsg.dll,netutils.dll"
  rem system boot
  call :KEEP_FILES \Windows\System32\ "netprovfw.dll"
  rem device manager resource
  call :KEEP_FILE \Windows\System32\netcfgx.dll
  call :DEL_SYSFILES "netbios.dll,NetDriverInstall.dll,neth.dll,netiohlp.dll,netlogon.dll,netman.dll,netmsg.dll"
  call :DEL_SYSFILES "NetSetupApi.dll,NetSetupEngine.dll,NetSetupShim.dll,NetSetupSvc.dll,netshell.dll"
  del /a /f /q "%X_SYS%\net*.exe"

  rd /s /q "%X_SYS%\NetworkList"

  del /a /f /q "%X_SYS%\ras*.*"
  del /a /f /q "%X_SYS%\WiFi*.*"
  del /a /f /q "%X_SYS%\wlan*.*"
)

set _REQ_EN_US=1
if "x%WB_PE_LANG%"=="xko-KR" set _REQ_EN_US=0
if "x%WB_PE_LANG%"=="xzh-CN" set _REQ_EN_US=0
if "x%WB_PE_LANG%"=="xzh-TW" set _REQ_EN_US=0
if "x%_REQ_EN_US%"=="x1" goto :END_EN_US_MUI

call :KEEP_FILES \Windows\System32\en-US\ "imageres.dll.mui,taskmgr.exe.mui"
del /a /f /q "%X_SYS%\en-US\*.*"
rd /s /q "%X_SYS%\wbem\en-US"

:END_EN_US_MUI
set _REQ_EN_US=

rem rd /q /s "%X_SYS%\WindowsPowerShell\v1.0\Modules\Storage"
rem rd /q /s "%X_SYS%\WindowsPowerShell\v1.0\Modules\StorageBusCache"
rem rd /q /s "%X_SYS%\WindowsPowerShell\v1.0\Modules\iSCSI"

del /a /f /q "%X_SYS%\AtBroker.exe"
del /a /f /q "%X_SYS%\autochk.exe"
del /a /f /q "%X_SYS%\autoconv.exe"

del /a /f /q "%X_SYS%\CloudRecApi.dll"
del /a /f /q "%X_SYS%\CloudRecSvc.exe"
del /a /f /q "%X_SYS%\clusapi.dll"

del /a /f /q "%X_SYS%\cmi2migxml.dll"
del /a /f /q "%X_SYS%\CompPkgSrv.exe"

call :KEEP_FILE \Windows\System32\credui.dll
del /a /f /q "%X_SYS%\CredProv*.*"

call :KEEP_FILES \Windows\System32\ "C_1252.NLS,C_437.NLS"
call :KEEP_FILE \Windows\System32\C_%WB_PE_CODEPAGE%.NLS

rem 1250: Central and East European Latin
rem  852: Slavic (Latin-2)
if "x%WB_PE_CODEPAGE%"=="x1250" (
  call :KEEP_FILE \Windows\System32\C_852.NLS
)

rem 1252: West European Latin
rem  850: Multilingual (Latin-1)
if "x%WB_PE_CODEPAGE%"=="x1252" (
  call :KEEP_FILE \Windows\System32\C_850.NLS
)

del /a /f /q "%X_SYS%\C_*.NLS"

del /a /f /q "%X_SYS%\csiagent.dll"

del /a /f /q "%X_SYS%\dbgeng.dll"
del /a /f /q "%X_SYS%\DbgModel.dll"
del /a /f /q "%X_SYS%\diagER.dll"
del /a /f /q "%X_SYS%\diagtrack.dll"

del /a /f /q "%X_SYS%\eap*.*"

del /a /f /q "%X_SYS%\edgeIso.dll"
del /a /f /q "%X_SYS%\EdgeManager.dll"
del /a /f /q "%X_SYS%\Faultrep.dll"
del /a /f /q "%X_SYS%\fdWCN.dll"
del /a /f /q "%X_SYS%\FlightSettings.dll"

del /a /f /q "%X_SYS%\ReserveManager.dll"
del /a /f /q "%X_SYS%\reseteng.dll"
del /a /f /q "%X_SYS%\ResetEngine.dll"
del /a /f /q "%X_SYS%\ResetEngine.exe"
del /a /f /q "%X_SYS%\ResetEngInterfaces.exe"
del /a /f /q "%X_SYS%\resetengmig.dll"
del /a /f /q "%X_SYS%\ResetPluginHost.exe"

del /a /f /q "%X_SYS%\setupplatform.cfg"
del /a /f /q "%X_SYS%\setupplatform.dll"
del /a /f /q "%X_SYS%\setupplatform.exe"



if exist "%X_SYS%\StartTileData.dll" del /a /f /q "%X_SYS%\StartTileData.dll"

del /a /f /q "%X_SYS%\storagewmi.dll"
del /a /f /q "%X_SYS%\%WB_PE_LANG%\storagewmi.dll.mui"

del /a /f /q "%X_SYS%\storagewmi_passthru.dll"

del /a /f /q "%X_SYS%\SysFxUI.dll"

del /a /f /q "%X_SYS%\sysreset.exe"

if exist "%X_SYS%\TDLMigration.dll" del /a /f /q "%X_SYS%\TDLMigration.dll"
del /a /f /q "%X_SYS%\tier2punctuations.dll"

del /a /f /q "%X_SYS%\TimeBrokerClient.dll"
del /a /f /q "%X_SYS%\TimeBrokerServer.dll"

if 1==0 (
  del /a /f /q "%X_SYS%\appinfo.dll"
  del /a /f /q "%X_SYS%\appinfoext.dll"
  del /a /f /q "%X_SYS%\twinapi.appcore.dll"
  del /a /f /q "%X_SYS%\twinapi.dll"
  del /a /f /q "%X_SYS%\twinui.appcore.dll"
  del /a /f /q "%X_SYS%\twinui.dll"
  del /a /f /q "%X_SYS%\twinui.pcshell.dll"
  del /a /f /q "%X_SYS%\twinapi.appcore.dll"

  del /a /f /q "%X_SYS%\UIRibbon.dll"
  del /a /f /q "%X_SYS%\UIRibbonRes.dll"
)

del /a /f /q "%X_SYS%\unbcl.dll"
del /a /f /q "%X_SYS%\uninstall.xml"
del /a /f /q "%X_SYS%\uninstall_data.xml"
del /a /f /q "%X_SYS%\unlodctr.exe"
del /a /f /q "%X_SYS%\upgradeagent.dll"
del /a /f /q "%X_SYS%\upgrade*.xml"
del /a /f /q "%X_SYS%\upgWow_bulk.xml"
rem del /a /f /q "%X_SYS%\unlodctr.exe"

del /a /f /q "%X_SYS%\VSSVC.exe"
del /a /f /q "%X_SYS%\wbengine.exe"

del /a /f /q "%X_SYS%\Wcn*.dll"

del /a /f /q "%X_SYS%\wdscapture.exe"
del /a /f /q "%X_SYS%\wdscapture.inf"
del /a /f /q "%X_SYS%\wdsclient.exe"
del /a /f /q "%X_SYS%\wdscsl.dll"
del /a /f /q "%X_SYS%\WdsDiag.dll"
del /a /f /q "%X_SYS%\WdsImage.dll"
del /a /f /q "%X_SYS%\wdsmcast.exe"
del /a /f /q "%X_SYS%\wdstptc.dll"
del /a /f /q "%X_SYS%\wdsutil.dll"

del /a /f /q "%X_SYS%\webplatstorageserver.dll"
del /a /f /q "%X_SYS%\webservices.dll"

del /a /f /q "%X_SYS%\Wer*.exe"

del /a /f /q "%X_SYS%\winquic.dll"

del /a /f /q "%X_SYS%\winresume.efi"
del /a /f /q "%X_SYS%\winresume.exe"

del /a /f /q "%X_SYS%\winsqlite3.dll"

del /a /f /q "%X_SYS%\wpr.config.xml"
del /a /f /q "%X_SYS%\wpr.exe"

del /a /f /q "%X_SYS%\wpx.dll"

:END_SLIM_FILES
rem restore [KEEP]
if not exist "%X%\[KEEP]" goto :EOF
xcopy /S /E /Q /H /K /Y "%X%\[KEEP]" "%X%\"
rd /s /q "%X%\[KEEP]"
goto :EOF

:DEL_FONTS
for %%i in (%~1) do (
  del /a /f /q "%X_WIN%\Fonts\%%i%~2"
)
goto :EOF

:DEL_DRIVERS
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\Drivers\%%i"
)
goto :EOF

:DEL_DRVSTORES
for %%i in (%~1) do (
  call :DEL_DRVSTORE "%%i"
)
goto :EOF

:DEL_DRVSTORE
for /f "delims=" %%i in ('dir /b /ad "%X_SYS%\DriverStore\FileRepository\%~1*"') do (
  echo rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
  rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
)
goto :EOF

:DEL_SYSFILES
for %%i in (%~1) do (
  del /a /f /q "%X_SYS%\%%i"
)
goto :EOF


:KEEP_FILES
echo move "%~1%~2" "%X%\[KEEP]%~1"
if not exist "%X%\[KEEP]%~1" mkdir "%X%\[KEEP]%~1"
for %%i in (%~2) do (
  move "%X%%~1%%i" "%X%\[KEEP]%~1"
)
goto :EOF

:KEEP_FILE
echo move "%~1" "%X%\[KEEP]%~p1"
if not exist "%X%\[KEEP]%~p1" mkdir "%X%\[KEEP]%~p1"
move "%X%%~1" "%X%\[KEEP]%~1"
goto :EOF
