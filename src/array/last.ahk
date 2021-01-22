last(param_array) {

	; create
	return this.takeRight(param_array)[1]
}


; tests
assert.test(A.last([1, 2, 3]), 3)
assert.test(A.last([]), "")
assert.test(A.last("fred"), "d")
assert.test(A.last(100), "0")


; omit
