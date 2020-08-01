if "x%_ADK_LANG%"=="xen-US" goto :EOF

cd /d "%OCs_PATH%"
pushd "%OCs_PATH%"

Dism "/image:%X%" /add-package /packagepath:"%OCs_PATH%\%_ADK_LANG%\lp.cab"
Dism "/image:%X%" /add-package /packagepath:"%OCs_PATH%\WinPE-FontSupport-%_ADK_LANG%.cab"

set opt[adk.font.%_ADK_LANG%]=false

Dism /image:%X% /Get-Intl
Dism /image:%X% /Set-UILang:%_ADK_LANG%
Dism /image:%X% /Set-AllIntl:%_ADK_LANG%
Dism /image:%X% /Get-Intl

popd
