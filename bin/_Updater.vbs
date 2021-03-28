Const OpenAsASCII = 0
Const OpenAsUnicode = -1

Const FailIfExist = 0
Const OverwriteIfExist = -1

Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

Dim argCount:argCount = Wscript.Arguments.Count

Dim optDir
If argCount > 1 Then
    If Wscript.Arguments(0) = "--dir" Then
        optDir = Wscript.Arguments(1)
    End If
End If

Dim optCheck:optCheck = 0

If argCount >= 1 Then
    If Wscript.Arguments(0) = "--check" Then
        optCheck = 1
    End If
End If

Dim inFile, outFile, inStream, outStream, inLine, FSO, WshShell
'inFile = Wscript.Arguments(0)
'outFile = Wscript.Arguments(0) & "_"

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

If optCheck = 1 Then
    optCheck = CheckUpdatedTime("remote.md5", "source.info")
    If optCheck >= 0 Then
        Wscript.Quit(optCheck)
    End If
    Wscript.Quit(2)
End If

Set objLocalMD5 = CreateObject("Scripting.Dictionary")
Set objRemoteMD5 = CreateObject("Scripting.Dictionary")

Dim res
If optDir = "" Then res = LoadHashToDict("local.md5", objLocalMD5)
res = LoadHashToDict("remote.md5", objRemoteMD5)

For Each file In objLocalMD5
    'remove same files from objRemoteMD5
    If objRemoteMD5.Exists(file) Then
        If objLocalMD5.Item(file) = objRemoteMD5.Item(file) Then
            objRemoteMD5.Remove(file)
        End If
    End If
Next

If optDir <> "" Then
    For Each file In objRemoteMD5
        If InStr(1, file, optDir, vbTextCompare) <> 1 Then
            objRemoteMD5.Remove(file)
        End If
    Next
End If

Dim outstr
outstr = vbCrLf
For Each file In objRemoteMD5
    outstr = outstr & file & vbCrLf
Next

outstr = Replace(outstr, "\", "/")
outstr = Replace(outstr, vbCrLf & "projects/", vbCrLf & "Projects/")
outstr = Replace(outstr, vbCrLf & "wimbuilder.cmd" & vbCrLf, vbCrLf & "WimBuilder.cmd" & vbCrLf)

Set outStream = FSO.CreateTextFile("updatefile.list", OverwriteIfExist)
outStream.Write outstr
outStream.Close

Function GetDateTimeInfo(file, pattern)
  Dim data, matched
  Set inStream = FSO.OpenTextFile(file, ForReading, FailIfNotExist)
  data = inStream.ReadAll
  inStream.Close

  Set regEx = New RegExp
  regEx.Pattern = pattern
  regEx.IgnoreCase = True
  'regEx.Global = True
  Set Matches = regEx.Execute(data)
  matched = ""
  For Each Match in Matches
      matched = Match.value
  Next
  GetDateTimeInfo = matched
End Function

Function CheckUpdatedTime(md5file, infofile)
  Dim data, md5date, infodate
  CheckUpdatedTime = -1
  If Not FSO.FileExists(md5file) Then Exit Function

  '// File Checksum Integrity Verifier version 2.05.
  'Start Time: 03/28/2021 at 18h49'31''
  md5date = GetDateTimeInfo(md5file, "(\d+/\d+/\d+)")
  md5date = Right(md5date, 4) & "-" & Left(md5date, 2) & "-" & Mid(md5date, 4, 2)
  Wscript.Echo "INFO: The updated time of [  " & md5file & " ] is " & md5date

  If Not FSO.FileExists(infofile) Then Exit Function
  'Gitee:  "date":"2021-03-26T23:29:00+08:00"
  'Github: "date": "2021-02-02T14:22:22Z"
  infodate = GetDateTimeInfo(infofile, "(\d+-\d+-\d+)")
  Wscript.Echo "INFO: The updated time of [ " & infofile & " ] is " & infodate

  If md5date > infodate Then
    CheckUpdatedTime = 0
  Else
    CheckUpdatedTime = 1
  End If

End Function

Function LoadHashToDict(filename, dict)
  If Not FSO.FileExists(filename) Then Exit Function
  Set inStream = FSO.OpenTextFile(filename, ForReading, FailIfNotExist)
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
