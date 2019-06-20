set HasPatch=true
find "%~1" "%WB_TEMP%\_patches_selected.txt" 1>nul 2>nul
if %errorlevel% NEQ 0 (
  set HasPatch=false
  errno 0
  goto :EOF
)
errno 1
