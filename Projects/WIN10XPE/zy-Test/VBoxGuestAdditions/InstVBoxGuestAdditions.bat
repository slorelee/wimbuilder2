drvload.exe "%WinDir%\Temp\vboxguest.inf\VBoxGuest.inf"
if exist "%WinDir%\System32\VBoxTray.exe" (
    rd /s /q "%WinDir%\Temp\vboxguest.inf\"
    start VBoxTray.exe
)
