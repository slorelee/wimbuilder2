if not "x%opt[shell.app]%"=="xwinxshell" goto :EOF
set "_MenuEXE=%X%\Program Files\Classic Shell\ClassicStartMenu.exe"
if not exist "%_MenuEXE%" goto :EOF

rem update ClassicStartMenu.exe binary
rem binmay.exe -u "%_MenuEXE%" -s u:explorer.exe\0\0 -r u:WinXShell.exe\0
set "_UStr_explorer=65 00 78 00 70 00 6C 00 6F 00 72 00 65 00 72 00 2E 00 65 00 78 00 65 00 00 00 00 00"
set "_UStr_WinXShell=57 00 69 00 6E 00 58 00 53 00 68 00 65 00 6C 00 6C 00 2E 00 65 00 78 00 65 00 00 00"
binmay.exe -u "%_MenuEXE%" -s "%_UStr_explorer%" -r "%_UStr_WinXShell%"

fc /b "%_MenuEXE%.org" "%_MenuEXE%"
del /f /q "%_MenuEXE%.org"

binmay.exe -U "%X%\Program Files\WinXShell\WinXShell.jcfg" -s "t:\"start_icon\": \"custom\"," -r "t:\"start_icon\":  \"empty\","
