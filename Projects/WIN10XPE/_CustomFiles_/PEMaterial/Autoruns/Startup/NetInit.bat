Net Start Wlansvc
Net Start WinHttpAutoProxySvc

rem Launch PENetwork
if exist "%ProgramFiles%\PENetwork\" (
    cd /d "%ProgramFiles%\PENetwork\"
    start "PENetwork" "%ProgramFiles%\PENetwork\PENetwork.exe"
)
set RunOnce=1
