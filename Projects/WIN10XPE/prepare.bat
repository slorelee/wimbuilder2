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
set X_WIN=%X%\Windows
set X_SYS=%X_WIN%\System32

rem call prepare.bat before mounting
if exist "%WB_PROJECT_PATH%\_CustomFiles_\_Prepare_.bat" (
    pushd "%WB_PROJECT_PATH%\_CustomFiles_\"
    call _Prepare_.bat :BEFORE_WIM_MOUNT
    popd
)

rem ===================================
rem update options

if "x%opt[system.admin_enabled]%"=="xtrue" (
    set opt[build.registry.software]=full
)
if "x%opt[component.netfx]%"=="xtrue" (
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
if exist "%WB_PROJECT_PATH%\_CustomFiles_\_Prepare_.bat" (
    pushd "%WB_PROJECT_PATH%\_CustomFiles_\"
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
