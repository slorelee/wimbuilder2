call ACLRegKey Tmp_System
call ACLRegKey Tmp_Software
call ACLRegKey Tmp_Default
rem call ACLRegKey Tmp_Drivers

rem make things easy with Everyone
rem AFAIK, FDResPub service needs the right(LOCAL SERVICE), otherwise fail to start
SetACL.exe -on "HKLM\Tmp_SYSTEM" -ot reg -actn ace -ace "n:Everyone;p:full"

call RegCopy HKLM\Software\Classes\AppID
call ACLRegKey HKLM\Software\Classes\AppID

rem set "RunAs"="Interactive User" -* "RunAs"=""
echo REGEDIT4 > "%WB_TMP_PATH%\RunAsUpdateTmp.reg"
echo. >> "%WB_TMP_PATH%\RunAsUpdateTmp.reg"
for /F %%i IN ('Reg Query HKLM\Tmp_Software\Classes\AppID /s /f "Interactive User" ^|%findcmd% Tmp_Software') do (
    echo [%%i]
    echo "RunAs"=""
) >> "%WB_TMP_PATH%\RunAsUpdateTmp.reg"
reg import "%WB_TMP_PATH%\RunAsUpdateTmp.reg"

call RegCopy HKLM\Software\Classes\CLSID
call RegCopy HKLM\Software\Classes\Interface
call RegCopy HKLM\Software\Classes\TypeLib
rem //-
call RegCopy HKLM\Software\Classes\Folder
call RegCopy HKLM\Software\Classes\themefile
call RegCopy HKLM\Software\Classes\SystemFileAssociations
rem //-
call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Svchost"
call RegCopy HKLM\Software\Microsoft\SecurityManager
call RegCopy HKLM\Software\Microsoft\Ole

rem // WLAN AutoConfig
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Svchost" /v WlansvcGroup /t REG_MULTI_SZ /d wlansvc\0 /f

rem // policymanager.dll need:
call RegCopy HKLM\Software\Microsoft\PolicyManager
rem call RegCopy HKLM\Software\Classes\Unknown

rem has high cost performance to copy all DriverDatabase items,
rem just 4MB SYSTEM size(608KB compressed)
if not "x%opt[build.registry.drivers]%"=="xnotset" (
    call RegCopy SYSTEM\DriverDatabase
)

set AddDrivers_TYPE=DRIVERS

rem TODO:use the DRIVERS hive if opt[build.registry.drivers]=replace
if not "x%opt[build.registry.drivers]%"=="xnotset" (
    rem just 3MB DRIVERS size(500KB compressed)
    call RegCopy DRIVERS\DriverDatabase
    rem skip RegCopy in AddDrivers macro
    set AddDrivers_TYPE=FILE
)

if "x%opt[build.registry.system]%"=="xmerge" (
    call RegCopy SYSTEM\ControlSet001
    set REGCOPY_SKIP_SYSTEM=1
)

call "%~dp0Catalog.bat"
