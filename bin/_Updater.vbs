Const OpenAsASCII = 0
Const OpenAsUnicode = -1

Const FailIfExist = 0
Const OverwriteIfExist = -1

Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

Dim argCount:argCount = Wscript.Arguments.Count

If argCount = 0 Then
  'Wscript.Quit(1)
End If

Dim inFile, outFile, inStream, outStream, inLine, FileSys, WshShell
'inFile = Wscript.Arguments(0)
'outFile = Wscript.Arguments(0) & "_"

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set FileSys = CreateObject("Scripting.FileSystemObject")

Set objLocalMD5 = CreateObject("Scripting.Dictionary")
Set objRemoteMD5 = CreateObject("Scripting.Dictionary")

Dim res
res = LoadHashToDict("local.md5", objLocalMD5)
res = LoadHashToDict("remote.md5", objRemoteMD5)

For Each file In objLocalMD5
    'remove same files from objRemoteMD5
    If objRemoteMD5.Exists(file) Then
        If objLocalMD5.Item(file) = objRemoteMD5.Item(file) Then
            objRemoteMD5.Remove(file)
        End If
    End If
Next

Dim outstr
outstr = vbCrLf
For Each file In objRemoteMD5
    outstr = outstr & file & vbCrLf
Next

outstr = Replace(outstr, "\", "/")
outstr = Replace(outstr, vbCrLf & "projects/", vbCrLf & "Projects/")
outstr = Replace(outstr, vbCrLf & "wimbuilder.cmd" & vbCrLf, vbCrLf & "WimBuilder.cmd" & vbCrLf)

Set outStream = FileSys.CreateTextFile("updatefile.list", OverwriteIfExist)
outStream.Write outstr
outStream.Close

Function LoadHashToDict(filename, dict)
  Set inStream = FileSys.OpenTextFile(filename, ForReading, FailIfNotExist)
  Do
    inLine = inStream.ReadLine
    If Left(inLine, 1) <> "" And Left(inLine, 1) <> "/" And _
        Left(inLine, 1) <> "S" And Left(inLine, 1) <> vbTab And _
          Left(inLine, 3) <> "End" And  Left(inLine, 3) <> "Err" Then
            arr = Split(inLine, " ", 2)
            'If dict.Exists(arr(1)) Then
            '    MsgBox( arr(1))
            'Else
                dict.Add arr(1), arr(0)
            'End If
    End If
  Loop Until inStream.AtEndOfStream
  inStream.Close
  LoadHashToDict = True
End Function

Function RegKeyRePlacer(transFlag, str, okey, nkey)
  RegKeyRePlacer = str
  transFlag = 0
  If InStr(1, str, okey) = 1 Then
    RegKeyRePlacer = Replace(str, okey, nkey, 1, 1)
    transFlag = 1
  End If
End Function
