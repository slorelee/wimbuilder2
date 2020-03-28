@echo off
cd /d "%~dp0"
cd ..

if not exist tests\tmp md tests\tmp
copy /y tests\Shortcuts.lua tests\tmp\

call LuaLink -init "%~dp0tmp\Shortcuts.lua"

call LinkToDesktop "Text Editor.lnk" notepad.exe
call LinkToDesktop WinXShell.lnk "X:\Program Files\WinXShell\WinXShell.exe"
call LinkToDesktop Tools\PENetwork.lnk "%%%%%%%%ProgramFiles%%%%%%%%\PENetwork\PENetwork.exe"
call LinkToDesktop -paramlist "UI_Shutdown.lnk" "[[%%%%%%%%ProgramFiles%%%%%%%%\WinXShell\WinXShell.exe]], '-ui -jcfg wxsUI\\UI_Shutdown.zip\\full.jcfg -blur 5', 'shell32.dll', 27"

call LinkToDesktop -paramlist "LoadExternalMaterial.lnk" "[[#pProgramFiles#p\WinXShell\WinXShell.exe]], [=[-code app:run#{#'/hide',[[%X_PEMaterial%\Autoruns\PEStartupMain.bat]]#}#]=], 'imageres.dll', 152"

call LinkToStartMenu "SystemTools\Reg Editor.lnk" regedit.exe
call LinkToStartMenu "File Manager.lnk" explorer.exe
call LinkToStartMenu Tools\PENetwork.lnk "%%%%%%%%ProgramFiles%%%%%%%%\PENetwork\PENetwork.exe"
call LinkToStartMenu -paramlist "WinXShell\UI_Shutdown.lnk" "[[%%%%%%%%ProgramFiles%%%%%%%%\WinXShell\WinXShell.exe]], '-ui -jcfg wxsUI\\UI_Shutdown.zip\\full.jcfg -blur 5', 'shell32.dll', 27"

rem use #p than %%%%%%%%
call LinkToDesktop "7-Zip.lnk" "#pProgramFiles#p\7-Zip\7zFM.exe"
call LinkToStartMenu "7-Zip\7-Zip File Manager.lnk" "#pProgramFiles#p\7-Zip\7zFM.exe"

call LuaLink -done

pause

