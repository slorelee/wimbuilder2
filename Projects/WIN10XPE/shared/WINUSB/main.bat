
rem ==========update filesystem==========
call AddDrivers winusb.inf

call AddFiles %0 :end_files
goto :end_files
@\Windows\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-Client-Desktop-Required-Package*.cat
+ver > 19500
Microsoft-OneCore-Connectivity-UsbHost-Package~*.cat
+ver >= 26100
Microsoft-OneCore-Connectivity-UsbConnectorManager-Package~*.cat
Microsoft-OneCore-Connectivity-UsbDualRole-Package~~*.cat
+ver*
\Windows\System32\winusb*
:end_files

rem ==========update registry==========
call RegCopyEx Services "WINUSB"
