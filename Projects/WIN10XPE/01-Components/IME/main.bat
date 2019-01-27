@echo off

set IME_Startup=0
call ImeKR_ko-KR.bat
call ImeTC.bat

if not "x%IME_Startup%"=="x1" goto :EOF

rem create Register IME dlls script
if "x%opt[build.registry.software]%"=="xfull" (
  echo start ctfmon.exe>"%X%\Windows\System32\IME_Cmd.cmd"
) else (
  copy /y IME_Cmd.txt "%X%\Windows\System32\IME_Cmd.cmd"
)
