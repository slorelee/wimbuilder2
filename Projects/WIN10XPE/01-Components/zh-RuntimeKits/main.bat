
if "x%opt[build.wow64support]%"=="xtrue" (
  call :ApplySubPatch "..\SysWOW64_Basic"
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
  call AddFiles %0 :[OpenGL_Files]
)

if "x%opt[component.directx]%"=="xtrue" (
  call _DirectX.bat
)

goto :EOF


:[OpenGL_Files]
@\Windows\System32\
+syswow64
glmf32.dll,glu32.dll,opengl32.dll
goto :EOF


:ApplySubPatch
  echo Applying Patch: %~1\main.bat
  pushd "%~1"
  call main.bat
  popd
goto :EOF
