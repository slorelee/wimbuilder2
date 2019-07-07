rem ==========update filesystem==========
call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
+ver < 17763
Microsoft-Windows-RemoteDesktop-*.cat
+ver >= 17763
Microsoft-Windows-TerminalServices-CommandLineTools-Package~*.cat
+ver*

@\Windows\System32\
cngcredui.dll,CredentialUIBroker.exe,credssp.dll,credui.dll,cryptui.dll
d2d1.dll,d3d10warp.dll,d3d11.dll,dcomp.dll,DWrite.dll,dxgi.dll
msacm32.dll,msacm32.drv,mstsc.exe,mstscax.dll
ncryptprov.dll,ncryptsslp.dll,pdh.dll,TSpkg.dll
Windows.Globalization.dll,Windows.Graphics.dll
Windows.Internal.UI.Logon.ProxyStub.dll
Windows.UI.Cred.dll,Windows.UI.CredDialogController.dll
Windows.UI.Xaml.Resources.Common.dll
wuceffects.dll
\Windows\SystemResources\Windows.UI.Cred

;SystemPropertiesRemote
;racpldlg.dll,remotepg.dll,srrstr.dll,SystemPropertiesRemote.exe

;share folder
;PCPksp.dll
;CredentialMigrationHandler.dll
;CredDialogBroker.dll

:end_files

rem ==========update registry==========

if not "x%opt[build.registry.software]%"=="xfull" (
  call RegCopy "HKLM\Software\Microsoft\Terminal Server Client"
)

reg add HKLM\Tmp_System\ControlSet001\Control\Lsa\OSConfig /v "Security Packages" /t REG_MULTI_SZ /d kerberos\0msv1_0\0tspkg\0pku2u\0livessp\0wdigest\0schannel /f
reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
rem Disable Network Level Authentication(NLA)
reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f

call TermService.bat
