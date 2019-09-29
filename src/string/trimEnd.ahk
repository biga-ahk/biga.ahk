trimEnd(param_string, param_chars := " ") {
    if (param_chars = " ") {
        l_string := param_string
        return % regexreplace(l_string, "(\s+)$") ;trim ending whitespace
    } else {
        l_string := param_string
        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

        ; replace ending characters
        l_string := this.replace(l_string, "/([" l_removechars "]+)$/", "")
        return l_string
    }
}


; tests
assert.test(A.trimEnd("  abc  "), "  abc")
assert.test(A.trimEnd("-_-abc-_-", "_-"), "-_-abc")
