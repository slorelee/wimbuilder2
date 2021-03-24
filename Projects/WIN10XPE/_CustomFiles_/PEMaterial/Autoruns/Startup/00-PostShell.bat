rem // Hide start menu Startup folders
rem attrib.exe +s +h "X:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
attrib.exe +s +h "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

rem -- Remove desktop.ini
del /a /q "X:\Users\Default\Desktop\desktop.ini"
del /a /q "X:\Users\Public\Desktop\desktop.ini"
del /a /q "%USERPROFILE%\Desktop\desktop.ini"

rem -- Show localized name for "Desktop" folder
start WinXShell.exe -code "reg_write([[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}]], '', app:call('resstr', '#{@shell32.dll,21769}'))"

rem -- clear Pinned icons by other User (Switch User)
del /a /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu\*.lnk"
del /a /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*.lnk"


rem -- Init Pin icons
if exist "%~dp000-InitPinIcons.lua" (
  "%ProgramFiles%\WinXShell\WinXShell.exe" -script "%~dp000-InitPinIcons.lua"
)

