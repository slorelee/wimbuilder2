@echo off

rem MACRO:RegCopyEx TYPE KEY(s)
rem Usage:
rem       RegCopyEx Services NlaSvc
rem       RegCopyEx Services WPDBusEnum,WpdUpFltr,WudfPf,WUDFRd

if "x%~2"=="x" goto :EOF
echo [MACRO]RegCopyEx %*

if /i "x%~1"=="xServices" goto :COPY_SERVICES
if /i "x%~1"=="xSRV" goto :COPY_SERVICES
echo Error:Unknown TYPE(%1).
goto :EOF

:COPY_SERVICES
for %%i in (%~2) do call RegCopy SYSTEM\ControlSet001\Services\%%i

