if "x%opt[config.computername]%"=="x" goto :EOF

set cname=%opt[config.computername]%
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /d "%cname%" /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\WinPE" /v SkipWaitForNetwork /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_Software\Microsoft\Windows NT\CurrentVersion\WinPE" /v SetComputerName /t REG_DWORD /d 0 /f
reg add "HKLM\Tmp_System\ControlSet001\Control\Session Manager\Environment" /v COMPUTERNAME /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\Control\ComputerName\ComputerName" /v ComputerName /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\Control\ComputerName\ActiveComputerName" /v ComputerName /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\Services\Tcpip\Parameters" /v "NV Hostname" /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\Services\Tcpip\Parameters" /v Hostname /d "%cname%" /f
