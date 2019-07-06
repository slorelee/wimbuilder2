goto :EOF

call AddFiles %0 :end_files
goto :end_files
; Seems Not required nlmgp.dll,nlmproxy.dll,nlmsprep.dll
@\Windows\System32\
networklist\
Wbem\netprofm.mof
ImplatSetup.dll,netprofm.dll,netprofmsvc.dll,npmproxy.dll,pnidui.dll
:end_files


rem // NetworkSetup2 and NetworkUxManager
call RegCopy HKLM\System\ControlSet001\Control\NetworkSetup2
call RegCopy HKLM\System\ControlSet001\Control\NetworkUXManager
call RegCopy "HKLM\Software\Microsoft\Windows NT\CurrentVersion\NetworkList"

reg add HKLM\Tmp_System\Setup\AllowStart\netprofm /f
rem needs startup with SetupInProgress=0
reg add HKLM\Tmp_System\ControlSet001\Services\netprofm /v Start /t REG_DWORD /d 4 /f

set Netprofm_SID=S-1-5-80-3635958274-2059881490-2225992882-984577281-633327304
set NlaSvc_SID=S-1-5-80-3141615172-2057878085-1754447212-2405740020-3916490453
set WwanSvc_SID=S-1-5-80-3981856537-581775623-1136376035-2066872258-409572886

SetAcl.exe -on "%X_SYS%\networklist" -ot file -actn ace -ace "n:%Netprofm_SID%;p:full;s:y"

set "NetworkList_Key=HKLM\Tmp_software\Microsoft\Windows NT\CurrentVersion\NetworkList"
SetAcl.exe -on "%NetworkList_Key%" -ot reg -actn ace -ace "n:%Netprofm_SID%;p:full;s:y"
SetAcl.exe -on "%NetworkList_Key%\Nla" -ot reg -actn ace -ace "n:%NlaSvc_SID%;p:full;s:y"

rem WwanSvc, Network Configuration Operators(S-1-5-32-556),Unknown SID(S-1-5-92-1467204242-1103346305-4253404563-2848856930-0)
rem SetAcl.exe -on "%NetworkList_Key%\Permissions" -ot reg -actn ace -ace "n:%WwanSvc_SID%;p:full;s:y"
rem SetAcl.exe -on "%NetworkList_Key%\Permissions" -ot reg -actn ace -ace "n:S-1-5-32-556;p:full"
rem SetAcl.exe -on "%NetworkList_Key%\Permissions" -ot reg -actn ace -ace "n:S-1-5-92-1467204242-1103346305-4253404563-2848856930-0;p:full"

SetAcl.exe -on "%NetworkList_Key%\Permissions" -ot reg -actn ace -ace "n:Everyone;p:full;s:y"
