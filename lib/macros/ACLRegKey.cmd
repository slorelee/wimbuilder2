if "x%WB_RUNAS_TI%"=="x1" (
  goto :EOF
)

call _ACLRegKey %*
