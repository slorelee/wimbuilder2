
call AudioDriverPatch.bat

call ComputerName.bat
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f

rem NumLock on/off
if not "x%opt[system.numlock]%"=="xfalse" (
    reg add "HKLM\Tmp_Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /d 2 /f
)
goto :EOF
