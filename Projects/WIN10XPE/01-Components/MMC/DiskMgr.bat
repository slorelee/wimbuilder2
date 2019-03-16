
rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

@windows\system32\
;Disk Management
diskmgmt.msc
dmdlgs.dll,dmdskmgr.dll,dmdskres.dll,dmdskres2.dll,dmintf.dll
dmocx.dll,dmutil.dll,dmvdsitf.dll,dmview.ocx,hhsetup.dll

:end_files

rem ==========update registry==========


