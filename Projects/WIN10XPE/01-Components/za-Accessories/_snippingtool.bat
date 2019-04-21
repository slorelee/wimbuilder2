call AddFiles %0 :end_files
goto :end_files

@\Program Files\Common Files\Microsoft Shared\ink\
InkObj.dll,tpcps.dll
??-??\InkObj.dll.mui

@\Windows\system32\
SnippingTool.exe
DWrite.dll,msdrm.dll,oleacc.dll,oleaccrc.dll,uxtheme.dll,wisp.dll
:end_files

if exist ProductOptions.txt (
  reg import ProductOptions.txt
  goto :EOF
)

rem use install.wim's ProductOptions (show version watermark on desktop)
call RegCopy HKLM\SYSTEM\ControlSet001\Control\ProductOptions
reg del HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions /v OSProductContentId /f
reg del HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions /v OSProductPfn /f
reg del HKLM\Tmp_SYSTEM\ControlSet001\Control\ProductOptions /v SubscriptionPfnList /f


