isAlnum(param) {
	if (isObject(param)) {
		return false
	}
	if param is alnum
	{
		return true
	}
	return false
}


; tests

assert.true(A.isAlnum(1))
assert.true(A.isAlnum("hello"))
assert.false(A.isAlnum([]))
assert.false(A.isAlnum({}))

; omit
assert.true(A.isAlnum("08"))
