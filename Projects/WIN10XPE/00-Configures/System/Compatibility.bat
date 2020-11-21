set "f0=%~f0"

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

;Here for both System32 and SysWOW64
@\Windows\%SysDir%\

; AFAIK Tencent QQ(x86) required
avicap32.dll
rasman.dll

;Here for System32 only
+if "%SysDir%"="System32"
findstr.exe
nsi.dll
sti.dll
-if

;Here for SysWOW64 only
+if "%SysDir%"="SysWOW64"
; PowerPoint 2007 Preview(F5) page switch
hlink.dll

; LENOVO BIOS Updater
lz32.dll

+ver > 18300
; OpenOffice, LibreOffice, ... (Open file)
shellstyle.dll
+ver*

+ver > 19000
; 32-bit Web Browsers
Windows.FileExplorer.Common.dll
+ver*

-if

:end_files

rem ==========update registry==========

rem --no-sandbox option
reg add "HKLM\Tmp_Software\Policies\Google\Chrome" /v "AudioSandboxEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Software\Policies\Microsoft\Edge" /v "AudioSandboxEnabled" /t REG_DWORD /d 0 /f

SetACL.exe -on "HKLM\Tmp_Software\Policies" -ot reg -actn ace -ace "n:Everyone;p:full"
