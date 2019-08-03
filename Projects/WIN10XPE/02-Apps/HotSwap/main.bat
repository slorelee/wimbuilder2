call V2X HotSwap -Extract "HotSwap_*.ZIP" "%X%\Temp\HotSwap\"
copy /y "%X%\Temp\HotSwap\%_V3264%bit\HotSwap^!.EXE" "%X_SYS%\"
rd /s /q "%X%\Temp\HotSwap\"

call AddFiles \Windows\system32\systray.exe
reg add "HKLM\Tmp_Default\Software\HotSwap^!" /v DFlags /t REG_DWORD /d 0x10000003 /f
