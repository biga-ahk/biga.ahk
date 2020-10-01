head(param_array) {

	; create
	return this.take(param_array)[1]
}


; tests
assert.test(A.head([1, 2, 3]), 1)
assert.test(A.head([]), "")
assert.test(A.head("fred"), "f")
assert.test(A.head(100), "1")
