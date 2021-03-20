sum(param_array) {
	if (!isObject(param_array)) {
		this._internal_ThrowException()
	}

	vSum := 0
	for key, value in param_array {
		vSum += value
	}
	return vSum
}


; tests
assert.test(A.sum([4, 2, 8, 6]), 20)


; omit
