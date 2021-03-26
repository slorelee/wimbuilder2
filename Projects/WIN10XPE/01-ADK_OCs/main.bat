set "OCs_PATH=%opt[adk.wpe_path]%\amd64\WinPE_OCs"
if "%WB_PE_ARCH%"=="x86" set "OCs_PATH=%opt[adk.wpe_path]%\x86\WinPE_OCs"
echo OCs_PATH:%OCs_PATH%

set _ADK_LANG=%opt[adk.lang]%
call PERegPorter.bat Tmp UNLOAD
sleep 2
dism /image:"%X%" /get-targetpath
dism /image:"%X%" /set-targetpath:X:\ 
