head(param_array) {

	; create
	return this.take(param_array)[1]
}


; tests
assert.test(A.head([1, 2, 3]), 1)
assert.test(A.head([]), "")
assert.test(A.head("fred"), "f")
assert.test(A.head(100), "1")


; omit


; aliases
assert.test(A.first([1, 2, 3]), 1)
assert.test(A.first([]), "")
assert.test(A.first("fred"), "f")
assert.test(A.first(100), "1")
