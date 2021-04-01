call X2X -done

rem update lua scripts for escape characters
call LuaLink -done
call LuaPin -done

if "x%opt[build.unmount_wim_demand]%"=="xtrue" set _WB_UNMOUNT_DEMAND=1
if "x%opt[build.last_filereg_disabled]%"=="xtrue" goto :REPLACE_FULLREG_END

rem New Menu
if %VER[3]% LSS 18300 (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v Classes /t REG_MULTI_SZ /d .library-ms\0.txt\0Folder /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v ~reserved~ /t REG_BINARY /d 0800000000000600 /f
)

if not exist "%X_SYS%\dwm.exe" ( 
    reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM /t REG_DWORD /d 1 /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v Composition /t REG_DWORD /d 0 /f
)

call za-Slim\Cleanup.bat

set _dll_drive=
for /f "tokens=3 delims=: " %%i in ('reg query HKLM\Tmp_Software\Classes\CLSID\{0000002F-0000-0000-C000-000000000046}\InprocServer32 /ve') do set _dll_drive=%%i
if /i "x%_dll_drive%"=="xX" goto :C2X_PATH_END

echo Update registry (C:\ =^> X:\) ...
rem Case Insensitive Search for 'C:\'
regfind -p HKEY_LOCAL_MACHINE\Tmp_Software -y C:\ -r X:\
rem regfind -p HKEY_LOCAL_MACHINE\Src_System -y C:\ -r X:\

:C2X_PATH_END
set _dll_drive=

if exist "%opt[slim.hive]%" (
    call "%opt[slim.hive]%"
    set REG_REWRITE_MODE=1
)

if "x%opt[build.unmount_wim_demand]%"=="xtrue" goto :REPLACE_FULLREG_END

if "x%REG_REWRITE_MODE%"=="x1" (
    set REG_REWRITE_MODE=
    call PERegPorter.bat Tmp REWRITE 1>nul
) else (
    call PERegPorter.bat Tmp UNLOAD 1>nul
)

rem use prepared HIVE files

call :FULLREG DEFAULT
call :FULLREG SOFTWARE
call :FULLREG SYSTEM
call :FULLREG COMPONENTS
call :FULLREG DRIVERS

:REPLACE_FULLREG_END

if exist "_CustomFiles_\final.bat" (
    call "_CustomFiles_\final.bat"
)
goto :EOF

:FULLREG
if exist "%~dp0%1" (
   xcopy /E /Y "%~dp0%1" "%X%\Windows\System32\Config\"
)
goto :EOF
