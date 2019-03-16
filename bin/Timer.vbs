Dim timer1, timer2, elapsed
If Wscript.Arguments.Count = 0 Then
     Wscript.echo GetTimestamp
ElseIf  Wscript.Arguments.Count = 2 Then 
     timer1 = Wscript.Arguments(0)
     timer2 = Wscript.Arguments(1)
     elapsed = DateDiff("s", CDate(timer1), CDate(timer2))
     Wscript.echo elapsed
End If


Function GetTimestamp()
    Dim N, timestamp 
    N = Now
    timestamp = Year(N) &  "-" & Right("0" & Month(N), 2) &  "-" & Right("0" & Day(N), 2) &   " " 
    timestamp = timestamp & Right("0" & Hour(N), 2) &  ":" & Right("0" & Minute(N), 2) &  ":" & Right("0" & Second(N), 2)
    GetTimestamp = timestamp
End Function
