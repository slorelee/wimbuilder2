
set PATCH_MODE=local
set WB_PE_VER=10.0.29610.1000
set WB_PE_ARCH=x64

set X_SYS=.
set "PATH=..\..\..\..\bin\%WB_PE_ARCH%;%PATH%"
@for /f "tokens=3,4 delims=." %%i in ("%WB_PE_VER%") do (
  set VER[3]=%%i
  set VER[4]=%%j
)

call main.bat


