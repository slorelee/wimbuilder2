cd /d "%~dp0"

call V2X WinXShell
if not exist "%X%\Program Files\WinXShell" goto :EOF
md "%X%\Program Files\WinXShell\%WB_PE_LANG%"
copy /y "%X_SYS%\%WB_PE_LANG%\systemcpl.dll.mui" "%X%\Program Files\WinXShell\%WB_PE_LANG%\"

rem Grant right for Administrator
call _ACLRegKey Tmp_Software\Classes\ms-settings
call _ACLRegKey Tmp_Software\Classes\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}

set _ui_opt=-hidewindow

if "%opt[support.network]%"=="false" goto :UI_VOLUME
if "x%opt[winxshell.ui_wifi.startup]%"=="xtrue" (
    echo "%%ProgramFiles%%\WinXShell\WinXShell.exe" -luacode "wxsUI('UI_WIFI',nil,'%_ui_opt%')"
) > "%X_Startup%\Startup_UI_WIFI.bat"

:UI_VOLUME
if "%opt[support.audio]%"=="false" goto :WXSUI_END
if "x%opt[winxshell.ui_volume.no_beep]%"=="xtrue" (
  set "_ui_opt=-hidewindow -nobeep"
)

if "x%opt[winxshell.ui_volume.startup]%"=="xtrue" (
  echo "%%ProgramFiles%%\WinXShell\WinXShell.exe" -luacode "wxsUI('UI_Volume',nil,'%_ui_opt%')"
) > "%X_Startup%\Startup_UI_Volume.bat"

:WXSUI_END
set _ui_opt=

if not "x%opt[shell.app]%"=="xwinxshell" goto :EOF
call SharedPatch NewBrowseDlg
call SharedPatch CustomCompmgmt
