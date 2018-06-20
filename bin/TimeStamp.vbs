N = Now
timestamp = Year(N) & Right("0" & Month(N), 2) & Right("0" & Day(N), 2)
timestamp = timestamp & Right("0" & Hour(N), 2) & Right("0" & Minute(N), 2) & Right("0" & Second(N), 2)
WSH.echo timestamp