rem call "%WB_PROJECT_PATH%\shared\InitLoader.bat"

if /i "%opt[loader.name]%"=="LUA" goto :LOADER_LUA
if /i "%opt[loader.name]%"=="PECMD" goto :LOADER_PECMD

rem  PE_LOADER=SYSTEM
copy /y Setup\startnet.cmd "%X_SYS%\"
goto :EOF

:LOADER_LUA
copy /y Setup\pecmd.lua "%X_PEMaterial%\"
goto :EOF

:LOADER_PECMD
copy /y Setup\Pecmd.ini "%X_SYS%\"
copy /y Setup\PecmdAdmin.ini "%X_SYS%\"
goto :EOF
