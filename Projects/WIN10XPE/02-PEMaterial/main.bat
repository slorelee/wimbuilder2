
set "PEM.Loc=%X%\PEMaterial"
if "x%opt[material.location]%"=="x_ISO_" set "PEM.Loc=%ISO_PATH%\PEMaterial"
if "x%opt[material.location]%"=="x_U_" set "PEM.Loc=%WB_ROOT%\_U_\PEMaterial"

if "x%opt[material.load_mode]%"=="xdemand" (
    echo.> "%X_PEMaterial%\Autoruns\PEStartup.Disabled"
    call LinkToDesktop -paramlist "%opt[_i18n.external_material]%.lnk" "[[#pProgramFiles#p\WinXShell\WinXShell.exe]], [=[-code exec#{#'/min',[[X:\%opt[loader.PEMaterial]%\Autoruns\PEStartupMain.bat]]#}#]=], 'imageres.dll', 152"
)

set SysWOW64=SysWOW64
if "x%WB_PE_ARCH%"=="xx86" set SysWOW64=System32

call :ADD_7ZIP

rem templates
if not exist "%PEM.Loc%\Installers\" mkdir "%PEM.Loc%\Installers\"
if not exist "%PEM.Loc%\PortableApps\" mkdir "%PEM.Loc%\PortableApps\"
if not exist "%PEM.Loc%\Program Files\" mkdir "%PEM.Loc%\Program Files\"

goto :EOF

:ADD_7ZIP
set "_7z_Patch=%WB_PROJECT_PATH%\02-Apps\7-Zip"
echo \033[96mApplying Patch:%_7z_Patch% | cmdcolor.exe
if not exist "%_7z_Patch%" goto :EOF
pushd "%_7z_Patch%"
call main.bat
popd
set _7z_Patch=

reg add "HKLM\tmp_DEFAULT\Environment" /v c7z /d "X:\Program Files\7-Zip\7z.exe" /f

goto :EOF
