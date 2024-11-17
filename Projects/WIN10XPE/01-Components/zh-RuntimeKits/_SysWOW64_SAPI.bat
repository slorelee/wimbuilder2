rem Needed for NVDA in 64 bit systems, 
rem if Microsoft Sapi 5 Synthesizer selected.
rem This is optional

if "x%opt[slim.speech]%"=="xtrue" goto :EOF
if not "x%opt[build.wow64support]%"=="xtrue" goto :EOF

call AddFiles %0 :end_files
goto :end_files
\Windows\SysWOW64\Speech\Common\
\Windows\SysWOW64\Speech\Engines\TTS\
:end_files

reg copy /s HKLM\Tmp_Software\Microsoft\Speech\Voices\Tokens HKLM\Tmp_Software\Wow6432Node\Microsoft\Speech\Voices\Tokens /f
