
rem ==========update file system==========
set AddFiles_Mode=merge

call SharedPatch WINUSB

set _regdriver_done=
reg query HKLM\Tmp_DRIVERS\DriverDatabase\DriverInfFiles\netrndis.inf 1>nul 2>nul
if %errorlevel% EQU 0 set _regdriver_done=1

call AddFiles %0 :end_files
goto :end_files
@\Windows\System32\drivers\
RNDISMP.sys,usb8023.sys

@\Windows\System32\DriverStore\%WB_PE_LANG%
netrndis.inf_loc,rndiscmp.inf_loc
:end_files

call AddDrivers "netrndis.inf,rndiscmp.inf"

rem some devices need
call AddDrivers wceisvista.inf

call DoAddFiles


if "x%_regdriver_done%"=="x" (
    rem add DriverDatabase\DeviceIds
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\{4d36e972-e325-11ce-bfc1-08002be10318}
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\ms_rndisusb
    call RegCopy HKLM\Drivers\DriverDatabase\DeviceIds\ms_rndisusb6
    call RegCopy "HKLM\Drivers\DriverDatabase\DeviceIds\USB\Class_EF&SubClass_04&Prot_01"
    call RegCopy "HKLM\Drivers\DriverDatabase\DeviceIds\USB\MS_COMP_RNDIS&MS_SUBCOMP_5162001"
)
set _regdriver_done=
