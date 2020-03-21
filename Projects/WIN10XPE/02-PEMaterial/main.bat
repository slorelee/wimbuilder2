
set "PEM.Loc=%X%\PEMaterial"
if "x%opt[material.location]%"=="x_ISO_" set "PEM.Loc=%WB_ROOT%\_ISO_\PEMaterial"
if "x%opt[material.location]%"=="x_U_" set "PEM.Loc=%WB_ROOT%\_U_\PEMaterial"

set SysWOW64=SysWOW64
if "x%WB_PE_ARCH%"=="xx86" set SysWOW64=System32

call App init _Cache_
