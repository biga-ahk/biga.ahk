isUndefined(param_value) {
    if (param_value == 0) {
        return false
    }
    if (!param_value) {
        return true
    }
    return false
}


; tests
assert.true(A.isUndefined(nonexistantVar))
assert.true(A.isUndefined(""))
assert.false(A.isUndefined({}))
assert.false(A.isUndefined(" "))
assert.false(A.isUndefined(0))
assert.false(A.isUndefined(false))
