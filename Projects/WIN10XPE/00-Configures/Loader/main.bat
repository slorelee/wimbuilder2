set PE_LOADER=SYSTEM

if "x%opt[loader.name]%"=="x" set opt[loader.name]=PECMD

if /i "x%opt[loader.name]%"=="xLUA" set PE_LOADER=LUA
if /i "x%opt[loader.name]%"=="xPECMD" set PE_LOADER=PECMD

echo PE_LOADER=%PE_LOADER%

if "x%opt[loader.PEMaterial]%"=="x" set opt[loader.PEMaterial]=PEMaterial
set "X_PEMaterial=%X%\%opt[loader.PEMaterial]%"

if exist "%_CUSTOMFILES_%\PEMaterial" (
  xcopy /Y /E "%_CUSTOMFILES_%\PEMaterial" "%X_PEMaterial%\"
  copy /y "%_CUSTOMFILES_%\PEMaterial\unattend.xml" "%X_SYS%\"
)
if "%WB_PE_ARCH%"=="x86" (
  call TextReplace "%X_SYS%\unattend.xml" "processorArchitecture=#qamd64#q" "processorArchitecture=#qx86#q"
)

rem add PECMD always
call V2X PECMD -Copy "Pecmd_%_V_xARCH%.exe" "%X_SYS%\Pecmd.exe"
call X2X

if "%PE_LOADER%"=="LUA" goto :LOADER_LUA
if "%PE_LOADER%"=="PECMD" goto :LOADER_PECMD

rem  PE_LOADER=SYSTEM
call AddFiles \Windows\System32\taskkill.exe
move /y "%X_PEMaterial%\startnet.cmd" "%X_SYS%\"
call TextReplace "%X_SYS%\startnet.cmd" "X:\\PEMaterial\\" "X:\%opt[loader.PEMaterial]%\" g
goto :EOF

:LOADER_LUA
call V2X WinXShell
set _WINXSHELL_COPYED=1

del /f /q "%X_PEMaterial%\Pecmd.ini"
del /f /q "%X_PEMaterial%\PecmdAdmin.ini"
del /f /q "%X_PEMaterial%\startnet.cmd"

copy /y "%X_PEMaterial%\winpeshl.ini" "%X_SYS%\"
goto :EOF

:LOADER_PECMD
if not exist "%X_SYS%\Pecmd.exe" (
  call V2X PECMD -Copy "Pecmd_%_V_xARCH%.exe" "%X_SYS%\Pecmd.exe"
)

rd /s /q "%X_PEMaterial%\locales"
del /f /q "%X_PEMaterial%\pecmd.lua"

move /y "%X_PEMaterial%\Pecmd.ini" "%X_SYS%\"
move /y "%X_PEMaterial%\PecmdAdmin.ini" "%X_SYS%\"
move /y "%X_PEMaterial%\winpeshl.ini" "%X_SYS%\"

call TextReplace "%X_SYS%\pecmd.ini" "X:\\PEMaterial\\" "X:\%opt[loader.PEMaterial]%\" g
goto :EOF
