cd /d "%~dp0"
if not exist X_%WB_PE_ARCH% goto :EOF
call X2X

rem Grant right for Administrator
call _ACLRegKey Tmp_Software\Classes\ms-settings

if not "x%opt[shell.app]%"=="xwinxshell" goto :EOF
call SharedPatch NewBrowseDlg

