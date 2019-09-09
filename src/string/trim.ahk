trim(param_string,param_chars := " ") {
    if (param_chars = " ") {
        l_string := regexreplace(param_string, "^(\s+)") ;trim beginning whitespace
        return % regexreplace(l_string, "(\s+)$") ;trim ending whitespace
    } else {
        l_string := param_string
        l_removechars := "\" this.join(StrSplit(param_chars,""),"\")

        ; replace starting characters
        l_string := this.replace(l_string,"/^([" l_removechars "]+)/","")
        ; replace ending characters
        l_string := this.replace(l_string,"/([" l_removechars "]+)$/","")
        return l_string
    }
}

; tests
assert.test(A.trim("  abc  "),"abc")
assert.test(A.trim("-_-abc-_-","_-"),"abc")
assert.test(A.map([" foo  ", "  bar  "],A.trim),["foo", "bar"])
