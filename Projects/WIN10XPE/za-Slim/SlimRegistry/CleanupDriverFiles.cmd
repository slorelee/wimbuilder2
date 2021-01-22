rem=rem --[=[ 1>nul
rem -- ==================== batch script ====================
if not exist "%WINXSHELL%" goto :EOF

echo Windows Registry Editor Version 5.00 > _RemoveRegDriverFiles.reg
echo. >> _RemoveRegDriverFiles.reg

if exist _RemoveDriverFiles.txt del /q _RemoveDriverFiles.txt
start /wait "%~nx0" "%WINXSHELL%" -console -script "%~dpnx0" -hive DRIVERS -x "%X%"
start /wait "%~nx0" "%WINXSHELL%" -console -script "%~dpnx0" -hive SYSTEM -x "%X%"
if not exist _RemoveRegDriverFiles.reg goto :EOF
reg import _RemoveRegDriverFiles.reg
for /f "delims=" %%i in (_RemoveDriverFiles.txt) do (
  if exist "%X_SYS%\DriverStore\FileRepository\%%i\" (
    echo RemoveDriverFile:FileRepository\%%i
    rd /s /q "%X_SYS%\DriverStore\FileRepository\%%i"
  )
)
goto :EOF
]=]

--- -- ====================  lua script  ====================
local function cd_scriptpath()
  local script_file = get_option('-script')
  local script_path = string.match(script_file, "[\"]?(.+)\\")
  app:call('cd', script_path)
  return script_path
end

local function write_file(file, mode, data)
  local f = io.open(file, mode)
  f:write(data)
  f:close()
end

local function walk_inf_reg(infdir, hive)
  local root_key = 'HKEY_LOCAL_MACHINE\\Tmp_' .. hive .. '\\DriverDatabase'
  local k, err = winapi.open_reg_key(root_key .. '\\DriverInfFiles')
  if not k then return app:print('failed to open reg key', err) end
  local keys = k:get_keys()
  local flag = ''
  local tbl_reg = {}
  local tbl_file = {}

  for k,v in ipairs(keys) do
    if not File.exists(infdir .. '\\' .. v) then
      local f, err = reg_read(root_key ..'\\DriverInfFiles\\' .. v, 'Active')
      table.insert(tbl_reg, root_key ..'\\DriverInfFiles\\' .. v)
      table.insert(tbl_reg, root_key ..'\\DriverPackages\\' .. f)
      table.insert(tbl_file, f)
    end
  end

  -- table => string
  local str = '[-'
  str = str .. table.concat(tbl_reg, ']\n[-') .. ']\n\n'
  write_file('_RemoveRegDriverFiles.reg', 'a+', str)
  str = table.concat(tbl_file, '\n') .. '\n\n'
  write_file('_RemoveDriverFiles.txt', 'a+', str)
end

local function main()
  local hive = get_option('-hive')
  local dir = get_option('-x')
  dir = dir:sub(2, -2)
  cd_scriptpath()
  walk_inf_reg(dir .. '\\Windows\\INF', hive)
end

main()

