rem ==========update filesystem==========
rem Explorer BitLocker integration
call AddFiles "@\Windows\System32\#nbdeunlock.exe,fvenotify.exe"

rem ==========update registry==========
call RegCopy HKLM\System\ControlSet001\Services\BDESVC
reg add HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /ve /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\bdeunlock.exe,-100" /f
reg add HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v AppliesTo /d System.Volume.BitLockerProtection:=6 /f
reg add HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v DefaultAppliesTo /d "" /f
reg add HKLM\Tmp_software\Classes\Drive\shell\unlock-bde /v Icon /d bdeunlock.exe /f
reg add HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v MultiSelectModel /d Single /f
reg add HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde\command /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\bdeunlock.exe %%1" /f
