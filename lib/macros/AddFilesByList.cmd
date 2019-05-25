echo [MACRO]AddFilesByList %1

set "_add_batch=%_WB_TMP_DIR%\_AddFileList.bat"

if 1==1 (
  echo call AddFiles "%%~0" :end_files
  echo goto :end_files
)>"%_add_batch%"
for /f "usebackq delims=" %%i in ("%~1") do (
    if not exist "%X_SYS%\%%i" (echo %%i)>>"%_add_batch%"
)
echo goto :end_files>>"%_add_batch%"

call "%_add_batch%"
set _add_batch=
