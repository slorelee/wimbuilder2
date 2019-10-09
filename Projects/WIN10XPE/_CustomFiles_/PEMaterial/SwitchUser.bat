rem Switch to SYSTEM
if not "%USERNAME%"=="SYSTEM" (
  "%ProgramFiles%\WinXShell\WinXShell.exe" -luacode SwitchSession^('SYSTEM'^)
  goto :EOF
)

rem Switch to ADMIN
if exist "X:\Users\Administrator" (
  "%ProgramFiles%\WinXShell\WinXShell.exe" -luacode SwitchSession^('ADMIN'^)
  goto :EOF
)

rem for STARTNET
if exist "X:\Windows\Temp\SYSTEM_LOADER" (
  startnet.cmd -user ADMIN
)

rem for PECMD
if exist "X:\Windows\System32\PecmdAdmin.ini" (
  LogonAdmin.bat PECMD
)

rem for LUA
"%ProgramFiles%\WinXShell\WinXShell.exe" -script "X:\PEMaterial\pecmd.lua" -user Administrator