if "x%opt[component.MMC]%"=="xtrue" (
  call ApplyPatch "..\MMC"
)

if "x%opt[component.taskmgr]%"=="xtrue" (
  call AddFiles %0 :[TaskManager]
)

if "x%opt[component.resmon]%"=="xtrue" (
  call AddFiles %0 :[ResMon]
)

if "x%opt[component.bitlocker]%"=="xtrue" (
  call ApplyPatch "..\BitLocker"
)

goto :EOF

:[TaskManager]
@\Windows\System32\
pdh.dll,d3d12.dll
TaskManagerDataLayer.dll
taskmgr.exe

;already in winre.wim
Windows.Web.dll
goto :EOF

:[ResMon]
@\Windows\System32\
pdhui.dll
perf*.dll,perf*.exe
perfmon.msc
pla.dll
wdc.dll
resmon.exe
goto :EOF

