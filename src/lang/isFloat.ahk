isFloat(param) {
	if param is float
	{
		return true
	}
	return false
}


; tests
assert.true(A.isFloat(1.0))
assert.false(A.isFloat(1))
