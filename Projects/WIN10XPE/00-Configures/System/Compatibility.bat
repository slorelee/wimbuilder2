set "f0=%~f0"

rem ==========update file system==========

rem System
call AddFiles "%f0%" :end_sys_files
goto :end_sys_files
@\Windows\System32\
nsi.dll
sti.dll
:end_sys_files

rem System32/SysWOW64
call :_Compatibility %WB_PE_ARCH% System32
if "x%opt[build.wow64support]%"=="xtrue" (
    call :_Compatibility x86 SysWOW64
)
goto :EOF

:_Compatibility
set SxSArch=%1
set SysDir=%2

rem ==========update file system==========
call AddFiles "%f0%" :end_files
goto :end_files

@\Windows\%SysDir%\

; PowerPoint 2007 Preview(F5) page switch
hlink.dll
:end_files

rem ==========update registry==========
