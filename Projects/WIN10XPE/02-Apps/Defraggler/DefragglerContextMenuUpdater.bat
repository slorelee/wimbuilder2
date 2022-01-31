rem=rem --[=[ 1>nul
start /wait WinXShell.exe -script "%~dpnx0"
goto :EOF
]=]
--- -- ====================  lua script  ====================

reg_write([[HKEY_CURRENT_USER\Software\Piriform\Defraggler]],
    'AnalyzeContextString',
    app:call('resstr', [[#{@X:\Program Files\Defraggler\Lang\APP_LANGFILE,505}]])
)

reg_write([[HKEY_CURRENT_USER\Software\Piriform\Defraggler]],
    'DefragContextString',
    app:call('resstr', [[#{@X:\Program Files\Defraggler\Lang\APP_LANGFILE,504}]])
)
