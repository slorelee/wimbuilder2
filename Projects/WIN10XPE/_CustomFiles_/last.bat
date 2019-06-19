if not exist PEMaterial goto :EOF
if not exist "%X%\Program Files\WinXShell\WinXShell.exe" goto :EOF

if exist "%X_SYS%\pecmd.exe" goto :EOF

copy /y "%X_PEMaterial%\winpeshl.ini" "%X_SYS%\"
del /q "%X_SYS%\wallpaperhost.exe"
reg add HKLM\Tmp_System\Setup /v CmdLine /d "X:\Program Files\WinXShell\WinXShell.exe -regist -script %X_PEMaterial%\Pecmd.lua" /f
set PE_LOADER=WinXShell

