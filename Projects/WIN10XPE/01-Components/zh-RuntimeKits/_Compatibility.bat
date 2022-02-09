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

findstr.exe

; AFAIK Tencent QQ(x86) required
avicap32.dll
rasman.dll

; PotPlayer
devenum.dll
EhStorAPI.dll

;Here for System32 only
+if "%SysDir%"="System32"
nsi.dll
sti.dll

\Windows\Fonts\times.ttf
-if

;Here for SysWOW64 only
+if "%SysDir%"="SysWOW64"
; PowerPoint 2007 Preview(F5) page switch
hlink.dll

; LENOVO BIOS Updater
lz32.dll

; Counter-Strike 1.5
dciman32.dll

;eCloud
glu32.dll
opengl32.dll

;ldplayer
RESAMPLEDMO.DLL

; Sound for TheWorld Web Browser
ksuser.dll,wdmaud.drv

+ver > 18300
; OpenOffice, LibreOffice, ... (Open file)
shellstyle.dll

+ver > 19000
; 32-bit Web Browsers
Windows.FileExplorer.Common.dll

+ver > 20000
;Tencent QQ(x86), Office 2010
prxyqry.dll

; FeiQ
;Windows.System.Launcher.dll
DiagnosticDataSettings.dll

+ver*

-if

:end_files

rem ==========update registry==========

rem --no-sandbox option
reg add "HKLM\Tmp_Software\Policies\Google\Chrome" /v "AudioSandboxEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Software\Policies\Microsoft\Edge" /v "AudioSandboxEnabled" /t REG_DWORD /d 0 /f

SetACL.exe -on "HKLM\Tmp_Software\Policies" -ot reg -actn ace -ace "n:Everyone;p:full"
