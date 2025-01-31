if "x%opt[component.MMC]%"=="xtrue" (
  call ApplyPatch "..\MMC"
)

if "x%opt[component.taskmgr]%"=="xtrue" (
  call AddFiles %0 :[TaskManager]
  reg add HKLM\Tmp_Software\Microsoft\Windows\CurrentVersion\Run /v DiskUsageInTaskmangerPerformanceTab /d "diskperf.exe -y" /f
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

; real-time data of the connected drives in the Performance tab
diskperf.exe
\Windows\SysWOW64\diskperf.exe
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

