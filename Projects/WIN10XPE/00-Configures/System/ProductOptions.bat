rem some features are dependence on this.
rem like: SnippingTool, TermService, etc.

rem use install.wim's ProductOptions (show version watermark on desktop)
call RegCopy HKLM\SYSTEM\ControlSet001\Control\ProductOptions
reg delete "HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions" /v OSProductContentId /f
reg delete "HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions" /v OSProductPfn /f
reg delete "HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions" /v SubscriptionPfnList /f

"%WINXSHELL%" -code "App:Call('exitcode', Reg.PolicySet == nil or 1)"
if not ERRORLEVEL 1 goto :USE_USER_PRODUCTOPTIONS
"%WINXSHELL%" -script "%~dp0ProductOptionsUpdater.lua"
goto :EOF

:USE_USER_PRODUCTOPTIONS
if exist "%_USER_CUSTOMFILES_%\ProductOptions.txt" (
  reg import "%_USER_CUSTOMFILES_%\ProductOptions.txt"
  goto :EOF
)

if exist "%WB_PROJECT_PATH%\_CustomFiles_\ProductOptions.txt" (
  reg import "%WB_PROJECT_PATH%\_CustomFiles_\ProductOptions.txt"
  goto :EOF
)

