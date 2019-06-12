if not exist PEMaterial goto :EOF
if not exist "%X%\Program Files\WinXShell\WinXShell.exe" goto :EOF

if exist "%X_SYS%\pecmd.exe" goto :EOF

xcopy /Y /E PEMaterial "%X%\PEMaterial\"
copy /y PEMaterial\winpeshl.ini "%X_SYS%\"
reg add HKLM\Tmp_System\Setup /v CmdLine /d "X:\Program Files\WinXShell\WinXShell.exe -regist -script X:\PEMaterial\Pecmd.lua" /f
set PE_LOADER=WinXShell

