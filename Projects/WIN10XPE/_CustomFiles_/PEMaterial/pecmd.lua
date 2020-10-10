
local logon_user = 'SYSTEM'
local explorer_shell = false

-- declare functions
local t -- alias i18n.t()
local set_progress, LINK
local log
-- shel = exec


local function OSInit()
  if File.exists('X:\\Windows\\Temp\\OSInited.txt') then return 1 end
  --set_progress('%{System configuration, Please Wait...}')

  -- show cursor, and wpeinit.exe
  exec('/wait', '%WinDir%\\System32\\winpeshl.exe')

  -- // Load Display drivers
  exec('/wait /hide', [[Drvload.exe %WinDir%\inf\basicdisplay.inf %WinDir%\inf\basicrender.inf %WinDir%\inf\c_display.inf %WinDir%\inf\display.inf %WinDir%\inf\displayoverride.inf]])
  -- // Try resolution(s)
  Screen:DispTest({'1024x768', '1152x864', '1366x768'})

  File.delete('X:\\Users\\Public\\Desktop\\desktop.ini')
  local f = io.open('X:\\Windows\\Temp\\OSInited.txt', 'w+');f:write('done');f:close();
  return 0
end

local function CustomOSInit()
  if File.exists('X:\\Windows\\Temp\\CustomOSInited.txt') then return 1 end

  set_progress(t('Prepare for system ...'))
  exec('/hide', 'cmd.exe /c ' .. script_path .. '\\Autoruns\\PEStartupMain.bat OSInit')

  local f = io.open('X:\\Windows\\Temp\\CustomOSInited.txt', 'w+');f:write('done');f:close();
end

local function PreShell()
  -- LetterSwap
  -- // exec('/wait /hide', [[LetterSwap.exe /auto /bootdrive Y:\CDUsb.y /Log %WinDir%\System32\LetterSwap.log]])

  -- Load oem drivers before shell in background
  -- exec('/hide', [[%WinDir%\System32\pnputil.exe /add-driver %WinDir%\inf\oem*.inf]])

  -- Prepare environment variables

  local homeprofile = 'X:\\Users\\Default'
  if logon_user ~= 'SYSTEM' then
    homeprofile = 'X:\\Users\\' .. logon_user
  end
  os.setenv('HOMEPROFILE', homeprofile) -- only for PE
  os.setenv('Desktop', homeprofile .. '\\Desktop')
  os.setenv('Programs', homeprofile .. [[\AppData\Roaming\Microsoft\Windows\Start Menu\Programs]])
  if File.exists('X:\\Windows\\explorer.exe') then
    explorer_shell = true
  end
end

local function CustomShortcuts()
end

local function Shortcuts()
  if File.exists('X:\\Windows\\Temp\\Shortcuts.txt') then return 1 end
  set_progress(t('Prepare shortcuts ...'))

  CustomShortcuts()

  local f = io.open('X:\\Windows\\Temp\\Shortcuts.txt', 'w+');f:write('done');f:close();
end

local function RunShell()
  -- if logon_user ~= 'SYSTEM' then return end
  if explorer_shell then
    shel('explorer.exe')
  else
    shel('WinXShell.exe -winpe')
  end
end

local function LoadShell()
  set_progress(t('load shell ...'))
  exec('PECMD.EXE EXEC -su ctfmon.exe')

  -- RunBeforeShell

  exec('/hide', 'cmd.exe /c ' .. script_path .. '\\Autoruns\\PEStartupMain.bat BeforeShell')
  RunShell()

  if explorer_shell then
    exec('WinXShell.exe -daemon')
  end
end

local function WaitShell()
  Taskbar:WaitForReady()
end

local function PostShell()
  WaitShell()
  sui:hide()
  exec('/hide', 'cmd.exe /c ' .. script_path .. '\\Autoruns\\PEStartupMain.bat PostShell')
end


local function Logon()
  os.setenv('logon_script', '')
  CustomOSInit()
  PreShell()
  Shortcuts()
  LoadShell()
  PostShell()
  -- set_progress('finished')
end

local function InitAdmin()
  set_progress(t('Prepare for Administrator ...'))
  os.setenv('PECMD_SCRIPT', script_file)
  exec('/wait /hide', 'LogonAdmin.bat LUA')
  os.setenv('PECMD_SCRIPT', '')
end

local function Loader()
  local os_inited = OSInit()

  local user_opt = get_option('-user') or ''
  if user_opt ~= '' then user_opt = '-user ' .. user_opt end

  -- call UI_logon
  os.setenv('logon_script', script_file)
  local exec_cmd = 'WinXShell.exe -ui ' .. user_opt .. ' -jcfg ' .. script_path .. '\\UI_LogonPE.jcfg'
  log('Loader():' .. exec_cmd)
  -- 1 - SYSTEM, 2 - ADMIN
  local rc = exec('/wait', exec_cmd)
  log('Loader():rc = ' .. rc)
  
  if os_inited == 1 then return end

  if rc == 2 then
    -- Admin logoned, Wait SYSTEM session
    app:call('WaitForSession','SYSTEM')
    exec('/wait', 'WinXShell.exe -ui -user SYSTEM -jcfg ' .. script_path .. '\\UI_LogonPE.jcfg')
  end

  -- loader keeper
  exec('/wait /hide', 'cmd.exe /k echo alive')
end

local function main()
  if _G.caller == nil then
    script_file = get_option('-script')
  else
    script_file = os.getenv('logon_script')
  end
  script_path = string.match(script_file, "(.+)\\")
  app:call('cd', script_path)
  i18n.load()
  t = i18n.t

  -- call by UI_Logon
  if _G.caller == 'UI_Logon' then
    log('main():_G.caller = UI_Logon')
    logon_user = _G.logon_user
    log('main():logon_user = ' .. logon_user)
    if logon_user == 'SYSTEM' then
      Logon()
      return
    -- elseif logon_user == 'Administrator' then
    else
      if Folder.exists('X:\\Users\\Administrator') then
        Logon()
        return
      else
        InitAdmin()
        return
      end
    end
  end
  log('main():Loader()')
  Loader()
end

function write_log(str, file)
  if file == nil then file = 'pecmd_lua.txt' end
  local tstr = os.date('%c') .. '  '
  local f = io.open('X:\\Windows\\Temp\\' .. file, 'a+');f:write(tstr .. str .. '\r\n');f:close();
end

-- ================== ui helper ==================
function set_progress(text)
  if _G.progress_text == nil then return end
  _G.progress_text.text = text
  coroutine.yield()
end

function LINK(lnk, target, param, icon, index, showcmd)
  -- set_progress(t('Create shortcut:') .. app:call('envstr',lnk))
  link(lnk, target, param, icon, index, showcmd)
end
-- ===============================================


log = write_log
main()
