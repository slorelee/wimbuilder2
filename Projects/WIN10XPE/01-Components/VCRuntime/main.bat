goto :main
Title=VCRuntime
Type=XPEPlugin
Description=VCRuntime
Author=ChriSR
Date=2018.05.30
Version=001
:main
set "f0=%~f0"

call :VCRuntimes %WB_PE_ARCH% System32
if "x%opt[build.wow64support]%"=="xtrue" (
    call :VCRuntimes x86 SysWOW64
)
goto :EOF

:VCRuntimes
set SxSArch=%1
set SysDir=%2
rem ==========update file system==========
call AddFiles "%f0%" :end_files
goto :end_files

@\Windows\%SysDir%\
; VC++ runtimes
; already in winre.wim but add for SysWOW64
msvcp_win.dll,msvcp60.dll,msvcp110_win.dll,msvcrt.dll

msvcp120_clr0400.dll,msvcrt20.dll,msvcrt40.dll
msvcr100_clr0400.dll,msvcr120_clr0400.dll

; WinSxS VC++ runtimes
\Windows\WinSxS\%SxSArch%_microsoft.vc80.crt*
\Windows\WinSxS\%SxSArch%_microsoft.vc90.crt*
\Windows\WinSxS\manifests\%SxSArch%_microsoft.vc80.crt*
\Windows\WinSxS\manifests\%SxSArch%_policy.8.0.microsoft.vc80.crt*
\Windows\WinSxS\manifests\%SxSArch%_microsoft.vc90.crt*
\Windows\WinSxS\manifests\%SxSArch%_policy.9.0.microsoft.vc90.crt*
:end_files

rem ==========update registry==========
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%SxSArch%_microsoft.vc80.crt_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%SxSArch%_microsoft.vc90.crt_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%SxSArch%_policy.8.0.microsoft.vc80.crt_*
call RegCopy HKLM\Software\Microsoft\Windows\CurrentVersion\SideBySide\Winners,%SxSArch%_policy.9.0.microsoft.vc90.crt_*
