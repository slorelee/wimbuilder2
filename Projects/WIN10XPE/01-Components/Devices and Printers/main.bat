if "x%opt[component.dsmsvc]%"=="xtrue" (
    call _dsmsvc.bat
)

if "x%opt[component.printer]%"=="xtrue" (
    call _printer.bat
)

if "x%opt[component.bluetooth]%"=="xtrue" (
    call _bluetooth.bat
)

if "x%opt[component.camera]%"=="xtrue" (
    call _camera.bat
)

