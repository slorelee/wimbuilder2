rem Coverted from noel's bluetooth.ps1

call AddFiles %0 :end_files
goto :end_files
@\Windows\System32\
drivers\Microsoft.Bluetooth.AvrcpTransport.sys
drivers\Microsoft.Bluetooth.Legacy.LEEnumerator.sys
Bthprops\
Bluetooth*.*
BTAGService.dll
BTH*.*
btpanui.dll
btwdi.dll
BWContextHandler.dll
dafBth.dll
fdBth.dll
fdProxy.dll
fsquirt.exe
Microsoft.Bluetooth*.*
Windows.Internal.Bluetooth.dll
Windows.Devices.Radios.dll
WlanRadioManager.dll
WwanRadioManager.dll
DevicePairingFolder.dll
deviceaccess.dll
DeviceMetadataRetrievalClient.dll
dxp.dll
dlnashext.dll
DevDispItemProvider.dll
playto*.dll
;Services\DeviceAssociationService
das*.*
daf*.*

WSDApi.dll

wshbth.dll

;Need depends of devices
;
UserDataPlatformHelperUtil.dll
UserDataTypeHelperUtil.dll
QuickActionsDataModel.dll

;for phone
CallHistoryClient.dll
PhoneOM.dll
Phoneutil.dll
PhoneutilRes.dll
pimstore.dll
;for bth-scan.exe
irprops.cpl
drivers\bth*.sys
drivers\rfcomm.sys

+ver >= 22000
WppRecorderUM.dll
Windows.Internal.Devices.Bluetooth.dll
MSAJApi.dll
Windows.Devices.Bluetooth.dll

+ver > 20000
@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-Desktop-Shared-Drivers-merged-Package*.cat
Microsoft-OneCore-Bluetooth-Package~*.cat

:end_files

call RegCopy "HKLM\Software\Microsoft\Device Association Framework"

call RegCopyEx Services "bthserv,DeviceAssociationService" 

rem ; 4 services importants with data for bth : microphone (handfree) use winsock, speaker use other protocol
call RegCopyEx Services "RFCOMM,SWENUM,WinSock,WinSock2"

call RegCopyEx Services "DeviceAssociationBrokerSvc,BluetoothUserService,BTAGservice,BthAvctpSvc"

call RegCopy "HKLM\SYSTEM\ControlSet001\Control\Bluetooth"
call RegCopy "HKLM\SYSTEM\ControlSet001\Control\mediaCategories"
call RegCopy "HKLM\SYSTEM\ControlSet001\Control\mediaInterfaces"

:AddBTHDrivers
set ms_bth=microsoft_bluetooth
call AddDrivers "BtaMpm.inf,bth.inf,BthLCPen.inf,bthleenum.inf,bthmtpenum.inf,BthOob.inf,bthpan.inf,bthprint.inf,bthspp.inf"
call AddDrivers "hidbth.inf,hidbthle.inf,hidvhf.inf,mdmbtmdm,mshidkmdf.inf,mshidumdf.inf,tdibth.inf,umpass.inf,xinputhid.inf"
call AddDrivers "%ms_bth%_a2dp.inf,%ms_bth%_a2dp_src.inf,%ms_bth%_avrcptransport.inf"
call AddDrivers "%ms_bth%_hfp.inf,%ms_bth%_hfp_ag.inf,%ms_bth%_hfp_hf.inf"
set ms_bth=

call RegCopy "HKLM\SYSTEM\ControlSet001\Control\DevQuery"
