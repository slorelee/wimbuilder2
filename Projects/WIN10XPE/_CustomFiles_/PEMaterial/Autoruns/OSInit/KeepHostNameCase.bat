for /f "tokens=3" %%i in ('reg query HKLM\System\ControlSet001\Control\ComputerName\ComputerName /v ComputerName') do set hn=%%i
reg add "HKLM\System\ControlSet001\Services\Tcpip\Parameters" /v "NV Hostname" /d "%hn%" /f
reg add "HKLM\System\ControlSet001\Services\Tcpip\Parameters" /v Hostname /d "%hn%" /f
