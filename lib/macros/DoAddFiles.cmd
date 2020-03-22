@echo off

rem MACRO:DoAddFiles
rem extract _AddFiles.txt to mounted directory with wimlib

if "x%_WB_TMP_DIR%"=="x" goto :EOF

if not exist "%_WB_TMP_DIR%\_AddFiles.txt" goto :EOF

set "_DEST_DIR=%_WB_MNT_PATH%"
if not "x%~1"=="x" set "_DEST_DIR=%~1"

echo --dest-dir="%_DEST_DIR%" 
call wimextract "%WB_SRC%" %WB_SRC_INDEX% @"%_WB_TMP_DIR%\_AddFiles.txt" --dest-dir="%_DEST_DIR%" --no-acls --nullglob
set _DEST_DIR=

type nul>"%_WB_TMP_DIR%\_AddFiles.txt"
set AddFiles_Mode=
