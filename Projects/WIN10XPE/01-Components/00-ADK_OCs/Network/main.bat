pushd "%OCs_PATH%"

for /f "tokens=3,4 delims=.]=" %%i in ('set opt[adk.oc_net.') do (
  if "%%j"=="true" (
    Dism /image:%X% /add-package /packagepath:"WinPE-%%i.cab"
    Dism /image:%X% /add-package /packagepath:"%_ADK_LANG%\WinPE-%%i_%_ADK_LANG%.cab"
  )
)

popd
