parseInt(param_string) {
    param_string := this.trimStart(param_string,"0 -_")
    return % param_string + 0
}


; tests
assert.test(A.parseInt("08"), 8)
assert.test(A.map(["6", "08", "10"], A.parseInt), [6, 8, 10])
