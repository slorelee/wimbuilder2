@echo off

rem MACRO:DoAddFiles
rem extract _AddFiles.txt to mounted directory with wimlib

if "x%_WB_TMP_DIR%"=="x" goto :EOF

if not exist "%_WB_TMP_DIR%\_AddFiles.txt" goto :EOF

call wimextract "%WB_SRC%" %WB_SRC_INDEX% @"%_WB_TMP_DIR%\_AddFiles.txt" --dest-dir="%_WB_MNT_DIR%" --no-acls --nullglob


