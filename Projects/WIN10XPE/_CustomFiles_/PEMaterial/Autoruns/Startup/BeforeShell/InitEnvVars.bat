if "x%USERNAME%"=="xSYSTEM" goto :ENV_SYSTEM
goto :ENV_USER

:ENV_SYSTEM
goto :EOF

:ENV_USER
setx Desktop "%Desktop%"
setx Programs "%Programs%"
goto :EOF
