rem Remove the origin 'Safely Remove Hardware' Tray Icon (default Services=#31)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\SysTray /v Services /t REG_DWORD /d 29 /f
start SysTray.exe
start HotSwap^!.exe
