if "x%opt[build.source]%"=="xlight" goto :DEAL_WINSXS

if "x%opt[build.registry.software]%"=="xfull" set Merge_WinSxS=1
rem if "x%opt[build.registry.system]%"=="xfull" set Merge_WinSxS=1
if not "x%Merge_WinSxS%"=="x1" goto :EOF

:DEAL_WINSXS

set SxSListFile=SlimWinSxSList.txt
if "x%opt[slim.extra]%"=="xtrue" (
  set SxSListFile=SlimWinSxSList_Extra.txt
)
copy /y "%SxSListFile%" "%WB_TMP_PATH%\"
set "SxSListFile=%WB_TMP_PATH%\%SxSListFile%"

call OpenTextFile JS "%SxSListFile%" "%~dpnx0" :update_list
goto :update_list

var wsh = new ActiveXObject('WScript.Shell');
var env = wsh.Environment('PROCESS');
var SxSArch = env('WB_PE_ARCH');
var SxSLang = env('WB_PE_LANG');
if (SxSArch == 'x64') SxSArch = 'amd64';
TXT.replace(/%SxSArch%/g, SxSArch);
TXT.replace(/%Language%/g, SxSLang);

:update_list
rd /s /q "%WB_TMP_PATH%\SlimWinSxS"
if "x%opt[build.registry.software]%"=="xfull" (
  wimlib-imagex.exe extract "%WB_SRC%" %WB_SRC_INDEX% @"%SxSListFile%" --dest-dir="%WB_TMP_PATH%\SlimWinSxS" --no-acls --nullglob
) else (
  wimlib-imagex.exe extract "%WB_BASE_PATH%" %WB_BASE_INDEX% @"%SxSListFile%" --dest-dir="%WB_TMP_PATH%\SlimWinSxS" --no-acls --nullglob
)

if not "x%Merge_WinSxS%"=="x1" (
  (echo delete '\Windows\WinSxs' --force --recursive)>>"%WB_TMP_PATH%\SlimPatch.txt"
)
set Merge_WinSxS=
(echo add "%WB_TMP_PATH%\SlimWinSxS" \)>>"%WB_TMP_PATH%\SlimPatch.txt"
