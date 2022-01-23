If WSH.Arguments.Count = 0 Then WSH.Quit(0)

Public strLocaleDicKeyName, objLocaleDic
strLocaleDicKeyName = "NAME"
Set objLocaleDic = CreateObject("scripting.dictionary")

If WSH.Arguments(0) = "GetLocaleName" Then
    WSH.Echo GetLocaleName()
    WSH.Quit(0)
ElseIf WSH.Arguments(0) = "GetLocaleIdByName" Then
    If WSH.Arguments.Count = 2 Then
        WSH.Echo GetLocaleIdByName(WSH.Arguments(1))
    Else
        WSH.Echo "0"
    End If
    WSH.Quit(0)
End If



Sub AddLocaleDicItem(name, id)
    If strLocaleDicKeyName = "NAME" Then
        objLocaleDic.Add name, id
    Else
        objLocaleDic.Add id, name
    End If
End Sub

Sub CreateLocaleMap()
    'https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows
    AddLocaleDicItem "ar-SA", "1025"
    AddLocaleDicItem "be-BY", "1059"
    AddLocaleDicItem "bg-BG", "1026"
    AddLocaleDicItem "ca-ES", "1027"
    AddLocaleDicItem "cs-CZ", "1029"
    AddLocaleDicItem "da-DK", "1030"
    AddLocaleDicItem "de-DE", "1031"
    AddLocaleDicItem "el-GR", "1032"
    AddLocaleDicItem "en-US", "1033"
    AddLocaleDicItem "es-ES", "3082"
    AddLocaleDicItem "et-EE", "1061"
    AddLocaleDicItem "fi-FI", "1035"
    AddLocaleDicItem "fr-FR", "1036"
    AddLocaleDicItem "he-IL", "1037"
    AddLocaleDicItem "hr-HR", "1050"
    AddLocaleDicItem "hu-HU", "1038"
    AddLocaleDicItem "hy-AM", "1067"
    AddLocaleDicItem "id-ID", "1057"
    AddLocaleDicItem "it-IT", "1040"
    AddLocaleDicItem "ja-JP", "1041"
    AddLocaleDicItem "ka-GE", "1079"
    AddLocaleDicItem "ko-KR", "1042"
    AddLocaleDicItem "lt-LT", "1063"
    AddLocaleDicItem "lv-LV", "1062"
    AddLocaleDicItem "mk-MK", "1071"
    AddLocaleDicItem "nb-NO", "1044"
    AddLocaleDicItem "nl-NL", "1043"
    AddLocaleDicItem "pl-PL", "1045"
    AddLocaleDicItem "pt-BR", "1046"
    AddLocaleDicItem "pt-PT", "2070"
    AddLocaleDicItem "ro-RO", "1048"
    AddLocaleDicItem "ru-RU", "1049"
    AddLocaleDicItem "sk-SK", "1051"
    AddLocaleDicItem "sl-SI", "1060"
    AddLocaleDicItem "sq-AL", "1052"
    AddLocaleDicItem "sv-SE", "1053"
    AddLocaleDicItem "th-TH", "1054"
    AddLocaleDicItem "tr-TR", "1055"
    AddLocaleDicItem "uk-UA", "1058"
    AddLocaleDicItem "vi-VN", "1066"
    AddLocaleDicItem "zh-CN", "2052"
    AddLocaleDicItem "zh-HK", "3076"
    AddLocaleDicItem "zh-TW", "1028"
End Sub

Function GetLocaleName()
    Dim lcid
    lcid = GetLocale()
    strLocaleDicKeyName = "ID"
    CreateLocaleMap()
    If objLocaleDic.Exists(CStr(lcid)) Then
        GetLocaleName = objLocaleDic.Item(CStr(lcid))
    Else
        GetLocaleName = lcid
    End If
End Function

Function GetLocaleIdByName(name)
    CreateLocaleMap()
    If objLocaleDic.Exists(name) Then
        GetLocaleIdByName = objLocaleDic.Item(name)
    Else
        GetLocaleIdByName = "0"
    End If
End Function


Set objI18nStrDic = CreateObject("scripting.dictionary")
Set objI18nRegExpDic = CreateObject("scripting.dictionary")
Class I18n
    Private Sub Class_Initialize
    End Sub
    Private Sub Class_Terminate
    End Sub
    Public Sub s(str, trans)
      objI18nStrDic.Add str, trans
    End Sub
    Public Sub r(regexp, trans)
      objI18nRegExpDic.Add regexp, trans
    End Sub

    Public Function trans(str)
        trans = str
      'direct match
      If objI18nStrDic.Exists(str) Then
          trans = objI18nStrDic.Item(str)
          Exit Function
      End If

      'part match
      Dim objKeys, i, p
     objKeys = objI18nStrDic.Keys
     For i = 0 To objI18nStrDic.Count - 1
        p = InStr(1, str, objKeys(i))
        If p > 0 Then
            trans = Replace(str, objKeys(i), objI18nStrDic.Item(objKeys(i)))
          Exit Function
        End If
      Next

      'TODO:RegExp match
    End Function
End Class
Set t = New I18n

Sub Trans()
    Dim modestr, mode, colorstr, transstr, f, i, pos
    f = 1
    modestr = WSH.Arguments(0)
    mode = "ECHO"
    colorstr = ""
    If InStr(1, modestr, "LOG") > 0 Then mode = "LOG"
    If InStr(1, modestr, "CLR") = 1 Then
       colorstr = WSH.Arguments(0)
       'f = f + 1
      pos = InstrRev(colorstr, "_")
       colorstr = CLR_Trans(Mid(colorstr, pos + 1))
    End If
    transstr = t.trans(WSH.Arguments(f))
    For i = f + 1 To WSH.Arguments.Count - 1
        transstr = Replace(transstr, "@s", WSH.Arguments(i), 1, 1)
    Next
    Select Case mode
    Case "ECHO"
        WSH.Echo colorstr & transstr
    Case "LOG"
        WSH.Echo colorstr & transstr
        WSH.Echo  log_prefix() & Left("INFO" & Space(10), 10) & transstr
    Case Else
         WSH.Echo transstr
    End Select
End Sub

Function log_prefix()
    dim N
    N = Now()
    log_prefix = Year(N) & "-" & Right("0" & Month(N), 2) & "-" & Right("0" & Day(N), 2) & " " 
    log_prefix = log_prefix & Right("0" & Hour(N), 2) & ":" & Right("0" & Minute(N), 2) & ":" & Right("0" & Second(N), 2) & ","
End Function
