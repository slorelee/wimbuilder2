
set _CTF_DEFAULT={03B5835F-F03C-411B-9CE2-AA23E1171E36}
set _CTF_PROFILE={A76C93D9-5523-4E90-AAFA-4DB112F9AC76}


call AddFiles %0 :end_files
goto :end_files

\Windows\IME\IMEJP\
\Windows\System32\IME\IMEJP\
\Windows\System32\InputMethod\JPN\

; rem =================WOW64 Support=================
+if "x%opt[build.wow64support]%"="xtrue"
\Windows\SysWOW64\\IME\IMEJP\
\Windows\SysWOW64\InputMethod\JPN\
-if

:end_files

:UDPATE_REGISTY

call RegCopy HKLM\SOFTWARE\Microsoft\MSIME

call RegCopyEx Classes "ImeCommonAPI1041,ImeCommonAPI1042"
call RegCopyEx Classes "ImeCommonAPIClassFactory1028,ImeCommonAPIClassFactory1041,ImeCommonAPIClassFactory1042"
call RegCopyEx Classes "IMESingleKanjiDict"
goto :IME_CLASSES_END

rem FULL items
call RegCopyEx Classes "ImeCommonAPI1041,ImeCommonAPI1041.1,ImeCommonAPI1041.15"
call RegCopyEx Classes "ImeCommonAPI1042,ImeCommonAPI1042.1,ImeCommonAPI1042.15"
call RegCopyEx Classes "ImeCommonAPIClassFactory1028,ImeCommonAPIClassFactory1028.1,ImeCommonAPIClassFactory1028.15"
call RegCopyEx Classes "ImeCommonAPIClassFactory1041,ImeCommonAPIClassFactory1041.1,ImeCommonAPIClassFactory1041.15"
call RegCopyEx Classes "ImeCommonAPIClassFactory1042,ImeCommonAPIClassFactory1042.1,ImeCommonAPIClassFactory1042.15"
call RegCopyEx Classes "IMESingleKanjiDict,IMESingleKanjiDict.9,IMESingleKanjiDict.15"
 :IME_CLASSES_END

call :UDPATE_IME_REGISTY Tmp_Default
call :UDPATE_IME_REGISTY Tmp_System

reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0x4090409 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000411\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v CLSID /d %_CTF_DEFAULT% /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000411\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v Profile /d %_CTF_PROFILE% /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\AssemblyItem\0x00000411\{34745C63-B2F0-4784-8B67-5E12C8701A31}\00000000 /v KeyboardLayout /t REG_DWORD /d 0x411 /f
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\SortOrder\Language /v 00000000 /d 00000411 /f

rem ; Microsoft Japanese
set _IME_MS_JAPANESE=1
if "x%opt[IME.ms_ja]%"=="xtrue" set _IME_MS_JAPANESE=1
reg add HKLM\Tmp_Default\Software\Microsoft\CTF\TIP\%_CTF_DEFAULT%\LanguageProfile\0x00000411\%_CTF_PROFILE% /v Enable /t REG_DWORD /d %_IME_MS_JAPANESE% /f
set  _IME_MS_JAPANESE=

rem Default Mode: 0 - Japanese, 1 - English
rem reg add "HKLM\Tmp_DEFAULT\Software\Microsoft\InputMethod\Settings\JPN" /v "Default Mode" /t REG_DWORD /d 1 /f

goto :EOF

:UDPATE_IME_REGISTY
reg add "HKLM\%1\Keyboard Layout\Preload" /v 2 /d 00000409 /f
reg add "HKLM\%1\Keyboard Layout\Preload" /v 1 /d 00000411 /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d {00000000-0000-0000-0000-000000000000} /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000409\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 0x4090409 /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000411\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Default /d %_CTF_DEFAULT% /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000411\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v Profile /d %_CTF_PROFILE% /f
reg add HKLM\%1\Software\Microsoft\CTF\Assemblies\0x00000411\{34745C63-B2F0-4784-8B67-5E12C8701A31} /v KeyboardLayout /t REG_DWORD /d 0x4110411 /f
reg add HKLM\%1\Software\Microsoft\CTF\HiddenDummyLayouts /v 00000411 /d 00000411 /f
goto :EOF
