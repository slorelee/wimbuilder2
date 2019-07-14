call _dsmsvc.bat

if "x%opt[component.printer]%"=="xtrue" (
    call _printer.bat
)
