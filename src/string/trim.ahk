trim(param_string,param_chars:="") {
    if (param_chars = "") {
        l_string := this.trimStart(param_string, param_chars)
        return  this.trimEnd(l_string, param_chars)
    } else {
        l_string := param_string
        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

        ; replace starting characters
        l_string := this.trimStart(l_string, param_chars)
        ; replace ending characters
        l_string := this.trimEnd(l_string, param_chars)
        return l_string
    }
}


; tests
assert.test(A.trim("  abc  "), "abc")
assert.test(A.trim("-_-abc-_-", "_-"), "abc")
assert.test(A.map([" foo  ", "  bar  "], A.trim), ["foo", "bar"])


; omit
assert.test(A.trim(A_Tab A_Tab "  abc  " A_Tab), "abc")
