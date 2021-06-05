echo 自定义保存WIM映像的脚本

call _Cleanup 0
call WIM_Exporter "%_WB_PE_WIM%"
