require('lua_helper.lua_helper')

local logon_user = 'SYSTEM'
local explorer_shell = false

-- declare functions
local t -- alias i18n.t()
local set_progress, LINK
shel = exec


local function OSInit()
  if File.exists('X:\\Windows\\Temp\\OSInited.txt') then return 1 end
  --set_progress('%{System configuration, Please Wait...}')

  -- show cursor, and wpeinit.exe
  exec('/wait', '%WinDir%\\System32\\winpeshl.exe')

  -- // Load Display drivers
  exec('/wait /hide', [[Drvload.exe %WinDir%\inf\basicdisplay.inf %WinDir%\inf\basicrender.inf %WinDir%\inf\c_display.inf %WinDir%\inf\display.inf %WinDir%\inf\displayoverride.inf]])
  -- // Try resolution(s)
  Screen:DispTest({'1152x864', '1366x768', '1024x768'})

  File.delete('X:\\Users\\Public\\Desktop\\desktop.ini')
  local f = io.open('X:\\Windows\\Temp\\OSInited.txt', 'w+');f:write('done');f:close();
  return 0
end

local function CustomOSInit()
  if File.exists('X:\\Windows\\Temp\\CustomOSInited.txt') then return 1 end

  set_progress(t('Prepare for system ...'))
  exec('/hide', 'cmd.exe /c ' .. script_path .. '\\Autoruns\\Runner.bat OSInit')

  local f = io.open('X:\\Windows\\Temp\\CustomOSInited.txt', 'w+');f:write('done');f:close();
end

local function PreShell()
  -- LetterSwap
  -- // exec('/wait /hide', [[LetterSwap.exe /auto /bootdrive Y:\CDUsb.y /Log %WinDir%\System32\LetterSwap.log]])

  -- Fix Screen resolution and Show Desktop. NoWait Hide
  -- exec('fixscreen.exe')
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
  local path = '%Programs%\\Administrative Tools'
  LINK(path .. '\\Computer Management.lnk', 'compmgmt.msc')
  LINK(path .. '\\Device Manager.lnk', 'devmgmt.msc')
  LINK(path .. '\\Disk Management.lnk', 'diskmgmt.msc')
  LINK(path .. '\\Services.lnk', 'services.msc')

  -- LINK('%Programs%\\System Tools\\#{@shell32.dll,22022}.lnk', 'cmd.exe')

  LINK('%Desktop%\\Explorer.lnk', 'Explorer.exe')
  LINK('%Desktop%\\#{@shell32.dll,22022}.lnk', 'cmd.exe')
  LINK('%Desktop%\\Internet Explorer.lnk', '%ProgramFiles%\\Internet Explorer\\iexplore.exe')
  LINK('%Desktop%\\PENetwork.lnk', '%ProgramFiles%\\PENetwork\\PENetwork.exe')

  if File.exists('X:\\Windows\\System32\\seclogon.dll') then
    LINK('%Desktop%\\SwitchUser.lnk', '%ProgramFiles%\\WinXShell\\WinXShell.exe', '-script ' .. script_file .. ' -user #SwitchUser#', 'imageres.dll', 319)
  end

  CustomShortcuts()

  local f = io.open('X:\\Windows\\Temp\\Shortcuts.txt', 'w+');f:write('done');f:close();
end

local function RunShell()
  if logon_user ~= 'SYSTEM' then return end
  if explorer_shell then
    shel('explorer.exe')
  else
    shel('WinXShell.exe -winpe')
  end
end

local function LoadShell()
  set_progress(t('load shell ...'))
  exec('ctfmon.exe')

  -- RunBeforeShell

  RunShell()

  if explorer_shell then
    exec('WinXShell.exe -daemon')
  end
end

local function WaitShell()
  local sh_win = winapi.find_window('Shell_TrayWnd', nil)
  while (sh_win == nil or sh_win:get_handle() == 0) do
    app:print(string.format("shell Handle:0x%x", sh_win:get_handle()))
    app:call('sleep', 1000)
    sh_win = winapi.find_window('Shell_TrayWnd', nil)
  end
end

local function PostShell()
  WaitShell()
  sui:hide()
  File.delete('%HOMEPROFILE%\\Desktop\\desktop.ini')
  File.delete('%HOMEPROFILE%\\Desktop\\shutdown.bat') -- no need this file if there is WinXShell.exe's UI_Shutdown
  exec('/wait /hide', 'cmd.exe /c del /q "%APPDATA%\\Microsoft\\Internet Explorer\\Quick Launch\\User Pinned\\TaskBar\\*.lnk"')
  Taskbar:Pin('%ProgramFiles%\\WinXShell\\WinXShell.exe', 'UI_Shutdown', '-ui -jcfg wxsUI\\UI_Shutdown.zip\\full.jcfg -blur 5', 'shell32.dll', 27)
  Taskbar:Pin('Explorer.exe')
  Taskbar:Pin('cmd.exe')
  Startmenu:Pin('notepad.exe')
  exec('/hide', 'cmd.exe /c ' .. script_path .. '\\Autoruns\\Runner.bat Startup')
end


local function Logon()
  CustomOSInit()
  PreShell()
  Shortcuts()
  LoadShell()
  PostShell()
  -- set_progress('finished')
end

local function InitAdmin()
  set_progress(t('Prepare for Administrator ...'))
  --File.delete('X:\\Users\\Default\\NTUSER.DAT')
  os.execute('del /q X:\\Users\\Default\\NTUSER.DAT')
  --exec('/wait /hide', 'cmd.exe /c copy /y X:\\Windows\\System32\\config\\Default X:\\Users\\Default\\NTUSER.DAT')
  os.execute('copy /y X:\\Windows\\System32\\config\\Default X:\\Users\\Default\\NTUSER.DAT')

  set_progress(t('Update registry ...'))
  local regkey = [[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]]
  reg_write(regkey, 'AutoAdminLogon', 1, winapi.REG_DWORD)
  reg_write(regkey, 'DefaultUserName', 'Administrator')
  reg_write(regkey, 'DefaultPassword', '')
  reg_write(regkey, 'Userinit', 'userinit.exe,X:\\Program Files\\WinXShell\\WinXShell.exe -script ' .. script_file .. ' -user Administrator')
  if File.exists('X:\\Windows\\explorer.exe') then
    reg_write(regkey, 'Shell', 'explorer.exe')
  else
    reg_write(regkey, 'Shell', 'X:\\Program Files\\WinXShell\\WinXShell.exe -winpe')
  end
  reg_write(regkey .. '\\SpecialAccounts\\UserList', 'Guest', 0, winapi.REG_DWORD)
  reg_write(regkey, 'EnableSIHostIntegration', 0, winapi.REG_DWORD)

  -- // REGI HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18\ProfileImagePath=X:\Users\Administrator

  set_progress(t('Update database ...'))
  -- // Force the administrator name whatever language
  exec('/wait /hide', [[secedit.exe /configure /db %WinDir%\security\database\unattend.sdb /cfg %WinDir%\security\templates\unattend.inf /log %WinDir%\security\logs\unattend.log]])

  set_progress(t('Start services ...'))
  -- call_dll('Netapi32.dll','NetJoinDomain', nil, 'WORKGROUP', nil, nil, nil, 32)
  exec('/wait /hide', 'sc start seclogon')

  if File.exists('X:\\Windows\\System32\\Admin18850+.bat') then
    exec('/wait /hide', 'X:\\Windows\\System32\\Admin18850+.bat')
  end

  set_progress(t('Ready to logon ...'))
  exec('/wait /hide', 'tsdiscon.exe')
end

local function Loader()
  local os_inited = OSInit()

  -- call UI_logon
  os.setenv('logon_script', script_file)
  local user_opt = get_option('-user') or ''
  if user_opt == '#SwitchUser#' then
    local un = os.getenv('USERNAME')
    user_opt = 'SYSTEM'
    if un == 'SYSTEM' then user_opt = 'Administrator' end
    -- TODO: Admin => SYSTEM
    if un == 'Administrator' then
      winapi.show_message('TODO', 'Can\'t switch to SYSTEM account.')
      return
    end
  end
  if user_opt ~= '' then user_opt = '-user ' .. user_opt end
  exec('/wait', 'WinXShell.exe -ui ' .. user_opt .. ' -jcfg ' .. script_path .. '\\UI_LogonPE.jcfg')
  os.setenv('logon_script', '')

  if os_inited == 1 then return end
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
    logon_user = _G.logon_user
    if logon_user == 'SYSTEM' then
      Logon()
      return
    elseif logon_user == 'Administrator' then
      if Folder.exists('X:\\Users\\Administrator') then
        Logon()
        return
      else
        InitAdmin()
        return
      end
    end
  end
  Loader()
end

-- ================== ui helper ==================
function set_progress(text)
  if _G.progress_text == nil then return end
  _G.progress_text.text = text
  coroutine.yield()
end

function LINK(lnk, target, param, icon, index, showcmd)
  set_progress(t('Create shortcut:') .. app:call('envstr',lnk))
  link(lnk, target, param, icon, index, showcmd)
end
-- ===============================================

main()
