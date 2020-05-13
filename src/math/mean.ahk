mean(param_array) {
	if (!IsObject(param_array)) {
		this.internal_ThrowException()
	}

	vSum := 0
	for Key, Value in param_array {
		vSum += Value
	}
	return vSum / this.size(param_array)
}


; tests
assert.test(A.mean([4, 2, 8, 6]), 5)


; omit
