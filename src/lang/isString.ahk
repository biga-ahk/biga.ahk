isString(param) {
	if (isObject(param)) {
		return false
	}
	if param is alnum
	{
		return true
	}
	if (strLen(param) > 0) {
		return true
	}
	return false
}


; tests
assert.true(A.isString("abc"))
assert.true(A.isString(1))
