set _pecmd_shell_head=EXP_
if "x%opt[shell.app]%"=="xwinxshell" set _pecmd_shell_head=WXS_
call TextReplace "%X_SYS%\pecmd.ini" #//%_pecmd_shell_head% ""
call TextReplace "%X_SYS%\pecmd.ini" #//%_pecmd_shell_head% ""
set _pecmd_shell_head=

call TextReplace "%X_SYS%\pecmd.ini" #//ARCH_%WB_PE_ARCH%_ ""
