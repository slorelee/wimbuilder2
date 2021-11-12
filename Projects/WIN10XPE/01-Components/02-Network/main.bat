
rem // For Samba Servers
call :PolicyLmCompatLevel

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


:PolicyLmCompatLevel
if "x%opt[policy.lmcompatlevel]%"=="x-" set opt[policy.lmcompatlevel]=
if "x%opt[policy.lmcompatlevel]%"=="x" goto :EOF
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LmCompatibilityLevel /t REG_DWORD /d %opt[policy.lmcompatlevel]% /f
goto :EOF
