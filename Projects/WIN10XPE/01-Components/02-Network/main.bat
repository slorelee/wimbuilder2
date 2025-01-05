
rem // For Samba Servers
call :PolicyLmCompatLevel

if "x%opt[component.PPPoE]%"=="xtrue" (
  call ApplyPatch "..\PPPoE" main.bat
)

if not exist "%X_SYS%\wlanapi.dll" (
  call ApplyPatch "..\00-Boot2WinRE" _WinPE-WiFi-Package.bat
)

if "x%opt[build.registry.software]%"=="xfull" (
  reg add "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\Capabilities\wlanLocationBypass" /v RequireWindowsCert /t REG_DWORD /d 0 /f
)

call _networktrayicon.bat
call full_functional.bat
call netdrivers.bat

goto :EOF

:PolicyLmCompatLevel
if "x%opt[policy.lmcompatlevel]%"=="x-" set opt[policy.lmcompatlevel]=
if "x%opt[policy.lmcompatlevel]%"=="x" goto :EOF
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LmCompatibilityLevel /t REG_DWORD /d %opt[policy.lmcompatlevel]% /f
goto :EOF
