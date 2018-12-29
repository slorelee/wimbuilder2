rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

; ncsi.dll.mui is not included in winre.wim
\Windows\System32\??-??\ncsi.dll.mui

\Windows\System32\??-??\Windows.CloudStore.dll.mui

; Possible Addition  \Windows\System32\umpoext.dll \Windows\System32\umpowmi.dll \Windows\System32\??-??\umpoext.dll.mui
; Power management - In Winre.wim system32: powercfg.cpl,powrprof.dll,workerdd.dll
\Windows\System32\powercpl.dll
\Windows\System32\??-??\powercpl.dll.mui

:end_files

rem ==========update registry==========

rem [ChangeReg]
rem // Start Services in RS5!
if %VER[3]% GTR 17700 (
  if %VER[3]% LSS 18000 (
    reg add HKLM\Tmp_System\ControlSet001\Services\BFE /v ImagePath /t REG_EXPAND_SZ /d "%%systemroot%%\system32\svchost.exe -k LocalServiceNoNetworkFirewall -p" /f
    reg add HKLM\Tmp_System\ControlSet001\Services\BFE /v SvcHostSplitDisable /t REG_DWORD /d 1 /f
    reg add HKLM\Tmp_System\ControlSet001\Services\BFE\Security /v Security /t REG_BINARY /d 01001480900000009c000000140000003000000002001c000100000002801400ff000f000101000000000001000000000200600004000000000014008500020001010000000000050b000000000014009f000e00010100000000000512000000000018009d000e0001020000000000052000000020020000000018008500000001020000000000052000000021020000010100000000000512000000010100000000000512000000 /f
    rem // in pecmd.ini EXEC @!%WinDir%\System32\Net.exe Start Wlansvc - EXEC @!%WinDir%\System32\Net.exe Start WinHttpAutoProxySvc
    rem // LanmanWorkstation,DNSCache,NlaSvc does not start alone with windows 10 1809
    reg add HKLM\Tmp_System\Setup\AllowStart\LanmanWorkstation /f
    reg add HKLM\Tmp_System\Setup\AllowStart\DNSCache /f
    reg add HKLM\Tmp_System\Setup\AllowStart\NlaSvc /f
  )
)

reg add "HKLM\Tmp_System\ControlSet001\Control\Session Manager\Environment" /v AppData /t REG_EXPAND_SZ  /d "%%SystemDrive%%\Users\Default\AppData\Roaming" /f

rem // Power Options
rem call RegCopy HKLM\System\ControlSet001\Control\Power

rem // Disable Hibernate
reg add HKLM\Tmp_System\ControlSet001\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\ControlSet001\Control\Power /v CustomizeDuringSetup /t REG_DWORD /d 0 /f
rem // Disable Fast Startup
reg add "HKLM\Tmp_System\ControlSet001\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
