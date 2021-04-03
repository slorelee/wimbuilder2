rem rd /s /q "%X%\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories"

if exist SIB_RegDefault.reg (
    reg import SIB_RegDefault.reg
)
