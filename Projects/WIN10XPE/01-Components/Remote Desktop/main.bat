rem ==========update filesystem==========
call AddFiles %0 :end_files
goto :end_files

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

call RegCopy HKLM\System\ControlSet001\Control\Lsa
call RegCopy HKLM\System\ControlSet001\Control\SecurityProviders

reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v LmCompatibilityLevel /t REG_DWORD /d 2 /f
reg add HKLM\Tmp_System\ControlSet001\Control\Lsa /v "Security Packages" /t REG_MULTI_SZ /d tspkg /f

reg add HKLM\Tmp_System\ControlSet001\Control\Lsa\OSConfig /v "Security Packages" /t REG_MULTI_SZ /d kerberos\0msv1_0\0tspkg\0pku2u\0livessp\0wdigest\0schannel /f
reg add "HKLM\Tmp_System\ControlSet001\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

call TerminalServer.bat
