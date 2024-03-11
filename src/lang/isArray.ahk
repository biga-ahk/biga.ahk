isArray(param) {

	if (param.getCapacity()) {
		return true
	}
	return false
}


; tests
assert.true(A.isArray([1, 2, 3]))
assert.label("string input")
assert.false(A.isArray("abc"))
assert.label("keyed object")
assert.true(A.isArray({"key": "value"}))


; omit
assert.false(A.isArray(1))
assert.false(A.isArray(""))

assert.label("number")
assert.false(A.isArray(123))

assert.label("boolean")
assert.false(A.isArray(true))

assert.label("undefined value")
assert.false(A.isArray(""))

assert.label("object containing an array")
assert.true(A.isArray({"key": [1, 2, 3]}))

assert.label("array of strings")
assert.true(A.isArray(["a", "b", "c"]))

assert.label("array of objects")
assert.true(A.isArray([{"a": 1}, {"b": 2}, {"c": 3}]))

assert.label("nested array")
assert.true(A.isArray([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))
