toLength(param_value) {

	; create
	if (!this.isNumber(param_value)) {
		return 0
	}
	return this.floor(param_value)
}


; tests
assert.test(A.toLength(3.2), 3)
assert.test(A.toLength("3.2"), 3)


; omit
assert.test(A.toLength("hello"), 0)
assert.test(A.toLength([]), 0)
assert.test(A.toLength({}), 0)
