@echo off

set vbox_version=%opt[vbox.version]%
if "x%vbox_version%"=="xauto" call :DETECT_VBOXVERSION
set _Vx86amd64=amd64
if "%WB_PE_ARCH%"=="x86" set _Vx86amd64=x86
call V2X VBoxGuestAdditions -extract "%vbox_version%_vboxguest.inf_%_Vx86amd64%.7z" "%X_WIN%\Temp\vboxguest.inf\"
copy /y InstVBoxGuestAdditions.bat "%X_Startup%\"
goto :EOF

:DETECT_VBOXVERSION
set "reg3264= "
if "x%PROCESSOR_ARCHITEW6432%"=="xAMD64" set "reg3264= /reg:64"
for /f "tokens=3,4 delims=. " %%i in ('reg query HKLM\SOFTWARE\Oracle\VirtualBox /v Version %reg3264%') do (
  set vbox_version=%%i.%%j
)

if "x%vbox_version%"=="xauto" (
  echo [ERROR] Could not find the version of Oracle VirtualBox.
  goto :EOF
)

echo [INFO] Found Oracle VirtualBox Version:%vbox_version%
