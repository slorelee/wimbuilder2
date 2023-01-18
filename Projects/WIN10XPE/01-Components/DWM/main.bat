call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
; Theme and dwm
dcomp.dll,d3d11.dll,dxgi.dll
dwm.exe,dwmcore.dll,dwmghost.dll,dwminit.dll,dwmredir.dll,hotplug.dll
themeservice.dll,themeui.dll,twinapi.appcore.dll,twinui.dll,ubpm.dll,uDWM.dll,wdi.dll
Windows.Gaming.Input.dll,Windows.UI.Immersive.dll
CoreMessaging.dll,CoreUIComponents.dll,ISM.dll,rmclient.dll

+ver > 18950
GameInput.dll
+ver >= 22000
wuceffects.dll
+ver*

+if "%VER[3]%" = "19041" Or "%VER[3]%" = "19042" Or "%VER[3]%" = "19043"
shell32.dll
SHCore.dll
KernelBase.dll
-if

; already in winre.wim, add for others, like winpe.wim(ADK)
+if "%opt[build.wim]%" <> "winre"
d2d1.dll,d3d10warp.dll,D3DCompiler_47.dll,DXCore.dll
-if

:end_files

rem ==========update registry==========
call REGCOPY HKLM\SYSTEM\ControlSet001\Services\CoreMessagingRegistrar
reg add HKLM\Tmp_SYSTEM\Setup\AllowStart\CoreMessagingRegistrar /f

reg query "HKLM\Tmp_Software\Microsoft\SecurityManager\TransientObjects\%5C%5C.%5CAlpcPort%5CMPCManager" 1>nul 2>nul
if ERRORLEVEL 1 reg import TransientObjects_MPCManager.reg

call REGCOPY HKLM\Software\Microsoft\Windows\DWM
reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM /t REG_DWORD /d 0 /f

rem Enable Rounded Corners in Windows 11
if %VER[3]% GEQ 22621 (
    reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v ForceEffectMode /t REG_DWORD /d 2 /f
)

rem No shadow effect, so force ColorPrevalence to 1
reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v ColorPrevalence /t REG_DWORD /d 1 /f

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
