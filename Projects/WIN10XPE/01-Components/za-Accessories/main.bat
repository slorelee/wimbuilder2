if "x%opt[component.wordpad]%"=="xtrue" (
  call AddFiles "\Program Files\Windows NT\Accessories\"
  call RegCopyEx Classes ".docx,.odt,.rtf,docxfile,odtfile,rtffile"
  rem call RegCopyEx Classes "textfile,Wordpad.Document.1,Application\wordpad.exe"
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

