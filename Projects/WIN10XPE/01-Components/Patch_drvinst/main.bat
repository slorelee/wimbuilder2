@echo off

rem install test driver

rem run "drvload X:\windows\INF\wceisvista.inf" to test
rem \X\Windows\INF
rem          netrndis.inf
rem          rndismp6.sys
rem          usb80236.sys
rem          wceisvista.inf

if "x%opt[patch_drvinst.install_test_driver]%"=="xtrue" (
  xcopy /E /Y X\*.* "%X%\"
)

rem set PATCH_MODE=local
if "%PATCH_MODE%"=="local" (
  set WB_PE_VER=10.0.18323
  set VER[3]=18323
  set WB_PE_ARCH=x64
  set X_SYS=.
)
rem use JFX's generic patcher
rem http://theoven.org/index.php?topic=2768.0 (>= v1.0.1)
rem http://theoven.org/index.php?topic=2726.msg31375#msg31375 (v1.0.0)

if %VER[3]% LSS 15063 goto :AssemblePatch
if %VER[3]% GEQ 19041 goto :AssemblePatch

DrvInstPatch_%WB_ARCH%.exe p "%X_SYS%\drvinst.exe"
if %errorlevel% NEQ 1 (
  goto :AssemblePatch
)

if "%PATCH_MODE%"=="local" pause
goto :EOF

:AssemblePatch
echo Assemble Patch ...
set VER_NAME=%WB_PE_VER%
if %VER[3]% GTR 17000 set VER_NAME=win10.rs4later
if %VER[3]% GTR 17700 set VER_NAME=win10.rs5later
if %VER[3]% GTR 18908 set VER_NAME=win10.18908later
if %VER[3]% GEQ 19041 set VER_NAME=win10.20h1later
call :Drvinst_%VER_NAME%_%WB_PE_ARCH%
if "%PATCH_MODE%"=="local" pause
goto :EOF

:Drvinst_10.0.14393_x64
call :PATCH 8BD8 85C0 7508 8B06
goto :EOF

:Drvinst_10.0.15063_x64
call :PATCH 8BF0 85C0 7509 418B
goto :EOF

:Drvinst_win10.rs4later_x64
call :PATCH 8BF8 85C0 7509 418B
goto :EOF

:Drvinst_win10.rs4later_x86
call :PATCH 8BD8 85DB 750A 8B4D
goto :EOF

:Drvinst_win10.rs5later_x64
call :PATCH 8BF0 85C0 7509 418B
goto :EOF

:Drvinst_win10.rs5later_x86
call :PATCH 8BD8 85DB 750A 8B4D
goto :EOF

:Drvinst_win10.18908later_x64
call :FULL_PATCH 8BF0_85C0_7447 33C0_8BF0_EB47
goto :EOF

:Drvinst_win10.18908later_x86
call :FULL_PATCH 8BD8_85DB_742B_53 33C0_8BD8_EB2B_53
goto :EOF

:Drvinst_win10.20h1later_x64
call :FULL_PATCH 8BF0_85C0_7423 33C0_8BF0_EB23
goto :EOF

:Drvinst_win10.20h1later_x86
call :FULL_PATCH 8BD8_85DB_741B_53 33C0_8BD8_EB1B_53
goto :EOF

:FULL_PATCH
binmay.exe -v -s "%1" -r "%2" -u "%X_SYS%\drvinst.exe"
goto :PATCH_CONFIRM

:PATCH
binmay.exe -v -s "%1%2%3%4" -r "33C0%19090%4" -u "%X_SYS%\drvinst.exe"
:PATCH_CONFIRM
fc /b "%X_SYS%\drvinst.exe.org" "%X_SYS%\drvinst.exe"
del /q "%X_SYS%\drvinst.exe.org"

