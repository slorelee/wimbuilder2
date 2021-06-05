echo Custom script to commit the WIM file.

call _Cleanup 0
call WIM_Exporter "%_WB_PE_WIM%"
