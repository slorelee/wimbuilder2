rem Load Network drivers at startup
cd /d %WinDir%\inf\
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    Drvload.exe athw8x.inf netathr10x.inf netathrx.inf netbc63a.inf netbc64.inf netrtwlane.inf netrtwlane_13.inf netrtwlanu.inf netwbw02.inf netwew00.inf netwew01.inf netwlan92de.inf netwlv64.inf netwns64.inf netwsw00.inf netwtw02.inf netwtw04.inf netwtw06.inf
) else (
    Drvload.exe athw8.inf netathr.inf netathr10.inf netbc63.inf netbc64.inf netrtwlane.inf netrtwlane_13.inf netrtwlanu.inf netwbn02.inf netwen00.inf netwen01.inf netwlan92de.inf netwlv32.inf netwns32.inf netwsn00.inf netwtn02.inf netwtn04.inf
)

Net Start Wlansvc
Net Start WinHttpAutoProxySvc

rem Launch PENetwork
if exist "%ProgramFiles%\PENetwork\" (
    cd /d "%ProgramFiles%\PENetwork\"
    start "PENetwork" "%ProgramFiles%\PENetwork\PENetwork.exe"
)
set RunOnce=1
