rem hide the Searchbox
rem Prevent Windows 10 from restoring the taskbar search box.
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search /v OnboardSearchboxOnTaskbar /t REG_DWORD /d 2 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search /v TraySearchBoxVisible /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search /v TraySearchBoxVisibleOnAnyMonitor /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarModeCache /t REG_DWORD /d 1 /f
