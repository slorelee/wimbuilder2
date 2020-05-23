call AddFiles %0 :end_files
goto :end_files
; common for zh-TW
@\Windows\System32\
MSWB70404.dll,NL7Data0404.dll,NL7Lexicons0404.dll,NL7Models0404.dll,NOISE.CHT
;
; zh-TW : Bopomofo, Cangjie, Quick, DaYi, Array IMEs
;
; Bopomofo IME, old style, from Win7
\Windows\IME\IMETC
IME\IMETC
ChtBopomofoDS.dll

; Cangjie, Quick IMEs, new style
\Windows\InputMethod\CHT
InputMethod\CHT
ChtCangjieDS.dll
ChtQuickDS.dll

; DaYi and Array IMEs
\Program Files\Windows NT\TableTextService

;
@\Windows\System32\
; zh-HK Cantonese IME not working
;ChtHkStrokeDS.dll
ContactHarvesterDS.dll
UserDataLanguageUtil.dll
UserDataPlatformHelperUtil.dll
UserLanguageProfileCallback.dll
Pimstore.dll

:end_files

rem =================WOW64 Support=================
if not "x%opt[build.wow64support]%"=="xtrue" goto :UDPATE_REGISTY
call AddFiles %0 :end_wow64_files
goto :end_wow64_files
\Windows\SysWOW64\MSWB70404.dll
\Windows\SysWOW64\NL7Data0404.dll
\Windows\SysWOW64\Pimstore.dll

; Bopomofo IME
\Windows\SysWOW64\IME\IMETC
:end_wow64_files

rem *************************************************************************************
rem * zh-TW IMEs has 3 class, 2 started by Win7, 1 started by Win8.
rem * Their classID show as follow :
rem *   {531fdebf-9b4c-4a43-a2aa-960e8fcdc732} (class 1) started by Win7
rem *   {E429B25A-E5D3-4D1F-9BE3-0C608477E3A1} (class 2) started by Win7
rem *   {B115690A-EA02-48D5-A231-E3578D2FDF80} (class 3) started by Win8
rem * 
rem * GUID of IMEs are as following
rem *   {B2F9C502-1742-11D4-9790-0080C882687E} (class 3) : Bopomofo (see note)
rem *   {6024B45F-5C54-11D4-B921-0080C882687E} (class 1) : Quick  
rem *   {4BDF9F03-C7D3-11D4-B2AB-0080C882687E} (class 1) : ChangJie
rem *   {037B2C25-480C-4D7F-B027-D6CA6B69788A} (class 2) : DaYi
rem *   {D38EFF65-AA46-4FD5-91A7-67845FB02F5B} (class 2) : Array
rem *   note: In Win10, Phonetic is renamed to Bopomofo with same IME ID,
rem *         but classID change to class 3
rem *
rem * Not implemented IME for win10 (class 1 for win7, class3 for win10)
rem *   {B2F9C502-1742-11D4-9790-0080C882687E} (class 1)   : Phonetic
rem *   {0B883BA0-C1C7-11D4-87F9-0080C882687E} (class 1,3) : new Quick
rem *   {F3BA907A-6C7E-11D4-97FA-0080C882687E} (class 1,3) : new ChangJie
rem *************************************************************************************
:UDPATE_REGISTY
rem added for Phonetic(Bopomofo) IME
call RegCopyEx Classes ImeCommonAPIClassFactory1028

rem added for DaYi and Array IME
reg add HKLM\Tmp_Default\Software\Microsoft\TableTextService\0x00000404\{037B2C25-480C-4D7F-B027-D6CA6B69788A} /f
reg add HKLM\Tmp_Software\Microsoft\TableTextService\0x00000404\{037B2C25-480C-4D7F-B027-D6CA6B69788A} /t REG_EXPAND_SZ /v SettingFile /d "%%programFiles%%\Windows NT\TableTextService\TableTextServiceDaYi.txt" /f
reg add HKLM\Tmp_Software\Microsoft\TableTextService\0x00000404\{D38EFF65-AA46-4FD5-91A7-67845FB02F5B} /t REG_EXPAND_SZ /v SettingFile /d "%%programFiles%%\Windows NT\TableTextService\TableTextServiceArray.txt" /f

reg add "HKLM\Tmp_Default\Keyboard Layout\Preload" /v 1 /d 00000404 /f
reg add "HKLM\Tmp_Default\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {B115690A-EA02-48D5-A231-E3578D2FDF80} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {B2F9C502-1742-11D4-9790-0080C882687E} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67372036 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000404 /d 00000404 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {B115690A-EA02-48D5-A231-E3578D2FDF80} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {B2F9C502-1742-11D4-9790-0080C882687E} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\Language /v 00000000 /d 00000404 /f
rem //- Default input Mode, eng="0x00000001" cht="0x00000000"
reg add HKLM\Tmp_Default\Software\Microsoft\IME\15.0\IMETC /v "Default Input Mode" /d "0x00000001" /f

rem //-
rem // Phonetic(Bopomofo), Quick, Cangjie, DaYi, Array IMEs can work now
rem //-

rem for Phonetic, default enable=1, here must add else part to set enable=0 to hide it
if "x%opt[IME.ms_Phonetic]%"=="xtrue" (
  reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{B2F9C502-1742-11D4-9790-0080C882687E} /v Enable /t REG_DWORD /d 1 /f
) else (
  reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{B2F9C502-1742-11D4-9790-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
)

rem following IMEs not existed in regstry by default, so default is hide. Add enable=1 to show it
if "x%opt[IME.ms_Quick]%"=="xtrue" (
  reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{531fdebf-9b4c-4a43-a2aa-960e8fcdc732}\LanguageProfile\0x00000404\{6024B45F-5C54-11D4-B921-0080C882687E} /v Enable /t REG_DWORD /d 1 /f
)
if "x%opt[IME.ms_Cangjie]%"=="xtrue" (
  reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{531fdebf-9b4c-4a43-a2aa-960e8fcdc732}\LanguageProfile\0x00000404\{4BDF9F03-C7D3-11D4-B2AB-0080C882687E} /v Enable /t REG_DWORD /d 1 /f
)
if "x%opt[IME.cht_DaYi]%"=="xtrue" (
  reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}\LanguageProfile\0x00000404\{037B2C25-480C-4D7F-B027-D6CA6B69788A} /v Enable /t REG_DWORD /d 1 /f
)
if "x%opt[IME.cht_Array]%"=="xtrue" (
  reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}\LanguageProfile\0x00000404\{D38EFF65-AA46-4FD5-91A7-67845FB02F5B} /v Enable /t REG_DWORD /d 1 /f
)

rem //-
rem //  Not working IMEs, set enable=0 to hide
rem // "Hong Kong Cantonese","new Quick","new Cangjie" IMEs
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{0AEC109C-7E96-11D4-B2EF-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{0B883BA0-C1C7-11D4-87F9-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{F3BA907A-6C7E-11D4-97FA-0080C882687E} /v Enable /t REG_DWORD /d 0 /f

rem //-
reg add "HKLM\Tmp_System\Keyboard Layout\Preload" /v 1 /d 00000404 /f
reg add "HKLM\Tmp_System\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {B115690A-EA02-48D5-A231-E3578D2FDF80} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {B2F9C502-1742-11D4-9790-0080C882687E} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000404\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67372036 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000404 /d 00000404 /f
rem //-
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{B2F9C502-1742-11D4-9790-0080C882687E} /v Enable /t REG_DWORD /d 1 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{531fdebf-9b4c-4a43-a2aa-960e8fcdc732}\LanguageProfile\0x00000404\{6024B45F-5C54-11D4-B921-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{531fdebf-9b4c-4a43-a2aa-960e8fcdc732}\LanguageProfile\0x00000404\{4BDF9F03-C7D3-11D4-B2AB-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}\LanguageProfile\0x00000404\{037B2C25-480C-4D7F-B027-D6CA6B69788A} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}\LanguageProfile\0x00000404\{D38EFF65-AA46-4FD5-91A7-67845FB02F5B} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{0B883BA0-C1C7-11D4-87F9-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{F3BA907A-6C7E-11D4-97FA-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
