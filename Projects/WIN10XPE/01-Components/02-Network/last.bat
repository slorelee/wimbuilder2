rem remove WcmSvc from Wlansvc service's DependOnService
rem data sample:nativewifip\0RpcSs\0Ndisuio\0Eaphost

set WLANSVC_DEPEND_SERV=
for /f "tokens=3" %%i in ('reg query HKLM\Tmp_SYSTEM\ControlSet001\services\Wlansvc /v DependOnService') do (
  set WLANSVC_DEPEND_SERV=%%i
)
if "x%WLANSVC_DEPEND_SERV%"=="x" goto :EOF

set WLANSVC_NEW_DEPEND=%WLANSVC_DEPEND_SERV%
if not "x%WLANSVC_NEW_DEPEND%"=="x" (
  set WLANSVC_NEW_DEPEND=%WLANSVC_NEW_DEPEND:WcmSvc\0=%
)
if not "x%WLANSVC_NEW_DEPEND%"=="x" (
  set WLANSVC_NEW_DEPEND=%WLANSVC_NEW_DEPEND:\0WcmSvc=%
)
if not "x%WLANSVC_DEPEND_SERV%"=="x%WLANSVC_NEW_DEPEND%" (
  echo update Wlansvc's DependOnService from [%WLANSVC_DEPEND_SERV%] To [%WLANSVC_NEW_DEPEND%]
  reg add HKLM\Tmp_SYSTEM\ControlSet001\services\Wlansvc /v DependOnService /t REG_MULTI_SZ /d "%WLANSVC_NEW_DEPEND%" /f
)

if "x%opt[network.hide_system_tray_icon]%"=="xtrue" (
    reg add "HKLM\Tmp_SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCANetwork /t REG_DWORD /d 1 /f
)

rem netprofm service
if not exist "%X_SYS%\netprofm.dll" goto :EOF
binmay.exe -u "%X_SYS%\netprofm.dll" -s u:SystemSetupInProgress -r u:DisableNetworkListMgr
fc /b "%X_SYS%\netprofm.dll.org" "%X_SYS%\netprofm.dll"
del /f /q "%X_SYS%\netprofm.dll.org"
