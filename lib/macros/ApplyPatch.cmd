rem MACRO:ApplyPatch

set "_applypatch_entryfile=%~2"
if "x%~2"=="x" set _applypatch_entryfile=main.bat
echo Applying Patch: %~1\%_applypatch_entryfile%
pushd "%~1"
call %_applypatch_entryfile%
set _applypatch_entryfile=
popd
