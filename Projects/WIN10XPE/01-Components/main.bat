if "x%opt[component.DWM]%"=="xtrue" (
  call ApplyPatch ".\DWM"
)

if "x%opt[component.search]%"=="xtrue" (
  call ApplyPatch ".\Search"
)

if "x%opt[patch.drvinst]%"=="xtrue" (
  call ApplyPatch ".\Patch_drvinst"
)

goto :EOF
