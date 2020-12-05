rem MACRO:DoAddFiles
rem extract _AddFiles.txt to mounted directory with wimlib

if "x%WB_TMP_PATH%"=="x" goto :EOF

if not exist "%WB_TMP_PATH%\_AddFiles.txt" goto :EOF

set "_DEST_PATH=%_WB_MNT_PATH%"
if not "x%~1"=="x" set "_DEST_PATH=%~1"

rem echo --dest-dir="%_DEST_DIR%" 
call wimextract "%WB_SRC%" %WB_SRC_INDEX% @"%WB_TMP_PATH%\_AddFiles.txt" --dest-dir="%_DEST_PATH%" --no-acls --nullglob
set _DEST_PATH=

type nul>"%WB_TMP_PATH%\_AddFiles.txt"
set AddFiles_Mode=
