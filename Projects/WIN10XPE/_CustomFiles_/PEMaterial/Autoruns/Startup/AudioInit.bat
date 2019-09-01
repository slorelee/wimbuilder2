set RunOnce=1

rem SERV -wait Audiosrv (audio service already started)
rem Install HDAudio driver sound cards
drvload %WinDir%\inf\hdaudio.inf

if not exist "%WinDir%\System32\dsound.dll" goto :EOF

rem Adjust the volume (windows default 67%)
rem WinXShell.exe -luacode Volume:Level(67)

rem Startup sound
rem start WinXShell.exe -luacode app:call('Play',[[%SystemRoot%\Media\startup.mp3]])

