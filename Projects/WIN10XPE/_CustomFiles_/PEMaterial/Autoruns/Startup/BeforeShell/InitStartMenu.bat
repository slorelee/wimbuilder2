rem display startmenu folders/shortcuts name with language

if "x%USERNAME%"=="xSYSTEM" set RunOnce=1

set "_Programs_Path=%Programs%"
attrib +s "%_Programs_Path%\Accessibility"
attrib +s "%_Programs_Path%\Accessories"
attrib +s "%_Programs_Path%\System Tools"

set "_Programs_Path=X:\ProgramData\Microsoft\Windows\Start Menu\Programs"
attrib +s "%_Programs_Path%\Accessories"

set _Programs_Path=
