trimStart(param_string,param_chars := " ") {
    if (param_chars = " ") {
        return  regexreplace(param_string, "^(\s+)") ;trim beginning whitespace
    } else {
        l_string := param_string
        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

        ; replace starting characters
        l_string := this.replace(l_string, "/^([" l_removechars "]+)/", "")
        return l_string
    }
}


; tests
assert.test(A.trimStart("  abc  "), "abc  ")
assert.test(A.trimStart("-_-abc-_-", "_-"), "abc-_-")
