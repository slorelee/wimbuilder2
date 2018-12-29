if not "x%opt[shell.app]%"=="xwinxshell" goto :EOF
cd /d "%~dp0"
call X2X
call SharedPatch NewBrowseDlg

