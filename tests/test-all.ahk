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

; Start speed function
QPC(1)

assert.label("every()")
users := [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": false }]

; The `A.matches` iteratee shorthand
assert.false(A.every(users, { "user": "barney", "age": 36, "active": false }))

; The `A.matchesProperty` iteratee shorthand.
assert.true(A.every(users, ["active", false]), ["barney", "fred"])

; The `A.property` iteratee shorthand.
assert.false(A.every(users, "active"))


; omit
assert.label("UNDEFINED")
assert.true(A.every(["", "", ""], A.isUndefined))
assert.label("2")
assert.true(A.every([1, 2, 3], func("isPositive")))
isPositive(value) {
    if (value > 0) {
        return true
    }
    return false
}

votes := [true, false, true, true]
A.every(votes, Func("fn_istrue")) " was the result"
fn_istrue(value) {
    if (value == true) {
        return true
    } 
    return false
}


userVotes := [{"name":"fred", "votes": ["yes","yes"]}
            , {"name":"bill", "votes": ["no","yes"]}
            , {"name":"jake", "votes": ["no","yes"]}]

msgbox, % A.every(userVotes, ["votes.1", "yes"])
; => false
msgbox, % A.every(userVotes, ["votes.2", "yes"])
; => true

if (A.every(userVotes, "votes.2")) {
    msgbox, % "everyone voted yes on option #2"
}
;; Display test results in GUI
speed := QPC(0)
assert.fullreport()
msgbox, %speed%
ExitApp

QPC(R := 0)
{
    static P := 0, F := 0, Q := DllCall("QueryPerformanceFrequency", "Int64P", F)
    return ! DllCall("QueryPerformanceCounter", "Int64P", Q) + (R ? (P := Q) / F : (Q - P) / F) 
}
