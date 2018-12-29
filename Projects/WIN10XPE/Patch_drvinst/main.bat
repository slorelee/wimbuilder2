@echo off

rem install test driver

rem run "drvload X:\windows\INF\wceisvista.inf" to test
rem \X\Windows\INF
rem          netrndis.inf
rem          rndismp6.sys
rem          usb80236.sys
rem          wceisvista.inf

if "x%opt[patch_drvinst.install_test_driver]%"=="xtrue" (
  xcopy /E /Y X\*.* %X%\
)

set "PATCH_TMP=%Temp%"
rem set PATCH_MODE=local
if "%PATCH_MODE%"=="local" (
  set WB_PE_VER=10.0.17763
  set WB_PE_ARCH=x64
  set X_SYS=.
  set PATCH_TMP=.
)
call :Drvinst_%WB_PE_VER%%WB_PE_ARCH%
if "%PATCH_MODE%"=="local" pause
goto :EOF

:Drvinst_10.0.15063x64
call :PATCH 8BF0 85C0 7509 418B
goto :EOF

:Drvinst_10.0.17134x64
call :PATCH 8BF8 85C0 7509 418B
goto :EOF

:Drvinst_10.0.17134x86
call :PATCH 8BD8 85DB 750A 8B4D
goto :EOF

:Drvinst_10.0.17763x64
call :PATCH 8BF0 85C0 7509 418B
goto :EOF

:Drvinst_10.0.17763x86
call :PATCH 8BD8 85DB 750A 8B4D
goto :EOF

:PATCH
binmay.exe -v -s "%1%2%3%4" -r "33C0%19090%4" -i "%X_SYS%\drvinst.exe" -o "%PATCH_TMP%\drvinst_patched.exe"
fc /b "%X_SYS%\drvinst.exe" "%PATCH_TMP%\drvinst_patched.exe"
if not "x%PATCH_TMP%"=="x." (
  copy /y "%PATCH_TMP%\drvinst_patched.exe" "%X_SYS%\drvinst.exe"
)
