rem Battery icon should be optional, skip now

call AddFiles %0 :end_files
goto :end_files

; Computer Management shortcut
; write menu command in registry directly
; \ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Computer Management.lnk

; Battery icon - In Winre.wim inf: hidbatt.inf,cmbatt.inf - drivers: battc.sys,HidBatt.sys,CmBatt.sys - system32: umpo.dll,umpnpmgr.dll
\Windows\INF\battery.inf
\Windows\INF\c_battery.inf
\Windows\System32\batmeter.dll

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
+if "x%opt[shell.app]%"<>"xwinxshell"
+ver >= 17763
Microsoft-Windows-Client-Desktop-Required-Package*.cat
Microsoft-Windows-Client-Desktop-Required-WOW64-Package*.cat
+ver*
Microsoft-Windows-Client-Features-Package*.cat
Microsoft-Windows-Client-Features-WOW64-Package*.cat
-if

@\Windows\System32\

;in winre.wim
mlang.dat,mlang.dll
ieframe.dll

; resources for Computer Management
mycomput.dll

; resources for This PC's Properties
systemcpl.dll

; resources for desktop background contextmenu
Display.dll
themecpl.dll

; Microsoft FTP Folder
msieftp.dll,shdocvw.dll

; Add Network Location
shwebsvc.dll

; Create Shortcut Wizard
;AppWiz.cpl
;%WB_PE_LANG%\AppWiz.cpl.mui
;osbaseln.dll

; Details default folderview layout
windows.storage.dll

; Resolution settings for 24h2
+ver >= 26100
DispBroker.Desktop.dll
Windows.Graphics.dll

; remove ver check (add with any ver)
+ver*

; system tray icons stuck issue for 2025.08 update latter
+if "%VER_202508_LATER%"="1"
CapabilityAccessManager.Desktop.Storage.dll
gamemode.dll
-if

:end_files

call RegCopy /-s "HKLM\SOFTWARE\Classes\*"

rem Computer Management Command
reg add HKLM\Tmp_Software\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\Manage\command /ve /d "mmc.exe compmgmt.msc /s" /f

rem fix blank shortcut icons
reg add HKLM\Tmp_Software\Policies\Microsoft\Windows\Explorer /v EnableShellShortcutIconRemotePath /t REG_DWORD /d 1 /f

rem Display, Personalize
if not "x%opt[build.registry.software]%"=="xfull" (
    call RegCopy HKLM\SOFTWARE\Classes\DesktopBackground\Shell
)

reg import Shell_RegDefault.reg
reg import Shell_RegSoftware.reg

pushd Explorer
call submain.bat
popd

pushd WinXShell
call submain.bat
popd

