if "x%opt[system.workgroup]%"=="x" (
    rem del /a /f /q "%X_SYS%\startnet.exe"
)

pushd SlimResources
call last.bat
popd
