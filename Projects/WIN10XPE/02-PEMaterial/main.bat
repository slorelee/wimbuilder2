@echo on
set "PEM.Loc=%X%\PEMaterial"
if "x%opt[material.location]%"=="x_ISO_" set "PEM.Loc=%WB_ROOT%\_ISO_\PEMaterial"
if "x%opt[material.location]%"=="x_U_" set "PEM.Loc=%WB_ROOT%\_U_\PEMaterial"

if "x%opt[material.load_mode]%"=="xdemand" (
    echo.> "%X_PEMaterial%\Autoruns\PEStartup.Disabled"
    call LinkToDesktop -paramlist "%opt[_i18n.external_material]%.lnk" "[[#pProgramFiles#p\WinXShell\WinXShell.exe]], [=[-code exec#{#'/min',[[X:\%opt[loader.PEMaterial]%\Autoruns\PEStartupMain.bat]]#}#]=], 'imageres.dll', 152"
)

set SysWOW64=SysWOW64
if "x%WB_PE_ARCH%"=="xx86" set SysWOW64=System32

reg add "HKLM\tmp_DEFAULT\Environment" /v c7z /d "X:\Program Files\7-Zip\7z.exe" /f

call App init _Cache_

rem templates
if not exist "%PEM.Loc%\Installers\" mkdir "%PEM.Loc%\Installers\"
if not exist "%PEM.Loc%\PortableApps\" mkdir "%PEM.Loc%\PortableApps\"
if not exist "%PEM.Loc%\Program Files\" mkdir "%PEM.Loc%\Program Files\"
