@echo off
echo %cd%

rem TODO:auto recursive call *.bat

call Core.bat
call DiskManagement.bat
call Shell\explorer\main.bat
call Startup.bat

rem call X2X macro
xcopy /E /Y X\*.* X:\
