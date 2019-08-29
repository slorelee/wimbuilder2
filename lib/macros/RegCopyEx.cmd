@echo off

rem MACRO:RegCopyEx TYPE KEY(s)
rem Usage:
rem       RegCopyEx Services NlaSvc
rem       RegCopyEx Services WPDBusEnum,WpdUpFltr,WudfPf,WUDFRd
rem       RegCopyEx Classes .msi
rem       RegCopyEx Classes Msi.Package,Msi.Path

if "x%~2"=="x" goto :EOF
echo [MACRO]RegCopyEx %*

if /i "x%~1"=="xServices" goto :COPY_SERVICES
if /i "x%~1"=="xSRV" goto :COPY_SERVICES
if /i "x%~1"=="xClasses" goto :COPY_CLASSES
echo Error:Unknown TYPE(%1).
goto :EOF

:COPY_SERVICES
for %%i in (%~2) do call RegCopy SYSTEM\ControlSet001\Services\%%i
goto :EOF

:COPY_CLASSES
for %%i in (%~2) do call RegCopy SOFTWARE\Classes\%%i
goto :EOF

