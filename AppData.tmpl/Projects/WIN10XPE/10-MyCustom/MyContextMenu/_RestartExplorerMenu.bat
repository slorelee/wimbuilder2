if not "x%opt[custom.restart_explorer_menu]%"=="xtrue" goto :EOF

reg add HKLM\Tmp_Software\Classes\Directory\background\shell\restartshell /ve /d "%opt[custom.restart_explorer_item]%" /f
reg add HKLM\Tmp_Software\Classes\Directory\background\shell\restartshell\command /ve /d "WinXShell.exe -code CloseShellWindow()" /f
