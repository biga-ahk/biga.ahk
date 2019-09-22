repeat(param_string,param_number:=1) {
    vNewString := ""
    loop, % param_number
    {
        vNewString .= param_string
    }
    return vNewString
}

; tests

assert.test(A.repeat("*",3), "***")
assert.test(A.repeat("abc",2), "abcabc")
assert.test(A.repeat("abc",0), "")
