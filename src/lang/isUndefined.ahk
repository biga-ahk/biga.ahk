isUndefined(param_value) {
	if (param_value == "") {
		return true
	}
	return false
}


; tests
assert.true(A.isUndefined(""))
assert.true(A.isUndefined(non_existant_var))
assert.false(A.isUndefined({}))
assert.false(A.isUndefined(" "))
assert.false(A.isUndefined(0))
assert.false(A.isUndefined(false))
