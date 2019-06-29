rem ==========update filesystem==========

set AddFiles_Mode=merge
rem devices and printers
call AddDrivers "c_pnpprinters.inf,c_printer.inf,PrintQueue.inf,printupg.inf,usbprint.inf"

rem base drivers
call AddDrivers "ntprint4.inf,ntprint.inf,ntprint4.inf,tsprint.inf,wsdprint.inf"

call AddFiles %0 :end_files
goto :end_files

\Windows\splwow64.exe
\Windows\PrintDialog

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
;Printers
spool\tools\Microsoft Print To PDF\
spool\tools\Microsoft XPS Document Writer\

ApMon.dll,AppMon.dll,bidispl.dll,compstui.dll,DafPrintProvider.dll,defaultdevicemanager.dll,defaultprinterprovider.dll
DevDispItemProvider.dll,DeveloperOptionsSettingsHandlers.dll,deviceassociation.dll
DeviceCenter.dll,DeviceDisplayStatusManager.dll,DeviceDriverRetrievalClient.dll
DeviceEject.exe,DeviceElementSource.dll,DeviceEnroller.exe,DevicesFlowBroker.dll,DeviceMetadataRetrievalClient.dll
DevicePairing.dll,DevicePairingFolder.dll,DevicePairingProxy.dll,DevicePairingWizard.exe
deviceregistration.dll,DeviceSetupManager.dll,DeviceSetupManagerAPI.dll,DeviceSetupStatusProvider.dll
DeviceSoftwareInstallationClient.dll,DeviceUxRes.dll,devinv.dll,DevPropMgr.dll,DevQueryBroker.dll,efswrt.dll
FaxPrinterInstaller.dll,FdDevQuery.dll,fdPnp.dll,fdprint.dll,fdWNet.dll,fdWSD.dll,findnetprinters.dll
fundisc.dll,fxsapi.dll,FXSMON.dll,FXSRESM.dll,gpprnext.dll,hgprint.dll,icm32.dll,icmui.dll
inetpp.dll,inetppui.dll,IPPMon.dll,localspl.dll,localui.dll,mgmtapi.dll
newdev.exe,ntprint.dll,ntprint.exe,OpcServices.dll,pcl.sep,print.exe
PrintBrmUi.exe,PrintDialogHost.exe,PrintDialogs.dll,printfilterpipelineprxy.dll,printfilterpipelinesvc.exe
PrintIsolationHost.exe,PrintIsolationProxy.dll,printmanagement.msc,PrintPlatformConfig.dll,PrintRenderAPIHost.DLL
printui.dll,printui.exe,PrintWSDAHost.dll,prncache.dll,prnfldr.dll,prnntfy.dll,prntvpt.dll,pscript.sep
puiapi.dll,puiobj.dll,rasadhlp.dll,RepCurUser.cmd,ReSpooler.cmd,serialui.dll,spoolss.dll,spoolsv.exe,srclient.dll
srcore.dll,sysprint.sep,sysprtj.sep,tcpmon.ini,umb.dll,usbmon.dll,webservices.dll,win32spl.dll
Windows.Devices.Printers.dll,Windows.Devices.Printers.Extensions.dll
Windows.Graphics.dll,Windows.Graphics.Printing.3D.dll,Windows.Graphics.Printing.dll
Windows.Internal.Shell.Broker.dll,WLIDNSP.DLL,WlS0WndH.dll,WSDApi.dll,WSDMon.dll,wsdprintproxy.dll,WSDScanProxy.dll
XpsDocumentTargetPrint.dll,XpsFilt.dll,XpsGdiConverter.dll,XpsPrint.dll,XpsRasterService.dll,XPSServiceS.DLL,XPSSHHDR.dll
xwizard.exe,xwizards.dll,xwtpdui.dll,xwtpw32.dll
:end_files

call DoAddFiles

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

rem update spoolsv.exe binary
binmay.exe -u "%X_SYS%\spoolsv.exe" -s u:SystemSetupInProgress -r u:DisableSpoolsvInWinPE
fc /b "%X_SYS%\spoolsv.exe.org" "%X_SYS%\spoolsv.exe"
del /f /q "%X_SYS%\spoolsv.exe.org"

rem EnablePrintFeature
if 1==1 (
  echo ntprint.exe
  echo net start spooler
  echo PnPutil.exe -i -a "%%Windir%%\inf\usbprint.inf"
)>"%X_PEMaterial%\EnablePrintFeature.bat"
rem call link "%X_PEMaterial%\EnablePrintFeature.bat" "%X_Desktop%\EnablePrintFeature.lnk"
