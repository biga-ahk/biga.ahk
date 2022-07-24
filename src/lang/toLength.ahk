toLength(param_value) {

	; create
	return this.floor(param_value)
}


; tests
assert.test(A.toLength(3.2), 3)
assert.test(A.toLength("3.2"), 3)

; omit
