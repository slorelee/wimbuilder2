echo 自定义挂载WIM映像的脚本

call WIM_Mounter "%_WB_PE_WIM%" %WB_BASE_INDEX% "%_WB_MNT_DIR%" base_wim_mounted
if not "%base_wim_mounted%"=="1" (
  call :cecho ERROR "mount base wim file failed."
  call _Cleanup
  pause
  exit 1
)

rem 禁止映射挂载目录为X驱动器
rem set NO_X_SUBST=1
