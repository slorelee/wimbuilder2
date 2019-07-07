cd /d "%~dp0"

call V2X WinXShell
if not exist "%X%\Program Files\WinXShell" goto :EOF

rem Grant right for Administrator
call _ACLRegKey Tmp_Software\Classes\ms-settings
call _ACLRegKey Tmp_Software\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}

if not "x%opt[shell.app]%"=="xwinxshell" goto :EOF
call SharedPatch NewBrowseDlg
call SharedPatch CustomCompmgmt
