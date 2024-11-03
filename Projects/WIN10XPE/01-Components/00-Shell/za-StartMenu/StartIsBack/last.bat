if "x%opt[shell.startmenu]%"=="xStartAllBack" (
  goto :update_registry
)

rem incompatible with StartIsBack(SYSTEM account)
if not exist "%X_SYS%\tsdiscon.exe" (
  del /q "%X_SYS%\windows.immersiveshell.serviceprovider.dll"
)

:update_registry
rem // hide useless contextmenu
reg add "HKLM\Tmp_DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f 
reg add "HKLM\Tmp_DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f 
