rem Battery icon should be optional, skip now

call AddFiles %0 :end_files
goto :end_files

; Battery icon should be optional, skip now
+ver < 0
; Battery icon - In Winre.wim inf: hidbatt.inf,cmbatt.inf - drivers: battc.sys,HidBatt.sys,CmBatt.sys - system32: umpo.dll,umpnpmgr.dll

\Windows\INF\battery.inf
\Windows\INF\c_battery.inf
@\Windows\System32\
batmeter.dll
+ver*

@\Windows\System32\

; resources for desktop background contextmenu
Display.dll
themecpl.dll

:end_files

call X2X
call Explorer\submain.bat
call WinXShell\submain.bat
