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
assert.label("number preceeded by zero")
assert.true(A.isAlnum("08"))

assert.label("number preceeded by zeros")
assert.true(A.isAlnum("0000008"))

assert.label("Testing with a number string")
assert.true(A.isAlnum("123"))

assert.label("Testing with a alphanumeric string")
assert.true(A.isAlnum("abc123"))

assert.label("Testing with a string containing special characters")
assert.false(A.isAlnum("abc123!"))

assert.label("Testing with a string containing spaces")
assert.false(A.isAlnum("abc 123"))

assert.label("Testing with an undefined value")
assert.true(A.isAlnum(""))

assert.label("Testing with a boolean value")
assert.true(A.isAlnum(true))

assert.label("Testing with a negative number")
assert.false(A.isAlnum(-1))

assert.label("Testing with a fraction")
assert.false(A.isAlnum(0.5))
