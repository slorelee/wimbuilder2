if "x%V%"=="x" (
rem test_setup
set V=Z:\WimBuilder2\vendor
set V=D:\MyWork\WimBuilder2\vendor
set WB_ARCH=x64
)

rem reg delete "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\AppX" /f

set "WINXSHELL=%V%\WinXShell\X_PF\WinXShell\WinXShell_%WB_ARCH%.exe"
if not exist "%WINXSHELL%" goto :EOF

set opt[registry.software.compress]=true

pushd "%cd%"
set "dp0=%~dp0"
cd /d "%dp0%"

if exist RemoveInvaildItems_Reg.txt del /q RemoveInvaildItems_Reg.txt
if exist RemoveInvaildRegItems.lua (
    "%WINXSHELL%" -console -script "%dp0%RemoveInvaildRegItems.lua"
) else (
    "%WINXSHELL%" -console -script "%dp0%RemoveInvaildRegItems.bin"
)
reg import RemoveInvaildItems_Reg.txt

set dp0=
popd
