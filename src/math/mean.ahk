mean(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	; create
	return this.sum(param_array) / param_array.maxIndex()
}


; tests
assert.test(A.mean([4, 2, 8, 6]), 5)


; omit
assert.label("same value")
assert.test(A.mean([10, 10, 10]), 10)

assert.label("with string value")
assert.test(A.mean([10, "10", 10]), 10)

assert.label("decimals")
assert.test(A.mean([10.1, 42.2]), 26.150000)

assert.label("empty values")
assert.test(A.mean([4, 2, , 8, 6]), 4)
