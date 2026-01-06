local x_path = os.getenv('X')
if not x_path then x_path = 'X:' end

local function alert(str)
  winapi.show_message("", str)
end

local function cd_scriptpath()
  local script_file = get_option('-script')
  local script_path = string.match(script_file, "[\"]?(.+)\\")
  app:call('cd', script_path)
  return script_path
end

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

local whitelist_clsid = {}
whitelist_clsid['{daf95313-e44d-46af-be1b-cbacea2c3065}'] = true -- CLSID_StartMenuProviderFolder
whitelist_clsid['{e345f35f-9397-435c-8f95-4e922c26259e}'] = true -- CLSID_StartMenuPathCompleteProviderFolder
whitelist_clsid['{a00ee528-ebd9-48b8-944a-8942113d46ac}'] = true -- CLSID_StartMenuCommandingProviderFolder
whitelist_clsid['{2f6ce85c-f9ee-43ca-90c7-8a9bd53a2467}'] = true -- FileHistoryDataSource
whitelist_clsid['{04731b67-d933-450a-90e6-4acd2e9408fe}'] = true -- CLSID_SearchFolder
whitelist_clsid['{89d83576-6bd1-4c86-9454-beb04e94c819}'] = true -- mssvp.dll (MSSearch Vista Platform)
whitelist_clsid['{bd7a2e7b-21cb-41b2-a086-b309680c6b7e}'] = true -- mssvp.dll (MSSearch Vista Platform)
whitelist_clsid['{8fd8b88d-30e1-4f25-ac2b-553d3d65f0ea}'] = true -- DXP (Device Stage Shell Extention)
whitelist_clsid['{98f275b4-4fff-11e0-89e2-7b86dfd72085}'] = true -- CLSID_StartMenuLauncherProviderFolder

local function sysfile_check(file, x_path, syswow64)
  local notfound_file = nil

  if File.exists(file) then
    return 0, nil
  end

  if syswow64 == 1 then
    return 1, nil
  end

  x_path = x_path:lower()
  notfound_file = file:lower()
  if notfound_file:find(x_path .. '\\windows\\system32\\') ~= 1 then
    return 1, nil
  end

  notfound_file = notfound_file:gsub(x_path .. '\\windows\\system32\\', x_path .. '\\Windows\\SysWOW64\\')
  if not File.exists(notfound_file) then
    return 2,  notfound_file
  end
  return 0, nil
end

local function walk_clsid_reg(reg_file, syswow64)
  local root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Classes\CLSID]]
  if syswow64 == 1 then
    root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Wow6432Node\Classes\CLSID]]
  end
  local k, err = winapi.open_reg_key(root_key)
  if not k then return app:print('failed to open reg key', err) end
  local keys = k:get_keys()
  local file = ''
  local tbl = {}
  table.remove(keys, 1) -- remove CLSID
  for k,v in ipairs(keys) do
    file = reg_read(root_key ..'\\' .. v .. '\\InprocServer32')
    if not file then
      file = reg_read(root_key ..'\\' .. v .. '\\InProcHandler32')
    end
    if not file then
      file = reg_read(root_key ..'\\' .. v .. '\\LocalServer32')
    end
    if file then
      table.insert(tbl, v)
      table.insert(tbl, file)
    end
  end

  -- expand environment varibles for all
  -- table => string
  local str = table.concat(tbl, '\n')

  str = string.lower(str)
  str = string.gsub(str, '%%systemroot%%', x_path .. '\\Windows')
  str = string.gsub(str, '%%windir%%', x_path .. '\\Windows')
  str = string.gsub(str, '%%programfiles%%', x_path .. '\\Program Files')
  str = string.gsub(str, '%%programfiles[(]x86[)]%%', x_path .. '\\Program Files(x86)')
  str = string.gsub(str, '%%commonprogramfiles%%', x_path .. '\\Program Files\\Common Files')
  
  log(str)
  -- string => table
  tbl = {}

  string.gsub(str, "[^\n]+", function (s)
    table.insert(tbl, s)
  end)

  app:print(#tbl)

  local invaild_tbl = {}
  local invaild_tbl_clsid = {}
  local n = #tbl

  local fill_path, pos

  for i = 1, n, 2 do
    k = tbl[i]
    file = tbl[i + 1]
    fill_path = ''
    if file:sub(1, 1) == '\"' then
      file = file:sub(2)
      fill_path = '\"'
    end
    if file:sub(2, 3) ~= ':\\' then
      if syswow64 ~= 1 then
        file = x_path .. '\\Windows\\System32\\' .. file
      else
        file = x_path .. '\\Windows\\SysWOW64\\' .. file
      end
    else
      file = x_path .. file:sub(3)
    end
    fill_path = fill_path .. file

    if fill_path:sub(1, 1) == '\"' then
      pos = file:find('\"')
      if pos then file = file:sub(1, pos - 1) end
    end
    
    -- remove parameter(s)
    pos = file:find('[.]')
    if pos then
      pos = file:find(' ', pos)
      if pos then file = file:sub(1, pos - 1) end
    end

    local notfound_cnt, notfound_file = sysfile_check(file, x_path, syswow64)

    if notfound_cnt > 0 then
      table.insert(invaild_tbl, k)
      if not whitelist_clsid[k] then
        invaild_tbl_clsid[k] = true
        reg_file:write(';' .. fill_path .. '\n')
        if notfound_cnt == 2 then
          reg_file:write(';' .. notfound_file .. '\n')
        end
        reg_file:write('[-' .. root_key .. '\\' .. k .. ']\n')
      end
    end
  end

  log('##INVAILD##')
  str = table.concat(invaild_tbl, '\n')
  log(str)

  invaild_tbl = {}
  root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Classes\Interface]]
  k, err = winapi.open_reg_key(root_key)
  if not k then return app:print('failed to open reg key', err) end
  local clsid = nil
  local keys = k:get_keys()

  app:print(#keys)
  table.remove(keys, 1) -- remove Interface
  for k,v in ipairs(keys) do
    clsid = reg_read(root_key ..'\\' .. v .. '\\ProxyStubClsid32')
    if clsid then
      if invaild_tbl_clsid[clsid] then
        -- os.exec('reg delete \"' .. root_key .. '\\' .. k .. '\" /f')
        reg_file:write('[-' .. root_key .. '\\' .. v .. ']\n')
      end
    end
  end

end

-- HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Winners
local function walk_winners_reg(reg_file, winsxslist)
  local root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Winners]]
  local k, err = winapi.open_reg_key(root_key)
  if not k then return app:print('failed to open reg key', err) end
  local keys = k:get_keys()
  local file = ''
  table.remove(keys, 1) -- remove Winners
  local _fn, _
  for k,v in ipairs(keys) do
    _fn = v:match('.-_(.-)_')
    if _fn == nil then _fn = '' end
    if _fn == 'c' then _fn = '' end -- c_xxxx.inf
    if _fn:match('([0-9a-f]+)') ~= _fn then
      if winsxslist:find(v:match('(.+)_.+'), 0, true) == nil then
        reg_file:write('[-' .. root_key .. '\\' .. v .. ']\n')
      end
    else
      log(v)
    end
  end
end

-- HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId

local function walk_winrt_reg(reg_file, syswow64)
  local root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassID]]
  if syswow64 == 1 then
    root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Wow6432Node\Microsoft\WindowsRuntime\ActivatableClassId]]
  end
  local k, err = winapi.open_reg_key(root_key)
  if not k then
    log('failed to open reg key:' .. root_key)
    return app:print('failed to open reg key', err)
  end
  local keys = k:get_keys()
  local file = ''
  local tbl = {}
  table.remove(keys, 1) -- remove ActivatableClassId
  for k,v in ipairs(keys) do
    file = reg_read(root_key ..'\\' .. v, 'DllPath')
    if file then
      table.insert(tbl, v)
      table.insert(tbl, file)
    end
  end

  -- expand environment varibles for all
  -- table => string
  local str = table.concat(tbl, '\n')

  str = string.lower(str)
  str = string.gsub(str, '%%systemroot%%', x_path .. '\\Windows')
  str = string.gsub(str, '%%windir%%', x_path .. '\\Windows')
  str = string.gsub(str, '%%programfiles%%', x_path .. '\\Program Files')
  str = string.gsub(str, '%%commonprogramfiles%%', x_path .. '\\Program Files\\Common Files')
  
  log(str)
  -- string => table
  tbl = {}

  string.gsub(str, "[^\n]+", function (s)
    table.insert(tbl, s)
  end)

  app:print(#tbl)

  local invaild_tbl = {}
  local invaild_tbl_clsid = {}
  local n = #tbl


  for i = 1, n, 2 do
    k = tbl[i]
    file = tbl[i + 1]
    if file:sub(2, 3) ~= ':\\' then
      if syswow64 ~= 1 then
        file = x_path .. '\\Windows\\System32\\' .. file
      else
        file = x_path .. '\\Windows\\SysWOW64\\' .. file
      end
    else
      file = x_path .. file:sub(3)
    end

    local notfound_cnt, notfound_file = sysfile_check(file, x_path, syswow64)

    if notfound_cnt > 0 then
      table.insert(invaild_tbl, k)

      invaild_tbl_clsid[k] = true
      reg_file:write(';' .. file .. '\n')
      if notfound_cnt == 2 then
        reg_file:write(';' .. notfound_file .. '\n')
      end
      reg_file:write('[-' .. root_key .. '\\' .. k .. ']\n')
    end
  end

  log('##INVAILD##')
  str = table.concat(invaild_tbl, '\n')
  log(str)

  invaild_tbl = {}
  root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Microsoft\WindowsRuntime\CLSID]]
  if syswow64 == 1 then
    root_key = [[HKEY_LOCAL_MACHINE\Tmp_SOFTWARE\Wow6432Node\Microsoft\WindowsRuntime\CLSID]]
  end

  k, err = winapi.open_reg_key(root_key)
  if not k then return app:print('failed to open reg key', err) end
  local clsid = nil
  local keys = k:get_keys()

  app:print(#keys)

  for k,v in ipairs(keys) do
    clsid = reg_read(root_key ..'\\' .. v, 'ActivatableClassId')
    if clsid then
      if invaild_tbl_clsid[clsid:lower()] then
        -- os.exec('reg delete \"' .. root_key .. '\\' .. k .. '\" /f')
        reg_file:write('[-' .. root_key .. '\\' .. v .. ']\n')
      end
    end
  end

end

local function main()
  local path = cd_scriptpath()
  app:print(path)
  log_init('_runlog.log')

  local reg_file = io.open('_RemoveInvaildItems_Reg.txt', 'w+')
  reg_file:write('Windows Registry Editor Version 5.00\n\n')
  walk_clsid_reg(reg_file, 0)
  -- walk_clsid_reg(reg_file, 1) -- SysWOW64
  local mfile = io.open('_WinSxS_Manifests.txt')
  if mfile ~= nil then
    local filelist = mfile:read("a*")
    mfile:close()
    filelist = string.gsub(filelist, "_[^_]+(_[^_]+_[^_\\n]+)[\\.]manifest", "%1")
    log('WinSxsManifests:')
    log(filelist)
    walk_winners_reg(reg_file, filelist)
  end
  walk_winrt_reg(reg_file, 0)
  walk_winrt_reg(reg_file, 1) -- SysWOW64
  reg_file:close()
  log_close()
end

main()
app:call('sleep', 500)
