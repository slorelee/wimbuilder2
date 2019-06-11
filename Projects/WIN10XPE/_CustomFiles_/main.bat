if not exist MyCustom goto :EOF

for /f %%i in ('dir /b MyCustom\*.bat') do (
  echo Applying MyCustom\%%i ...
  call MyCustom\%%i
)

if exist PEMaterial (
    xcopy /Y /E PEMaterial "%X%\PEMaterial\"
    copy /y PEMaterial\winpeshl.ini "%X_SYS%\"
    reg add HKLM\Tmp_System\Setup /v CmdLine /d "X:\Program Files\WinXShell\WinXShell.exe -regist -script X:\PEMaterial\Pecmd.lua" /f
    set PE_LOADER=WinXShell
)
