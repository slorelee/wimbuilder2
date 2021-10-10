if not "x%opt[shell.startmenu]%"=="xClassicShell" goto :EOF
call V2X "Classic Shell"

rem Account Pictures
set "_AccPic_Path=%X%\ProgramData\Microsoft\User Account Pictures"
if not exist "%_AccPic_Path%\" mkdir "%_AccPic_Path%"
copy /y "%WB_ROOT%\%APPDATA_DIR%\_CustomFiles_\AccountPictures\user-200.png" "%_AccPic_Path%\"
set _AccPic_Path=

