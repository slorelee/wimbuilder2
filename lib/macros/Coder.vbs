Set objArgs = WScript.Arguments
If objArgs.Count < 3 Then
    WScript.Quit(1)
End If

For i = 1 To objArgs.Count - 1
   WScript.Echo "ARGUMENTS(" & i & "):" & objArgs.Item(i)
Next

Dim code_file, code_word
code_file = objArgs.Item(1)
code_word = objArgs.Item(2)

Dim fso
Const ForReading = 1, ForWriting = 2, ForAppending = 3
Set fso = CreateObject("Scripting.FileSystemObject")

Dim f, bCode, line, codes
Set f = fso.OpenTextFile(code_file, ForReading, TristateFalse)
line = f.Readline
Do Until f.AtEndOfStream
   line = f.ReadLine
   If (Not bCode) And line = "goto " & code_word Then
       bCode = true
   ElseIf line = code_word Then
       Exit Do
   ElseIf bCode Then
       codes = codes & line & vbCrLf
   End If
Loop
f.Close

execute(codes)
