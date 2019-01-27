goto :main
rem ==========================================================================
Title=ImeTC
Type=XPEPlugin
Description=Chinese TC IME Support
Author=ChrisR
Date=2018.10.10
HistoryNotes=Be Free to Customize
HistoryNotes01= cobraman modified, both zh-TW and zh-CN can work up to v1809
rem ==========================================================================

:main
call AddFiles %0 :end_files
goto :end_files

\Windows\IME\SPTIP.DLL
\Windows\IME\??-??\SpTip.dll.mui

@\Windows\System32\
IME\SHARED
InputMethod\SHARED
inputLocaleManager.dll,inputHost.dll,inputService.dll
msctfime.ime,Msctfp.dll,MSWB7.dll,NOISE.DAT
MTF.dll,MTFServer.dll,TextInputFramework.dll,Winsta.dll

+mui
Ctfmon.exe,Globinputhost.dll,input.dll,inputSwitch.dll,msctf.dll,msutb.dll
MsCtfMonitor.dll,MsctfuiManager.dll,Windows.Globalization.dll,Winlangdb.dll
:end_files

rem =================WOW64 Support=================
if not "x%opt[build.wow64support]%"=="xtrue" goto :UDPATE_REGISTY
call AddFiles %0 :end_wow64_files
goto :end_wow64_files

@\Windows\SysWOW64\
IME\SHARED
inputLocaleManager.dll,inputHost.dll,inputService.dll
msctfime.ime,Msctfp.dll,MSWB7.dll,NOISE.DAT
MTF.dll,MTFServer.dll,TextInputFramework.dll,Winsta.dll

+mui
Ctfmon.exe,Globinputhost.dll,input.dll,inputSwitch.dll,msctf.dll,msutb.dll
MsCtfMonitor.dll,MsctfuiManager.dll,Windows.Globalization.dll,Winlangdb.dll
:end_wow64_files

:UDPATE_REGISTY
call :ImeTC_Reg HKLM\Software
if "x%opt[build.wow64support]%"=="xtrue" (
  call :ImeTC_Reg HKLM\Software\WOW6432Node
)

if exist ImeTC_%WB_PE_LANG%.bat (
  call ImeTC_%WB_PE_LANG%.bat
)

set IME_Startup=1
goto :EOF


:ImeTC_Reg
call RegCopy %1\Microsoft\CTF
call RegCopy %1\Microsoft\IME\15.0\IMETC
call RegCopy %1\Microsoft\IME\15.0\Shared
call RegCopy %1\Microsoft\IME\PlugInDict
call RegCopy %1\Microsoft\IMETC
call RegCopy %1\Microsoft\InputMethod
