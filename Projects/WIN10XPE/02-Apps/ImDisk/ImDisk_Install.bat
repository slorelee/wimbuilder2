cd /d "%windir%\Temp\imdiskinst\"

if exist "%windir%\System32\imdisk.exe" goto :IMDISK_REGUPDATE

set IMDISK_SILENT_SETUP=1
call install.cmd

if not exist "%windir%\System32\imdisk.exe" (
  echo %date% %time%:Failed to install ImDisk. >> "%RUNLOG%"
  goto :EOF
)

:IMDISK_REGUPDATE
if "%USERNAME%"=="SYSTEM" set RUNONCE=1

echo %date% %time%:ImDisk is installed. >> "%RUNLOG%"
echo %date% %time%:Update Registry for %USERNAME%. >> "%RUNLOG%"

if exist ImDisk_Settings.reg (
  reg import ImDisk_Settings.reg
)
