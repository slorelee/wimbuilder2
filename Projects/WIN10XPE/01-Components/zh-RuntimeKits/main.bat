
if "x%opt[build.wow64support]%"=="xtrue" (
  call ApplyPatch "..\SysWOW64_Basic"
)

if "x%opt[wow64.speech_api]%"=="xtrue" (
  call _SysWOW64_SAPI.bat
)

if "x%opt[appcompat.property_page]%"=="xtrue" (
  set opt[component.MSI]=true
)

if "x%opt[component.vcruntime]%"=="xtrue" (
  call ApplyPatch "..\VCRuntime"
)

if "x%opt[component.netfx]%"=="xtrue" (
  call ApplyPatch "..\NetFX"
)

if "x%opt[component.MSI]%"=="xtrue" (
  call ApplyPatch "..\MSI"
)

if "x%opt[component.opengl]%"=="xtrue" (
  call AddFiles "+syswow64#nglmf32.dll,glu32.dll,opengl32.dll"
)

if "x%opt[component.directx]%"=="xtrue" (
  call _DirectX.bat
)

if "x%opt[component.speech_onecore]%"=="xtrue" (
  call _Speech_OneCore.bat
)

if "x%opt[appcompat.property_page]%"=="xtrue" (
  call _AppCompat.bat
)

if "x%opt[system.high_compatibility]%"=="xtrue" (
  call _Compatibility.bat
)

goto :EOF
