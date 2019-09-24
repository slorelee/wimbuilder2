require('lua_helper.lua_helper')

local lang = os.getenv('WB_PE_LANG')
local x_sys = os.getenv('X_SYS')

local function alert(str)
  winapi.show_message("", str)
end

local function cd_scriptpath()
  local script_file = get_option('-script')
  local script_path = string.match(script_file, "(.+)\\")
  app:call('cd', script_path)
end

local function get_resstr(file, id)
  local res = str.format('#{@%s\\%s\\%s.mui,%s}', x_sys, lang, file, id)
  return app:call('resstr', res)
end

local function main()
  cd_scriptpath()
  reg_write([[HKEY_LOCAL_MACHINE\Tmp_Software\Classes\DesktopBackground\Shell\Display]], '', get_resstr('display.dll', 4))
  reg_write([[HKEY_LOCAL_MACHINE\Tmp_Software\Classes\DesktopBackground\Shell\Display]], 'Icon', [[X:\Windows\Resources\Icons\display.dll_1.ico]])

  reg_write([[HKEY_LOCAL_MACHINE\Tmp_Software\Classes\DesktopBackground\Shell\Personalize]], '', get_resstr('themecpl.dll', 10))
  reg_write([[HKEY_LOCAL_MACHINE\Tmp_Software\Classes\DesktopBackground\Shell\Personalize]], 'Icon', [[X:\Windows\Resources\Icons\themecpl.dll_1.ico]])
end

main()
