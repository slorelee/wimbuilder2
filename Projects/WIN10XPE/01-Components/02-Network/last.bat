rem remove WcmSvc from Wlansvc service's DependOnService
rem data sample:nativewifip\0RpcSs\0Ndisuio\0Eaphost

set WLANSVC_DEPEND_SERV=
for /f "tokens=3" %%i in ('reg query HKLM\SOFTWARE\Tmp_SYSTEM\ControlSet001\services\Wlansvc /v DependOnService') do (
  set WLANSVC_DEPEND_SERV=%%i
)
set WLANSVC_NEW_DEPEND=%WLANSVC_DEPEND_SERV%
if not "x%WLANSVC_NEW_DEPEND%"=="x" (
  set WLANSVC_NEW_DEPEND=%WLANSVC_NEW_DEPEND:WcmSvc\0=%
)
if not "x%WLANSVC_NEW_DEPEND%"=="x" (
  set WLANSVC_NEW_DEPEND=%WLANSVC_NEW_DEPEND:\0WcmSvc=%
)
if not "x%WLANSVC_DEPEND_SERV%"=="x%WLANSVC_NEW_DEPEND%" (
  echo update Wlansvc depend(%WLANSVC_DEPEND_SERV% To %WLANSVC_NEW_DEPEND%)
  reg add HKLM\SOFTWARE\Tmp_SYSTEM\ControlSet001\services\Wlansvc /v DependOnService /t REG_MULTI_SZ /d "%WLANSVC_NEW_DEPEND%" /f
)
