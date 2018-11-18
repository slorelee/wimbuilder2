if not "x%opt[build.source]%"=="xlight" goto :EOF

copy /y SlimWinSxSList.txt "%_WB_TMP_DIR%\"
set "SxSListFile=%_WB_TMP_DIR%\SlimWinSxSList.txt"
call OpenTextFile JS "%SxSListFile%" %0 :update_list
goto :update_list

var wsh = new ActiveXObject('WScript.Shell');
var env = wsh.Environment('PROCESS');
var SxSArch = env('WB_PE_ARCH');
var SxSLang = env('WB_PE_LANG');
if (SxSArch == 'x64') SxSArch = 'amd64';
TXT.replace(/%SxSArch%/g, SxSArch);
TXT.replace(/%Language%/g, SxSLang);

:update_list

wimlib-imagex.exe extract "%_WB_PE_WIM%" %WB_BASE_INDEX% @"%SxSListFile%" --dest-dir="%_WB_TMP_DIR%\SlimWinSxS" --no-acls --nullglob

(echo delete '\Windows\WinSxs' --force --recursive)>>"%_WB_TMP_DIR%\SlimPatch.txt"
(echo add "%_WB_TMP_DIR%\SlimWinSxS" \)>>"%_WB_TMP_DIR%\SlimPatch.txt"
