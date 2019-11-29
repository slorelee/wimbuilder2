if "x%~1"=="x" goto :EOF

pushd "%~dp0"
call %1
goto :DONE

:BEFORE_WIM_MOUNT
rem ===================================
rem set Enviroment
rem BUILD_NUMBER
for /f "tokens=3 delims=." %%v in ("%WB_PE_VER%") do set VER[3]=%%v
rem ===================================
rem SYSTEM_PATH
rem set X=%WB_X_DRIVE%
set "X_PF=%X%\Program Files"
set X_WIN=%X%\Windows
set X_SYS=%X_WIN%\System32
set X_Desktop=%X%\Users\Default\Desktop
set "_CUSTOMFILES_=%WB_PROJECT_PATH%\_CustomFiles_"

call "%WB_PROJECT_PATH%\shared\InitLoader.bat"

call V2X -init

rem call prepare.bat before mounting
if exist "%_CUSTOMFILES_%\_Prepare_.bat" (
    pushd "%_CUSTOMFILES_%\"
    call _Prepare_.bat :BEFORE_WIM_MOUNT
    popd
)

rem ===================================
rem update options

call CheckPatch "00-Configures\x-Account"
if %errorlevel% EQU 0 (
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
if "x%HasPatch%_%opt[component.printer]%"=="xtrue_true" (
    set opt[build.registry.software]=full
    set opt[patch.drvinst]=true
)

if "x%opt[network.function_discovery]%"=="xtrue" (
    set opt[build.registry.software]=full
)
if "x%opt[build.registry.system]%"=="xtrue" (
    set opt[build.registry.system]=merge
)

rem ===================================
rem reduce the wim file before mounting it
cd /d za-Slim
call SlimWim.bat
rem ===================================
goto :EOF

:BEFORE_HIVE_LOAD

rem call prepare.bat before hive load
if exist "%_CUSTOMFILES_%\_Prepare_.bat" (
    pushd "%_CUSTOMFILES_%\"
    call _Prepare_.bat :BEFORE_HIVE_LOAD
    popd
)

if "x%opt[build.registry.software]%"=="xfull" (
    call AddFiles \Windows\System32\config\SOFTWARE
    set REGCOPY_SKIP_SOFTWARE=1
)

goto :EOF

:DONE
popd
