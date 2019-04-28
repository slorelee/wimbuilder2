rem ==========update filesystem==========

rem add all as default
set VER_CNAME=*.
if %VER[3]% GTR 17000 set VER_CNAME=.rs4.
if %VER[3]% GTR 17700 set VER_CNAME=.rs5.
if %VER[3]% GTR 18300 set VER_CNAME=.19h1.

call AddFiles %0 :end_files
goto :end_files

;in winre.wim activeds.dll,adsldpc.dll,BCP47mrm.dll,certca.dll,certcli.dll,CredProv2faHelper.dll,CredProvDataModel.dll,credprovhost.dll,credprovs.dll,credprovslegacy.dll,dfscli.dll,Faultrep.dll
;in winre.wim gpsvc.dll,joinutil.dll,logoncli.dll,LogonController.dll,msiltcfg.dll,netjoin.dll,ninput.dll,nlaapi.dll,profapi.dll,profext.dll,profsvc.dll,samcli.dll,SensApi.dll
;in winre.wim userinit.exe,usermgr.dll,usermgrcli.dll,UserMgrProxy.dll,weretw.dll,WerFault.exe,wersvc.dll,wincorlib.dll,Windows.Internal.UI.Logon.ProxyStub.dll,Windows.UI.CredDialogController.dll,Windows.System.RemoteDesktop.dll,wmiclnt.dll
;dll in PESE does not seem required apprepapi.dll,CredDialogBroker.dll,cscapi.dll,cscdll.dll,hnetcfg.dll,mtxex.dll,profprov.dll,runas.exe,runonce.exe,Sens.dll,Windows.Globalization.Fontgroups.dll,Windows.UI.Cred.dll + WinSxS and Manifests *_microsoft-windows-p..al-securitytemplate_*

\Windows\inf\wvmic_ext.inf

@\Windows\System32\
AuthExt.dll

;need for NoteBook
batmeter.dll

;need install.wim's imageres.dll
imageres.dll

FontGlyphAnimator.dll,InputSwitch.dll,LogonUI.exe,MrmCoreR.dll,profsvcext.dll
secedit.exe,seclogon.dll,shacct.dll,threadpoolwinrt.dll,tscon.exe,tsdiscon.exe,whoami.exe
Windows.UI.dll,Windows.UI.Immersive.dll,Windows.UI.Logon.dll,Windows.UI.XamlHost.dll

; Windows.UI.Xaml.dll exist in all Language folders.
+mui(en-US,%WB_PE_LANG%)
Windows.UI.Xaml.dll
-mui

; 1709 uses Xaml.Resources.dll,1803 uses Xaml.Resources.rs4.dll and 1809 uses Xaml.Resources.rs5.dll, ...
; Keep both for compatibility with both versions
;Windows.UI.Xaml.Resources.dll,Windows.UI.Xaml.Resources.*.dll

Windows.UI.Xaml.Resources%VER_CNAME%dll

; for WinXShell
CoreMessaging.dll,CoreUIComponents.dll,InputHost.dll,rmclient.dll,TextInputFramework.dll,twinapi.appcore.dll

+ver > 17700
Windows.UI.Xaml.Controls.dll,Windows.ApplicationModel.dll
+ver > 18300
wuceffects.dll
Windows.Globalization.Fontgroups.dll
+ver > 18800
WindowManagement.dll
WindowManagementAPI.dll
+ver*

\Windows\SystemResources\Windows.UI.Logon


:end_files

if not exist "%X_SYS%\tsdiscon.exe" (
  echo \033[97;101mERROR Switch to Admin needs tsdiscon.exe present in Education, Professional or Enterprise edition | cmdcolor.exe
)

expand  Security.cab -F:* "%X_WIN%\Security"

rem use in :PECMD_ENTRY@last.bat
set PECMDINI=PecmdAdmin.ini
if exist "%WB_PROJECT_PATH%\_CustomFiles_\%PECMDINI%" copy /y "%WB_PROJECT_PATH%\_CustomFiles_\%PECMDINI%" "%X_SYS%\"

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

rem Screen image
if "x%opt[system.admin_screen]%"=="x" goto :EOF
if "x%opt[system.admin_screen]%"=="xnone" goto :EOF
if not exist "%X%\Windows\Web\Screen\" mkdir "%X%\Windows\Web\Screen"

if "x%opt[system.admin_screen]%"=="xwallpaper" (
  copy /y "%opt[shell.wallpaper]%" "%X%\Windows\Web\Screen\img100.jpg"
  goto :EOF
)

copy /y "%WB_PROJECT_PATH%\_CustomFiles_\%opt[system.admin_screen]%" "%X%\Windows\Web\Screen\img100.jpg"
