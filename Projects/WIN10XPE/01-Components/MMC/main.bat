@echo off

rem MMC base

rem ==========add files==========

call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
mmc.exe,mmcbase.dll,mmcndmgr.dll,mmcshext.dll
; mmc resources
filemgmt.dll

:end_files

rem ==========update registry==========

rem Classes\AppID,CLSID,Interface,TypeLib already copied
reg ADD HKLM\Tmp_Software\Classes\Applications\MMC.exe /v NoOpenWith /f
reg ADD HKLM\Tmp_Software\Classes\.msc /ve /d MSCFile /f
call REGCOPY HKLM\Software\Classes\mscfile
call REGCOPY HKLM\Software\Microsoft\MMC

call CompMgr.bat
rem DevMgr.bat
call AddFiles "@windows\system32\#ndevmgmt.msc,devmgr.dll"
call DiskMgr.bat
rem SrvMgr.bat
call AddFiles \windows\system32\services.msc
