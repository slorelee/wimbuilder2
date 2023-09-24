rem ==========update filesystem==========
rem Explorer BitLocker integration

rem full feature
rem call AddFiles "@\Windows\System32\#nbde*.exe,fve*.exe,bde*.dll,fve*.dll,BitLocker*.*,EhStor*.*"

call AddFiles "@\Windows\System32\#nbdesvc.dll,bdeunlock.exe,fvenotify.exe,Windows.UI.Immersive.dll"

if not "%opt[build.wim]%"=="winre" (
  call AddFiles "@\Windows\System32\#nbdeui.dll,fveapi.dll,fvecerts.dll,fveui.dll"
)

if "x%opt[shell.app]%"=="xexplorer" (
  rem auto contextmenu
  call AddFiles "@\Windows\System32\#nStructuredQuery.dll,Windows.Storage.Search.dll"
)

rem ==========update registry==========
rem call RegCopy HKLM\System\ControlSet001\Services\BDESVC
call RegCopy HKLM\Software\Classes\Drive\shell\unlock-bde
reg add HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v Icon /d bdeunlock.exe /f

rem remove unsupported menu
if "x%opt[build.registry.software]%"=="xfull" (
  reg delete HKLM\Tmp_Software\Classes\Drive\shell\encrypt-bde-elev /f
)

set _Need_Fix_Menu=1
if exist "%X_SYS%\Windows.Storage.Search.dll" (
  set _Need_Fix_Menu=0
)
if "x%opt[shell.app]%"=="xwinxshell" (
  set _Need_Fix_Menu=1
)
if %_Need_Fix_Menu% EQU 1 call :FIXED_DRIVE_MENU
set _Need_Fix_Menu=

goto :EOF


:FIXED_DRIVE_MENU
reg delete HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v AppliesTo /f
reg delete HKLM\Tmp_Software\Classes\Drive\shell\unlock-bde /v DefaultAppliesTo /f
goto :EOF
