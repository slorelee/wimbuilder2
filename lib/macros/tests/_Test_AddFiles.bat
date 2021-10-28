@echo off
cd /d "%~dp0"
cd ..

if not exist tests\tmp md tests\tmp

del /f /a /q tests\tmp\_AddFiles.txt
copy /y tests\AddFiles\_AddFiles_SYSMUI.txt tests\tmp\
copy /y tests\AddFiles\_AddFiles_SYSRES.txt tests\tmp\
set ADDFILES_INITED=1

set "WB_TMP_PATH=%cd%\tests\tmp"

set WB_PE_LANG=zh-CN
set ADDFILES_SYSRES=1
set ADDFILES_SYSWOW64=1

set AddFiles_Mode=merge

rem ============================================================================
call AddFiles "mspaint.exe"
call AddFiles "\Windows\System32\mspaint.exe"
call AddFiles "@\Windows\System32\#nmspaint.exe"
call AddFiles "services.msc"
call AddFiles "pdh.dll,taskmgr.exe"
call AddFiles "\Windows\SysWOW64\activeds.dll"
call AddFiles "@\Windows\System32\#nbde*.exe,fve*.exe"
call AddFiles "+syswow64#nglmf32.dll,glu32.dll,opengl32.dll"
call AddFiles \Windows\System32\catroot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\

rem ============================================================================
call AddFiles %0 :end_files
goto :end_files

@windows\system32\
compmgmt.msc,CompMgmtLauncher.exe

; Filesystem Management
fsmgmt.msc

:end_files
rem ============================================================================

call AddFiles %0 :[DirectX_Files]

pause
goto :EOF

:[DirectX_Files]
@\Windows\System32\
drivers\gm.dls

+syswow64

;Microsoft Direct2D
d2d1.dll
goto :EOF

