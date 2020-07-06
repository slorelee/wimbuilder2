rem some features are dependence on this.
rem like: SnippingTool, TermService, etc.

if exist "%_USER_CUSTOMFILES_%\ProductOptions.txt" (
  reg import "%_USER_CUSTOMFILES_%\ProductOptions.txt"
  goto :EOF
)

if exist "%WB_PROJECT_PATH%\_CustomFiles_\ProductOptions.txt" (
  reg import "%WB_PROJECT_PATH%\_CustomFiles_\ProductOptions.txt"
  goto :EOF
)

rem use install.wim's ProductOptions (show version watermark on desktop)
call RegCopy HKLM\SYSTEM\ControlSet001\Control\ProductOptions
reg del HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions /v OSProductContentId /f
reg del HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions /v OSProductPfn /f
reg del HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions /v SubscriptionPfnList /f
