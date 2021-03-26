pushd "%OCs_PATH%"

if "x%opt[adk.fonts.legacy]%"=="xtrue" (
  Dism /image:"%X%" /add-package /packagepath:"WinPE-Fonts-Legacy.cab"
)

for /f "tokens=3,4 delims=.]=" %%i in ('set opt[adk.font.') do (
  if "%%j"=="true" Dism /image:"%X%" /add-package /packagepath:"WinPE-FontSupport-%%i.cab"
)

popd
