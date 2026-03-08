if "x%opt[arm64.amd64support%"=="xtrue" (
  call AddFiles %0 :[AMD64Support]
)

if "x%opt[arm64.x86support%"=="xtrue" (
  call AddFiles %0 :[x86Support]
)
goto :EOF


:[AMD64Support]
@\Windows\System32\

;26100
kdstub.dll
ImplatSetup.dll
Windows.Devices.Enumeration.dll

goto :EOF

:[x86Support]
@\Windows\System32\

;19045
wowarmhw.dll

;26100
xtajit.dll

goto :EOF
