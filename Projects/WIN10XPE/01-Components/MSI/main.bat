
rem ==========update filesystem==========

call AddFiles %0 :end_files
goto :end_files

\Windows\AppPatch\msimain.sdb
\Windows\AppPatch\sysmain.sdb
\Windows\Installer\

@\Windows\System32\
+syswow64
msi.dll,msiexec.exe,msihnd.dll
msiltcfg.dll,msimsg.dll,msisip.dll
;mscoree.dll,pcacli.dll,RstrtMgr.dll,srpapi.dll
-syswow64

wbem\msi.mof
wbem\msiprov.dll
wbem\??-??\msi.mfl

:end_files

rem ==========update registry==========

call RegCopyEx Services "eventlog\Application\MsiInstaller"
call RegCopyEx Services "msiserver,TrustedInstaller"

call RegCopyEx Classes ".msi,.msp,IMsiServer,Msi.Package,Msi.Patch"
call RegCopyEx Classes WindowsInstaller.Installer
call RegCopyEx Classes WindowsInstaller.Message

call RegCopy "HKLM\Software\Classes\AppID\{000C101C-0000-0000-C000-000000000046}"
rem CLSID,Interface,TypeLib already be copied


call :Reg_Msi \
call :Reg_Msi \Wow6432Node\

rem ==========add startup entry==========

rem Register Msi Windows Installer
if 1==1 (
echo Regsvr32.exe /s %%WinDir%%\System32\Msi.dll
echo if exist "%%WinDir%%\SysWOW64\Msi.dll" %%WinDir%%\SysWOW64\Regsvr32.exe /s %%WinDir%%\SysWOW64\Msi.dll
echo del /f /q "%%~0"
)>"%X_Startup%\RegisterMsidll.bat"

goto :EOF


:Reg_Msi
set "_rpath=HKLM\Software%1Microsoft\Cryptography\OID\EncodingType 0"
set _oid={000C10F1-0000-0000-C000-000000000046}

call RegCopy "%_rpath%\CryptSIPDllCreateIndirectData\%_oid%"
call RegCopy "%_rpath%\CryptSIPDllGetSignedDataMsg\%_oid%"
call RegCopy "%_rpath%\CryptSIPDllIsMyFileType2\%_oid%"
call RegCopy "%_rpath%\CryptSIPDllPutSignedDataMsg\%_oid%"
call RegCopy "%_rpath%\CryptSIPDllRemoveSignedDataMsg\%_oid%"
call RegCopy "%_rpath%\CryptSIPDllVerifyIndirectData\%_oid%"

set _rpath=
set _oid=

call RegCopy "HKLM\Software%1Microsoft\Windows\CurrentVersion\Installer"
call RegCopy "HKLM\Software%1Microsoft\Windows\CurrentVersion\Installer\Secure"


