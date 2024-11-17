rem NVDA can detect this voices
rem as default in Windows 8.1, 10 and 11

call AddFiles %0 :end_files
goto :end_files

\Windows\Speech_OneCore
\Windows\System\Speech

@\Windows\System32\

+syswow64
Speech_OneCore\
OneCoreCommonProxyStub.dll
OneCoreUAPCommonProxyStub.dll
rometadata.dll
threadpoolwinrt.dll
Windows.Media.dll
Windows.Media.Speech.dll
-syswow64

Windows.Media.Speech.UXRes.dll
:end_files

if "x%opt[build.registry.software]%"=="xfull" goto :EOF

call RegCopy "HKLM\Software\Microsoft\Speech_OneCore"
call RegCopy "HKLM\Software\Classes" "SAPI_OneCore.*"
