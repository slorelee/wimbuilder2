if "x%opt[build.source]%"=="xlight" goto :DEAL_WINSXS

if "x%opt[build.registry.software]%"=="xfull" set Merge_WinSxS=1
rem if "x%opt[build.registry.system]%"=="xfull" set Merge_WinSxS=1
if not "x%Merge_WinSxS%"=="x1" goto :EOF

:DEAL_WINSXS

set SxSListFile=SlimWinSxSList.txt
if "x%opt[slim.extra]%"=="xtrue" (
  set SxSListFile=SlimWinSxSList_Extra.txt
)
copy /y "%SxSListFile%" "%_WB_TMP_DIR%\"
set "SxSListFile=%_WB_TMP_DIR%\%SxSListFile%"

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
rd /s /q "%_WB_TMP_DIR%\SlimWinSxS"
wimlib-imagex.exe extract "%WB_ROOT%\%_WB_PE_WIM%" %WB_BASE_INDEX% @"%SxSListFile%" --dest-dir="%_WB_TMP_DIR%\SlimWinSxS" --no-acls --nullglob

if not "x%Merge_WinSxS%"=="x1" (
  (echo delete '\Windows\WinSxs' --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
)
set Merge_WinSxS=
(echo add "%_WB_TMP_DIR%\SlimWinSxS" \)>>"%_WB_TMP_DIR%\SlimPatch.txt"
