
if "x%opt[component.PPPoE]%"=="xtrue" (
  call :ApplySubPatch "..\PPPoE"
)

call _networktrayicon.bat
call full_functional.bat
call netdrivers.bat

goto :EOF

:ApplySubPatch
  echo Applying Patch: %~1\main.bat
  pushd "%~1"
  call main.bat
  popd
goto :EOF
