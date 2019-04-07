rem use custom compmgmt
if exist "%X_SYS%\compmgmt.msc" (
  del /a /f /q "%X_SYS%\%WB_PE_LANG%\compmgmt.msc"
  if exist "compmgmt\%WB_PE_LANG%\compmgmt.msc" (
    copy /y compmgmt\%WB_PE_LANG%\compmgmt.msc "%X_SYS%\compmgmt.msc"
  ) else (
    copy /y compmgmt\compmgmt.msc "%X_SYS%\compmgmt.msc"
  )
)
