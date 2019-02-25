if "x%opt[component.bitlocker]%"=="xtrue" (
   call :ApplySubPatch "..\BitLocker"
)

if "x%opt[component.DWM]%"=="xtrue" (
   call :ApplySubPatch "..\DWM"
)

if "x%opt[component.MMC]%"=="xtrue" (
   call :ApplySubPatch "..\MMC"
)

if "x%opt[component.MTP]%"=="xtrue" (
   call :ApplySubPatch "..\MTP_Support"
)
goto :EOF

:ApplySubPatch
   echo Applying Patch:%~1\main.bat
   pushd "%~1"
   call main.bat
   popd
goto :EOF