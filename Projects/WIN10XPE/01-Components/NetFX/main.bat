set "f0=%~f0"

rem .Net detector(dotnet.exe)
call X2X

set "_PFDir=Program Files"
if "x%WB_PE_ARCH%"=="xx64" set "_PFDir=Program Files (x86)"
call :Sys_Files System32
set _PFDir=
rem =================WOW64 Support=================
if not "x%opt[build.wow64support]%"=="xtrue" goto :UDPATE_REGISTY
call :Sys_Files SysWOW64

:UDPATE_REGISTY

rem use FULL SOFTWARE hive for .NET framework

if 0==1 (
rem // [DummyRegistry]
call RegCopy HKLM\Software\Microsoft\Fusion
call RegCopy HKLM\Software\Microsoft\.NETFramework
call RegCopy HKLM\Software\Microsoft\NET Framework Setup
call RegCopy HKLM\System\ControlSet001\Services\FontCache*
call RegCopy HKLM\Software\WOW6432Node\Microsoft\.NETFramework
call RegCopy HKLM\Software\WOW6432Node\Microsoft\NET Framework Setup
)

goto :EOF

:Sys_Files
set SysDir=%1
call AddFiles "%f0%" :end_files
goto :end_files

+if "%SysDir%"<>"SysWOW64"
\%_PFDir%\Microsoft.NET
\Windows\Microsoft.NET

@\Windows\System32\CatRoot\{F750E6C3-38EE-11D1-85E5-00C04FC295EE}\
Microsoft-Windows-NetFx4-US-OC-Package~*.cat
+ver >= 17763
Microsoft-Windows-NetFx-Shared-Package~*.cat
+ver*

-if

\Windows\%SysDir%\??-??\PresentationHost.exe.mui
\Windows\%SysDir%\MUI\0409\mscorees.dll
@\Windows\%SysDir%\
mscoree.dll,mscorier.dll,mscories.dll
msvcp120_clr0400.dll,msvcr100_clr0400.dll,msvcr120_clr0400.dll

; Additional Files for v1903
msvcp140_clr0400.dll,ucrtbase_clr0400.dll,vcruntime140_clr0400.dll
aspnet_counters.dll,dfshim.dll,UIAutomationCore.dll

netfxperf.dll
PresentationCFFRasterizerNative_v0300.dll
PresentationHost.exe,PresentationHostProxy.dll
PresentationNative_v0300.dll
WindowsCodecs.dll,WindowsCodecsExt.dll
sxstrace.exe

+if "%SysDir%"<>"SysWOW64"
FntCache.dll
-if
:end_files
set SysDir=
goto :EOF
