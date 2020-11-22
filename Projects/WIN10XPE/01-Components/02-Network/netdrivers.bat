rem built-in network drivers
if not "x%opt[network.builtin_drivers]%"=="xtrue" goto :EOF

set AddFiles_Mode=merge

call :NETDRIVERS_%WB_PE_ARCH%
goto :END_NETDRIVERS

:NETDRIVERS_x64
call AddDrivers "athw8x.inf,bcmwdidhdpcie.inf,mrvlpcie8897.inf"
call AddDrivers "net8185.inf,net8187bv64.inf,net8187se64.inf,net8192se64.inf,net8192su64.inf,net819xp.inf"
call AddDrivers "netathr10x.inf,netathrx.inf,netbc63a.inf,netbc64.inf,netr28ux.inf,netr28x.inf,netr7364.inf"
call AddDrivers "netrtwlane.inf,netrtwlane01.inf,netrtwlane_13.inf,netrtwlans.inf,netrtwlanu.inf"
call AddDrivers "netwbw02.inf,netwew00.inf,netwew01.inf,netwlv64.inf,netwns64.inf"
call AddDrivers "netwsw00.inf,netwtw02.inf,netwtw04.inf,netwtw06.inf,netwtw08.inf"

goto :EOF

:NETDRIVERS_x86
call AddDrivers "athw8.inf,bcmwdidhdpcie.inf,mrvlpcie8897.inf"
call AddDrivers "net8185.inf,net8187bv32.inf,net8187se86.inf,net8192se32.inf,net8192su32.inf,net819xp.inf"
call AddDrivers "netathr.inf,netathr10.inf,netbc63.inf,netbc64.inf,netr28.inf,netr28u.inf,netr73.inf"
call AddDrivers "netrtwlane.inf,netrtwlane01.inf,netrtwlane_13.inf,netrtwlans.inf,netrtwlanu.inf"
call AddDrivers "netwbn02.inf,netwen00.inf,netwen01.inf,netwlv32.inf,netwns32.inf"
call AddDrivers "netwsn00.inf,netwtn02.inf,netwtn04.inf"

goto :EOF

:END_NETDRIVERS

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
;built-in network drivers
Microsoft-Windows-Client-Drivers-drivers-Package~*.cat
Microsoft-Windows-Client-Drivers-net-Package~*.cat
Microsoft-Windows-Client-Drivers-Package~*.cat
Microsoft-Windows-Client-Drivers-Package-net~*.cat
Microsoft-Windows-Desktop-Shared-Drivers-*.cat
Microsoft-Client-Features-Classic-WOW64-*.cat
:end_files

call DoAddFiles
