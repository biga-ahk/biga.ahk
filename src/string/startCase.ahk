startCase(param_string) {
    StringUpper, param_string, param_string, T
    return % param_string
}

; tests
assert.true(A.startCase("--foo-bar--","Foo Bar"))
