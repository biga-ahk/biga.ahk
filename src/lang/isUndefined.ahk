isUndefined(param_value) {
    if (!param_value) {
        return true
    }
    return false
}


; tests
assert.true(A.isUndefined(neverIntializedVar))
assert.true(A.isUndefined(""))
assert.false(A.isUndefined({}))
assert.false(A.isUndefined(" "))
