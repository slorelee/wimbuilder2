if exist "%_USER_CUSTOMFILES_%\MyCustom\Last\%~nx0" (
    goto :EOF
)

rem -- Remove desktop.ini
rem del /a /q "%X%\Users\Default\Desktop\desktop.ini"
rem del /a /q "%X%\Users\Public\Desktop\desktop.ini"

rem -- no need this file if there is WinXShell.exe's UI_Shutdown
del /a /q "%X%\Users\Default\Desktop\shutdown.bat"


call LuaPin -init "%X_Startup%\00-InitPinIcons.lua"

call PinToTaskbar -paramlist "[[#pProgramFiles#p\WinXShell\WinXShell.exe]], 'UI_Shutdown', '-ui -jcfg wxsUI\\UI_Shutdown.zip\\full.jcfg -blur 5', 'shell32.dll', 27"
call PinToTaskbar Explorer.exe
call PinToTaskbar cmd.exe
call PinToStartmenu "X:\Windows\System32\notepad.exe"

call LuaPin -done

call LuaPin -init "%X_Startup%\PinShortcuts.lua"

call LinkToDesktop Explorer.lnk Explorer.exe
call LinkToDesktop "#{@shell32.dll,22022}.lnk" cmd.exe

if exist "%X_SYS%\seclogon.dll" (
    call LinkToDesktop -paramlist "#{@shutdownux.dll,3052}.lnk" "'SwitchUser.bat', '', 'imageres.dll', 319"
)
