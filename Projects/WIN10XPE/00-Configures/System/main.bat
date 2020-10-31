rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

\Windows\Cursors\aero_arrow.cur

@\Windows\System32\
setx.exe

; ncsi.dll.mui is not included in winre.wim
\Windows\System32\??-??\ncsi.dll.mui

\Windows\System32\??-??\Windows.CloudStore.dll.mui

; Possible Addition umpowmi.dll
umpoext.dll

; Power management - In Winre.wim system32:powrprof.dll,workerdd.dll
powercfg.cpl
powercpl.dll

\Windows\Fonts\segoeui.ttf

+if %VER[3]% > 19550 And %VER[3]% < 19587
@\Windows\Fonts\
+if "%WB_PE_LANG%"="zh-CN" Or "%WB_PE_LANG%"="zh-TW"
mingliu.ttc
msyh.ttc
simsun.ttc
-if
-if

:end_files

call AddDrivers winusb.inf

rem ==========update registry==========

rem [ChangeReg]
rem // Start Services after RS5
if %VER[3]% GTR 17700 (
  reg add HKLM\Tmp_System\ControlSet001\Services\BFE /v ImagePath /t REG_EXPAND_SZ /d "%%systemroot%%\system32\svchost.exe -k LocalServiceNoNetworkFirewall -p" /f
  reg add HKLM\Tmp_System\ControlSet001\Services\BFE /v SvcHostSplitDisable /t REG_DWORD /d 1 /f
  reg add HKLM\Tmp_System\ControlSet001\Services\BFE\Security /v Security /t REG_BINARY /d 01001480900000009c000000140000003000000002001c000100000002801400ff000f000101000000000001000000000200600004000000000014008500020001010000000000050b000000000014009f000e00010100000000000512000000000018009d000e0001020000000000052000000020020000000018008500000001020000000000052000000021020000010100000000000512000000010100000000000512000000 /f
  rem // in pecmd.ini EXEC @!%WinDir%\System32\Net.exe Start Wlansvc - EXEC @!%WinDir%\System32\Net.exe Start WinHttpAutoProxySvc
  rem // LanmanWorkstation,DNSCache,NlaSvc does not start alone with windows 10 1809
  reg add HKLM\Tmp_System\Setup\AllowStart\LanmanWorkstation /f
  reg add HKLM\Tmp_System\Setup\AllowStart\DNSCache /f
  reg add HKLM\Tmp_System\Setup\AllowStart\NlaSvc /f
)

call ProductOptions.bat

rem // Environment
reg add "HKLM\Tmp_System\ControlSet001\Control\Session Manager\Environment" /v AppData /t REG_EXPAND_SZ  /d "%%SystemDrive%%\Users\Default\AppData\Roaming" /f
rem // Disable Telemetry
reg add HKLM\Tmp_System\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener /v Start /t REG_DWORD /d 0 /f
rem //-
rem // Taking Ownership, Appinfo and ProfSvc Services. ProfSvc Already Here
call RegCopyEx Services Appinfo
rem call RegCopyEx Services ProfSvc
reg add HKLM\Tmp_System\Setup\AllowStart\ProfSvc /f

call RegCopy HKLM\System\ControlSet001\Control\Lsa
call RegCopy HKLM\System\ControlSet001\Control\SecurityProviders

reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v "Security Packages" /t REG_MULTI_SZ /d tspkg /f
reg add HKLM\Tmp_System\ControlSet001\Control\SecurityProviders /v SecurityProviders /d credssp.dll /f

rem // Power Options
rem call RegCopy HKLM\System\ControlSet001\Control\Power

rem // Disable Hibernate
reg add HKLM\Tmp_System\ControlSet001\Control\Power /v HibernateEnabled /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\ControlSet001\Control\Power /v CustomizeDuringSetup /t REG_DWORD /d 0 /f

rem // Disable Fast Startup
reg add "HKLM\Tmp_System\ControlSet001\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f

rem // Do Not Update the Last-Access Timestamp for Ntfs and Refs
reg add HKLM\Tmp_System\ControlSet001\Control\FileSystem /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_System\ControlSet001\Control\FileSystem /v RefsDisableLastAccessUpdate /t REG_DWORD /d 1 /f

rem // For Samba Servers
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LmCompatibilityLevel /t REG_DWORD /d 2 /f

rem // Allow network users to access without password > Also display Share with in Context Menu!
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f


reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f
rem // Disable Telemetry
reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection /v AllowTelemetry /t REG_DWORD /d 0 /f

reg add "HKLM\Tmp_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Segoe UI (TrueType)" /d segoeui.ttf /f

if "x%opt[build.registry.software]%"=="xfull" (
  call :EditReg_FullSoftware
)

if "x%opt[system.high_compatibility]%"=="xtrue" (
  call Compatibility.bat
)
goto :EOF

:EditReg_FullSoftware
set "WinPE_Key=HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\WinPE"
reg add "%WinPE_Key%" /v InstRoot /d X:\ /f
reg add "%WinPE_Key%" /v CustomBackground /t REG_EXPAND_SZ /d X:\Windows\Web\Wallpaper\Windows\img0.jpg /f
rem reg add "%WinPE_Key%\OC\Microsoft-WinPE-HTA" /v "1. Fix path of MSHTA.EXE" /d "reg add HKEY_CLASSES_ROOT\htafile\Shell\Open\Command /t REG_EXPAND_SZ /f /ve /d "%^SystemRoot%\System32\mshta.exe \"%%1\" %%*" /f
rem reg add "%WinPE_Key%\OC\Microsoft-WinPE-WMI" /v "1. Register CIMWIM32" /d %^systemroot%\system32\wbem\cimwin32.dll /f
rem reg add "%WinPE_Key%\OC\Microsoft-WinPE-WSH" /v "1. Register WSHOM" /d %^systemroot%\system32\wshom.ocx /f
reg add "%WinPE_Key%\UGC" /v Microsoft-Windows-TCPIP /t REG_MULTI_SZ /d "netiougc.exe -online" /f
rem //-
rem // Autorecover wbem MOFs files from winre.wim. To do optionally with correct Language
rem //reg add HKLM\Tmp_Software\Microsoft\WBEM\CIMOM /v "Autorecover MOFs" /t REG_MULTI_SZ /d %^windir%\system32\wbem\cimwin32.mof,%^windir%\system32\wbem\ncprov.mof,%^windir%\system32\wbem\en-us\cimwin32.mfl /f
goto :EOF
