endsWith(param_string,param_needle,param_fromIndex:="") {
    if (IsObject(param_string) || IsObject(param_needle) || IsObject(param_fromIndex)) {
        this.internal_ThrowException()
    }

    ; prepare defaults
    if (param_fromIndex = "") {
        param_fromIndex := StrLen(param_string)
    }
    if (StrLen(param_needle) > 1) {
        param_fromIndex := StrLen(param_string) - StrLen(param_needle) + 1
    }

    ; create
    l_endChar := SubStr(param_string, param_fromIndex, StrLen(param_needle))
    if (this.isEqual(l_endChar, param_needle)) {
        return true
    }
    return false
}


; tests
assert.true(A.endsWith("abc", "c"))
assert.false(A.endsWith("abc", "b"))
assert.true(A.endsWith("abc", "b", 2))


; omit

; make sure comment detection works
assert.true(A.endsWith("String;", ";"))
assert.true(A.endsWith("String;", "ing;"))
assert.true(A.endsWith("String;", "String;"))
