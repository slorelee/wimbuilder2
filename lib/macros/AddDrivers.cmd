rem MACRO:AddDrivers
rem     call AddDrivers athw8x.inf [TYPE]
rem     call AddDrivers "netathr10x.inf,netathrx.inf" [TYPE]
rem     TYPE: FILE or REG

if "x%~1"=="x" goto :EOF
echo [MACRO]AddDrivers %*

if "x%ADDDRIVERS_INITED%"=="x" (
    del /s /a /q "%_WB_TMP_DIR%\_AddDrivers_INF.txt"
    wimlib-imagex.exe dir "%WB_SRC%" %WB_SRC_INDEX% --path=\Windows\INF\ >"%_WB_TMP_DIR%\_AddDrivers_INF.txt"
    rem for /f "usebackq delims=" %%i in ("%_WB_TMP_DIR%\_AddDrivers_INF.txt") do mkdir "%_WB_TMP_DIR%\Windows_INF\%%~nxi"
    set ADDDRIVERS_INITED=1
)

set "_AddDrivers_FILE=%~dpnx0"

set _AddDrivers_TYPE=%AddDrivers_TYPE%
if not "x%2"=="x" set _AddDrivers_TYPE=%2

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
if "x%2"=="xREG" goto :AddDriver_Reg
if "x%2"=="xDRIVERS" goto :AddDriver_Reg

rem ==========update filesystem==========
findstr /i /c:"%~1" "%_WB_TMP_DIR%\_AddDrivers_INF.txt" >nul
if not "%errorlevel%"=="0" (
    echo [INFO] Driver does not exist^(%~1^).
    goto :EOF
)
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
set _AddDriver_UserDriver=1
rem wildcard(*) check
set _AddDriver_Wildcard=0
echo "%~1"|find "*" 1>nul
if %errorlevel% EQU 0 set _AddDriver_Wildcard=1

if "x%_AddDrivers_TYPE%"=="xDRIVERS" goto :REGCOPY_FROM_DRIVERS

:REGCOPY_FROM_SYSTEM
if %_AddDriver_Wildcard% EQU 0 (
    call RegCopy "HKLM\SYSTEM\DriverDatabase\DriverInfFiles\%~1"
) else (
    call RegCopy HKLM\SYSTEM\DriverDatabase\DriverInfFiles "%~1"
)
set _AddDriver_UserDriver=%errorlevel%
call RegCopy HKLM\SYSTEM\DriverDatabase\DriverPackages "%~1*"
if %_AddDriver_UserDriver% EQU 0 goto :EOF

:REGCOPY_FROM_DRIVERS
if %_AddDriver_Wildcard% EQU 0 (
    call RegCopy "HKLM\Drivers\DriverDatabase\DriverInfFiles\%~1"
) else (
    call RegCopy HKLM\Drivers\DriverDatabase\DriverInfFiles "%~1"
)
call RegCopy HKLM\Drivers\DriverDatabase\DriverPackages "%~1*"
