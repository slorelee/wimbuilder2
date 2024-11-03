if "x%opt[shell.startmenu]%"=="xStartIsBack" goto :StartIsBackFiles
if "x%opt[shell.startmenu]%"=="xStartAllBack" goto :StartAllBackFiles
if not "x%opt[shell.startmenu]%"=="xStartXBack" goto :EOF

set opt[shell.startmenu]=StartIsBack
if %VER[3]% GEQ 22000 (
    rem use StartAllBack for Windows 11
    set opt[shell.startmenu]=StartAllBack
    goto :StartAllBackFiles
)

:StartIsBackFiles
set _startMenuName=StartIsBack
call V2X StartIsBack -extract StartIsBackPlusPlus_setup[v%opt[SIB.version]%].exe "%X_PF%\StartIsBack"

if not exist "%X%\Program Files\StartIsBack\StartIsBack64.dll" goto :EOF
if not "%WB_PE_ARCH%"=="x64" del /f "%X%\Program Files\StartIsBack\StartIsBack64.dll"
del /f "%X%\Program Files\StartIsBack\StartIsBackARM64.dll" 2> nul
rem del /f "%X%\Program Files\StartIsBack\startscreen.exe" 2> nul
rem del /f "%X%\Program Files\StartIsBack\UpdateCheck.exe" 2> nul
goto :End_StartXBackFiles

:StartAllBackFiles
set _startMenuName=StartAllBack
call V2X StartAllBack -extract StartAllBack_*_setup.exe "%X_PF%\StartAllBack"

if not exist "%X_PF%\StartAllBack\StartAllBackX64.dll" goto :EOF
if not "%WB_PE_ARCH%"=="arm64" (
    del /f "%X%\Program Files\StartAllBack\StartAllBackLoaderA64.dll" 2> nul
    del /f "%X%\Program Files\StartAllBack\StartAllBackA64.dll" 2> nul
    del /f "%X%\Program Files\StartAllBack\DarkMagicLoaderA64.exe" 2> nul
    del /f "%X%\Program Files\StartAllBack\DarkMagicA64.dll" 2> nul
)
if  not "%WB_PE_ARCH%"=="x64" (
    del /f "%X%\Program Files\StartAllBack\StartAllBackLoaderX64.dll" 2> nul
    del /f "%X%\Program Files\StartAllBack\StartAllBackX64.dll" 2> nul
    del /f "%X%\Program Files\StartAllBack\DarkMagicLoaderX64.exe" 2> nul
    del /f "%X%\Program Files\StartAllBack\DarkMagicX64.dll" 2> nul
)
if  not "%WB_PE_ARCH%"=="x86" (
    del /f "%X%\Program Files\StartAllBack\DarkMagicLoaderX86.exe" 2> nul
    del /f "%X%\Program Files\StartAllBack\DarkMagicX86.dll" 2> nul
)

rem del /f "%X%\Program Files\StartAllBack\UpdateCheck.exe" 2> nul
:End_StartXBackFiles

rem Support SIB v2.9.4
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell /v TabletMode /t REG_DWORD /d 0 /f

rem call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
authui.dll
nrtapi.dll
shdocvw.dll
shutdownux.dll
sud.dll
van.dll

:end_files

if "%_startMenuName%"=="StartAllBack" (
    reg import "%~dp0SAB_RegDefault.reg"
    reg import "%~dp0SAB_RegSoftware.reg"
    if "%WB_PE_ARCH%"=="arm64"  reg import "%~dp0SAB_RegSoftware_arm64.reg"
) else (
    reg import "%~dp0SIB_RegDefault.reg"
    reg import "%~dp0SIB_RegSoftware.reg"
)

rem keep UpdateCheck.exe to update
goto :WinInfoUpdated

rem Support SAB v3.8
reg add HKLM\Tmp_Default\Software\StartIsBack /v WinBuild /t REG_DWORD /d %VER[3]% /f

call GetLocaleId %WB_PE_LANG%
set WinLangID=%GetLocaleId_Ret%
if "x%WinLangID%"=="x" set WinLangID=1033
reg add HKLM\Tmp_Default\Software\StartIsBack /v WinLangID /t REG_DWORD /d %WinLangID% /f

:WinInfoUpdated

rem disable Win32 tray clock
reg add HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell /v UseWin32TrayClockExperience /t REG_DWORD /d 0 /f

if "%WB_PE_ARCH%"=="x64" (
    if not "x%opt[build.wow64support]%"=="xtrue" (
        del /f "%X%\Program Files\StartIsBack\StartIsBack32.dll"
        copy /y "%X_SYS%\regedt32.exe" "%X%\Program Files\%_startMenuName%\%_startMenuName%Cfg.exe"
        (echo @start explorer.exe ::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{BB06C0E4-D293-4F75-8A90-CB05B6477EEE}) > "%X%\Program Files\%_startMenuName%\%_startMenuName%CfgCmd.cmd"
        reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%_startMenuName%Cfg.exe" /v Debugger /d "X:\Program Files\%_startMenuName%\%_startMenuName%CfgCmd.cmd" /f
    )
)

if exist "%X_PF%\StartAllBack\StartAllBackCfgCmd.cmd" (
    reg delete HKLM\Tmp_Software\Classes\sib-activate /f
    reg delete HKLM\Tmp_Software\Classes\sib-reactivate /f
)

if "%_startMenuName%"=="StartAllBack" goto :update_config

rem update dll path for x86
if "%WB_PE_ARCH%"=="x64" goto :update_config
call :update_clsid_dll_path {865e5e76-ad83-4dca-a109-50dc2113ce9b}
call :update_clsid_dll_path {a2a9545d-a0c2-42b4-9708-a0b2badd77c9}
call :update_clsid_dll_path {AD1405D2-30CF-4877-8468-1EE1C52C759F}
call :update_clsid_dll_path {c71c41f1-ddad-42dc-a8fc-f5bfc61df958}
call :update_clsid_dll_path {E5C31EC8-C5E6-4E07-957E-944DB4AAD85E}
call :update_clsid_dll_path {FCEA18FF-BC55-4E63-94D7-1B2EFBFE706F}
reg add HKLM\Tmp_Software\Classes\CLSID\{FCEA18FF-BC55-4E63-94D7-1B2EFBFE706F} /v LocalizedString /t REG_EXPAND_SZ /d @%^ProgramFiles^%\StartIsBack\StartIsBack32.dll,-510 /f

:update_config
if "x%opt[SIB.skin]%"=="x" set opt[SIB.skin]=Plain8
set SIB_KEY=HKLM\Tmp_Default\Software\StartIsBack
reg add %SIB_KEY% /v AlterStyle /d "X:\Program Files\%_startMenuName%\Styles\%opt[SIB.skin]%.msstyles" /f
reg add %SIB_KEY% /v TaskbarStyle /d "X:\Program Files\%_startMenuName%\Styles\%opt[SIB.skin]%.msstyles" /f

if "x%opt[SIB.skin]%"=="xPlain10" (
    reg add %SIB_KEY% /v TaskbarStyle /d "X:\Program Files\%_startMenuName%\Styles\Windows 10.msstyles" /f
)

rem // StartIsBack Display as flyout menu (Windows XP style) value 0/1
if not "x%opt[SIB.programs.flyout]%"=="xfalse" (
    reg add %SIB_KEY% /v AllProgramsFlyout /t REG_DWORD /d 1 /f
) else (
    reg add %SIB_KEY% /v AllProgramsFlyout /t REG_DWORD /d 0 /f
)

rem // StartIsBack Start Menu Opaque
if not "x%opt[SIB.style.opaque]%"=="xfalse" (
    reg add %SIB_KEY% /v StartMenuColor  /t REG_DWORD /d 0xffffffff /f
    reg add %SIB_KEY% /v StartMenuBlur   /t REG_DWORD /d 2 /f
    reg add %SIB_KEY% /v StartMenuAlpha  /t REG_DWORD /d 255 /f
    reg add %SIB_KEY% /v TaskbarColor  /t REG_DWORD /d 0xffffffff /f
    reg add %SIB_KEY% /v TaskbarBlur   /t REG_DWORD /d 0 /f
    reg add %SIB_KEY% /v TaskbarAlpha  /t REG_DWORD /d 255 /f
)
set SIB_KEY=

rem Account Pictures
set "_AccPic_Path=%X%\ProgramData\Microsoft\User Account Pictures"
if not exist "%_AccPic_Path%\" mkdir "%_AccPic_Path%"
rem copy /y "%WB_ROOT%\%APPDATA_DIR%\_CustomFiles_\user-200.png" "%_AccPic_Path%\"
copy /y "%WB_ROOT%\%APPDATA_DIR%\_CustomFiles_\AccountPictures\*.*" "%_AccPic_Path%\"
rem 2.9 and later
reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\PropertySystem\PropertyHandlers\.accountpicture-ms /ve /d {9a02e012-6303-4e1e-b9a1-630f802592c5} /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\AccountPicture /v SourceId /d user-200 /f
call RegCopyEx Classes ".accountpicture-ms,accountpicturefile"
set "_AccPic_Path=%X%\Users\Default\AppData\Roaming\Microsoft\Windows\AccountPictures"
if not exist "%_AccPic_Path%\" mkdir "%_AccPic_Path%"
copy /y "%WB_ROOT%\%APPDATA_DIR%\_CustomFiles_\AccountPictures\*.*" "%_AccPic_Path%\"
set _AccPic_Path=

set _startMenuName=
goto :EOF

:update_clsid_dll_path
reg add HKLM\Tmp_Software\Classes\CLSID\%1\InProcServer32 /ve /d "X:\\Program Files\\StartIsBack\\StartIsBack32.dll" /f
