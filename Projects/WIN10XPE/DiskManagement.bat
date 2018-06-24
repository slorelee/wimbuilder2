@echo off

rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

@windows\system32\
+mui
diskmgmt.msc
dmdlgs.dll,dmdskmgr.dll,dmdskres.dll,dmdskres2.dll,dmintf.dll
dmocx.dll,dmutil.dll,dmvdsitf.dll,dmview.ocx,hhsetup.dll
mmc.exe,mmcbase.dll,mmcndmgr.dll,mmcshext.dll

:end_files

rem ==========update registry==========

rem Classes\AppID,CLSID,Interface,TypeLib already copied
pe_reg /ADD HKLM\Software\Classes\Applications\MMC.exe /v NoOpenWith
pe_reg /ADD HKLM\Software\Classes\.msc /ve MSCFile
call REGCOPY HKLM\Software\Classes\mscfile
call REGCOPY HKLM\Software\Microsoft\MMC

