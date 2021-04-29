isArray(param) {
	if (param.GetCapacity()) {
		return true
	}
	return false
}


; tests
assert.true(A.isArray([1, 2, 3]))
assert.false(A.isArray("abc"))
assert.true(A.isArray({"key": "value"}))


; omit
assert.false(A.isArray(1))
assert.false(A.isArray(""))
