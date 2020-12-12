if "x%opt[mycustom.theme_id]%"=="x" goto :EOF

echo [Example]Theme Id: %opt[mycustom.theme_id]%

echo [Example]7z.exe x "%~dp0Web%opt[mycustom.theme_id]%.7z" -y -aos -o"%X_WIN%\"
echo [Example]copy /y startup%opt[mycustom.theme_id]%.wav "%X_WIN%\Media\startup.wav"
