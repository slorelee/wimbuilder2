if exist "%WinDir%\System32\netprofmsvc.dll" (
  sc config netprofm start= demand
  rem reg add HKLM\SYSTEM\ControlSet001\Services\netprofm /v Start /t REG_DWORD /d 2 /f
  reg add HKLM\SYSTEM\Setup /v SystemSetupInProgress /t REG_DWORD /d 0 /f
  Net Start netprofm
  reg add HKLM\SYSTEM\Setup /v SystemSetupInProgress /t REG_DWORD /d 1 /f
)
