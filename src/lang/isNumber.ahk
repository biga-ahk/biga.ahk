isNumber(param) {
	if (isObject(param)) {
		return false
	}
	if param is number
	{
		return true
	}
	return false
}


; tests
assert.true(A.isNumber(1))
assert.true(A.isNumber("1"))
assert.true(A.isNumber("1.001"))

; omit
assert.false(A.isNumber([]))
assert.false(A.isNumber({}))
