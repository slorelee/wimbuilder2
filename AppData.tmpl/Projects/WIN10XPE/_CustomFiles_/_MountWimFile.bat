echo Custom script to mount the WIM file.

call WIM_Mounter "%_WB_PE_WIM%" %WB_BASE_INDEX% "%_WB_MNT_DIR%" base_wim_mounted
if not "%base_wim_mounted%"=="1" (
  call :cecho ERROR "mount base wim file failed."
  call _Cleanup
  pause
  exit 1
)

rem Disable mapping mounted directory to the X drive
rem set NO_X_SUBST=1
