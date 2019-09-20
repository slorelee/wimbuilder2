if "x%opt[component.taskmgr]%"=="xtrue" (
  call AddFiles \Windows\System32\taskmgr.exe
)

if "x%opt[component.bitlocker]%"=="xtrue" (
  call :ApplySubPatch ".\BitLocker"
)

if "x%opt[component.DWM]%"=="xtrue" (
  call :ApplySubPatch ".\DWM"
)

if "x%opt[component.MMC]%"=="xtrue" (
  call :ApplySubPatch ".\MMC"
)

if "x%opt[component.MTP]%"=="xtrue" (
  call :ApplySubPatch ".\MTP_Support"
)

if "x%opt[component.search]%"=="xtrue" (
  call :ApplySubPatch ".\Search"
)

if "x%opt[component.vcruntime]%"=="xtrue" (
  call :ApplySubPatch ".\VCRuntime"
)

if "x%opt[component.netfx]%"=="xtrue" (
  call :ApplySubPatch ".\NetFX"
)

if "x%opt[component.MSI]%"=="xtrue" (
  call :ApplySubPatch ".\MSI"
)

if "x%opt[patch.drvinst]%"=="xtrue" (
  call :ApplySubPatch ".\Patch_drvinst"
)

goto :EOF

:ApplySubPatch
  echo Applying Patch:%~1\main.bat
  pushd "%~1"
  call main.bat
  popd
goto :EOF