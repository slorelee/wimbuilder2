rem ==========update filesystem==========
rem Explorer BitLocker integration

rem full feature
rem call AddFiles "@\Windows\System32\#nbde*.exe,fve*.exe,bde*.dll,fve*.dll,BitLocker*.*,EhStor*.*"

call AddFiles "@\Windows\System32\#nbdeunlock.exe,fvenotify.exe"

if "x%opt[shell.app]%"=="xwinxshell" (
  rem auto contextmenu
  call AddFiles "@\Windows\System32\#nStructuredQuery.dll,Windows.Storage.Search.dll"
)

rem ==========update registry==========
rem call RegCopy HKLM\System\ControlSet001\Services\BDESVC
call RegCopy HKLM\Software\Classes\Drive\shell\unlock-bde
reg add HKLM\Tmp_software\Classes\Drive\shell\unlock-bde /v Icon /d bdeunlock.exe /f

if "x%opt[shell.app]%"=="xwinxshell" (
  reg delete HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v AppliesTo /f
  reg delete HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v DefaultAppliesTo /f
)
