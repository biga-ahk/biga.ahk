startsWith(para_string, para_needle, para_fromIndex := 1) {
    l_startString := SubStr(para_string, para_fromIndex, StrLen(para_needle))
    ; check if substring matches
    if (this.caseSensitive ? (l_startString == para_needle) : (l_startString = para_needle)) {
        return true
    }
    return false
}


; tests
assert.true(A.startsWith("String","S"))
assert.true(A.startsWith("String","s"))
assert.true(A.startsWith("; String",";"))
assert.true(A.startsWith("; String","; "))
