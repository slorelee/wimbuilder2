@echo off

set IME_Startup=0
if exist Ime_%WB_PE_LANG%.bat (
  set IME_Startup=1
  call Ime_Common.bat
  call Ime_%WB_PE_LANG%.bat
)

if not "x%IME_Startup%"=="x1" goto :EOF

rem create Register IME dlls script
if "x%opt[build.registry.software]%"=="xfull" (
  echo start ctfmon.exe>"%X%\Windows\System32\IME_Cmd.cmd"
) else (
  copy /y IME_Cmd.txt "%X%\Windows\System32\IME_Cmd.cmd"
)
