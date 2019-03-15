if "x%opt[component.mspaint]%"=="xtrue" call _mspaint.bat

if "x%opt[component.winphotoviewer]%"=="xtrue" (
  call _winphotoviewer.bat
)

if "x%opt[component.accessibility]%"=="xtrue" (
  call _accessibility.bat
)
