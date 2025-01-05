if "x%opt[component.taskmgr]%"=="xtrue" (
  call AddFiles "pdh.dll,d3d12.dll,TaskManagerDataLayer.dll,taskmgr.exe"
)

if "x%opt[component.bitlocker]%"=="xtrue" (
  call ApplyPatch ".\BitLocker"
)

if "x%opt[component.DWM]%"=="xtrue" (
  call ApplyPatch ".\DWM"
)

if "x%opt[component.MMC]%"=="xtrue" (
  call ApplyPatch ".\MMC"
)

if "x%opt[component.search]%"=="xtrue" (
  call ApplyPatch ".\Search"
)

if "x%opt[patch.drvinst]%"=="xtrue" (
  call ApplyPatch ".\Patch_drvinst"
)

goto :EOF
