#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include unit-testing.ahk\export.ahk
; #Include util-array.ahk\export.ahk
; #Include util-misc.ahk\export.ahk
#Include json.ahk\export.ahk
#NoTrayIcon
#SingleInstance, force
SetBatchLines, -1

A := new biga()
assert := new unittesting()

; Star timer
Start := A_TickCount
QPC(1)
