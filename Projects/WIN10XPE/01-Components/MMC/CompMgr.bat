
rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

@windows\system32\
compmgmt.msc,CompMgmtLauncher.exe

; Filesystem Management
fsmgmt.msc

:end_files

rem ==========update registry==========

