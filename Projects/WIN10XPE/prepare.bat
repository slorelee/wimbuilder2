rem ===================================
if "x%opt[build.cmd_mode]%"=="xtrue" (
    rem dummy line - DON'T DELETE THIS LINE
    %opt[build.cmd_mode_code]%
)

rem ===================================
rem set Enviroment
rem BUILD_NUMBER
for /f "tokens=3 delims=." %%v in ("%WB_PE_VER%") do set VER[3]=%%v
set VER[4]=%WB_PE_BUILD%
set VER[3.4]=%VER[3]%.%VER[4]%
rem ===================================
rem SYSTEM_PATH
rem set X=%WB_X_DRIVE%
set "X_PF=%X%\Program Files"
set X_WIN=%X%\Windows
set X_SYS=%X_WIN%\System32
set X_WOW64=%X_WIN%\SysWOW64
set X_Desktop=%X%\Users\Default\Desktop
set "_CUSTOMFILES_=%WB_PROJECT_PATH%\_CustomFiles_"

set "WB_USER_PROJECT_PATH=%WB_ROOT%\%APPDATA_DIR%\Projects\%WB_PROJECT%"
set "_USER_CUSTOMFILES_=%WB_USER_PROJECT_PATH%\_CustomFiles_"

call "%WB_PROJECT_PATH%\shared\InitLoader.bat"

call V2X -init
call App init _Cache_
set "WINXSHELL=%V_APP%\WinXShell\X_PF\WinXShell\WinXShell_%WB_ARCH%.exe"

echo.
call "%WB_PROJECT_PATH%\shared\CheckUserFiles.bat"

rem ===================================
echo .
echo Update options

call CheckPatch "00-Configures\x-Account"
if "x%HasPatch%"=="xfalse" (
    set opt[account.admin_enabled]=false
)

call CheckPatch "01-Components\02-Network"
set opt[support.network]=%HasPatch%
if "%opt[support.network]%"=="false" (
    set opt[network.function_discovery]=false
)

if "x%opt[account.admin_enabled]%"=="xtrue" (
    set opt[support.admin]=true
)
if "x%opt[component.netfx]%"=="xtrue" (
    set opt[build.registry.software]=full
)

call CheckPatch "01-Components\Devices and Printers"
if "x%HasPatch%_%opt[component.bluetooth]%"=="xtrue_true" (
    set opt[component.MTP]=true
    set opt[component.printer]=true
)

if "x%HasPatch%_%opt[component.printer]%"=="xtrue_true" (
    set opt[build.registry.software]=full
    set opt[patch.drvinst]=true
)

if "x%opt[build.registry.system]%"=="xtrue" (
    set opt[build.registry.system]=merge
)

if %VER[3]% GTR 21000 (
    echo [INFO] Update StartIsBack version for 21H2
    set opt[SIB.version]=02.09.08
    set opt[SIB.version]
)
call CheckPatch "01-Components\Windows Media Player"
if "x%HasPatch%"=="xtrue" (
    echo [INFO] Adapt StartIsBack for Windows Media Player
    set opt[SIB.version]=02.09.00
    set opt[SIB.version]
)

rem ===================================
rem reduce the wim file before mounting it
cd /d za-Slim
call SlimWim.bat
rem ===================================
