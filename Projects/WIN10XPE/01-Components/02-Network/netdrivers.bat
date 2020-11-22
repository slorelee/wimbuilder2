rem built-in network drivers
if not "x%opt[network.builtin_drivers]%"=="xtrue" goto :EOF

set AddFiles_Mode=merge

if "%WB_PE_ARCH%"=="x64" (
  call AddDrivers "athw8x.inf,netathr10x.inf,netathrx.inf,netbc63a.inf"
  call AddDrivers "netwbw02.inf,netwew00.inf,netwew01.inf,netwlv64.inf,netwns64.inf,netwsw00.inf,netwtw04.inf"
) else (
  call AddDrivers "athw8.inf,netathr.inf,netathr10.inf,netbc63.inf"
  call AddDrivers "netwbn02.inf,netwen00.inf,netwen01.inf,netwlv32.inf,netwns32.inf,netwsn00.inf,netwtn04.inf"
)
call AddDrivers "netbc64.inf,netrtwlane.inf,netrtwlane_13.inf,netrtwlanu.inf"

if %VER[3]% LEQ 17700 goto :END_NETDRIVERS

if "%WB_PE_ARCH%"=="x64" (
  call AddDrivers "netwtw02,netwtn06.inf"
) else (
  call AddDrivers netwtn02.inf
)

:END_NETDRIVERS
call DoAddFiles
