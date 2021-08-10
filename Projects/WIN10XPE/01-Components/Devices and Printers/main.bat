if "x%opt[component.dsmsvc]%"=="xtrue" (
    call _dsmsvc.bat
)

if "x%opt[component.MTP]%"=="xtrue" (
    call :ApplySubPatch "..\MTP_Support"
)

if "x%opt[component.RNDIS]%"=="xtrue" (
    call :ApplySubPatch "..\RNDIS"
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

:ApplySubPatch
echo Applying Patch: %~1\main.bat
pushd "%~1"
call main.bat
popd
goto :EOF