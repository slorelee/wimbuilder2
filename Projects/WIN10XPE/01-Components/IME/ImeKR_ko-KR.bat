goto :main
rem ==========================================================================
Title=ImeKR
Type=XPEPlugin
Description=Korean IME Support
Author=Flower3,ChrisR
Date=2018.06.01
HistoryNotes=Be Free to Customize
rem ==========================================================================

:main
if not "x%WB_PE_LANG%"=="xko-KR" goto :EOF

call AddFiles %0 :end_files
goto :end_files

; In ko-KR Winre.wim gulim.ttc,malgun.ttf
;\Windows\IME\SPTIP.DLL
;\Windows\IME\??-??\SpTip.dll.mui

\Windows\IME\IMEKR\DICTS\imkrhjd.lex

@\Windows\System32\IME\IMEKR\
DICTS\imkrhjd.dll,imkrapi.dll,imkrtip.dll
@\Windows\System32\IME\SHARED\
IMEAPIS.DLL,IMETIP.DLL,IMJKAPI.DLL,MSCAND20.DLL
@\Windows\System32
inputLocaleManager.dll,inputHost.dll,inputService.dll
msctfime.ime,Msctfp.dll,MSWB7.dll,NOISE.DAT
MTF.dll,MTFServer.dll,TextInputFramework.dll,Winsta.dll

+mui
Ctfmon.exe,Globinputhost.dll,input.dll,inputSwitch.dll,msctf.dll,msutb.dll
MsCtfMonitor.dll,MsctfuiManager.dll,Windows.Globalization.dll,Winlangdb.dll
-mui

; Search
korwbrkr.lex
korwbrkr.dll

@\Windows\System32\
;------------------------------------------------
;          National Language Support (.NLS)
;------------------------------------------------
C_437.NLS
C_949.NLS
C_1252.NLS
C_1255.NLS
C_1256.NLS
C_1361.NLS
C_10003.NLS
C_20127.NLS
C_20833.NLS
C_20949.NLS
C_28591.NLS
C_65001.NLS
;------------------------------------------------
;          Keyboard
;------------------------------------------------
KBD101a.dll
KBD101b.dll
KBD101c.dll
KBD103.dll
KBDKOR.DLL
KBDUS.DLL
KBDUSA.DLL
;------------------------------------------------
;          Additional Fonts
;------------------------------------------------
@\Windows\Fonts\
gulim.ttc
malgun.ttf
;msyh.ttc
;simsun.ttc
app949.fon
arial.ttf
cga40woa.fon
cga80woa.fon
consola.ttf
desktop.ini
dosapp.fon
ega40woa.fon
ega80woa.fon
fms_metadata.xml
h8514fix.fon
h8514oem.fon
h8514sys.fon
hvgafix.fon
hvgasys.fon
LeelawUI.ttf
lucon.ttf
marlett.ttf
micross.ttf
msyi.ttf
segmdl2.ttf
segoeui.ttf
seguisym.ttf
svgafix.fon
svgasys.fon
tahoma.ttf
trebuc.ttf
vga949.fon
vgafix.fon
vgaoem.fon
vgasys.fon

:end_files

rem =================WOW64 Support=================
if not "x%opt[build.wow64support]%"=="xtrue" goto :UDPATE_REGISTY
call AddFiles %0 :end_wow64_files
goto :end_wow64_files

@\Windows\SysWOW64\IME\IMEKR\
DICTS\imkrhjd.dll,imkrapi.dll,imkrtip.dll
@\Windows\SysWOW64\IME\SHARED\
IMEAPIS.DLL,IMETIP.DLL,IMJKAPI.DLL,MSCAND20.DLL
@\Windows\SysWOW64
inputLocaleManager.dll,inputHost.dll,inputService.dll
msctfime.ime,Msctfp.dll,MSWB7.dll,NOISE.DAT
MTF.dll,MTFServer.dll,TextInputFramework.dll,Winsta.dll

+mui
Ctfmon.exe,Globinputhost.dll,input.dll,inputSwitch.dll,msctf.dll,msutb.dll
MsCtfMonitor.dll,MsctfuiManager.dll,Windows.Globalization.dll,Winlangdb.dll
-mui

;------------------------------------------------
;          National Language Support (.NLS)
;------------------------------------------------
@\Windows\SysWOW64\
C_437.NLS
C_1252.NLS
C_10003.NLS
C_20833.NLS
;------------------------------------------------
;          Keyboard
;------------------------------------------------
KBD101a.dll
KBD101b.dll
KBD101c.dll
KBD103.dll
KBDKOR.DLL
KBDUS.DLL
KBDUSA.DLL

:end_wow64_files

:UDPATE_REGISTY
call :ImeKR_RegHKLM\Software
if "x%opt[build.wow64support]%"=="xtrue" (
  call :ImeKR_Reg HKLM\Software\WOW6432Node
)

if not "x%opt[build.registry.software]%"=="xfull" (
  call :Fonts_Reg
)

call :Keyboard_ko-KR_Reg

set IME_Startup=1
goto :EOF


:ImeKR_Reg
call RegCopy %1\Microsoft\CTF
call RegCopy %1\Microsoft\IME\15.0\IMETC
call RegCopy %1\Microsoft\IME\15.0\Shared
call RegCopy %1\Microsoft\IME\PlugInDict
call RegCopy %1\Microsoft\IMEKR
call RegCopy %1\Microsoft\InputMethod
goto :EOF

:Keyboard_ko-KR_Reg
rem // Set ko-KR;en-US Keyboard
reg add "HKLM\Tmp_Default\Keyboard Layout\Preload" /v 1 /d 00000412 /f
reg add "HKLM\Tmp_Default\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {A028AE76-01B1-46C2-99C4-ACD9858AE02F} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {B5FE1F02-D5F2-4445-9C03-C568F23C99A1} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 68289554 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000412 /d 00000412 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\LangBar /v ExtraIconsOnMinimized /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\LangBar /v Label /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\LangBar /v ShowStatus /t REG_DWORD /d 4 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\LangBar /v Transparency /t REG_DWORD /d 255 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {A028AE76-01B1-46C2-99C4-ACD9858AE02F} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {B5FE1F02-D5F2-4445-9C03-C568F23C99A1} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\Language /v 00000000 /d 00000412 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{A028AE76-01B1-46C2-99C4-ACD9858AE02F}\LanguageProfile\0x00000412\{B5FE1F02-D5F2-4445-9C03-C568F23C99A1} /v Enable /t REG_DWORD /d 1 /f
rem //-
reg add "HKLM\Tmp_System\Keyboard Layout\Preload" /v 1 /d 00000412 /f
reg add "HKLM\Tmp_System\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {A028AE76-01B1-46C2-99C4-ACD9858AE02F} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {B5FE1F02-D5F2-4445-9C03-C568F23C99A1} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000412\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 68289554 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000412 /d 00000412 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{A028AE76-01B1-46C2-99C4-ACD9858AE02F}\LanguageProfile\0x00000412\{B5FE1F02-D5F2-4445-9C03-C568F23C99A1} /v Enable /t REG_DWORD /d 1 /f
goto :EOF

:Fonts_Reg
rem //-
rem //reg add "HKLM\Tmp_Default\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 1 /f
rem //-
rem // Register Fonts
rem //reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Gulim & GulimChe & Dotum & DotumChe (TrueType)" /d gulim.ttc /f
rem //reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Malgun Gothic (TrueType)" /d malgun.ttf /f

reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Arial (TrueType)" /d arial.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Consolas (TrueType)" /d consola.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Leelawadee UI (TrueType)" /d leelawui.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Lucida Console (TrueType)" /d lucon.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Microsoft Sans Serif (TrueType)" /d micross.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Microsoft YaHei & Microsoft YaHei UI (TrueType)" /d msyh.ttc /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Microsoft Yi Baiti (TrueType)" /d msyi.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "SimSun & NSimSun (TrueType)" /d simsun.ttc /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Segoe UI (TrueType)" /d segoeui.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Segoe UI Symbol (TrueType)" /d seguisym.ttf /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\Fonts" /v "Tahoma (TrueType)" /d tahoma.ttf /f
