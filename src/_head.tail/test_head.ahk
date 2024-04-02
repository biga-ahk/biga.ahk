#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include expect.ahk\export.ahk
#NoTrayIcon
#SingleInstance, force
SetBatchLines, -1
StringCaseSense, On

A := new biga()
assert := new expect()
