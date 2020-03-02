set "_Programs_Path=%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
rem attrib -h -s "%_Programs_Path%\Accessories\Desktop.ini"
rem ren "%_Programs_Path%\Accessories\Desktop.ini" Desktop_Notepad.ini

call AddFiles %0 :end_files
goto :end_files

\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility\Desktop.ini
;\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Desktop.ini
\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Desktop.ini

:end_files

rem merge Notepad.lnk localized name
if 0==1 (
  echo.
  echo [LocalizedFileNames]
  echo Notepad.lnk=@%%SystemRoot%%\system32\shell32.dll,-22051
) >> "%_Programs_Path%\Accessories\Desktop.ini"

if 0==1 (
  copy /b "%_Programs_Path%\Accessories\Desktop.ini" + "%_Programs_Path%\Accessories\Desktop_Notepad.ini" "%_Programs_Path%\Accessories\Desktop_Merged.ini"
  del /q "%_Programs_Path%\Accessories\Desktop.ini"
  del /q "%_Programs_Path%\Accessories\Desktop_Notepad.ini"
  ren "%_Programs_Path%\Accessories\Desktop_Merged.ini" Desktop.ini
)

attrib -h -s "%_Programs_Path%\Accessories\Desktop.ini"
copy /y Desktop.ini "%_Programs_Path%\Accessories\Desktop.ini"
attrib +h +s "%_Programs_Path%\Accessories\Desktop.ini"

rem display startmenu folders/shortcuts name with language
attrib +s "%_Programs_Path%\Accessibility"
attrib +s "%_Programs_Path%\Accessories"
attrib +s "%_Programs_Path%\System Tools"

set _Programs_Path=

if "x%opt[shell.startmenu]%"=="x" set opt[shell.startmenu]=auto
if "%opt[shell.startmenu]%"=="auto" (
  if "x%opt[shell.app]%"=="xexplorer" set opt[shell.startmenu]=StartIsBack
  if "x%opt[shell.app]%"=="xwinxshell" set opt[shell.startmenu]=ClassicShell
)
