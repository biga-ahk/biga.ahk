isObject(param) {
	if (isObject(param)) {
		return true
	}
	return false
}


; tests
assert.true(A.isObject({}))
assert.true(A.isObject([1, 2, 3]))
assert.false(A.isObject(""))
