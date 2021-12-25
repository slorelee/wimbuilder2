rem MACRO:AddDrivers
rem     call AddDrivers athw8x.inf [TYPE] [REGKEY]
rem     call AddDrivers "netathr10x.inf,netathrx.inf" [TYPE] [REGKEY]
rem     TYPE: FILE or REG
rem     REGKEY: DRIVERS or other

if "x%~1"=="x" goto :EOF
echo [MACRO]AddDrivers %*

if "x%ADDDRIVERS_INITED%"=="x" (
    del /s /a /q "%WB_TMP_PATH%\_AddDrivers_INF.txt"
    wimlib-imagex.exe dir "%WB_SRC%" %WB_SRC_INDEX% --path=\Windows\INF\ >"%WB_TMP_PATH%\_AddDrivers_INF.txt"
    rem for /f "usebackq delims=" %%i in ("%WB_TMP_PATH%\_AddDrivers_INF.txt") do mkdir "%WB_TMP_PATH%\Windows_INF\%%~nxi"
    set ADDDRIVERS_INITED=1
)

set "_AddDrivers_FILE=%~dpnx0"

set _AddDrivers_TYPE=%AddDrivers_TYPE%
if not "x%2"=="x" set _AddDrivers_TYPE=%2

set _AddDrivers_REGKEY=DRIVERS
if not "x%3"=="x" set _AddDrivers_REGKEY=%3

rem * can't be in for (set)
rem for %%f in (%~1) do call :AddDriver %%f %2
call :AddDriver_SHIFT %~1
set _AddDrivers_TYPE=
set _AddDrivers_FILE=
goto :EOF

:AddDriver_SHIFT
:SHIFT_LOOP
if "x%~1"=="x" goto :EOF
call :AddDriver "%~1" %_AddDrivers_TYPE%
SHIFT
goto :SHIFT_LOOP
goto :EOF

:AddDriver

rem wildcard(*) check
set _AddDriver_Wildcard=0
echo "%~1"|find "*" 1>nul
if %errorlevel% EQU 0 set _AddDriver_Wildcard=1

if "x%2"=="xREG" goto :AddDriver_Reg

rem ==========update filesystem==========
if %_AddDriver_Wildcard% EQU 1 goto :END_INF_CHECK
if "x%findcmd%"=="xfindstr" (
    findstr /i /c:"%~1" "%WB_TMP_PATH%\_AddDrivers_INF.txt" >nul
) else (
    find /i "%~1" "%WB_TMP_PATH%\_AddDrivers_INF.txt" >nul
)
if not "%errorlevel%"=="0" (
    echo [INFO] Driver does not exist^(%~1^).
    goto :EOF
)
:END_INF_CHECK

set "_AddDriver_INF=%~1"
set "_AddDriver_Name=%~n1"
call AddFiles "%_AddDrivers_FILE%" :end_files
goto :end_files
windows\INF\%_AddDriver_INF%
\Windows\System32\drivers\%_AddDriver_Name%.sys
\Windows\System32\DriverStore\FileRepository\%_AddDriver_INF%*
\Windows\System32\DriverStore\%WB_PE_LANG%\%_AddDriver_INF%_loc
:end_files
set _AddDriver_INF=
set _AddDriver_Name=
if "x%2"=="xFILE" goto :EOF

:AddDriver_Reg
rem ==========update registry==========
if "x%_AddDrivers_REGKEY%"=="xDRIVERS" goto :REGCOPY_FROM_DRIVERS

:REGCOPY_FROM_SYSTEM
set _AddDriver_UserDriver=1
call :REGCOPY_DRIVERDATABASE SYSTEM "%~1"
set _AddDriver_UserDriver=%errorlevel%
if %_AddDriver_UserDriver% EQU 0 goto :EOF

:REGCOPY_FROM_DRIVERS
call :REGCOPY_DRIVERDATABASE DRIVERS "%~1"
goto :EOF

:REGCOPY_DRIVERDATABASE
if %_AddDriver_Wildcard% EQU 1 (
    call RegCopy HKLM\%1\DriverDatabase\DriverInfFiles "%~2"
    call RegCopy HKLM\%1\DriverDatabase\DriverPackages "%~2*"
    goto :EOF
)

set _AddDriver_INFHASH=
for /f "tokens=3" %%i in ('reg query HKLM\Src_Drivers\DriverDatabase\DriverInfFiles\%~2 /ve') do set _AddDriver_INFHASH=%%i
if "x%_AddDriver_INFHASH%"=="x" (
    echo [ERROR] Regkey does not exist^(HKLM\%1\DriverDatabase\DriverInfFiles\%~2^).
    errno 1
    goto :EOF
)
call RegCopy "HKLM\%1\DriverDatabase\DriverInfFiles\%~2"
call RegCopy "HKLM\%1\DriverDatabase\DriverPackages\%_AddDriver_INFHASH%"
set _AddDriver_INFHASH=
