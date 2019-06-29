if "x%opt[config.computername]%"=="x" goto :EOF
call TextReplace "%X_SYS%\unattend.xml" "Name>*</Computer" "Name>%opt[config.computername]%</Computer"
