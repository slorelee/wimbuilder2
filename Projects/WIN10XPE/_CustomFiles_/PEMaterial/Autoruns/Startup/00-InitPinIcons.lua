rem=nil --[=[
@echo off && cd /d "%~dp0"
set "WINXSHELL=%ProgramFiles%\WinXShell\WinXShell.exe"
if exist "%WINXSHELL%" start "PinIcons" /wait "%WINXSHELL%" -script "%~0"
goto :EOF
]=]
--- -- ====================  lua script  ====================


--[[
-- Samples:
Taskbar:Pin('%ProgramFiles%\\WinXShell\\WinXShell.exe', 'UI_Shutdown', '-ui -jcfg wxsUI\\UI_Shutdown.zip\\full.jcfg -blur 5', 'shell32.dll', 27)
Taskbar:Pin('Explorer.exe')
Taskbar:Pin('cmd.exe')
Startmenu:Pin('X:\\Windows\\System32\\notepad.exe')
]]

local isBeforeShellPhase = Script.Path:sub(-12) == '\\BeforeShell'
if WinPE:IsTaskbarPinOK() == isBeforeShellPhase then
    os.exit(0)
end

-- Pin icons

