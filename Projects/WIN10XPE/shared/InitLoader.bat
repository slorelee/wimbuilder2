if not "x%PE_LOADER%"=="x" goto :EOF

set PE_LOADER=SYSTEM

if "x%opt[loader.name]%"=="x" set opt[loader.name]=PECMD

if /i "x%opt[loader.name]%"=="xLUA" set PE_LOADER=LUA
if /i "x%opt[loader.name]%"=="xPECMD" set PE_LOADER=PECMD

echo PE_LOADER=%PE_LOADER%

if "x%opt[loader.PEMaterial]%"=="x" set opt[loader.PEMaterial]=PEMaterial
set "X_PEMaterial=%X%\%opt[loader.PEMaterial]%"
set "X_OSInit=%X_PEMaterial%\Autoruns\OSInit"
set "X_Startup=%X_PEMaterial%\Autoruns\Startup"
set "X_BeforeShell=%X_PEMaterial%\Autoruns\Startup\BeforeShell"

rem init for LUALINK, LUAPIN
call LuaLink -init "%X_Startup%\BeforeShell\Shortcuts.lua"
call LuaPin -init "%X_Startup%\PinShortcuts.lua"
