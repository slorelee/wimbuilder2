@echo off

rem VBoxManage.exe be very slow with Administrator privileges, so switch to normal.
if "x%THIS_RUNAS_NORMAL%"=="x" (
    set THIS_RUNAS_NORMAL=1
    NSudoC.exe -WAIT -U:C "%~0" %*
    goto :EOF
)

set "stor_dvd="SATA" --port 1 --device 0"

title Test the ISO image
echo testing with VirtualBox ...

rem detect installed path
set vbox_path=
set "reg3264= "
if "x%PROCESSOR_ARCHITEW6432%"=="xAMD64" set "reg3264= /reg:64"
for /f "tokens=2,* delims= " %%i in ('reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox /v InstallDir %reg3264%') do (
  set vbox_path=%%j
)

if "x%vbox_path%"=="x" (
  echo ERROR:Could not find the VirtualBox installed path.
  goto :ERR_DONE
)

echo Found path:%vbox_path%
if not exist "%vbox_path%VBoxManage.exe" (
  echo ERROR:Could not find the VBoxManage.exe.
  goto :ERR_DONE
)

cd /d "%vbox_path%"

set "vm=%~1"
VBoxManage.exe showvminfo "%vm%" 1>nul 2>nul
if ERRORLEVEL 1 (
  echo ERROR:Could not find a registered machine named '%vm%'.
  goto :ERR_DONE
)
echo Mount ISO:"%WB_ROOT%_Factory_\BOOTPE.iso"
VBoxManage.exe storageattach "%vm%" --storagectl %stor_dvd% --type dvddrive --medium "%WB_ROOT%_Factory_\BOOTPE.iso"
VBoxManage.exe startvm "%vm%"
if ERRORLEVEL 1 goto :ERR_DONE
rem ping -n 3 127.1 1>nul
goto :EOF
:ERR_DONE
pause
