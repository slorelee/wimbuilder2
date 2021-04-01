if 1==0 (
rem test_setup
set V=D:\dev\WimBuilder2\vendor
set WB_ARCH=x64
)

if not exist "%WINXSHELL%" goto :EOF

set "Icons=%X_WIN%\Resources\Icons"
if not exist "%Icons%" md "%Icons%"

rem ResourcesExtract.exe /ExtractIcons 1
xcopy /y Icons\*.*  "%Icons%\"

"%WINXSHELL%" -console -script "%~dp0UpdateRegResources.lua"

del /q "%X_SYS%\Display.dll"
del /q "%X_SYS%\themecpl.dll"
