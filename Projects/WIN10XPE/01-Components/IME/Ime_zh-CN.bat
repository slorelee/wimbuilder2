if "x%opt[IME.ms_pinyin]%"=="x" set opt[IME.ms_pinyin]=true

set _CTF_DEFAULT={81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}
set _CTF_PROFILE={FA550B04-5AD7-411F-A5AC-CA038EC515D7}

if not "%opt[IME.ms_pinyin]%"=="true" (
    if "x%opt[IME.ms_wubi]%"=="xtrue" (
        set _CTF_DEFAULT={6A498709-E00B-4C45-A018-8F9E4081AE40}
        set _CTF_PROFILE={82590C13-F4DD-44F4-BA1D-8667246FDF8E}
    )
)

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

call :UDPATE_IME_REGISTY Tmp_Default
call :UDPATE_IME_REGISTY Tmp_System

reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0x4090409 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d %_CTF_DEFAULT% /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d %_CTF_PROFILE% /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\Language /v 00000000 /d 00000804 /f

rem ; Microsoft Pinyin
set _IME_MS_PINYIN=0
if "x%opt[IME.ms_pinyin]%"=="xtrue" set _IME_MS_PINYIN=1
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804\{FA550B04-5AD7-411F-A5AC-CA038EC515D7} /v Enable /t REG_DWORD /d %_IME_MS_PINYIN% /f
set _IME_MS_PINYIN=

rem ; Microsoft Wubi
if "x%opt[IME.ms_wubi]%"=="xtrue" (
    reg add HKLM\Tmp_Software\Microsoft\CTF\TIP\{6A498709-E00B-4C45-A018-8F9E4081AE40}\LanguageProfile\0x00000804\{82590C13-F4DD-44F4-BA1D-8667246FDF8E} /v Enable /t REG_DWORD /d 1 /f
)

goto :EOF

:UDPATE_IME_REGISTY
reg add "HKLM\%1\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add "HKLM\%1\Keyboard Layout\Preload" /v 1 /d 00000804 /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 0x4090409 /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d %_CTF_DEFAULT% /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d %_CTF_PROFILE% /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 0x8040804 /f
reg add HKLM\%1\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000804 /d 00000804 /f
goto :EOF
