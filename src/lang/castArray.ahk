castArray(param_value:="__default") {

	; prepare
	if (this.isArray(param_value)) {
		return param_value.clone()
	} else if (param_value == "__default") {
		return []
	}

	; create
	return [param_value]
}


; tests
assert.test(A.castArray(1), [1])
assert.test(A.castArray({"a": 1}), {"a": 1})
assert.test(A.castArray("abc"), ["abc"])
assert.test(A.castArray(""), [""])


; omit
assert.test(A.castArray([1, 2, 3]), [1, 2, 3])

assert.label("boolean value")
assert.test(A.castArray(true), [true])
assert.test(A.castArray(false), [false])

assert.label("an undefined value")
assert.test(A.castArray(""), [""])

assert.label("number that is not 1")
assert.test(A.castArray(0), [0])
assert.test(A.castArray(2), [2])

assert.label("string input")
assert.test(A.castArray("ghi"), ["ghi"])

assert.label("complex object")
assert.test(A.castArray({"a": 1, "b": 2}), {"a": 1, "b": 2})

assert.label("an array of multiple elements that is not [1, 2, 3]")
assert.test(A.castArray([4, 5, 6]), [4, 5, 6])

assert.label("an empty object")
assert.test(A.castArray({}), [{}])

assert.label("an empty array")
assert.test(A.castArray([]), [[]])

assert.label("string containing special characters")
assert.test(A.castArray("@#$%^&*()"), ["@#$%^&*()"])

assert.label("negative number")
assert.test(A.castArray(-1), [-1])
