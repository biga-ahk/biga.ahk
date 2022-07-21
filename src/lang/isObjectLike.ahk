; ###incomplete###
isObjectLike(param_value) {
	if (isObject(param_value)) {
		return true
	}
	return false
}


; tests
assert.true(A.isObjectLike(""))
assert.true(A.isObjectLike(non_existant_var))
assert.false(A.isObjectLike({}))
assert.false(A.isObjectLike(" "))
assert.false(A.isObjectLike(0))
assert.false(A.isObjectLike(false))
