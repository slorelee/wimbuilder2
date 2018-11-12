
call AddFiles %0 :end_files
goto :end_files

@\Windows\InputMethod\CHS\
ChsPinyin.lex,ChsPinyin.lm
ChsWubi.lex

@\Windows\System32\
InputMethod\CHS
MSWB70804.dll,NL7Data0804.dll,NL7Lexicons0804.dll,NL7Models0804.dll
NOISE.CHS,chs_singlechar_pinyin.dat,ChsStrokeDS.dll
:end_files

rem =================WOW64 Support=================
if not "x%opt[build.wow64support]%"=="xtrue" goto :UDPATE_REGISTY
call AddFiles %0 :end_wow64_files
goto :end_wow64_files
\Windows\SysWOW64\InputMethod\CHS
\Windows\SysWOW64\chs_singlechar_pinyin.dat
:end_wow64_files

:UDPATE_REGISTY
reg add "HKLM\Tmp_Default\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add "HKLM\Tmp_Default\Keyboard Layout\Preload" /v 1 /d 00000804 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {FA550B04-5AD7-411F-A5AC-CA038EC515D7} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 134481924 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000804 /d 00000804 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {FA550B04-5AD7-411F-A5AC-CA038EC515D7} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\Language /v 00000000 /d 00000804 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804\{FA550B04-5AD7-411F-A5AC-CA038EC515D7} /v Enable /t REG_DWORD /d 1 /f
rem ; is zh-TW IMEs, set enable=0 to hide
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{B115690A-EA02-48D5-A231-E3578D2FDF80}\LanguageProfile\0x00000404\{B2F9C502-1742-11D4-9790-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{531fdebf-9b4c-4a43-a2aa-960e8fcdc732}\LanguageProfile\0x00000404\{6024B45F-5C54-11D4-B921-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{531fdebf-9b4c-4a43-a2aa-960e8fcdc732}\LanguageProfile\0x00000404\{4BDF9F03-C7D3-11D4-B2AB-0080C882687E} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}\LanguageProfile\0x00000404\{037B2C25-480C-4D7F-B027-D6CA6B69788A} /v Enable /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{E429B25A-E5D3-4D1F-9BE3-0C608477E3A1}\LanguageProfile\0x00000404\{D38EFF65-AA46-4FD5-91A7-67845FB02F5B} /v Enable /t REG_DWORD /d 0 /f
rem //-
reg add "HKLM\Tmp_System\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add "HKLM\Tmp_System\Keyboard Layout\Preload" /v 1 /d 00000804 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 67699721 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {FA550B04-5AD7-411F-A5AC-CA038EC515D7} /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 134481924 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000804 /d 00000804 /f
reg add HKLM\Tmp_System\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804\{FA550B04-5AD7-411F-A5AC-CA038EC515D7} /v Enable /t REG_DWORD /d 1 /f

