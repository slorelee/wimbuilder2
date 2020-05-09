if "x%opt[driver.load_basic_display_demand]%"=="xtrue" call :DEMAND_BASICDISPLAY
goto :EOF

:DEMAND_BASICDISPLAY
set DrvFolder=
for /f "tokens=3" %%i in ('reg query HKLM\Tmp_DRIVERS\DriverDatabase\DriverInfFiles\display.inf /v Active') do set DrvFolder=%%i
if "x%DrvFolder%"=="x" goto :EOF
echo Update Configurations:%DrvFolder%
reg delete "HKLM\Tmp_DRIVERS\DriverDatabase\DriverPackages\%DrvFolder%\Configurations\MSBDA" /v Service /f
set DrvFolder=
goto :EOF
