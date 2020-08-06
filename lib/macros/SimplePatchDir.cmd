echo [MACRO]%~n0 %*

if not exist "%~1" goto :EOF

pushd "%~1"
for /f "delims=" %%i in ('dir /b *.bat *.reg') do (
    echo Applying %~1\%%i ...
    if /i "%%~xi"==".bat" call "%~1\%%i"
    if /i "%%~xi"==".reg" reg import "%~1\%%i"
)
popd
