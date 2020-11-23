goto :main
Title=Display Drivers
Description=Display Drivers
Author=ChriSR
Date=2018.09.21
Version=001

:main
rem ==========update filesystem==========

rem Display Drivers
call AddDrivers "display.inf,displayoverride.inf,c_monitor.inf,monitor.inf"

rem ==========update registry==========
rem [Reg_Display]
set DeviceIdsKey=HKLM\Tmp_Drivers\DriverDatabase\DeviceIds
call RegEx NO_VAL add %DeviceIdsKey%\{4d36e968-e325-11ce-bfc1-08002be10318} /v displayoverride.inf /t REG_NONE
call RegEx NO_VAL add %DeviceIdsKey%\{4d36e968-e325-11ce-bfc1-08002be10318} /v display.inf /t REG_NONE

reg add "%DeviceIdsKey%\ACPI\CLS_0003&SUBCLS_0000" /v display.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\ACPI\CLS_0003&SUBCLS_0001" /v display.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\ACPI\CLS_0003&SUBCLS_0003" /v display.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\CC_0300" /v display.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\CC_0301" /v display.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\VEN_1002&DEV_474D" /v displayoverride.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\VEN_1002&DEV_474F" /v displayoverride.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\VEN_1002&DEV_4752" /v displayoverride.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\VEN_102B&DEV_0522" /v displayoverride.inf /t REG_BINARY /d 01fb0000 /f
reg add "%DeviceIdsKey%\PCI\VEN_1039&DEV_6325" /v displayoverride.inf /t REG_BINARY /d 01fb0000 /f

rem [Reg_Monitor]
reg add %DeviceIdsKey%\*PNP09FF /v monitor.inf /t REG_BINARY /d 01ff0000 /f
call RegEx NO_VAL add %DeviceIdsKey%\{4d36e96e-e325-11ce-bfc1-08002be10318} /v c_monitor.inf /t REG_NONE
call RegEx NO_VAL add %DeviceIdsKey%\{4d36e96e-e325-11ce-bfc1-08002be10318} /v monitor.inf /t REG_NONE

rem // call RegCopy HKLM\Drivers\ControlSet001\Control\Class\{4d36e96e-e325-11ce-bfc1-08002be10318}
call RegCopyEx Services monitor
set DeviceIdsKey=
