if not "x%opt[shell.app]%"=="xwinxshell" goto :EOF

if "x%opt[shell.light_theme]%"=="xtrue" (
  if "x%WB_PE_LANG%"=="xzh-CN" (
    binmay.exe -U "%X%\Program Files\WinXShell\WinXShell.jcfg" -s "22 3A 3A E4B8BB E9A298 22 3A 20 20226461726B22 2C" -r "22 3A 3A E4B8BB E9A298 22 3A 20 226c6967687422 2C"
  ) else (
    binmay.exe -U "%X%\Program Files\WinXShell\WinXShell.jcfg" -s "t:\"theme\":  \"dark\"," -r "t:\"theme\": \"light\","
  )
)

set "_MenuEXE=%X%\Program Files\Classic Shell\ClassicStartMenu.exe"
if not exist "%_MenuEXE%" goto :EOF

rem update ClassicStartMenu.exe binary
rem binmay.exe -u "%_MenuEXE%" -s u:explorer.exe\0\0 -r u:WinXShell.exe\0
set "_UStr_explorer=65 00 78 00 70 00 6C 00 6F 00 72 00 65 00 72 00 2E 00 65 00 78 00 65 00 00 00 00 00"
set "_UStr_WinXShell=57 00 69 00 6E 00 58 00 53 00 68 00 65 00 6C 00 6C 00 2E 00 65 00 78 00 65 00 00 00"
binmay.exe -u "%_MenuEXE%" -s "%_UStr_explorer%" -r "%_UStr_WinXShell%"

fc /b "%_MenuEXE%.org" "%_MenuEXE%"
del /f /q "%_MenuEXE%.org"

if "x%WB_PE_LANG%"=="xzh-CN" (
  binmay.exe -U "%X%\Program Files\WinXShell\WinXShell.jcfg" -s "223A3A E5BC80 E5A78B E68C89 E992AE 22 3A 20 22 7468656D65 22 2C" -r "223A3A E5BC80 E5A78B E68C89 E992AE 22 3A 20 22 656D707479 22 2C"
) else (
  binmay.exe -U "%X%\Program Files\WinXShell\WinXShell.jcfg" -s "t:\"start_icon\": \"theme\"," -r "t:\"start_icon\": \"empty\","
)

