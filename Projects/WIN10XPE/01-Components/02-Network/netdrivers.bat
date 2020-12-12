rem built-in network drivers
if not "x%opt[network.builtin_drivers]%"=="xtrue" goto :EOF

set _NETDRIVERS_FILE=netdrivers_default.txt
if "%opt[network.type_builtin_drivers]%"=="custom" set "_NETDRIVERS_FILE=%WB_USER_PROJECT_PATH%\netdrivers_custom.txt"
if not exist "%_NETDRIVERS_FILE%" (
    echo [ERROR] File does not exist^(%_NETDRIVERS_FILE%^).
    set _NETDRIVERS_FILE=
    goto :EOF
)

echo [INFO] Add Network Drivers with %_NETDRIVERS_FILE%.
set AddFiles_Mode=merge

set _ADD_NETDRIVERS_START=0

for /f "usebackq eol=; delims=" %%i in ("%_NETDRIVERS_FILE%") do (
    call :ADDNETDRIVERS "%%i"
)
set _ADD_NETDRIVERS_START=
set _NETDRIVERS_FILE=

goto :END_NETDRIVERS

:ADDNETDRIVERS
if "%~1"==":NETDRIVERS_%WB_PE_ARCH%" set _ADD_NETDRIVERS_START=1&&goto :EOF
if "%~1"==":END_NETDRIVERS_%WB_PE_ARCH%" set _ADD_NETDRIVERS_START=0&&goto :EOF
if "%_ADD_NETDRIVERS_START%"=="0" goto :EOF

call AddDrivers "%~1"
goto :EOF


:END_NETDRIVERS

rem digitally-signed catalog files (.cat) for network drivers
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
