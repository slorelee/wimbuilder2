if %VER[3]% LEQ 18300 goto :EOF
binmay.exe -u "%X_SYS%\InputService.dll" -s u:MiniNT -r u:NiniNT
fc /b "%X_SYS%\InputService.dll.org" "%X_SYS%\InputService.dll"
del /f /q "%X_SYS%\InputService.dll.org"
