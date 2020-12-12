if not "x%opt[custom.show_cmd_menu]%"=="xtrue" goto :EOF

reg delete HKLM\Tmp_Software\Classes\Directory\background\shell\cmd /v Extended  /f
reg delete HKLM\Tmp_Software\Classes\Directory\shell\cmd /v Extended  /f
reg delete HKLM\Tmp_Software\Classes\Drive\shell\cmd /v Extended  /f
