rem ==========update filesystem==========

set VER_CNAME=.
if %VER[3]% GTR 17000 set VER_CNAME=.rs4.
if %VER[3]% GTR 17700 set VER_CNAME=.rs5.

call AddFiles %0 :end_files
goto :end_files

;in winre.wim activeds.dll,adsldpc.dll,BCP47mrm.dll,certca.dll,certcli.dll,CredProv2faHelper.dll,CredProvDataModel.dll,credprovhost.dll,credprovs.dll,credprovslegacy.dll,dfscli.dll,Faultrep.dll
;in winre.wim gpsvc.dll,joinutil.dll,logoncli.dll,LogonController.dll,msiltcfg.dll,netjoin.dll,ninput.dll,nlaapi.dll,profapi.dll,profext.dll,profsvc.dll,samcli.dll,SensApi.dll
;in winre.wim userinit.exe,usermgr.dll,usermgrcli.dll,UserMgrProxy.dll,weretw.dll,WerFault.exe,wersvc.dll,wincorlib.dll,Windows.Internal.UI.Logon.ProxyStub.dll,Windows.UI.CredDialogController.dll,Windows.System.RemoteDesktop.dll,wmiclnt.dll
;dll in PESE does not seem required apprepapi.dll,CredDialogBroker.dll,cscapi.dll,cscdll.dll,hnetcfg.dll,mtxex.dll,profprov.dll,runas.exe,runonce.exe,Sens.dll,Windows.Globalization.Fontgroups.dll,Windows.UI.Cred.dll + WinSxS and Manifests *_microsoft-windows-p..al-securitytemplate_*

\Windows\inf\wvmic_ext.inf

@\Windows\System32\
FontGlyphAnimator.dll,LogonUI.exe,profsvcext.dll
shacct.dll,threadpoolwinrt.dll,Windows.UI.dll,Windows.UI.Logon.dll

; 1709 uses Xaml.Resources.dll,1803 uses Xaml.Resources.rs4.dll and 1809 uses Xaml.Resources.rs5.dll, ...
; Keep both for compatibility with both versions
;Windows.UI.Xaml.Resources.dll,Windows.UI.Xaml.Resources.*.dll

Windows.UI.Xaml.Resources%VER_CNAME%dll

+ver > 17700
Windows.UI.Xaml.Controls.dll,Windows.ApplicationModel.dll
+ver*

Windows.UI.XamlHost.dll

+mui
;need install.wim's imageres.dll
imageres.dll
AuthExt.dll,InputSwitch.dll,twinapi.appcore.dll,Windows.UI.Immersive.dll
secedit.exe,seclogon.dll,tscon.exe,tsdiscon.exe,whoami.exe

; Windows.UI.Xaml.dll exist in all Language folders.
+mui(en-US,%WB_PE_LANG%)
Windows.UI.Xaml.dll

-mui
CoreMessaging.dll,CoreUIComponents.dll,InputHost.dll,MrmCoreR.dll,rmclient.dll,TextInputFramework.dll
\Windows\SystemResources\Windows.UI.Logon


:end_files

if not exist "%X_SYS%\tsdiscon.exe" (
  echo \033[97;101mERROR Switch to Admin needs tsdiscon.exe present in Education, Professional or Enterprise edition | cmdcolor.exe
)

call X2X
ren "%X_SYS%\startnet_%WB_PE_ARCH%.exe" startnet.exe
expand  Security.cab -F:* "%X_WIN%\Security"

rem use in :PECMD_ENTRY@last.bat
set PECMDINI=PecmdAdmin.ini

rem ==========update registry==========
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CoreMessagingRegistrar /f

reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
call RegCopy HKLM\System\ControlSet001\Services\seclogon
rem ACLRegKey Tmp_System\ControlSet001\Services\gpsvc
reg add HKLM\Tmp_System\ControlSet001\Services\gpsvc /v Start /t REG_DWORD /d 3 /f
rem ACLRegKey Tmp_System\ControlSet001\Services\TrustedInstaller
reg add HKLM\Tmp_System\ControlSet001\Services\TrustedInstaller /v Start /t REG_DWORD /d 3 /f

if %opt[system.admin_countdown]% GTR 0 (
  rem Enable Mouse Cursor (EnableCursorSuppression=0) or use Exec = Winpeshl.exe in PecmdAdmin.ini
  reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
  call TextReplace "%X_SYS%\PecmdAdmin.ini" "CALL ADMIN#r#n//CALL SWITCHTOADMINQUESTION" "#//CALL ADMIN#r#nCALL SWITCHTOADMINQUESTION"
  call TextReplace "%X_SYS%\PecmdAdmin.ini" "#YN *3000 $N" "#YN *%opt[system.admin_countdown]%000 $N"
)
