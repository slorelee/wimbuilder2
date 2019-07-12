if "x%opt[build.last_filereg_disabled]%"=="xtrue" goto :EOF

rem incompatible with StartIsBack(SYSTEM account)
if exist "%X%\Program Files\StartIsBack\" ( 
    del /q "%X_SYS%\windows.immersiveshell.serviceprovider.dll"
)

rem display startmenu folders/shortcuts name with language
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\SendTo"
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility"
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories"
attrib +s "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools"

rem New Menu
if %VER[3]% LSS 18300 (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v Classes /t REG_MULTI_SZ /d .library-ms\0.txt\0Folder /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew /v ~reserved~ /t REG_BINARY /d 0800000000000600 /f
)

if not exist "%X_SYS%\dwm.exe" ( 
    reg add HKLM\Tmp_Software\Microsoft\Windows\DWM /v OneCoreNoBootDWM /t REG_DWORD /d 1 /f
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\DWM /v Composition /t REG_DWORD /d 0 /f
)

call 00-Configures\Loader.bat
call za-Slim\Cleanup.bat

rem use prepared HIVE files
call PERegPorter.bat Tmp UNLOAD 1>nul

call :FULLREG DEFAULT
call :FULLREG SOFTWARE
call :FULLREG SYSTEM
call :FULLREG COMPONENTS
call :FULLREG DRIVERS


if exist "_CustomFiles_\final.bat" (
    call "_CustomFiles_\final.bat"
)
goto :EOF

:FULLREG
if exist "%~dp0%1" (
   xcopy /E /Y "%~dp0%1" "%X%\Windows\System32\Config\"
)
goto :EOF
