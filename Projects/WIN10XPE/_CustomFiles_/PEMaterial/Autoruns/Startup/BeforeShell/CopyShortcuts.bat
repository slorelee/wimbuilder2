rem copy logoned Administrator's shortcuts to SYSTEM

if not "x%USERNAME%"=="xSYSTEM" goto :EOF
if not exist "X:\Users\Administrator" goto :EOF

xcopy /s /y "X:\Users\Administrator\Desktop\*.lnk" "%USERPROFILE%\Desktop\"
xcopy /s /y "X:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\*.lnk" "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\"

set RunOnce=1

