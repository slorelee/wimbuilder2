set AddFiles_Mode=merge

if "x%opt[component.notepad]%"=="xtrue" call _notepad.bat

if "x%opt[component.wordpad]%"=="xtrue" (
  call AddFiles "\Program Files\Windows NT\Accessories\"
  call RegCopyEx Classes ".docx,.odt,.rtf,docxfile,odtfile,rtffile"
  rem call RegCopyEx Classes "textfile,Wordpad.Document.1,Application\wordpad.exe"
  call AddFiles "\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Wordpad.lnk"
)

if "x%opt[component.mspaint]%"=="xtrue" call _mspaint.bat

if "x%opt[component.winphotoviewer]%"=="xtrue" (
  call _winphotoviewer.bat
)

if "x%opt[component.snippingtool]%"=="xtrue" (
  call _snippingtool.bat
)

if "x%opt[component.accessibility]%"=="xtrue" (
  call _accessibility.bat
)

call AddFiles "\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\desktop.ini"

call doAddFiles
