call V2X ImDisk -extract "imdiskinst_*.exe" "%X_WIN%\Temp\imdiskinst\"
if exist ImDisk_Settings.%WB_PE_LANG%.reg (
  copy /y ImDisk_Settings.%WB_PE_LANG%.reg "%X_WIN%\Temp\imdiskinst\ImDisk_Settings.reg"
)

copy /y ImDisk_Install.bat "%X_Startup%\BeforeShell\"

if not "x%opt[imdisk.ramdisk]%"=="xtrue" goto :EOF
(
  echo imdisk.exe -a -t vm -s %opt[imdisk.disk_size]%M -m %opt[imdisk.drive_letter]% -p "/fs:ntfs /v:RamDisk /q /c /y"
) >> "%X_Startup%\BeforeShell\ImDisk_Install.bat"
