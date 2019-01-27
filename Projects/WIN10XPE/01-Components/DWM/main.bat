@echo off

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
+mui
; Theme and dwm
dwm.exe,dwmcore.dll,dwminit.dll,dwmredir.dll,hotplug.dll
themeservice.dll,themeui.dll,twinapi.appcore.dll,twinui.dll,ubpm.dll,uDWM.dll,wdi.dll
Windows.Gaming.Input.dll,Windows.UI.Immersive.dll

-mui
CoreMessaging.dll,CoreUIComponents.dll,ISM.dll,rmclient.dll

:end_files

rem ==========update registry==========
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CoreMessagingRegistrar /f

call REGCOPY HKLM\Software\Microsoft\Windows\DWM
reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v Composition /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v ColorizationGlassAttribute /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f

rem   // For dwm.exe or StateRepository
rem   //RegCopyKey,HKLM,Tmp_Software\Microsoft\WindowsRuntime\Server\StateRepository
rem   //RegCopyKey,HKLM,Tmp_Software\Microsoft\WindowsRuntime\ActivatableClassId
call REGCOPY HKLM\Software\Microsoft\WindowsRuntime
call REGCOPY "HKLM\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel"
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\AppModel
call REGCOPY HKLM\Software\Microsoft\Windows\CurrentVersion\AppX
