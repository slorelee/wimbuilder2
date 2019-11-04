call V2X ImDisk -extract "imdiskinst_*.exe" "%X_WIN%\Temp\imdiskinst\"
if exist ImDisk_Settings.%WB_PE_LANG%.reg (
  copy /y ImDisk_Settings.%WB_PE_LANG%.reg "%X_WIN%\Temp\imdiskinst\ImDisk_Settings.reg"
)

copy /y ImDisk_Install.bat "%X_Startup%\BeforeShell\"
