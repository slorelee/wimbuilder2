call AddFiles %0 :end_files
goto :end_files

\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessibility\desktop.ini
\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\desktop.ini
\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Desktop.ini
\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Notepad.lnk
:end_files

del /s /q "%X%\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Notepad.lnk"

if "x%opt[shell.startmenu]%"=="x" set opt[shell.startmenu]=auto
if "%opt[shell.startmenu]%"=="auto" (
  if "x%opt[shell.app]%"=="xexplorer" set opt[shell.startmenu]=StartXBack
  if "x%opt[shell.app]%"=="xwinxshell" set opt[shell.startmenu]=ClassicShell
)
