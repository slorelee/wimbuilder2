@echo off

call ComputerName.bat

call AddFiles %0 :end_files
goto :end_files
windows\system32\taskkill.exe
:end_files

rem startup explorer shell
rem set X32=X:\Windows\System32
del /q X:\setup.exe
del /q X:\Windows\System32\winpeshl.ini
del /q X:\Windows\System32\WallpaperHost.exe

reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f

rem update startnet.cmd
call OpenTextFile JS X:\Windows\System32\startnet.cmd %0 :end_startnet_edit
goto :end_startnet_edit

TXT.before('wpeinit').insert('set USERPROFILE=X:\\Users\\Default');
TXT.append('\r\n\
taskkill /f /im WallpaperHost.exe\r\n\
start explorer.exe\r\n\
');

:end_startnet_edit

echo ping -n 2 127.0.0.1 1^>nul>>X:\Windows\System32\startnet.cmd
echo taskkill /f /im explorer.exe>>X:\Windows\System32\startnet.cmd
echo explorer.exe>>X:\Windows\System32\startnet.cmd
echo cmd.exe>>X:\Windows\System32\startnet.cmd