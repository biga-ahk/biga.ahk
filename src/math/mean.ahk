mean(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	l_sum := 0
	for Key, Value in param_array {
		l_sum += Value
	}
	return l_sum / this.size(param_array)
}


; tests
assert.test(A.mean([4, 2, 8, 6]), 5)


; omit
assert.label(".mean - same value")
assert.test(A.mean([10, 10, 10]), 10)

assert.label(".mean - with string value")
assert.test(A.mean([10, "10", 10]), 10)

assert.label(".mean - decimals")
assert.test(A.mean([10.1, 42.2]), 26.150000000000002)
