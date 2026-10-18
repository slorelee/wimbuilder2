rem=nil --[=[
@echo off && cd /d "%~dp0"
set "WINXSHELL=%ProgramFiles%\WinXShell\WinXShell.exe"
if exist "%WINXSHELL%" start "PinIcons" /wait "%WINXSHELL%" -script "%~0"
goto :EOF
]=]
--- -- ====================  lua script  ====================

local isBeforeShellPhase = Script.Path:sub(-12) == '\\BeforeShell'

if WinPE:IsTaskbarPinOK() == isBeforeShellPhase then
    if not isBeforeShellPhase and os.getenv('USERNAME') ~= 'SYSTEM' then
        -- the explorer.exe started earlier then BeforeShell phase in Admin account by SYSTEM
        -- restart to refresh the Pinned icons
        Shell:Close()
    end
    os.exit(0)
end

-- Pin icons

