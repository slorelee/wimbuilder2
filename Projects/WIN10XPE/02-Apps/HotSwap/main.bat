call V2X HotSwap -Extract "HotSwap_*.ZIP" "%X_WIN%\Temp\HotSwap\"
copy /y "%X_WIN%\Temp\HotSwap\%_V3264%bit\HotSwap^!.EXE" "%X_SYS%\"
rd /s /q "%X_WIN%\Temp\HotSwap\"

call AddFiles systray.exe
reg add "HKLM\Tmp_Default\Software\HotSwap^!" /v DFlags /t REG_DWORD /d 0x10000003 /f
