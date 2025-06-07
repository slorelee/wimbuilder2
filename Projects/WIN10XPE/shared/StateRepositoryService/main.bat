call AddFiles %0 :[StateRepository_Files]

set _SRD_Files=srd.7z
if %VER[3]% GEQ 22631 (
  call RegCopyEx Services "StateRepository"
  mkdir "%X%\ProgramData\Microsoft\Windows\AppRepository\"
  set _SRD_Files=srd_22631.7z
)
if %VER[3]% GEQ 27842 (
  set _SRD_Files=srd_27842.7z
)

if exist %_SRD_Files% (
  call Extract2X %_SRD_Files% "%X%\ProgramData\Microsoft\Windows\AppRepository\"
)
set _SRD_Files=
goto :EOF


:[StateRepository_Files]
@\Windows\System32\
StateRepository.core.dll
Windows.StateRepository.dll
Windows.StateRepositoryBroker.dll
Windows.StateRepositoryCore.dll
Windows.StateRepositoryClient.dll
Windows.StateRepositoryPS.dll
Windows.StateRepositoryUpgrade.dll
goto :EOF