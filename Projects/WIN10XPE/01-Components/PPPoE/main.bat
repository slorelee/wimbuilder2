rem call AddFiles \Windows\System32\rasphone.exe

rem Convert from WinPE_OCs\WinPE-PPPoE.cab (ADK)

rem ==========update filesystem==========
call AddFiles %0 :end_files
goto :end_files

\Windows\WinSxS\*_microsoft-windows-tapicore*

@\Windows\System32\
; sens service
sens.dll

; tapi2xclient
tapi32.dll

; tapicore
dialer.exe,tapilua.dll,tapiperf.dll,tapiui.dll,telephon.cpl

; tapiservice
tapisrv.dll

rasdial.exe
rasphone.exe
:end_files

rem winpe-oc-pppoe's configras.cmd (remove exit)
copy /y configras.cmd "%X_SYS%"
