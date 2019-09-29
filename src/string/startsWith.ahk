startsWith(param_string, param_needle, param_fromIndex := 1) {
    l_startString := SubStr(param_string, param_fromIndex, StrLen(param_needle))
    ; check if substring matches
    if (this.caseSensitive ? (l_startString == param_needle) : (l_startString = param_needle)) {
        return true
    }
    return false
}


; tests
assert.true(A.startsWith("abc", "a"))
assert.false(A.startsWith("abc", "b"))
assert.true(A.startsWith("abc", "b", 2))
A.caseSensitive := true
assert.false(A.startsWith("abc", "A"))


; omit
; set caseSensitive back to false
A.caseSensitive := false

; make sure comment detection works
assert.true(A.startsWith("; String", ";"))
assert.true(A.startsWith("; String", "; "))