
if "x%opt[build.wow64support]%"=="xtrue" (
  call :ApplySubPatch "..\SysWOW64_Basic"
)

if "x%opt[appcompat.property_page]%"=="xtrue" (
  set opt[component.MSI]=true
)

if "x%opt[component.vcruntime]%"=="xtrue" (
  call :ApplySubPatch "..\VCRuntime"
)

if "x%opt[component.netfx]%"=="xtrue" (
  call :ApplySubPatch "..\NetFX"
)

if "x%opt[component.MSI]%"=="xtrue" (
  call :ApplySubPatch "..\MSI"
)

if "x%opt[component.opengl]%"=="xtrue" (
  call AddFiles "+syswow64#nglmf32.dll,glu32.dll,opengl32.dll"
)

if "x%opt[component.directx]%"=="xtrue" (
  call _DirectX.bat
)

if "x%opt[appcompat.property_page]%"=="xtrue" (
  call _AppCompat.bat
)

if "x%opt[system.high_compatibility]%"=="xtrue" (
  call _Compatibility.bat
)

goto :EOF


:ApplySubPatch
  echo Applying Patch: %~1\main.bat
  pushd "%~1"
  call main.bat
  popd
goto :EOF
