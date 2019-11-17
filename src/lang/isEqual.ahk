isEqual(param_value,param_other) {
    if (IsObject(param_value)) {
        param_value := this.printObj(param_value)
        param_other := this.printObj(param_other)
    }

    if (this.caseSensitive ? (param_value == param_other) : (param_value = param_other)) {
        return true
    }
    return false
}


; tests
assert.true(A.isEqual(1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 2))
A.caseSensitive := true
assert.false(A.isEqual({ "a": "a" }, { "a": "A" }))


; omit
A.caseSensitive := false
assert.false(A.isEqual({ "a": 1 }, { "a": 2 }))
