call _dsmsvc.bat

if "x%opt[component.printer]%"=="xtrue" (
    call _printer.bat
)

if "x%opt[component.bluetooth]%"=="xtrue" (
    call _bluetooth.bat
)

