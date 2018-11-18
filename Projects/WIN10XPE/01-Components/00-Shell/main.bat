rem Battery icon should be optional, skip now
goto :end_files
call AddFiles %0 :end_files
goto :end_files
; Battery icon - In Winre.wim inf: hidbatt.inf,cmbatt.inf - drivers: battc.sys,HidBatt.sys,CmBatt.sys - system32: umpo.dll,umpnpmgr.dll

\Windows\INF\battery.inf
\Windows\INF\c_battery.inf
\Windows\System32\batmeter.dll
\Windows\System32\??-??\batmeter.dll.mui

:end_files

call Explorer\submain.bat
call WinXShell\submain.bat
