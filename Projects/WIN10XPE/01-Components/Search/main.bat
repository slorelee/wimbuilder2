@echo off

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-SearchEngine-Client-Package~*.cat
+ver >= 17763
WindowsSearchEngineSKU-Group-Package~*.cat
+ver*

@\Windows\System32\
; Search
\Windows\INF\wsearchidxpi

; Search This PC
EhStorShell.dll

esent.dll,NaturalLanguage6.dll,NOISE.DAT,MSWB7.dll
mssph.dll,mssprxy.dll,mssrch.dll,mssvp.dll,mssitlb.dll
query.exe,query.dll,SearchFilterHost.exe,SearchFolder.dll,SearchIndexer.exe,SearchProtocolHost.exe
srchadmin.dll,StructuredQuery.dll,tquery.dll
Windows.Shell.Search.UriHandler.dll,Windows.Storage.Search.dll,wsepno.dll
prm*.dll,MLS*.dll

:end_files

rem ==========update registry==========

rem [Reg_Search]
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Start_SearchFiles /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Start_SearchPrograms /t REG_DWORD /d 1 /f
call RegCopy "HKLM\Software\Microsoft\Windows Search"
call RegCopy HKLM\System\ControlSet001\Control\ContentIndex
rem //call RegCopy HKLM\System\ControlSet001\services\WSearch
rem //reg add HKLM\Tmp_System\ControlSet001\Services\WSearch /v Start /t REG_DWORD /d 4 /f
call RegCopy HKLM\System\ControlSet001\services\WSearchIdxPi

rem [Reg_VolumeInfoCache]
rem // Failed to get data VolumeInfoCache \C:,DriveType in x64 build > Delete + Write
call RegEx HAS_KEY delete "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\C:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\C:" /v VolumeLabel /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\D:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\D:" /v VolumeLabel /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\E:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\E:" /v VolumeLabel /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\F:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\F:" /v VolumeLabel /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\G:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\G:" /v VolumeLabel /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\H:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\H:" /v VolumeLabel /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\I:" /v DriveType /t REG_DWORD /d 3 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows Search\VolumeInfoCache\I:" /v VolumeLabel /f
