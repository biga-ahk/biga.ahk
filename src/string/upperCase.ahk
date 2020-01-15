upperCase(param_string:="") {
    if (IsObject(param_string)) {
        this.internal_ThrowException()
    }

    ; create the return
    l_string := this.startCase(param_string)
    l_string := this.toupper(this.trim(l_string))
    return l_string
}


; tests
assert.test(A.upperCase("--Foo-Bar--"), "FOO BAR")
assert.test(A.upperCase("fooBar"), "FOO BAR")
assert.test(A.upperCase("__FOO_BAR__"), "FOO BAR")


; omit
assert.test(A.upperCase("  Foo-Bar--"), "FOO BAR")
