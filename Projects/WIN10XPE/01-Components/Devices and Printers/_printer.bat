rem ==========update filesystem==========

set AddFiles_Mode=merge
rem devices and printers
call AddDrivers "c_pnpprinters.inf,c_printer.inf,PrintQueue.inf,printupg.inf,usbprint.inf"

rem base drivers
call AddDrivers "ntprint.inf,ntprint4.inf,tsprint.inf,wsdprint.inf"
call AddDrivers "prnms003.inf"

call AddFiles %0 :end_files
goto :end_files

\Windows\splwow64.exe
\Windows\PrintDialog

\Windows\Inf\prn*.inf

\Windows\System32\drivers\usbprint.sys
@\Windows\System32\driverstore\en-US
;devices and printers
c_dot4print.inf_loc
c_pnpprinters.inf_loc
c_printer.inf_loc
c_receiptprinter.inf_loc

;base drivers
ntprint4.inf_loc

@\Windows\System32\driverstore\%WB_PE_LANG%
;devices and printers
bthprint.inf_loc
PrintQueue.inf_loc
usbprint.inf_loc

;base drivers
ntprint.inf_loc
tsprint.inf_loc
WSDPrint.inf_loc

@\Windows\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
*Print*
ntprint.cat
ntprint4.cat
prn*.cat
\Windows\System32\DriverStore\FileRepository\prn*.inf*

@\Windows\System32\

;Windows Photo Viewer needs them too
spool\
coloradapterclient.dll,efswrt.dll,icm32.dll,mscms.dll,photowiz.dll,shimgvw.dll

DafPrintProvider.dll
DevDispItemProvider.dll,DeveloperOptionsSettingsHandlers.dll,deviceassociation.dll
DeviceCenter.dll,DeviceDisplayStatusManager.dll
DeviceEject.exe,DeviceElementSource.dll,DeviceEnroller.exe,DevicesFlowBroker.dll,DeviceMetadataRetrievalClient.dll
DevicePairing.dll,DevicePairingFolder.dll,DevicePairing.dll,DevicePairingProxy.dll,DevicePairingWizard.exe
deviceregistration.dll
DeviceUxRes.dll,devinv.dll,DevPropMgr.dll,DevQueryBroker.dll,efswrt.dll
FaxPrinterInstaller.dll,fdPnp.dll,fdWNet.dll,fdWSD.dll
fxsapi.dll,FXSMON.dll,FXSRESM.dll,gpprnext.dll,hgprint.dll,icm32.dll,icmui.dll
inetppui.dll,IPPMon.dll,localspl.dll,localui.dll,mgmtapi.dll
newdev.exe,ntprint.dll,ntprint.exe,pcl.sep,print.exe
PrintBrmUi.exe,PrintDialogHost.exe,PrintDialogs.dll,printfilterpipelineprxy.dll,printfilterpipelinesvc.exe
PrintIsolationHost.exe,PrintIsolationProxy.dll,printmanagement.msc,PrintPlatformConfig.dll,PrintRenderAPIHost.DLL
printui.dll,printui.exe,PrintWSDAHost.dll,prncache.dll,prnfldr.dll,prnntfy.dll,prntvpt.dll,pscript.sep
puiapi.dll,puiobj.dll,rasadhlp.dll,RepCurUser.cmd,ReSpooler.cmd,serialui.dll,spoolss.dll,spoolsv.exe,srclient.dll
srcore.dll,sysprint.sep,sysprtj.sep,tcpmon.dll,tcpmon.ini,tcpmonui.dll,umb.dll,usbmon.dll,webservices.dll,win32spl.dll
Windows.Devices.Printers.dll,Windows.Devices.Printers.Extensions.dll
Windows.Graphics.dll,Windows.Graphics.Printing.3D.dll,Windows.Graphics.Printing.dll
Windows.Internal.Shell.Broker.dll,WLIDNSP.DLL,WlS0WndH.dll,WSDApi.dll,WSDMon.dll,wsdprintproxy.dll,WSDScanProxy.dll
XpsDocumentTargetPrint.dll,XpsFilt.dll,XpsGdiConverter.dll,XpsPrint.dll,XPSSHHDR.dll
xwizard.exe,xwizards.dll,xwtpdui.dll,xwtpw32.dll

;V1803
coloradapterclient.dll

;Document and Device
defaultdevicemanager.dll
defaultprinterprovider.dll
fundisc.dll
FdDevQuery.dll
fdprint.dll
DDOIProxy.dll
RemoveDeviceContextHandler.dll
DeviceDisplayStatusManager.dll

;mof: "wmi win32_printer"
wbem\win32_printer.mof
;mof get-printer
wbem\PrintManagementProvider.*

;"printer option" menu
compstui.dll

;Sharing printers on Local Network
findnetprinters.dll
wsnmp32.dll

;Printer PDF
;spool\tools\Microsoft Print To PDF\
;spool\tools\Microsoft XPS Document Writer\
DeviceSetupManager.dll
DeviceSetupManagerAPI.dll
DeviceSetupStatusProvider.dll
DeviceDriverRetrievalClient.dll

;V1809 dsmsvc
DeviceSoftwareInstallationClient.dll

;Printer XPS
;V1809
ApMon.dll,AppMon.dll,bidispl.dll
;Absence in V1803 and V1809???
xpsrchvw.exe

;Print on Internet
inetpp.dll

;For PDF and XPS
OpcServices.dll
xpsservices.dll
XpsRasterService.dll


;add for EnablePrintFeature.bat
timeout.exe

:end_files

call DoAddFiles

rem ; V1709
SetACL.exe -on "%X_SYS%\spool\PRINTERS" -ot file -actn ace -ace "n:Everyone;p:full;s:y"

rem ; V1803
rem prn*.inf

rem ==========update registry==========

call RegCopy SYSTEM\ControlSet001\Control\Print
call RegCopy SYSTEM\ControlSet001\Control\Class\{1ed2bbf9-11f0-4084-b21f-ad83a8e6dcdc}
call RegCopy SYSTEM\ControlSet001\Control\Class\{4658ee7e-f050-11d1-b6bd-00c04fa372a7}
call RegCopy SYSTEM\ControlSet001\Control\Class\{49ce6ac8-6f86-11d2-b1e5-0080c72e74a2}
call RegCopy SYSTEM\ControlSet001\Control\Class\{4d36e979-e325-11ce-bfc1-08002be10318}
call RegCopy SYSTEM\ControlSet001\Control\Class\{c30ecea0-11ef-4ef9-b02e-6af81e6e65c0}
call RegCopy SYSTEM\ControlSet001\Control\Class\{c7bc9b22-21f0-4f0d-9bb6-66c229b8cd33}

rem add services
call RegCopyEx Services Spooler

rem remove usbprint if this is additional component
call RegCopyEx Services usbprint

rem avoid error: "the printer driver is not compatible with a policy on your computer which disable NT4.0 driver"
reg add "HKLM\Tmp_Software\Policies\Microsoft\Windows NT\Printers" /v KmPrintersAreBlocked /t REG_DWORD /d 0 /f

rem register WNF_DEP_OOBE_COMPLETE notification for v1903 and later
if %VER[3]% GTR 18300 (
  reg add "HKLM\tmp_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Notifications\Data" /v 41960B29A3BC0C75 /t REG_BINARY /d 0100000001000000 /f
)

rem update spoolsv.exe binary
binmay.exe -u "%X_SYS%\spoolsv.exe" -s u:SystemSetupInProgress -r u:DisableSpoolsvInWinPE
fc /b "%X_SYS%\spoolsv.exe.org" "%X_SYS%\spoolsv.exe"
del /f /q "%X_SYS%\spoolsv.exe.org"


rem https://theoven.org/index?topic=1639.msg39755#msg39755 by noelBlanc
if "%WB_PE_ARCH%"=="x64" (
    binmay.exe -u "%X_SYS%\spoolsv.exe" -s "BA C0 D4 01 00 48" -r "BA E8 03 00 00 48"
) else (
    binmay.exe -u "%X_SYS%\spoolsv.exe" -s "68 C0 D4 01 00" -r "68 E8 03 00 00"
)
fc /b "%X_SYS%\spoolsv.exe.org" "%X_SYS%\spoolsv.exe"
del /f /q "%X_SYS%\spoolsv.exe.org"

rem EnablePrintFeature
if 1==1 (
  echo @echo off
  echo X:\windows\system32\wbem\mofcomp.exe X:\windows\system32\wbem\win32_printer.mof
  echo X:\windows\system32\wbem\mofcomp.exe X:\windows\system32\wbem\PrintManagementProvider.mof
  echo.
  echo reg add HKLM\SYSTEM\Setup /v SystemSetupInProgress /t REG_DWORD /d 0 /f
  echo net start spooler
  echo PnPutil.exe -i -a "%%Windir%%\inf\usbprint.inf"
  echo drvload.exe "%%Windir%%\inf\printqueue.inf"
)>"%X_PEMaterial%\EnablePrintFeature.bat"

call LinkToDesktop -paramlist "#{@printui.dll,12007}.lnk" "[[X:\%opt[loader.PEMaterial]%\EnablePrintFeature.bat]], '', 'shell32.dll', 16"
