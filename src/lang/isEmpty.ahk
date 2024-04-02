isEmpty(param_value) {

	; create
	if (param_value == "") {
		return true
	}
	if (this.isString(param_value)) {
		return false
	}
	for key, value in param_value {
		return false
	}
	return true
}


; tests
assert.true(A.isEmpty(""))
assert.true(A.isEmpty(true))
assert.true(A.isEmpty(1))
assert.false(A.isEmpty([1, 2, 3]))
assert.false(A.isEmpty({"a": 1}))


; omit
assert.false(A.isEmpty("hello"), "string input")
