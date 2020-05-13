sum(param_array) {
	if (!IsObject(param_array)) {
		this.internal_ThrowException()
	}

	vSum := 0
	for Key, Value in param_array {
		vSum += Value
	}
	return vSum
}


; tests
assert.test(A.sum([4, 2, 8, 6]), 20)


; omit
