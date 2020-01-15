camelCase(param_string:="") {
    if (IsObject(param_string)) {
        this.internal_ThrowException()
    }

    ; create the return
    l_string := this.startCase(param_string)
    l_startChar := this.head(l_string)
    l_outputString := this.toLower(l_startChar) this.join(this.tail(StrReplace(l_string, " ", "")), "")

    return l_outputString
}


; tests
assert.test(A.camelCase("--foo-bar--"), "fooBar")
assert.test(A.camelCase("fooBar"), "fooBar")
assert.test(A.camelCase("__FOO_BAR__"), "fooBar")
