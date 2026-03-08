
call AudioDriverPatch.bat

call ComputerName.bat
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f

rem NumLock on/off
if not "x%opt[system.numlock]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /d 2 /f
) else (
    reg add "HKLM\Tmp_Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /d 0 /f
    if exist "%X_SYS%\Pecmd.ini" call TextReplace "%X_SYS%\Pecmd.ini" "NUMK 1" "NUMK 0" g
)
goto :EOF
