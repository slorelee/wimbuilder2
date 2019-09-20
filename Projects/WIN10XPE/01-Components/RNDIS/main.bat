
rem ==========update file system==========
set AddFiles_Mode=merge

call SharedPatch WINUSB

call AddFiles %0 :end_files
goto :end_files
@\Windows\System32\drivers\
RNDISMP.sys,usb8023.sys

@\Windows\System32\DriverStore\%WB_PE_LANG%
netrndis.inf_loc,rndiscmp.inf_loc
:end_files

call AddDrivers "netrndis.inf,rndiscmp.inf"

call DoAddFiles
