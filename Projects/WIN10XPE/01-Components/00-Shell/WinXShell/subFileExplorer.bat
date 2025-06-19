if "x%opt[winxshell.fileexp.app]%"=="xnone" goto :EOF
if "x%opt[winxshell.fileexp.app]%"=="xexplorer" call AddFiles %0 :[FileExplorer_Explorer]
goto :EOF

:[FileExplorer_Explorer]
\Windows\explorer.exe
\Windows\%WB_PE_LANG%\explorer.exe.mui

@\Windows\System32\
dxgi.dll
twinapi.appcore.dll

+ver <= 19045
CoreMessaging.dll

+ver <= 22631
twinapi.dll

+ver > 22631
mscms.dll
MDMRegistration.dll
msvcp110_win.dll

goto :EOF

