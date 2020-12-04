@echo off
cd /d "%~dp0"
cd ..

if not exist tests\tmp md tests\tmp
copy /y tests\PinShortcuts.lua tests\tmp\

call LuaPin -init "%~dp0tmp\PinShortcuts.lua"

call PinToTaskbar notepad.exe
call PinToTaskbar "X:\Program Files\WinXShell\WinXShell.exe"
call PinToTaskbar "%%%%%%%%ProgramFiles%%%%%%%%\PENetwork\PENetwork.exe"
call PinToTaskbar -paramlist "[[%%%%%%%%ProgramFiles%%%%%%%%\WinXShell\WinXShell.exe]], 'UI_Shutdown', '-ui -jcfg wxsUI\\UI_Shutdown.zip\\full.jcfg -blur 5', 'shell32.dll', 27"

call PinToTaskbar -paramlist "[[#pProgramFiles#p\WinXShell\WinXShell.exe]], 'AutoDisp', '-code Screen:Disp#{##}#', 'shell32.dll', 34"

call PinToStartMenu regedit.exe
call PinToStartMenu "X:\Program Files\WinXShell\WinXShell.exe"
call PinToStartMenu "%%%%%%%%ProgramFiles%%%%%%%%\PENetwork\PENetwork.exe"
call PinToStartMenu -paramlist "[[%%%%%%%%ProgramFiles%%%%%%%%\WinXShell\WinXShell.exe]], 'wxsExplorer', nil, 'shell32.dll', 27"

rem use #p than %%%%%%%%
call PinToTaskbar "#pProgramFiles#p\7-Zip\7zFM.exe"
call PinToStartMenu "#pProgramFiles#p\7-Zip\7zFM.exe"

call LuaPin -done

pause

