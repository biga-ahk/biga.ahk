tail(param_array) {

	; create
	return this.drop(param_array)
}


; tests
assert.test(A.tail([1, 2, 3]), [2, 3])
assert.test(A.tail("fred"), ["r", "e", "d"])
assert.test(A.tail(100), ["0", "0"])

; omit
assert.test(A.tail([]), [])
