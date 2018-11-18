@echo off

call ComputerName.bat

reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v ProfileImagePath /d X:\Users\Default /f
