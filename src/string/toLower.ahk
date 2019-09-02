toLower(param_string) {
    StringLower, OutputVar, param_string
    return % OutputVar
}

; tests
assert.test(A.toLower("--Foo-Bar--"),"--foo-bar--")
assert.test(A.toLower("fooBar"),"foobar")
assert.test(A.toLower("__FOO_BAR__"),"__foo_bar__")
