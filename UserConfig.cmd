
@rem inherit and share the AppData
@rem set "WB_USER_APPDATA=D:\WimBuilder2\AppData"


@rem redirect the workplace to ramdisk
@set "WB_RAMDISK_DIR=Z:\WimBuilder2"


@if "x%APP_ROOT%"=="x" (
    echo Please startup with WimBuilder.cmd.
    pause
    goto :EOF
)

:RAMDISK_WORKDIR
if not exist "%WB_RAMDISK_DIR%" goto :INIT_APPDATA
set "Factory=%WB_RAMDISK_DIR%\_Factory_"
set "ISO_DIR=%WB_RAMDISK_DIR%\_ISO_"

:DIR_LINK
if not exist "%Factory%" md "%Factory%"
if not exist "%ISO_DIR%" md "%ISO_DIR%"
if not exist _Factory_.link mklink /d _Factory_.link "%Factory%"
if not exist _ISO_.link mklink /d _ISO_.link "%ISO_DIR%"

:INIT_APPDATA
if exist "AppData.link\" (
    set APPDATA_DIR=AppData.link
    goto :END_CONFIG
)
if "x%WB_USER_APPDATA%"=="x" goto :FALLBACK_APPDATA
if exist "%WB_USER_APPDATA%" mklink /d AppData.link "%WB_USER_APPDATA%"

if exist "AppData.link\" (
    set APPDATA_DIR=AppData.link
    goto :END_CONFIG
)
echo [ERROR] Failed to make symbol link^(%WB_USER_APPDATA% --* %~dp0AppData.link^),
echo         You needs to copy the folder manually.
sleep 5
:FALLBACK_APPDATA
if not exist "%APPDATA_DIR%" (
    echo [INFO] The "%APPDATA_DIR%" folder is missing, create one with the template^(AppData.tmpl^).
    sleep 5
    xcopy /E /Y "AppData.tmpl" "AppData\"
)

:END_CONFIG
set WB_RAMDISK_DIR=
set WB_USER_APPDATA=

