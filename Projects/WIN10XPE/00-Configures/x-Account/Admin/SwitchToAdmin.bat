rem ==========update filesystem==========

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

Windows.UI.Xaml.Resources%VER_XAMLRES%.dll

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
+ver > 20000
pfclient.dll
+ver > 22621
Windows.Globalization.dll
;logoff(optional)
Windows.UI.Core.TextInput.dll
windowsudk.shellcommon.dll
+ver*

\Windows\SystemResources\Windows.UI.Logon


:end_files

if exist "%X_SYS%\tsdiscon.exe" goto :COMMANDS_CONFIRM

rem try to extract from WinSxS
set sxsexpcmd=sxsexp32.exe
set _SxSArch=%WB_PE_ARCH%
if "%_SxSArch%"=="x64" set _SxSArch=amd64
if "%_SxSArch%"=="x64" set sxsexpcmd=sxsexp64.exe
call AddFiles %0 :[CommandsFromWinSxS]
for /f "usebackq delims=" %%i in (`dir /b "%X_WIN%\WinSxS\%_SxSArch%_microsoft-windows-t..es-commandlinetools_*"`) do (
  %sxsexpcmd% "%X_WIN%\WinSxS\%%i\tsdiscon.exe" "%X_SYS%\tsdiscon.exe"
  %sxsexpcmd% "%X_WIN%\WinSxS\%%i\tscon.exe" "%X_SYS%\tscon.exe"
  rem use the first one
  goto :_COPY_CMD_MUI
)

:_COPY_CMD_MUI
for /f "usebackq delims=" %%i in (`dir /b "%X_WIN%\WinSxS\%_SxSArch%_microsoft-windows-t..linetools.resources_*_%WB_PE_LANG%_*"`) do (
  copy /y "%X_WIN%\WinSxS\%%i\*.exe.mui" "%X_SYS%\%WB_PE_LANG%\"
  rem use the first one
  goto :_COPY_CMD_MUI_END
)

:_COPY_CMD_MUI_END
set _SxSArch=
goto :COMMANDS_CONFIRM

:[CommandsFromWinSxS]
\Windows\WinSxS\%_SxSArch%_microsoft-windows-t..es-commandlinetools_*\tsdiscon.exe
\Windows\WinSxS\%_SxSArch%_microsoft-windows-t..es-commandlinetools_*\tscon.exe
\Windows\WinSxS\%_SxSArch%_microsoft-windows-t..linetools.resources_*_%WB_PE_LANG%_*\tsdiscon.exe.mui
\Windows\WinSxS\%_SxSArch%_microsoft-windows-t..linetools.resources_*_%WB_PE_LANG%_*\tscon.exe.mui
goto :EOF

:COMMANDS_CONFIRM
if not exist "%X_SYS%\tsdiscon.exe" (
  echo \033[97;101mERROR Switch to Admin needs tsdiscon.exe present in Education, Professional or Enterprise edition | cmdcolor.exe
  sleep 5
)

if %VER[3]% GTR 18850 (
  rem Can not Create the Administrator's Profile if this file is absent
  copy /y UsrClass.dat "%X%\Users\Default\AppData\Local\Microsoft\Windows\"
)

if %VER[3]% GEQ 19041 (
  rem Can not create the Administrator's Profile with Windows Embedded Standard's fbwf driver
  if exist "%X_WIN%\fbwf.cfg" (
    set opt[account.precreate_admin_profile]=true
  )
)

if "x%opt[account.precreate_admin_profile]%"=="xtrue" (
  copy /y LSAgetRights_%WB_PE_ARCH%.exe "%X_SYS%\LSAgetRights.exe"
  copy /y "PreCreateAdminProfile.bat" "%X_SYS%\"
)

rem use in :PECMD_ENTRY@last.bat
set PECMDINI=PecmdAdmin.ini
if exist "%WB_PROJECT_PATH%\_CustomFiles_\%PECMDINI%" copy /y "%WB_PROJECT_PATH%\_CustomFiles_\%PECMDINI%" "%X_SYS%\"

if "x%opt[account.custom_admin_name]%"=="x%opt[account.localized_admin_name]%" set opt[account.custom_admin_name]=
if not "x%opt[account.custom_admin_name]%"=="x" (
  expand Security.cab -F:* "%X_WIN%\Security"
  call TextReplace "%X_WIN%\Security\Templates\unattend.inf" "#qAdministrator#q" "#q%opt[account.custom_admin_name]%#q"
  if exist "%X_SYS%\PecmdAdmin.ini" call TextReplace "%X_SYS%\%PECMDINI%" "Administrator" "%opt[account.custom_admin_name]%" g
  if exist "%X_PEMaterial%\pecmd.lua" call TextReplace "%X_PEMaterial%\pecmd.lua" "'DefaultUserName', 'Administrator'" "'DefaultUserName', '%opt[account.custom_admin_name]%'"

  if /i not "%opt[account.custom_admin_name]%"=="Administrator" (
    if exist "%X_SYS%\PreCreateAdminProfile.bat" call TextReplace "%X_SYS%\PreCreateAdminProfile.bat" "Administrator" "%opt[account.custom_admin_name]%" g
  )
)

move /y "%X_PEMaterial%\LogonAdmin.bat" "%X_SYS%\"
move /y "%X_PEMaterial%\SwitchUser.bat" "%X_SYS%\"

rem dual-session
call TextReplace "%X_SYS%\pecmd.ini" "_SHEL " "_DaemonShell " g

rem ==========update registry==========
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CoreMessagingRegistrar /f

if %VER[3]% GEQ 22621 (
  Call RegCopyEx Services TextInputManagementService
)

reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\System /v DelayedDesktopSwitchTimeout /t REG_DWORD /d 0 /f

call RegCopy HKLM\System\ControlSet001\Services\seclogon
rem ACLRegKey Tmp_System\ControlSet001\Services\gpsvc
reg add HKLM\Tmp_System\ControlSet001\Services\gpsvc /v Start /t REG_DWORD /d 3 /f
rem ACLRegKey Tmp_System\ControlSet001\Services\TrustedInstaller
reg add HKLM\Tmp_System\ControlSet001\Services\TrustedInstaller /v Start /t REG_DWORD /d 3 /f

call RegCopy "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication"
call RegCopy "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

reg add "HKLM\Tmp_Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations" /v "LowRiskFileTypes" /d ".com;.exe;.bat;.cmd;" /f

if %opt[account.autologon_countdown]% GTR 0 (
  rem Enable Mouse Cursor (EnableCursorSuppression=0) or use Exec = Winpeshl.exe in PecmdAdmin.ini
  reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
  call TextReplace "%X_SYS%\PecmdAdmin.ini" "#YN *3000 $N" "#YN *%opt[account.autologon_countdown]%000 $N"
)

rem update UI_LogonPE.jcfg
if not "x%_UI_LogonPE_jcfg%"=="x" (
  if "x%opt[account.admin_autologon]%"=="xtrue" (
    call TextReplace "%_UI_LogonPE_jcfg%" "#qlogon_user#q:#qSYSTEM#q" "#qlogon_user#q:#qAdministrator#q"
  )
  if %opt[account.autologon_countdown]% GTR 0 (
    call TextReplace "%_UI_LogonPE_jcfg%" "#qauto_logon_second#q:0" "#qauto_logon_second#q:%opt[account.autologon_countdown]%"
  )
  if not "x%opt[account.admin_logon_pass]%"=="x" (
    call TextReplace "%_UI_LogonPE_jcfg%" "#qshadow#q:#qAdministrator:;\\nSYSTEM:;#q" "#qshadow#q:#qAdministrator:%opt[account.admin_logon_pass]%;\\nSYSTEM:%opt[account.SYSTEM_logon_pass]%;#q"
  )
)
set _UI_LogonPE_jcfg=

rem Screen image
if "x%opt[account.admin_screen]%"=="x" goto :EOF
if "x%opt[account.admin_screen]%"=="xnone" goto :EOF
if not exist "%X%\Windows\Web\Screen\" mkdir "%X%\Windows\Web\Screen"

if "x%opt[account.admin_screen]%"=="xwallpaper" (
  copy /y "%opt[shell.wallpaper]%" "%X%\Windows\Web\Screen\img100.jpg"
  goto :EOF
)

copy /y "%WB_ROOT%\%APPDATA_DIR%\_CustomFiles_\%opt[account.admin_screen]%" "%X%\Windows\Web\Screen\img100.jpg"
