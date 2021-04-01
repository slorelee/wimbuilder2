--[=[ 2>nul
rem -- ==================== batch script ====================
set "f0=%~f0"&&set "dp0=%~dp0"&&set "_Loc=%dp0%"
call :%1
goto :EOF


:BeforeShell

if exist "%dp0%wallpaper.jpg" (
    copy /y "%dp0%wallpaper.jpg" "%windir%\Web\wallpaper\img0.jpg"
    start WinXShell.exe -code "app:call('Desktop::SetWallpaper',[[%windir%\Web\wallpaper\img0.jpg]])"
)

xcopy /E /Y "%dp0%Program Files\*.*" "%ProgramFiles%\"

rem ---------------------------------------------------------------------------------






rem ---------------------------------------------------------------------------------
start /wait WinXShell.exe -script "%f0%"
goto :EOF

:PostShell
if not "x%USERNAME%"=="xSYSTEM" (
    start WinXShell.exe -code "app:call('Desktop::SetWallpaper', [[%windir%\Web\wallpaper\img0.jpg]])"
)
start /wait WinXShell.exe -script "%f0%"
goto :EOF
]=]

--- -- ====================  lua script  ====================
local dp0 = os.getenv('dp0')

local function AppToDesk(path, arch)
   local name = path:match('([^\\]+)$')
   LINK('%Desktop%\\' .. name .. '.lnk', dp0 .. 'PortableApps\\' .. path .. arch .. '.exe')
end

function BeforeShell()
  -- LINK([[%Desktop%\BOOTICE.lnk]], dp0 ..[[PortableApps\BOOTICE\BOOTICEx64.exe]])
  -- LINK([[%Desktop%\Install Office2007.lnk]], dp0 .. [[Installers\Office2007\install.cmd]], nil, dp0 .. [[Installers\Office2007\Office.ico]], 0)
  -- LINK([[%Desktop%\Startup PotPlayer.lnk]], dp0 .. [[Installers\PotPlayer\install.cmd]], nil, dp0 .. [[Installers\PotPlayer\Pot.ico]], 0)
  -- AppToDesk('BOOTICE\\BOOTICE', 'x%_V8664%')
  -- AppToDesk('CPU-Z\\cpuz', '_x%_V3264%')
  -- AppToDesk('NTPWEdit\\ntpwedit', '%_V64%')


end

function PostShell()
  -- Startmenu:Pin(dp0 .. [[PortableApps\BOOTICE\BOOTICEx%_V8664%.exe]])
  -- Taskbar:Pin(dp0 .. [[PortableApps\Everything\Everything.exe]])



end

local function main()
  local phase = os.getenv('STARTUP_PHASE')
  if phase then load(phase .. '()')() end
end
main()
