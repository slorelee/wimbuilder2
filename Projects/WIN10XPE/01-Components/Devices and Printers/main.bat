if "x%opt[component.bluetooth]%"=="xtrue" (
    set opt[component.MTP]=true
    set opt[component.printer]=true
)

if "x%opt[component.camera]%"=="xtrue" set opt[component.MTP]=true


if "x%opt[component.dsmsvc]%"=="xtrue" (
    call _dsmsvc.bat
)

if "x%opt[component.MTP]%"=="xtrue" (
    call ApplyPatch "..\MTP_Support"
)

if "x%opt[component.RNDIS]%"=="xtrue" (
    call ApplyPatch "..\RNDIS"
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


goto :EOF
