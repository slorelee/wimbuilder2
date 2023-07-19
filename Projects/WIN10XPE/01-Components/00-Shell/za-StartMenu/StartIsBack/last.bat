rem incompatible with StartIsBack(SYSTEM account)
del /q "%X_SYS%\windows.immersiveshell.serviceprovider.dll"

rem // hide useless contextmenu
reg add "HKLM\Tmp_DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f 
reg add "HKLM\Tmp_DEFAULT\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f 
