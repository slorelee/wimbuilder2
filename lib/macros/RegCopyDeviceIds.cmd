rem=rem --[=[ 1>nul
rem -- ==================== batch script ====================
echo [MACRO]%~n0 %*
set "f0=%~f0"&&set "dp0=%~dp0"&&set "_Loc=%dp0%"
if not exist "%WINXSHELL%" goto :EOF

start /wait "%~nx0" "%WINXSHELL%" -script "%f0%" -subkey %~1 -inf %~2 -log "%WB_TMP_PATH%\RegCopyDeviceIds.log" 
type "%WB_TMP_PATH%\RegCopyDeviceIds.log"
goto :EOF
]=]

--- -- ====================  lua script  ====================

local log_file = nil
local function log_init(file)
  log_file = io.open(file, 'w+')
end

local function log(msg)
  if not msg then msg = '(NULL)' end
  log_file:write(msg .. "\n")
end

local function log_close()
  log_file:close()
end


local function walk_reg(subkey, inf_name)
  local root_key = [[HKEY_LOCAL_MACHINE\Src_Drivers\DriverDatabase\DeviceIds]]
  if subkey ~= '' then root_key = root_key .. '\\' .. subkey end
  local k, err = winapi.open_reg_key(root_key)
  if not k then return app:print('failed to open reg key', err) end
  local keys = k:get_keys()
  local flag = ''
  local tbl = {}

  for k,v in ipairs(keys) do
    flag, err = reg_read(root_key ..'\\' .. v, inf_name)
    if flag then
      table.insert(tbl, [[[MACRO]RegCopy "HKLM\DRIVERS\DriverDatabase\DeviceIds\]] .. subkey .. '\\' .. v .. '\"')
      exec([[cmd /c call RegCopy "HKLM\DRIVERS\DriverDatabase\DeviceIds\]] .. subkey .. '\\' .. v .. '\"')
    end
  end

  -- table => string
  local str = table.concat(tbl, '\n')
  log(str)

end

local function main()
  log_init(get_option('-log'))
  log('rem CMDLINE:' .. app:info('cmdline'))
  walk_reg(get_option('-subkey'), get_option('-inf'))
  log_close()
end

main()

