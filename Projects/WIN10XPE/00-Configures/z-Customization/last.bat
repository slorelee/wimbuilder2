rem ThemeColors
call theme.bat

rem Explorer Dark or Light Theme
if "x%opt[system.darktheme]%"=="xtrue" (
    rem check WB_PE_VER > 17700
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
) else (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 1 /f
)

if not exist "%X_SYS%\WindowsPowerShell\v1.0\powershell.exe" (
    rem use cmd.exe on directorybackground than powershell.exe

    call :SHOW_CMD_CONTEXTMENU Directory\background
    call :SHOW_CMD_CONTEXTMENU Directory
    call :SHOW_CMD_CONTEXTMENU Drive
)

rem // Shortcuts with 'shortcut' name and transparent icon
if "x%opt[tweak.shortcut.noarrow]%"=="xtrue" (
    call X2X
    reg add "HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\transparent.ico" /f
)

if "x%opt[tweak.shortcut.nonosuffix]%"=="xtrue" (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer /v link /t REG_BINARY /d 00000000 /f
) else (
    reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer /v link /t REG_BINARY /d 16000000 /f
)

goto :EOF

:SHOW_CMD_CONTEXTMENU
reg delete HKLM\Tmp_Software\Classes\%1\shell\Powershell /v ShowBasedOnVelocityId /f
reg add HKLM\Tmp_Software\Classes\%1\shell\Powershell /v HideBasedOnVelocityId /t REG_DWORD /d 0x639bc8 /f
reg delete HKLM\Tmp_Software\Classes\%1\shell\cmd /v HideBasedOnVelocityId /f
reg add HKLM\Tmp_Software\Classes\%1\shell\cmd /v ShowBasedOnVelocityId /t REG_DWORD /d 0x639bc8 /f
rem add icon
reg add HKLM\Tmp_Software\Classes\%1\shell\cmd /v Icon /d cmd.exe /f
rem always show the menu item
rem reg delete HKLM\Tmp_Software\Classes\%1\shell\cmd /v Extended /f
goto :EOF
