snakeCase(param_string:="") {
    if (IsObject(param_string)) {
        this.internal_ThrowException()
    }

    ; create the return
    l_string := this.startCase(param_string)
    l_string := StrReplace(this.trim(l_string), " ", "_")
    return l_string
}


; tests
assert.test(A.snakeCase("Foo Bar"), "foo_bar")
assert.test(A.snakeCase("fooBar"), "foo_bar")
assert.test(A.snakeCase("--FOO-BAR--"), "foo_bar")


; omit
assert.test(A.snakeCase("  Foo-Bar--"), "FOO_BAR")
