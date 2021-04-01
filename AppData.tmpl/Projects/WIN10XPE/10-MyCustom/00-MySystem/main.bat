goto :EOF


call AddFiles %0 :end_files
goto :end_files

@\Windows\System32\
;xxxx.dll,yyyy.dll

@\Windows\SysWOW64\
;xxxx.dll

:end_files

call X2X X
