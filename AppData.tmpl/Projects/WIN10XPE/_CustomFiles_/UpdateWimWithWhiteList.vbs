Const OpenAsASCII = 0
Const OpenAsUnicode = -1

Const FailIfExist = 0
Const OverwriteIfExist = -1

Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

Dim FSO, WshShell, regEx
Dim objkeepdict, f

Set WshShell = Wscript.CreateObject("Wscript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")

Set objkeepdict = CreateObject("Scripting.Dictionary")

Set f = FSO.OpenTextFile("_wimsyslist.txt", ForReading, FailIfNotExist)
wimorgfiles = f.ReadAll()
f.Close()

Set regEx = New RegExp
regEx.Pattern = "\\Windows\\System32\\.+\\.+\r\n"
regEx.IgnoreCase  = True
regEx.Global  = True
 
wimorgfiles = regEx.Replace(wimorgfiles, "")
wimorgfiles = Mid(wimorgfiles, 20) ' SKip \Windows\System32

Set f = FSO.OpenTextFile("SysWhiteList.txt", ForReading, FailIfNotExist)
keepfiles = f.ReadAll()
f.Close()

Dim i, lines
lines = Split(keepfiles, vbCrLf)
For i = 0 To UBound(lines) - 1:objkeepdict.Add lines(i), 1:Next

lines = Split(wimorgfiles, vbCrLf)

Dim n
ReDim remove_files(UBound(lines))
n = 0
For i = 0 To UBound(lines) - 1
    If Mid(Right(lines(i), 4), 1, 1) = "." Then
        If Not objkeepdict.Exists(lines(i)) Then
            remove_files(n) = "delete --force " & lines(i)
            n = n + 1
          End If
    End If
Next
ReDim Preserve remove_files(n)

Set f = FSO.OpenTextFile("_wimsyslist.txt", ForWriting, OverwriteIfExist)
f.Write(Join(remove_files, vbCrLf))
f.Close()
WSH.Quit(0)
