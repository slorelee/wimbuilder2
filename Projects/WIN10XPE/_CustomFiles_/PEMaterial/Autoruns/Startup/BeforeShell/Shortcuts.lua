require('lua_helper.lua_helper')

local function LINK(lnk, target, param, icon, index, showcmd)
  link(lnk, target, param, icon, index, showcmd)
end


-- =======================================================================

-- local path = '%Programs%\\Administrative Tools'
-- LINK(path .. '\\Computer Management.lnk', 'compmgmt.msc')
-- LINK(path .. '\\Device Manager.lnk', 'devmgmt.msc')
-- LINK(path .. '\\Disk Management.lnk', 'diskmgmt.msc')
-- LINK(path .. '\\Services.lnk', 'services.msc')

-- LINK('%Programs%\\System Tools\\#{@shell32.dll,22022}.lnk', 'cmd.exe')

LINK('%Desktop%\\Explorer.lnk', 'Explorer.exe')
LINK('%Desktop%\\#{@shell32.dll,22022}.lnk', 'cmd.exe')
LINK('%Desktop%\\Internet Explorer.lnk', '%ProgramFiles%\\Internet Explorer\\iexplore.exe')
LINK('%Desktop%\\PENetwork.lnk', '%ProgramFiles%\\PENetwork\\PENetwork.exe')

if File.exists('X:\\Windows\\System32\\seclogon.dll') then
  LINK('%Desktop%\\SwitchUser.lnk', 'X:\\Windows\\System32\\SwitchUser.bat', '', 'imageres.dll', 319)
end

