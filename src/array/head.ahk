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
assert.test(A.head({"a": 1, "b": 2, "c":3}), 1)

assert.label("alias")
assert.test(A.first([1, 2, 3]), 1)
assert.test(A.first([]), "")
assert.test(A.first("fred"), "f")
assert.test(A.first(100), "1")
