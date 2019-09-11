require('lua_helper.lua_helper')

local function PinToTaskbar(target, name, param, icon, index, showcmd)
    Taskbar:Pin(target, name, param, icon, index, showcmd)
end

local function PinToStartMenu(target, name, param, icon, index, showcmd)
    Startmenu:Pin(target, name, param, icon, index, showcmd)
end


-- =======================================================================
