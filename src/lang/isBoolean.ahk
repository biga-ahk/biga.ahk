isBoolean(param) {

	if this.isEqual(param, 1) {
		return true
	}
	if this.isEqual(param, 0) {
		return true
	}
	return false
}


; tests
assert.true(A.isBoolean(true))
assert.true(A.isBoolean(1))
assert.true(A.isBoolean(false))
assert.true(A.isBoolean(0))


; omit
assert.false(A.isBoolean(0.1))
assert.false(A.isBoolean(1.1))
assert.false(A.isBoolean("1.1"))
