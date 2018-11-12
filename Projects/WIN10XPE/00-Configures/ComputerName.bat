if "x%opt[config.computername]%"=="x" goto :EOF

set cname=%opt[config.computername]%
reg add "HKLM\Tmp_software\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /d "%cname%"
reg add "HKLM\Tmp_software\Microsoft\Windows NT\CurrentVersion\WinPE" /v SkipWaitForNetwork /t REG_DWORD /d 0
reg add "HKLM\Tmp_software\Microsoft\Windows NT\CurrentVersion\WinPE" /v SetComputerName /t REG_DWORD /d 0
reg add "HKLM\Tmp_System\ControlSet001\Control\Session Manager\Environment" /v COMPUTERNAME /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\Control\ComputerName\ComputerName" /v ComputerName /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\Control\ComputerName\ActiveComputerName" /v ComputerName /d "%cname%" /f
reg add "HKLM\Tmp_System\ControlSet001\services\Tcpip\Parameters" /v "NV Hostname" /d "%cname%"
reg add "HKLM\Tmp_System\ControlSet001\services\Tcpip\Parameters" /v Hostname /d "%cname%"
