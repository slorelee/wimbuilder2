@echo off
set USERPROFILE=X:\Users\Default
wpeinit.exe
call "X:\PEMaterial\Autoruns\Runner.bat" OSInit

if exist %SystemRoot%\System32\IME_Cmd.cmd (
    call %SystemRoot%\System32\IME_Cmd.cmd
)

if exist "%windir%\explorer.exe" (
  start explorer.exe
  if exist "%ProgramFiles%\WinXShell\WinXShell.exe" (
    start "Daemon" "%ProgramFiles%\WinXShell\WinXShell.exe" -regist -daemon
  )
) else (
  if exist "%ProgramFiles%\WinXShell\WinXShell.exe" (
    start "WinXShell" "%ProgramFiles%\WinXShell\WinXShell.exe" -regist -winpe
  )
)

rem restart explorer
if exist "%windir%\explorer.exe" (
  ping -n 2 127.1 1>nul
  taskkill /f /im explorer.exe
  start explorer.exe
)

call "X:\PEMaterial\Autoruns\Runner.bat" Startup
cmd.exe
