if not exist "%X_WIN%\WinSxS\Catalogs\" mkdir "%X_WIN%\WinSxS\Catalogs"

call ACLRegKey Tmp_System
call ACLRegKey Tmp_Software
call ACLRegKey Tmp_Default
rem call ACLRegKey Tmp_Drivers

rem make things easy with Everyone(S-1-1-0)
rem AFAIK, FDResPub service needs the right(LOCAL SERVICE), otherwise fail to start
SetACL.exe -on "HKLM\Tmp_SYSTEM" -ot reg -actn ace -ace "n:S-1-1-0;p:full"

call RegCopy HKLM\Software\Classes\AppID
call ACLRegKey HKLM\Software\Classes\AppID

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

rem //- fix Speech path for the full SOFTWARE hive (Speech_OneCore -> Speech)
if not "x%opt[build.registry.software]%"=="xfull" goto :End_FixSpeechPath

if "%WB_PE_LANG%"=="ru-RU" set SpeechPath_FixReg=WINRE_TTS_MS_RU-RU_IRINA_11.0.reg
if "%WB_PE_LANG%"=="zh-CN" set SpeechPath_FixReg=WINRE_TTS_MS_ZH-CN_HUIHUI_11.0.reg
if "%WB_PE_LANG%"=="zh-TW" set SpeechPath_FixReg=WINRE_TTS_MS_ZH-TW_HANHAN_11.0.reg
if "%SpeechPath_FixReg%"=="" goto :End_FixSpeechPath
reg import %SpeechPath_FixReg%

:End_FixSpeechPath

rem // show right version info for 23H2 and later
call RegCopy HKLM\SYSTEM\Software\Microsoft\BuildLayers

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
