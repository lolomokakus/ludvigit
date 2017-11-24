%
; använd millimeter istället för tum eller nån annan skit
G21
; utgångsläge
N001 G91 G28 X0 Y0 Z0 M05
N005 G90 T1 M06
; starta spindeln
N010 M03 S20000
; flytta spindeln till början på första bokstaven
N015 G00 X20 Y25
; höj spindeln
N020 Z25
; skär ut bokstaven L
N025 G01 F300 Z-2
N030 X25 Y20
N035 X65
N040 X60 Y25
N045 X25
N050 Y100
N055 X20 Y105
N060 Y25
N065 G00 Z25
; flytta spindeln till början på andra bokstaven
N070 X100 Y25
; skär ut bokstaven H
N075 G01 Z-2
N080 X105 Y20
N085 Y60
N090 X140
N100 Y25
N105 X145 Y20
N110 Y100
N115 X140 Y105
N120 Y65
N125 X105
N130 Y100
N135 X100 Y105
N140 Y25
; raise your spindles ヽ༼ຈل͜ຈ༽ﾉ
N145 G00 Z25
; gå tillbaka till utgångsläget
N150 G91 G28 X0 Y0 Z0 M05
; avsluta programmet
N155 M30
%
