rem update lua scripts for escape characters
call LuaLink -done
call LuaPin -done

if "x%opt[build.unmount_wim_demand]%"=="xtrue" set _WB_UNMOUNT_DEMAND=1
if "x%opt[build.last_filereg_disabled]%"=="xtrue" goto :EOF

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

if "x%opt[registry.software.compress]%"=="xtrue" (
    reg save HKLM\Tmp_Software "%X_SYS%\config\SOFTWARE.hiv" /y /c
)
if "x%opt[registry.system.compress]%"=="xtrue" (
    reg save HKLM\Tmp_SYSTEM "%X_SYS%\config\SYSTEM.hiv" /y /c
)

if "x%opt[build.unmount_wim_demand]%"=="xtrue" goto :REPLACE_FULLREG_END

rem use prepared HIVE files
call PERegPorter.bat Tmp UNLOAD 1>nul

if "x%opt[registry.software.compress]%"=="xtrue" (
    del /f /q /a "%X_SYS%\config\SOFTWARE"
    ren "%X_SYS%\config\SOFTWARE.hiv" SOFTWARE
)
if "x%opt[registry.system.compress]%"=="xtrue" (
    del /f /q /a "%X_SYS%\config\SYSTEM"
    ren "%X_SYS%\config\SYSTEM.hiv" SYSTEM
)

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
